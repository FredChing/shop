<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;

use Think\Exception;

class KDmfH5Controller extends PayController
{
    public function __construct()
    {
       
        parent::__construct();
        if( strpos( $_SERVER['REQUEST_URI'] , 'notifyurl' ) !== false  )
        {
            $this->notifyurl();
            exit;
        }
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_KDmfH5_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_KDmfH5_callbackurl.html'; //返回通知

        $parameter = array(
            'code' => 'KDmfH5', // 通道名称
            'title' => '单面付H5',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body'=>$body,
            'channel'=>$array
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
		
		$app_id = $return['mch_id'];
		$notify_url = $return['notifyurl'];
      	$callback_url = $return['callbackurl'];
		$config =  array(
			'merchant_id' => $return['mch_id'],
			'merchant_key' =>  $return['signkey'],
			'notify_url' =>    $return['notifyurl'],
			'callback_url' =>   $return['callbackurl'],
		);
		 	$subject =  $return['orderid'];
		$body = $return['orderid'];
        $alipay_pkey = $return['signkey'];
      
		header("Content-type: text/html; charset=utf-8");
		require_once dirname( __FILE__ ).'/dmf/pay/model/builder/AlipayTradePrecreateContentBuilder.php';
		require_once dirname( __FILE__ ).'/dmf/pay/service/AlipayTradeService.php';
	

		// 业务扩展参数，目前可添加由支付宝分配的系统商编号(通过setSysServiceProviderId方法)，系统商开发使用,详情请咨询支付宝技术支持
		$providerId = ""; //系统商pid,作为系统商返佣数据提取的依据
		$extendParams = new \ExtendParams();
		$extendParams->setSysServiceProviderId($providerId);
		$extendParamsArr = $extendParams->getExtendParams();

		// 支付超时，线下扫码交易定义为5分钟
		$timeExpress = "4m";

		// 商品明细列表，需填写购买商品详细信息，
		$goodsDetailList = array();

		// 创建一个商品信息，参数含义分别为商品id（使用国标）、名称、单价（单位为分）、数量，如果需要添加商品类别，详见GoodsDetail
		$goods1 = new \GoodsDetail();
		$goods1->setGoodsId("apple-01");
		$goods1->setGoodsName("iphone");
		$goods1->setPrice(3000);
		$goods1->setQuantity(1);
		//得到商品1明细数组
		$goods1Arr = $goods1->getGoodsDetail();

		// 继续创建并添加第一条商品信息，用户购买的产品为“xx牙刷”，单价为5.05元，购买了两件
		$goods2 = new \GoodsDetail();
		$goods2->setGoodsId("apple-02");
		$goods2->setGoodsName("ipad");
		$goods2->setPrice(1000);
		$goods2->setQuantity(1);
		//得到商品1明细数组
		$goods2Arr = $goods2->getGoodsDetail();

		$goodsDetailList = array($goods1Arr,$goods2Arr);

		$appAuthToken = "";//根据真实值填写
		$outTradeNo = $return['orderid'];
		$totalAmount = $return['amount'];
		$qrPayRequestBuilder = new \AlipayTradePrecreateContentBuilder();
		$qrPayRequestBuilder->setOutTradeNo($outTradeNo);
		$qrPayRequestBuilder->setTotalAmount($totalAmount);
		$qrPayRequestBuilder->setTimeExpress($timeExpress);
		$qrPayRequestBuilder->setSubject($subject);
		$qrPayRequestBuilder->setBody($body);
		$qrPayRequestBuilder->setUndiscountableAmount($undiscountableAmount);
		$qrPayRequestBuilder->setExtendParams($extendParamsArr);
		$qrPayRequestBuilder->setGoodsDetailList($goodsDetailList);

		$qrPayRequestBuilder->setAppAuthToken($appAuthToken);
		
		// 调用qrPay方法获取当面付应答
		$qrPay = new \AlipayTradeService($config);
	
		$qrPayResult = $qrPay->qrPay($qrPayRequestBuilder);
 
		//	根据状态值进行业务处理
		$res = $qrPayResult->getTradeStatus();
		if( $res == "SUCCESS" )
		{
			#$response = $qrPayResult->getResponse();
			#header("Location: ". $response->qr_code );
			#exit;
          
          	$response = $qrPayResult->getResponse();
          	$code_url = $response->qr_code;
          	$payorderid = $return['orderid'];
          	$paymoney = $return['amount'];
          	include dirname(__FILE__).'/page/aliwap.php';
          
          
		}
		else
		{
			echo "<Pre>";
			print_r( $res );
			exit;
		}


    }
 
	
	
    //同步通知
    public function callbackurl()
    {
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $_REQUEST["out_trade_no"]])->getField("pay_status");
        if($pay_status <> 0){
            $this->EditMoney($_REQUEST["out_trade_no"], 'KDmfH5', 1);
        }else{
            exit("支付完成");
        }

    }

    //异步通知
       public function notifyurl()
    {
	 error_reporting( 0 );
        file_put_contents( dirname( __FILE__ ).'/dmf_post.txt', var_export($_POST, true), FILE_APPEND );
        file_put_contents( dirname( __FILE__ ).'/dmf_get.txt', var_export($_GET, true), FILE_APPEND );
        file_put_contents( dirname( __FILE__ ).'/dmf_input.txt', file_get_contents("php://input"), FILE_APPEND );

        
         error_reporting( 0 );

         $conf = M('Order')->where( ['pay_orderid' => $_POST['out_trade_no' ] ] )->find();
         $alipay_pkey =  $conf['key'];
		 $app_id = $_POST['app_id'];
         $config = array (
            //签名方式,默认为RSA2(RSA2048)
            'sign_type' => "RSA2",

            //支付宝公钥
            'alipay_public_key' => $alipay_pkey,//"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsmfc8m+hNQqePJzBQaCfzdkGq6FinfFGM9SpfkkZYhjStdjcOUc+4OTZqa1T5u5dMpZ3Zl8rPHpUpTjrpIszdvEa3l3pBprE0Xr6e2zyj9qKJqap1FuBoPHhfXKyScwm3H5ZfEK9Yf3UrFybzb33iC/rKhJKMGhYy/VQTkSFIqpKg3c5cHeMImNsJssQKwB2e5sCpoz7X13ezZgdUucLDB9g2z/RkYzt0oU9ZZTjDuZiZPvLL/RHs9UFI8O6gvUbku8gCN5yZMHaZ6VRJhlrh/WzUe37r/G5sdhziBNeH+strW888p+8hjG0siLHmMJ7sn3AyVblwF24rbCXkd7F5wIDAQAB",

            //商户私钥
            'merchant_private_key' => 
        "MIIEpAIBAAKCAQEAxlDUUNOMDGnlQe9/AdDXBRD7CrkHqGOk/CJTu43iqeKKJhA39kK9dX/AlTlizYHSx4preuLZ/Q4wRv+9fcZbWDNxaypTjJnk8V8Huwq/ZVp0J8gFIKX1ABPXGmo4VI7fm31usA6XDMsnFc8V/ScvgndQLaAujixuXjpNZLwtEfc8aJhuTvaGn1jS72+63asg6HNtS/HhqS0wPnEC1VnogsPRROIpzjMwdkTmmISB4k7STLmRRkC+myPbYZAhXxLlKgWvyrZLb6p0K2uCpKnpMdfcnMZxFD8TZ1WNHzLP13dGHncCTKY56Tm1bult56kz2gnqJ23R5kb59xojudZ3qwIDAQABAoIBABaMwleedmJC+EqTDQIL2Sc+Uw1ZFMHU8sGotZSyAYAHvmWtmm9qD1j4+dD+AXoUtP7zgl0qxla78klgcw+GKoTQ9KiW24E1To8TmzFte23u5x5O5CZeOImVt/PM+DLFPC/WB2wFfK97uioErh9nAUP4hSlq+WA5NSOJxZsaupU8MGT4MihuTtCHjUn2Mw5PGPXezpZIHRviYoLdUvfC8p/onnQGiuyZwrGPS0ZdvuVktABQtNdir9MDwGEW/JFbkH1hXFlz7Q6M0ZvqDs/pNoRdau2kBgbuWdhDIqgq0l40KiFCOwXMgSJrkOjq2tNis3d2Mr9wtu6ypsxG7pQ3EIECgYEA5pKQd+cQkwBN03x470Iz10NpijQMtvr5CRYgamOLh5exKUI2+WSTs5CX64uZvuAyjxsv3aK8dwdwGxWuuqmTOVtfhhLl3f9VWvbUhOnoUqbD6BKnoVhWoSAfpDzY0TmgoOn4fyAgE1Be3+I/EYCoN9mFriKkBz+plNKs1VnJqzECgYEA3C+anKdd8F0A53y86NvWrV+ECAUdQId4gJH9rDHX6l7M6Cj5ADXLe/Vo7sOA6RnlhjdI8MjFk+uGA3Zc4Ntri57EDzz1Kvu98F5f7q8TQ+dr7HbrJ9n9CBsRQfOdYI5/ps4b+k9OQqqOl9WjxiIbi2L7+4QNCtfBEi6JPYCyoZsCgYBvALp6bwxkqO3O1grmrMmGZdbmiR5h7Tt9a2CZt2jSE25f/Ze3wvr0pLTu2htfcFIG4UDPA+yVpUgMUgj3pnHRWDMJugleMfGmxFQV1QJa4BxKmsiG/Z9fHLb++6gqOgMh1OIkWZP3mGbEhAh25aiWkqsv5U9wie6bTj2UzRAw0QKBgQDaN5ecv8a67AF0akxy30Vwh+Q7ao4mINzNV2K4IKHjVlbvk4PLsITdckevsjR1UMQH84ynjeM6iUZE8i50byGzuwKGM5yrH9mLeozK6dpHBvkP3n+J/GHogaLl4QHM6w0aDNTvi199dLljQ0lPmQgBaXVgPOwMHe3sDhDX0k+3FwKBgQCvhM9Z7H7rXXCmwn8vtLGVqAN23wIaJGC9LuNmkRykydMmnNkmHzxfcudR/do6PicOpLst2fm49jimHU/tqXWnmFGfsDIN6oHn+h/90IIjq0eTLmoV9225HauigkhUMEgVD72pgGYIrH1GoDDyySL1PZORLLrXaX2ygQLFJPRV0w==",

            //编码格式
            'charset' => "UTF-8",

            //支付宝网关
            'gatewayUrl' => "https://openapi.alipay.com/gateway.do",

            //应用ID
            'app_id' => $app_id,

            //异步通知地址,只有扫码支付预下单可用
            'notify_url' => 'http://www.baidu.com',

            //最大查询重试次数
            'MaxQueryRetry' => "10",

            //查询间隔
            'QueryDuration' => "3"
        );
   
          require_once   dirname( __FILE__ ).'/dmf/pay/service/AlipayTradeService.php';
			        
          $arr=$_POST;

          $alipaySevice = new \AlipayTradeService($config); 
     	 
          $result = $alipaySevice->check($arr);

          if($result) 
          {
              $out_trade_no = $_POST['out_trade_no']; //订单号
              $trade_no = $_POST['trade_no']; 	//支付宝交易号
              $jine=$_POST['total_amount'];		//订单金额
              $trade_status = $_POST['trade_status']; //订单状态
              $this->EditMoney2( $out_trade_no, 'DmfSm', 0 );		
          }

          echo 'success';
         
         
        
	 
    }

}