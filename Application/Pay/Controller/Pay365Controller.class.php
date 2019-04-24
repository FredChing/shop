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

class Pay365Controller extends PayController
{
    private $bankItem = [
        'CCB'   => '1105',
        'ABC'   => '1103',
        'ICBC'  => '1102',
        'CEB'   => '1303',
        'PSBC'  => '1403',
        'BJB'   => '1313',
        'SHB'   => '1310',
        'CMB'   => '1308',
        'BOC'   => '1104',
        'CITIC' => '1302',
        'SPAB'  => '1307',
    ];
    protected $gateway = 'http://103.80.27.113:3651/pay1.0/';

    public function __construct()
    {
        parent::__construct();
    }

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $return = $this->getParameter('365Pay', $array, __CLASS__, 1);

        $params = [
            'Fs'         => 'b2c',
            'MerchantNo' => $return['appid'],
            'OrderNo'    => $return['orderid'],
            'Amount'     => $return['amount'],
            'BankName'   => '10000',
            'NotifyUrl'  => $return['notifyurl'],
            'ReturnUrl'  => $return['callbackurl'],
        ];
        $signStr = $params['Fs'] .
            $return['mch_id'] .
            $params['OrderNo'] .
            $params['Amount'] .
            $params['NotifyUrl'] .
            $return['signkey'];
        $params['Sign'] = md5($signStr);
        $result         = curlPost(
            $this->gateway,
            json_encode($params)
        );
        $result = json_decode($result, true);
        if ($result['Status'] == 100 && $result['CodeUrl']) {
            header('Location:' . $result['CodeUrl']);
        } else {
            $this->showmessage($result['CodeMsg']);
        }

        // $encryp = encryptDecrypt(serialize($return), '365Pay');

        // $this->assign([
        //     'bank_array' => $this->bankItem,
        //     'rpay_url'   => U('Pay365/Rpay'),
        //     'orderid'    => I('post.pay_orderid', ''),
        //     'body'       => I('post.pay_productname', ''),
        //     'money'      => sprintf('%.2f', $return['amount']),
        //     'encryp'     => $encryp,
        // ]);
        // $this->display('BankPay/pc');
    }

    // public function Rpay()
    // {
    //     //接收传输的数据
    //     $data = I('post.', '');

    //     //将数据解密并反序列化
    //     $return = unserialize(encryptDecrypt($data['encryp'], '365Pay', 1));
    //     //检测数据是否正确
    //     $return || $this->error('传输数据不正确！');

    //     $bankCode = I('post.bankCode', '');
    //     $bankCode || $this->error('请选择支付的银行');

    // }

    public function notifyurl()
    {

        $data = file_get_contents('php://input');
        
        file_put_contents('./Data/Pay365_notify1.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . $data . "\r\n\r\n", FILE_APPEND);
        
        $data = json_decode($data, true);

        if ($data['Status'] == 100) {
            $orderInfo = M('Order')->where(['pay_orderid' => $data['OrderNo']])->find();
            $signStr   = $orderInfo['memberid'] .
                $data['OrderNo'] .
                $data['Amount'] .
                $data['Status'] .
                $orderInfo['key'];
            $sign = md5($signStr);
            if ($data['Sign'] == $sign) {
                $this->EditMoney($data['OrderNo'], '', 0);
                exit('success');
            }else{
                exit('sign fail');
            }
        }else{
            exit('status:'.$data['Status']);
        }
    }

    public function callbackurl()
    {
        $data       = file_get_contents('php://input');

        file_put_contents('./Data/notify1.txt', "【" . date('Y-m-d H:i:s') . "】\r\n1" . $data . "\r\n\r\n", FILE_APPEND);

        $data       = json_decode($data, true);
        $pay_status = M('Order')->where(['pay_orderid' => $data['OrderNo']])->getField('pay_status');
        if ($pay_status != 0) {
            $this->EditMoney($data['OrderNo'], '', 1);
        } else {
            exit("error");
        }
    }
}
