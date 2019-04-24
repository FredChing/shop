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
class ZskjKjController extends PayController
{
    //支付方式code
    private $code = '';

    private $desc = '中升科技-快捷';

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
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);
        $this->topay($return);
    }

    public function topay($order = null)
    {
        if(is_array($order) && !empty($order) && isset($order['orderid']))
        {
            $this->view = Think::instance('Think\View');
            $this->assign('orderid', $order['orderid']);
            $this->assign('gateway', $order['gateway'] . '/payapi/order');
            $this->assign('rpay_url', $this->_site . "Pay_{$this->code}_topay.html");
            $this->assign('money', round($order['amount'], 4));
            $this->display('ZskjKj/kj');
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

            $accountNo = I("post.accountNo", '');
            if(!$accountNo)
            {
                $this->showmessage("请填写银行卡号");
            }

            $accountName = I("post.accountName", '');
            if(!$accountName)
            {
                $this->showmessage("请填写持卡人姓名");
            }

            $idCardNo = I("post.idCardNo", '');
            if(!$idCardNo)
            {
                $this->showmessage("请填写身份证号");
            }

            $phone = I("post.phone", '');
            if(!$phone)
            {
                $this->showmessage("请填写手机号");
            }


            $notifyurl   = $this->_site . "Pay_{$this->code}_notifyurl.html"; //异步通知
            $callbackurl = $this->_site . "Pay_{$this->code}_callbackurl_orderid_{$order['pay_orderid']}.html"; //返回通知

            $params = [
                'merchantNo'  => $order['memberid'],
                'orderAmount' => round($order['pay_amount'], 2) * 100,
                'orderNo'     => $order['pay_orderid'],
                'notifyUrl'   => $notifyurl,
                'callbackUrl' => $callbackurl,
                'payType'     => '6',
                'productName' => $order['pay_productname'],
                'productDesc' => $order['pay_productname'],
                'accountName' => $accountName,
                'accountNo'   => $accountNo,
                'idCardNo'    => $idCardNo,
                'phone'       => $phone,
            ];

            $params['sign'] = $this->_createSign($order['key'], $params);

            $response = json_decode(curlPost($gateway, http_build_query($params)), true);
            if($response['status'] == 'F')
            {
                $this->showmessage($response['errMsg']);
            }
            else if($response['status'] == 'T')
            {
                $this->ajaxReturn(['status' => 'success', 'url' => $response['payUrl']]);
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
        unset($list['sign']);
        ksort($list);
        $md5str = "";
        foreach($list as $key => $val)
        {
            if(!empty($val))
            {
                $md5str = $md5str . $key . "=" . $val . "&";
            }
            else if(is_numeric($val) && $val == '0')
            {
                $md5str = $md5str . $key . "=" . $val . "&";
            }
        }

        $sign = strtolower(md5(substr($md5str, 0, -1) . $Md5key));
        return $sign;
    }

    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        $data = $_POST;

        $orderId  = $data['orderNo'];
        $postSign = $data['sign'];


        $order_info = M('Order')->where(['pay_orderid' => $orderId])->find();
        if(empty($order_info))
        {
            exit('无效订单');
        }

        $validSign = $this->_createSign($order_info['key'], $data);
        if($validSign != $postSign)
        {
            echo "签名校验错误";
            Log::record("{$this->desc}异步通知：签名校验错误:\n" . json_encode($data), Log::ERR);
            return false;
        }

        if($data["orderStatus"] == "SUCCESS")
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