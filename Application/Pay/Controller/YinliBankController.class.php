<?php

/**
 * @author zhangjianwei
 * @date   2018-06-01
 */

namespace Pay\Controller;

use Think\Log;
use Think\Think;


/**
 * 中升科技-快捷
 * @package Pay\Controller
 */
class YinliBankController extends PayController
{
    //支付方式code
    private $code = '';

    private $desc = '引力支付-银联';

    private $exchange = 1;

    private $gateway = 'https://www.yinlpay.com/cashier/Home';

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
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);
        $this->topay($return);
    }

    public function topay($order = null)
    {
        if(is_array($order) && !empty($order) && isset($order['orderid']))
        {
            $this->view = Think::instance('Think\View');
            $this->assign('product_name', $order['subject']);
            $this->assign('orderid', $order['orderid']);
            $this->assign('gateway', $this->gateway);
            $this->assign('rpay_url', $this->_site . "Pay_{$this->code}_topay.html");
            $this->assign('money', round($order['amount'], 4));
            $this->display('YinliBank/bank');
        }
        else
        {
            $gateway     = I("post.gateway");
            $orderid     = I("post.orderid");
            $bankSegment = I("post.bankSegment");
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


            $notifyurl   = $this->_site . "Pay_{$this->code}_notifyurl.html"; //异步通知
            $callbackurl = $this->_site . "Pay_{$this->code}_callbackurl_orderid_{$order['pay_orderid']}.html"; //返回通知

            $params = [
                'mch_id'        => $order['memberid'],
                'out_trade_no'  => $order['pay_orderid'],
                'notify_url'    => $notifyurl,
                'callback_url'  => $callbackurl,
                'total_fee'     => round($order['pay_amount'], 2),
                'service'       => 'wy',
                'way'           => 'wap',
                'format'        => 'json',
                'mch_create_ip' => get_client_ip(),
                'goods_tag'     => $bankSegment,
            ];

            $params['sign'] = $this->_createSign($order['key'], $params);


            $url      = sprintf('%s?%s', $gateway, http_build_query($params));
            $response = json_decode(file_get_contents($url), true);
            if($response['success'] === false)
            {
                $this->showmessage($response['msg']);
            }
            else if($response['success'] === true)
            {
                $this->ajaxReturn(['status' => 'success', 'url' => $response['pay_info']]);
            }
            else
            {
                $this->showmessage('支付服务异常');
            }
        }
    }


    /**
     * 创建签名
     *
     * @param $Md5key
     * @param $list
     *
     * @return string
     */
    private function _createSign($Md5key, $list)
    {

        $sign = md5(sprintf(
            '%s%s%s%s%s%s%s%s%s',
            $list['mch_id'],
            $list['out_trade_no'],
            $list['callback_url'],
            $list['notify_url'],
            $list['total_fee'],
            $list['service'],
            $list['way'],
            $list['format'],
            $Md5key
        ));

        return $sign;
    }

    /**
     * 生成异步校验签名
     * @param $Md5key
     * @param $list
     *
     * @return string
     */
    private function _validSign($Md5key, $list)
    {

        $sign = md5(sprintf(
            '%s%s%s%s%s%s%s%s%s%s%s',
            $list['mch_id'],
            $list['time_end'],
            $list['out_trade_no'],
            $list['ordernumber'],
            $list['transtypeid'],
            $list['transaction_id'],
            $list['total_fee'],
            $list['service'],
            $list['way'],
            $list['result_code'],
            $Md5key
        ));

        return $sign;
    }

    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        $data = $_GET;

        $orderId  = $data['out_trade_no'];
        $postSign = $data['sign'];

        $order_info = M('Order')->where(['pay_orderid' => $orderId])->find();
        if(empty($order_info))
        {
            exit('无效订单');
        }

        $validSign = $this->_validSign($order_info['key'], $data);
        if(strtolower($validSign) != strtolower($postSign))
        {
            echo "签名校验错误";
            Log::record("{$this->desc}异步通知：签名校验错误:\n" . json_encode($data), Log::ERR);
            return false;
        }

        if($data["result_code"] == "0")
        {
            //修改订单信息
            $this->EditMoney($orderId, '', 0);
            Log::record("{$this->desc}异步通知：" . "交易成功！订单号：" . $orderId, Log::INFO);
            exit("SUCCESS");
        }
        else
        {
            Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($data), Log::ERR);
            exit("FAIL");
        }
    }

    //同步回调地址
    public function callbackurl()
    {
        $pay_orderid = $_REQUEST['orderid'];

        $Order      = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $pay_orderid])->getField("pay_status");
        if($pay_status == 0)
        {
            sleep(3);//等待3秒
            $pay_status = M('Order')->where(['pay_orderid' => $pay_orderid])->getField("pay_status");
        }
        if($pay_status <> 0)
        {
            $this->EditMoney($pay_orderid, '', 1);
        }
        else
        {
            exit('页面已过期请刷新');
        }
    }

    public function log()
    {
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . $_SERVER["QUERY_STRING"] . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_SERVER['HTTP_API_SIGN']) . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode(getallheaders ()) . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }
}