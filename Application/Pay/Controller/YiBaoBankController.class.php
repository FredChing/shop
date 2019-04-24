<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-09-04
 * Time: 0:25
 */
namespace Pay\Controller;

/**
 * 第三方接口开发示例控制器
 * Class DemoController
 * @package Pay\Controller
 *
 * 三方通道接口开发说明：
 * 1. 管理员登录网站后台，供应商管理添加通道，通道英文代码即接口类名称
 * 2. 用户管理-》通道-》指定该通道（独立或轮询）
 * 3. 用户费率优先通道费率
 * 4. 用户通道指定优先系统默认支持产品通道指定
 * 5. 三方回调地址URL写法，如本接口 ：
 *    异步地址：http://www.yourdomain.com/Pay_Demo_notifyurl.html
 *    跳转地址：http://www.yourdomain.com/Pay_Demo_callbackurl.html
 *
 *    注：下游对接请查看商户API对接文档部分.
 */

class YiBaoBankController extends PayController
{
    private $getTokenUrl = 'https://open.yeepay.com/yop-center/rest/v1.0/sys/trade/order';

    private $gateway = 'https://cash.yeepay.com/cashier/std';

    private $priPath = './cert/yiBao/private.txt';

    private $pubPath = './cert/yiBao/public.txt';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $return = $this->getParameter('易宝网银', $array, __CLASS__, 1);
        $encryp = encryptDecrypt(serialize($return), 'DDBank');
        if($return['unlockdomain']) {//防封域名
            $gateway = $return['unlockdomain'].'/Pay_YiBaoBank_Rpay';
        } else {
            $gateway = $this->_site.'Pay_YiBaoBank_Rpay';
        }
        echo createForm($gateway, ['encryp' => $encryp]);
    }

    public function Rpay()
    {

        //接收传输的数据
        $data = I('post.', '');

        //将数据解密并反序列化
        $return = unserialize(encryptDecrypt($data['encryp'], 'DDBank', 1));
        //检测数据是否正确
        $return || $this->error('传输数据不正确！');

        vendor('Yop.YopRequest');
        vendor('Yop.YopClient3');
        vendor('Yop.Util.Base64Url');

        $priKey = file_get_contents($this->priPath);
        $pubKey = file_get_contents($this->pubPath);
        if($return['unlockdomain']) {//防封域名
            $frontUrl = $return['unlockdomain'].'/Pay_YiBaoBank_callbackurl.html';
            $backUrl = $return['unlockdomain'].'/Pay_YiBaoBank_notifyurl.html';
        } else {
            $frontUrl = $this->_site.'Pay_YiBaoBank_callbackurl.html';
            $backUrl = $this->_site.'Pay_YiBaoBank_notifyurl.html';
        }
        $request = new \YopRequest("OPR:" . $return['mch_id'], $priKey, "https://open.yeepay.com/yop-center", $pubKey);
        $request->addParam("parentMerchantNo", $return['mch_id']);
        $request->addParam("merchantNo", $return['mch_id']);
        $request->addParam("orderId", $return['orderid']);
        $request->addParam("orderAmount", $return['amount']);
        $request->addParam("redirectUrl", $frontUrl);
        $request->addParam("notifyUrl", $backUrl);
        $request->addParam("goodsParamExt", json_encode([
            'goodsName' => '在线支付！',
            'goodsDesc' => '在线支付！',
        ]));
        $response = \YopClient3::post("/rest/v1.0/std/trade/order", $request);
        $response = json_decode(json_encode($response), true);
        if ($response['result']['code'] != 'OPR00000') {
            $this->showmessage($response['error']);
        }

        $params = [
            'merchantNo'    => $return['mch_id'],
            'token'         => $response['result']['token'],
            'timestamp'     => time(),
            'directPayType' => '',
            'cardType'      => '',
            'userNo'        => '',
            'userType'      => 'USER_ID',
            'ext'           => json_encode([]),
        ];
        $signStr = 'merchantNo=' . $params['merchantNo'] .
            '&token=' . $params['token'] .
            '&timestamp=' . $params['timestamp'] .
            '&directPayType=' . $params['directPayType'] .
            '&cardType=' . $params['cardType'] .
            '&userNo=' . $params['userNo'] .
            '&userType=' . $params['userType'] .
            '&ext=' . $params['ext'];
        $priKey = "-----BEGIN RSA PRIVATE KEY-----\n" . wordwrap($priKey, 64, "\n", true) . "\n-----END RSA PRIVATE KEY-----";
        /* 提取私钥 */
        $privateKey = openssl_get_privatekey($priKey);

        openssl_sign($signStr, $encodeData, $privateKey, "SHA256");

        openssl_free_key($privateKey);

        $params['sign'] = \Base64Url::encode($encodeData);

        $params['sign'] .= '$SHA256';
        echo createForm($this->gateway, $params);
    }

    public function callbackurl()
    {
        $orderid    = I('request.orderId', ''); //系统订单号
        $Order      = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($orderid, '', 1);
        }
    }

    public function notifyurl()
    {

        $data = $_POST;
        // file_put_contents('./Data/notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . serialize($data) . "\r\n\r\n", FILE_APPEND);

       
        if ($data['response']) {
            vendor('Yop.Util.YopSignUtils');
            $priKey = file_get_contents($this->priPath);
            $pubKey = file_get_contents($this->pubPath);

            $result = \YopSignUtils::decrypt($data['response'], $priKey, $pubKey);
            $result = json_decode($result, true);
            
            if ($result['status'] == 'SUCCESS') {
                $this->EditMoney($result['orderId'], '', 0);
                echo "SUCCESS";
            }
        }
    }

}
