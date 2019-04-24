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

class HfbBankScanController extends PayController
{
   private $private_path = './cert/HFB/CS20180731047082_20180731112510176.pfx';
    private $public_path  = './cert/HFB/SS20180731047082_20180731112510176.cer';

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $return  = $this->getParameter('合付宝(银联扫码)', $array, __CLASS__, 100);
        $encrypt = encryptDecrypt(serialize($return), 'lgbya');
        echo createForm(U('Pay/HfbBankScan/Rpay'), ['encrypt' => $encrypt]);
    }

    public function Rpay()
    {
        $encrypt = I('post.encrypt','');
        $return = unserialize(encryptDecrypt($encrypt, 'lgbya', 1));
        $params = [
            'merchantNo' => $return['mch_id'],
            'version'    => 'v1',
            'channelNo'  => '05',
            'tranCode'   => 'YS1003',
            'tranFlow'   => $return['orderid'],
            'tranDate'   => date('Ymd'),
            'tranTime'   => date('His'),
            'amount'     => $return['amount'],
            'payType'    => '21',
            'bindId'     => $return['appid'],
            'notifyUrl'  => $return['notifyurl'],
            'bizType'    => '01',
            'goodsName'  => '普通支付',
            'buyerName'  => '张三',
            'buyerId'    => '1234567',
            'remark'     => '1',
            'YUL1'       => $return['callbackurl'],
        ];

        $public_key = file_get_contents($this->public_path);

        openssl_public_encrypt($params['buyerName'], $crypted, $public_key);
        $params['buyerName'] = base64_encode($crypted);

        $params['sign'] = $this->sign($params, $return['signkey']);
      
      
        $response       = curlPost($return['gateway'], http_build_query($params));
        parse_str($response, $result);

        if ($result['qrCodeURL'] && $result['rtnCode'] === '0000') {
            $return['amount'] = bcdiv($return['amount'], 100, 2);
            $this->showQRcode($result['qrCodeURL'], $return, 'yl');
            return;
        }
        $this->showmessage($result['rtnMsg']);
    }

    protected function sign($params, $key)
    {

        // 转换成key=val&串
        $params_str = md5Sign($params, '', '', false);
        $pkcs12     = file_get_contents($this->private_path);
        openssl_pkcs12_read($pkcs12, $certs, $key);

        // 签名
        $sign_falg = openssl_sign($params_str, $sign, $certs['pkey'], OPENSSL_ALGO_SHA1);
        if ($sign_falg) {
            return base64_encode($sign);
        }
        $this->showmessage('加密错误！');
    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $Order      = M("Order");
        $orderid   = I('request.orderid','');
        $pay_status = $Order->where(['pay_orderid'=>$orderid])->getField("pay_status");
        if ($pay_status != 0) {
            $this->EditMoney($orderid, '', 1);

        } else {
            exit("error");
        }
    }

    protected function verifySign($params)
    {
        // 公钥
        $public_key = file_get_contents($this->public_path);

        // 签名串
        $sign_str = $params['sign'];
        $sign_str = str_replace(" ", "+", $sign_str);

        // 转码
        unset($params['sign']);
        $params_str = $this->createLinkString($params);
        $sign       = base64_decode($sign_str);

        return (bool) openssl_verify($params_str, $sign, $public_key);

    }

    /**
     *  服务器通知
     */
    public function notifyurl()
    {
        $data = I('request.', '');
        if ($this->verifySign($data) && $data['rtnCode'] == '0000') {
            $this->EditMoney($data['tranFlow'], '', 0);
        }
    }

    public function createLinkString($para)
    {
        ksort($para); //排序
        $linkString = "";
        while (list($key, $value) = each($para)) {
            $linkString .= $key . "=" . $value . "&";
        }
        // 去掉最后一个&字符
        $linkString = substr($linkString, 0, count($linkString) - 2);
        return $linkString;
    }
}
