<?php
namespace Pay\Controller;
class PsCodePlusController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_PsCodePlus_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_PsCodePlus_callbackurl.html'; //跳转通知
        $parameter = array(
            'code' => 'PsCodePlus',       // 通道代码
            'title' => 'TCP个人码',      //通道名称
            'exchange' => 1,          // 金额比例
            'gateway' => '',            //网关地址
            'orderid' => '',            //平台订单号（有特殊需求的订单号接口使用）
            'out_trade_id'=>$orderid,   //外部商家订单号
            'body'=>$body,              //商品名称
            'channel'=>$array,          //通道信息
        );
        $return = $this->orderadd($parameter);
$url = "http://".$_SERVER['SERVER_ADDR'].":8080/PayHelper/thirdParty/qrcode";
$query_str = [
    'userId' => $return['mch_id'],      //商户 id
    'type'   => 'alipay',   //weixin  alipay
    'money'  => $return['amount'],
    'remark' => $return['orderid'].$return['unlockdomain'],   //备注  随机 唯一
    'thirdPartyOrderId' => $return['orderid'] //商户订单号
];

$postdata = http_build_query($query_str);
$opts = [
    'http' =>[
            'method'  => 'POST',
            'header'  => 'Content-type: application/x-www-form-urlencoded',
            'content' => $postdata
         ]
];
$context = stream_context_create($opts);
$result = file_get_contents($url, false, $context);
$res2arr = json_decode($result,true);
//dump($result);
if(1==$res2arr['code']&&'SUCCESS'==$res2arr['define'])
{
   $url = $res2arr['payUrl'];
   if(isMobile()){
    //header('Location: '.$url);
	header('Location: '.$this->_site . "alipay.php?payUrl=".urlencode($url));
    return;
   }
   $this->showQRcode($url,$return,'alipay');
   return;
}
    echo $res2arr['define'];        

    }

    public function callbackurl()
    {
       $callbackurl = I("request.callbackurl");
       header('Location: '.$callbackurl);
       echo 'ok';
    }  
 
    public function notifyurl()
    {
      file_put_contents('./ps',json_encode($_POST));  

       $order = $_POST['mark'];
       $order = substr($order,0,20);
       $this->EditMoney($order,'PsCodePlus',0);
       echo 'success';
    }  
  
}
