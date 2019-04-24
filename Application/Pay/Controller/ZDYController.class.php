<?php

namespace Pay\Controller;
class ZDYController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_ZDY_notifyurl.html'; //异步通知
        $parameter = array(
            'code' => 'ZDY',       // 通道代码
            'title' => '自定义',      //通道名称
            'exchange' => 1,          // 金额比例
            'gateway' => '',            //网关地址
            'orderid' => '',            //平台订单号（有特殊需求的订单号接口使用）
            'out_trade_id' => $orderid,   //外部商家订单号
            'body' => $body,              //商品名称
            'channel' => $array,          //通道信息
        );
        $return = $this->orderadd($parameter);
        $url = "https://api.sytapi.com";
//从网页传入price:支付价格， istype:支付渠道：1-支付宝；2-微信支付
        $price = $return['amount'];
        $istype =  $return['appid'];
        $codeid = $return['orderid'];
        $callbackurl = I('post.pay_callbackurl', '');
//校验传入的表单，确保价格为正常价格（整数，1位小数，2位小数都可以），支付渠道只能是1或者2，orderuid长度不要超过33个中英文字。

//此处就在您服务器生成新订单，并把创建的订单号传入到下面的orderid中。

        $uid = $return["mch_id"];//"此处填写SytApi的uid";
        $token = $return["signkey"];//"此处填写SytApi的Token";
        $key = md5($codeid . $istype . $notifyurl . $orderid . $price . $callbackurl . $token . $uid);
//经常遇到有研发问为啥key值返回错误，大多数原因：1.参数的排列顺序不对；2.上面的参数少传了，但是这里的key值又带进去计算了，导致服务端key算出来和你的不一样。

        $returndata['istype'] = $istype;
        $returndata['codeid'] = $codeid;
        $returndata['key'] = $key;
        $returndata['notify_url'] = $notifyurl;
        $returndata['orderid'] = $orderid;
        $returndata['price'] = $price;
        $returndata['return_url'] = $callbackurl;
        $returndata['uid'] = $uid;
        $returndata['str'] = $codeid . $istype . $notifyurl . $orderid . $price . $callbackurl . $token . $uid;

        $notifystr = "";
        foreach ($returndata as $key => $val) {
            $notifystr = $notifystr . $key . "=" . $val . "&";
        }
        $notifystr = rtrim($notifystr, '&');
        $opts = [
            'http' => [
                'method' => 'POST',
                'header' => 'Content-type: application/x-www-form-urlencoded',
                'content' => $notifystr
            ]
        ];
        $context = stream_context_create($opts);
        $html = file_get_contents($url, false, $context);
        echo $html;
    }

    public function notifyurl()
    {
        file_put_contents('./ps', json_encode($_POST));

        $order = $_GET['codeid'];
        $this->EditMoney($order, 'ZDY', 0);
        echo 'success';
    }

}
