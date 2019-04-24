<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;


class DyBankController extends PayController
{
    const PRIVATE_PEM = './cert/dyzf/rsa_private_key_M37.pem';
    const PUBLIC_PEM  = './cert/dyzf/dyzf.pem';
    const GATEWAY = 'http://111.231.217.165:28080';
    protected $bankItem = [
        'YLBILL' => 'unionpay',//银联通道
        'CCB' => 'CCB',//建设银行
        'ABC' => 'ABC',//农业银行
        'ICBC' => '102',//工商银行
        'BOC'  => '104',//中国银行
        'SPDB' => '3004',//浦发银行
        'CEB' => '3022' ,//光大银行
        'PABC' => '3035',//平安银行
        'CIB'  => '3009',//兴业银行
        'PSBC' =>'403',//邮储银行
        'CITIC' =>'3039' ,//中信银行
        'HXB'  => 'HXB',//华夏银行
        'CMB'  => '3001',//招商银行
        'GDB'  => '306',//广发银行
        'BJBANK' => '370',//北京银行
        'BOS'  => '420',//上海银行
        'CMBC' => '305',//民生银行
        'BCOM' => '301',//交通银行
        'BJRCB' => '北京农商银行',//北京农村商业银行
    ];

    public function __construct()
    {
        parent::__construct();
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_DyBank_notifyurl.html'; //异步通知
        $parameter = [
            'code' => 'DyBank', // 通道名称
            'title' => '独依支付（网关支付）',
            'exchange' => 100, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body' => $body,
            'channel' => $array
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $return['subject'] = $body;
        $callbackurl = $this->_site . 'Pay_DyBank_callbackurl_orderId_'.$return['orderid'].'.html'; //返回通知
        $opnbnk = I("post.bank_code");
        if($opnbnk) {
            if (!array_key_exists($opnbnk, $this->_bank_code)) {
                $this->showmessage('银行渠道错误');
            }
            $data['ORDERNO'] = $return['orderid'];//订单号
            $data['TXNAMT'] = $return['amount'];//订单金额
            $data['RETURNURL'] = $callbackurl;//前台通知地址
            $data['NOTIFYURL'] = $notifyurl;//后台通知地址
            $data['OPNBNK'] = $opnbnk;//银行渠道
            $data['REMARK'] = '商品订单';//订单描述
            $trandata = $this->gen($data); // 参数拼接
            $arr['MERCNUM'] = $return['mch_id']; // 商户号
            $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
            $arr['TRANDATA'] = urlencode($trandata); // 支付主参数

            $url = self::GATEWAY.'/Pay/trans/gateWayPay';
            echo createForm($url, $arr);
        } else {
            $url = $this->_site . 'Pay_DyBank_topay_orderid_'.$return["orderid"].'.html';
            echo '<script type="text/javascript">window.location.href="'.$url.'"</script>';
            exit;
        }
    }

    //填写银行卡号
    public function topay()
    {
        if(IS_POST) {
            $orderid = I("post.orderid");
            if(!$orderid) {
                $this->showmessage("参数错误");
            }
            $order = M('order')->where(array('pay_orderid'=>$orderid))->find();
            if(empty($order)) {
                $this->showmessage("订单不存在");
            }
            if($order['pay_status'] != 0) {
                $this->showmessage("订单已支付");
            }
            $opnbnk = I("post.bank_code");
            if(!$opnbnk) {
                $this->showmessage("银行渠道不能为空");
            }
            $notifyurl = $this->_site . 'Pay_DyBank_notifyurl.html'; //异步通知
            $callbackurl = $this->_site . 'Pay_DyBank_callbackurl_orderId_'.$orderid.'.html'; //返回通知
            $data['ORDERNO'] = $orderid;//订单号
            $data['TXNAMT'] = round($order['pay_amount'],4)*100;//订单金额
            $data['RETURNURL'] = $callbackurl;//前台通知地址
            $data['NOTIFYURL'] = $notifyurl;//后台通知地址
            $data['OPNBNK'] = $opnbnk;//银行渠道
            $data['REMARK'] = '商品订单';//订单描述
            $trandata = $this->gen($data); // 参数拼接

            $arr['MERCNUM'] = $order['memberid']; // 商户号
            $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
            $arr['TRANDATA'] = urlencode($trandata); // 支付主参数
            $url = self::GATEWAY.'/Pay/trans/gateWayPay';
            echo createForm($url, $arr);
        } else {
            $orderid = I("orderid");
            if(!$orderid) {
                $this->showmessage("参数错误");
            }
            $order = M('order')->where(array('pay_orderid'=>$orderid))->find();
            if(empty($order)) {
                $this->showmessage("订单不存在");
            }
            if($order['pay_status'] != 0) {
                $this->showmessage("订单已支付");
            }
            $rpay_url = $this->_site . 'Pay_DyBank_topay.html';
            $this->assign('order', $order);
            $this->assign('orderid', $orderid);
            $this->assign('rpay_url', $rpay_url);
            $this->assign('money', round($order['pay_amount'],4));
            $this->assign('bank_array', $this->bankItem);
            $this->display('DyBank/wg');
        }
    }


    //同步通知
    public function callbackurl()
    {
        $orderId = I('get.orderId', '');
        if(!$orderId) {
            exit('error');
        }
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderId])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($orderId, '', 1);
        } else {
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents('./Data/dyzf_notify.txt',"【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        $data = I('post.');
        if($data['RECODE'] == '000000') {
            $signData['ORDERNO'] = $data['ORDERNO'];
            $signData['TXNAMT'] = $data['TXNAMT'];
            $signData['ORDSTATUS'] = $data['ORDSTATUS'];
            $signStr = $this->gen($signData);
            $pubkeyid = openssl_pkey_get_public(file_get_contents(self::PUBLIC_PEM));
            $res = openssl_verify($signStr, base64_decode($data['SIGN']), $pubkeyid);
            if ($res == 1) {
                if($data['ORDSTATUS'] == '01') {
                    $this->EditMoney($data['ORDERNO'], 'DyBank', 0);
                    exit('success');
                } else {
                    exit('fail');
                }
            } else {
                exit('check sign fail');
            }
        } else {
            exit('fail');
        }

    }

    // 参数拼接
    private function gen($param)
    {
        $buff = "";
        foreach ($param as $k => $v) {
            if ($v !== "") {
                $buff .= $k . '=' . $v . '&';
            }
        }
        $string = rtrim($buff, '&');
        return $string;
    }

    // 生成签名字符串
    private function gen_sign($string)
    {
        $signature = '';
        $privatekey = openssl_pkey_get_private(file_get_contents(self::PRIVATE_PEM));
        $res = openssl_get_privatekey($privatekey);
        openssl_sign($string, $signature, $res);
        openssl_free_key($res);
        return base64_encode($signature);
    }
}