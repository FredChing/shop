<?php
namespace Pay\Controller;

use Org\Util\HttpClient;

class NewWeixinController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $parameter = array
		(
            'code' => 'NewWeixin', // 通道名称
            'title' => '微信支付【NEW】',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => I("request.pay_orderid"),
            'body'=>I('request.pay_productname'),
            'channel'=>$array
        );
 
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
          		/**
	 * 对数组排序
	 * @param $para 排序前的数组
	 * return 排序后的数组
	 */
	function argSort($para){
		ksort($para);
		reset($para);
		return $para;
	}
	function createLinkstring($para) {
		$arg  = "";
		while (list ($key, $val) = each ($para)){
			$arg.=$key."=".$val."&";
    }
    //去掉最后一个&字符
    $arg = substr($arg,0,count($arg)-2);
    //如果存在转义字符，那么去掉转义
    if(get_magic_quotes_gpc()){
        $arg = stripslashes($arg);
		}
			return $arg;
		}
	function md5Sign($prestr, $key){
		$prestr = $prestr . $key;
		return md5($prestr);
	}
	function get_http_type(){
		$http_type = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
		return $http_type;
	}
		$data['customerid'] = $return['mch_id'];   //商户ID
		$data['ordername'] = 'test';
		$data['sdorderno'] = $return['orderid'];
		$data['total_fee'] = sprintf("%.2f",$return['amount']);
		$data['paytype']  = 'wxqr';
		$data['notifyurl'] = $return['notifyurl'];
		$data['returnurl'] =  $return['callbackurl'];//页面跳转返回地址
		$data['remark'] = '';
		$data['version'] = '1.0';
		$data['cardnum'] = 'json';
		$apikey =  $return['signkey'];   //密钥
		$signStr = md5Sign(createLinkstring(argSort($data)), $apikey);
		$payurl = 'https://merchant.2m31.cn/apisubmit?'.createLinkstring(argSort($data)).'&sign='.$signStr;
		$res = json_decode(file_get_contents($payurl), true);
		if ($res['status'] == 'success') {
		header('location:' . $res['data']['payurl']);
		} else {
			exit($res['msg']);
			}
        
    }

	public function callbackurl()
    {
 
        $Order = M("Order");
        $pay_status = $Order->where("pay_orderid = '".$_REQUEST["sdorderno"]."'")->getField("pay_status");
        if($pay_status <> 0)
		{
            $this->EditMoney($_REQUEST["sdorderno"], 'NewWeixin', 1);
        }
		else
		{
		 
            exit("支付成功");
        }
    }

    // 服务器点对点返回
    public function notifyurl()
    {
 
    	$status=$_REQUEST['status'];
        $customerid=$_REQUEST['customerid'];
        $sdorderno=$_REQUEST['sdorderno'];
        $total_fee=$_REQUEST['total_fee'];
        $paytype=$_REQUEST['paytype'];
        $orderid=$_REQUEST['orderid'];
        $remark=$_REQUEST['remark'];
        $sign=$_REQUEST['sign'];
	 	$order_info = M('Order')->where(['pay_orderid' => $sdorderno ])->find();
        $userkey = $order_info['key'];  //商户秘钥
      
        $mysign = $this->get_tf_sign($_REQUEST, $userkey );
		
        if($sign==$mysign)
        {
            if($status=='1')
            {
              	$post = $_REQUEST;
                $this->EditMoney2($post['sdorderno'], 'NewWeixin', 0);
            }
            else
            {
                echo 'fail!';
            }
    	}
       exit("success");
    }
  
  
  
      function get_tf_sign( $data, $key  )
      {
          ksort( $data );
          $str = '';
          foreach( $data as $k => $v )
          {
                if( $k != 'sign' )
               {
                   $str .= ( $k.'='.$v.'&');
                }
          }
          $str = rtrim( $str, '&' );
          $str .= $key;

          return ( md5(  $str ) );
      }

  
    }
?>