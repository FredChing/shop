<?php

/**
 * @author zhangjianwei
 * @date   2018-06-01
 */

namespace Pay\Controller;

use Think\Log;
use Think\Think;


/**
 * 天下支付-天付宝-银联H5
 * 官网地址：http://www.tfb8.com/
 * @package Pay\Controller
 */
class TfbYlwapController extends PayController
{

    //支付方式code
    private $code = '';

    private $exchange = 1;

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    public function Pay($channel)
    {
        $exchange = $this->exchange;
        $return   = $this->getParameter('天下支付-天付宝-银联H5', $channel, __CLASS__, $exchange);
        $this->topay($return);
    }

    public function topay($order = null)
    {
        if(is_array($order) && !empty($order) && isset($order['orderid']))
        {
            $this->view = Think::instance('Think\View');
            $this->assign('orderid', $order['orderid']);
            $this->assign('gateway', $order['gateway']);
            $this->assign('rpay_url', $this->_site . "Pay_{$this->code}_topay.html");
            $this->assign('money', round($order['amount'], 4));
            $this->display('TfbYlwap/kj');
        }
        else
        {
            $gateway = I("post.gateway");
            $orderid = I("post.orderid");
            if(!$orderid)
            {
                $this->showmessage("参数错误");
            }
            $order = M('order')->where(array('pay_orderid' => $orderid))->find();
            if(empty($order))
            {
                $this->showmessage("订单不存在");
            }
            if($order['pay_status'] != 0)
            {
                $this->showmessage("订单已支付");
            }
            $card_type = I("post.card_type", 0);
            if(!$card_type)
            {
                $this->showmessage("银行卡类型不能为空");
            }
            $bank_accno = I("post.bank_accno");
            if(!$bank_accno)
            {
                $this->showmessage("银行卡号不能为空");
            }

            $notifyurl   = $this->_site . "Pay_{$this->code}_notifyurl.html"; //异步通知
            $callbackurl = $this->_site . "Pay_{$this->code}_callbackurl.html"; //返回通知
            $parameter   = array(
                "spid"         => $order['memberid'],
                "sp_userid"    => $order['pay_memberid'],
                "spbillno"     => $order['pay_orderid'],
                "money"        => intval(round($order['pay_amount'], 2) * 100),
                "cur_type"     => 1,//交易币种：RMB
                "return_url"   => $callbackurl,
                "notify_url"   => $notifyurl,
                "memo"         => 'trade',
                "bank_accno"   => $bank_accno,
                "bank_acctype" => sprintf('%02d', $card_type),
                "encode_type"  => 'MD5',
            );

            $parameter['sign'] = $this->_createSign($parameter, $order['key']);

            $this->params_log($parameter);
            echo createForm($gateway, $parameter);
        }
    }

    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        $data = $_GET;

        $retcode = $data['retcode'];
        $retmsg  = $data['retmsg'];

        unset($data['retcode']);
        unset($data['retmsg']);

        $orderId = $data['spbillno'];
        $key     = getKey($orderId);
        if(empty($key))
        {
            exit('无效的订单');
        }

        $sign = $this->_createSign($data, $key);

        if($sign == $data['sign'])
        {
            if($retcode == "00")
            {
                //修改订单信息
                $this->EditMoney($orderId, '', 0);
                Log::record("天下支付-天付宝-银联H5异步通知：" . "交易成功！订单号：" . $orderId, Log::INFO);
                exit("<retcode>00</retcode>");
            }
            else
            {
                Log::record("天下支付-天付宝-银联H5异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($data), Log::ERR);
                exit("交易失败");
            }
        }
        else
        {
            Log::record("天下支付-天付宝-银联H5异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($data), Log::ERR);
            exit('验签失败');
        }
    }

    //同步回调地址
    public function callbackurl()
    {
        $data = $_GET;

        $orderId = $data['spbillno'];
        $key     = getKey($orderId);
        if(empty($key))
        {
            exit('无效的订单');
        }

        $sign = $this->_createSign($data, $key);

        if($sign == $data['sign'])
        {
            $Order      = M("Order");
            $pay_status = $Order->where(['pay_orderid' => $orderId])->getField("pay_status");
            if($pay_status == 0)
            {
                sleep(3);//等待3秒
                $pay_status = M('Order')->where(['pay_orderid' => $orderId])->getField("pay_status");
            }
            if($pay_status <> 0)
            {
                $this->EditMoney($orderId, '', 1);
            }
            else
            {
                exit('页面已过期请刷新');
            }
        }
        else
        {
            exit('验签失败');
        }
    }

    /**
     * 规则是:按参数名称a-z排序,遇到空值的参数不参加签名。
     */
    private function _createSign($data, $key)
    {
        // 参数原串
        $signPars = "";
        // 按照键名排序
        ksort($data);
        // 生成原串
        foreach($data as $k => $v)
        {
            // 值不为空或键不是sign
            if("" != $v && "sign" != $k)
            {
                $signPars .= $k . "=" . mb_convert_encoding($v, 'GBK', 'UTF-8') . "&";
            }
        }
        // md5签名
        // 再拼接key字段
        $signPars .= "key=" . $key;
        $sign     = md5($signPars);

        return $sign;
    }

    public function params_log($data){
        file_put_contents("./Data/{$this->code}_params.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . http_build_query($data) . "\r\n\r\n", FILE_APPEND);
    }

    public function log()
    {
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . $_SERVER["QUERY_STRING"] . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }
}