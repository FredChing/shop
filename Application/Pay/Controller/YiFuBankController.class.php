<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;

class YiFuBankController extends PayController
{

    private $gateway = 'https://gateway.mkeybox.com/b2cPay/initPay';

    private $bankItem = [
        'CEB'  => 'CEB',
        'PSBC' => 'POST',
        'SHB'  => 'SHB',
        'CMBC' => 'CMBC',
        'BJB'  => 'BCCB',
        'CCB'  => 'CCB',
        'ICBC' => 'ICBC',
        'ABC'  => 'ABC',
    ];

    //支付
    public function Pay($array)
    {
        $return = $this->getParameter('逸付网关', $array, __CLASS__, 1);

        $encryp = encryptDecrypt(serialize($return), 'DDBank');

        $this->assign([
            'bank_array' => $this->bankItem,
            'rpay_url'   => U('YiFuBank/Rpay'),
            'orderid'    => I('post.pay_orderid', ''),
            'body'       => I('post.pay_productname', ''),
            'money'      => sprintf('%.2f', $return['amount']),
            'encryp'     => $encryp,
        ]);
        $this->display('BankPay/pc');
    }

    public function Rpay()
    {
        //接收传输的数据
        $data = I('post.', '');

        //将数据解密并反序列化
        $return = unserialize(encryptDecrypt($data['encryp'], 'DDBank', 1));
        //检测数据是否正确
        $return || $this->error('传输数据不正确！');

        $bankCode = I('post.bankCode', '');
        $bankCode || $this->error('请选择支付的银行');

        $param = [
            'payKey'          => $return['mch_id'],
            'orderPrice'      => $return['amount'],
            'outTradeNo'      => $return['orderid'],
            'productType'     => '50000103',
            'orderTime'       => date("Ymdhis", time()),
            'productName'     => "在线支付",
            'orderIp'         => getIP(),
            'bankCode'        => $bankCode,
            'bankAccountType' => 'PRIVATE_DEBIT_ACCOUNT',
            'returnUrl'       => $return['callbackurl'],
            'notifyUrl'       => $return['notifyurl'],
            'remark'          => "在线支付",
        ];
        $param['sign'] = strtoupper(md5Sign($param, $return['signkey'], '&paySecret='));
        echo createForm($this->gateway, $param);
    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $orderid    = I('request.outTradeNo', ''); //系统订单号
        $Order      = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($orderid, '', 1);
        }
    }

    public function notifyurl()
    {
        $data = I('request.', false);
        file_put_contents('./Data/cl_notify.txt',  serialize($data) . "\r\n\r\n", FILE_APPEND);
        if ($data['tradeStatus'] == 'SUCCESS') {
            $key  = getKey($data['outTradeNo']);
            $sign = strtolower($data['sign']);
            unset($data['sign']);
            $newSign = md5Sign($data, $key, '&paySecret=');echo $newSign;die;
            if ($newSign === $sign) {
                $this->EditMoney($data['outTradeNo'], '', 0);
                echo "success";
            } else {
				echo 'check sign fail';
			}
        }
    }

}
