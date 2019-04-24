<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;


class DyQuickController extends PayController
{
    const PRIVATE_PEM = './cert/dyzf/rsa_private_key_M37.pem';
    const PUBLIC_PEM  = './cert/dyzf/dyzf.pem';
    const GATEWAY = 'http://111.231.217.165:28080';

    public function __construct()
    {
        parent::__construct();
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_DyQuick_notifyurl.html'; //异步通知
        $parameter = [
            'code' => 'DyQuick', // 通道名称
            'title' => '独依支付（快捷支付）',
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
        $card_no = I("post.card_no",'');
        $callbackurl = $this->_site . 'Pay_DyQuick_callbackurl_orderId_'.$return['orderid'].'.html'; //返回通知
        if($card_no) {
            $data['ORDERNO'] = $return['orderid'];//订单号
            $data['TXNAMT'] = $return['amount'];//订单金额
            $data['RETURNURL'] = $callbackurl;//前台通知地址
            $data['NOTIFYURL'] = $notifyurl;//后台通知地址
            $data['CARDNO'] = $card_no;//支持储蓄卡号
            $data['REMARK'] = '商品订单';//订单描述
            $trandata = $this->gen($data); // 参数拼接
            $arr['MERCNUM'] = $return['mch_id']; // 商户号
            $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
            $arr['TRANDATA'] = urlencode($trandata); // 支付主参数

            $url = self::GATEWAY.'/Pay/trans/quickWayPay';
            echo createForm($url, $arr);
        } else {
            $url = $this->_site . 'Pay_DyQuick_topay_orderid_'.$return["orderid"].'.html';
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
            $card_no = I("post.card_no");
            if(!$card_no) {
                $this->showmessage("银行卡号不能为空");
            }
            $notifyurl = $this->_site . 'Pay_DyQuick_notifyurl.html'; //异步通知
            $callbackurl = $this->_site . 'Pay_DyQuick_callbackurl_orderId_'.$orderid.'.html'; //返回通知
            $data['ORDERNO'] = $orderid;//订单号
            $data['TXNAMT'] = round($order['pay_amount'],4)*100;//订单金额
            $data['RETURNURL'] = $callbackurl;//前台通知地址
            $data['NOTIFYURL'] = $notifyurl;//后台通知地址
            $data['CARDNO'] = $card_no;//支持储蓄卡号
            $data['REMARK'] = '商品订单';//订单描述
            $trandata = $this->gen($data); // 参数拼接

            $arr['MERCNUM'] = $order['memberid']; // 商户号
            $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
            $arr['TRANDATA'] = urlencode($trandata); // 支付主参数
            $url = self::GATEWAY.'/Pay/trans/quickWayPay';
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
            $rpay_url = $this->_site . 'Pay_DyQuick_topay.html';
            $this->assign('orderid', $orderid);
            $this->assign('rpay_url', $rpay_url);
            $this->assign('money', round($order['pay_amount'],4));
            $this->display('DyBank/quick');
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
                    $this->EditMoney($data['ORDERNO'], 'DyQuick', 0);
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