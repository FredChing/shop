<?php
namespace Pay\Controller;

use Org\Util\HttpClient;

class DUYIQUICKController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $parameter = array
		(
            'code' => 'DUYIQUICK', // 通道名称
            'title' => '快捷支付',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => I("request.pay_orderid"),
            'body'=>I('request.pay_productname'),
            'channel'=>$array
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
		$ORDERNO = $return['orderid'];
		$TXNAMT = $return['amount'];
		$MERCNUM = $return['mch_id'];
		$NOTIFYURL = 'http://s.91dpays.com/Pay_DUYIQUICK_notifyurl.html';//$return['notifyurl'];
		$RETURNURL = $return['callbackurl'];
		include dirname(__FILE__ ).'/duyi/send.php';


		exit;

    }

	function real_ip()
	{
		static $realip = NULL;

		if ($realip !== NULL)
		{
			return $realip;
		}

		if (isset($_SERVER))
		{
			if (isset($_SERVER['HTTP_X_FORWARDED_FOR']))
			{
				$arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);

				/* 取X-Forwarded-For中第一个非unknown的有效IP字符串 */
				foreach ($arr AS $ip)
				{
					$ip = trim($ip);

					if ($ip != 'unknown')
					{
						$realip = $ip;

						break;
					}
				}
			}
			elseif (isset($_SERVER['HTTP_CLIENT_IP']))
			{
				$realip = $_SERVER['HTTP_CLIENT_IP'];
			}
			else
			{
				if (isset($_SERVER['REMOTE_ADDR']))
				{
					$realip = $_SERVER['REMOTE_ADDR'];
				}
				else
				{
					$realip = '0.0.0.0';
				}
			}
		}
		else
		{
			if (getenv('HTTP_X_FORWARDED_FOR'))
			{
				$realip = getenv('HTTP_X_FORWARDED_FOR');
			}
			elseif (getenv('HTTP_CLIENT_IP'))
			{
				$realip = getenv('HTTP_CLIENT_IP');
			}
			else
			{
				$realip = getenv('REMOTE_ADDR');
			}
		}

		preg_match("/[\d\.]{7,15}/", $realip, $onlineip);
		$realip = !empty($onlineip[0]) ? $onlineip[0] : '0.0.0.0';

		return $realip;
	}




    public function callbackurl()
    {
      file_put_contents( dirname( __FILE__ ).'/duyikj_get.txt', var_export($_GET, true), FILE_APPEND );
		file_put_contents( dirname( __FILE__ ).'/duyikj_post.txt', var_export($_POST, true), FILE_APPEND );
        file_put_contents( dirname( __FILE__ ).'/log_input.txt', file_get_contents("php://input"), FILE_APPEND );
        $Order = M("Order");
        $pay_status = $Order->where("pay_orderid = '".$_REQUEST["orderid"]."'")->getField("pay_status");
        if($pay_status <> 0)
		{
            $this->EditMoney($_REQUEST["orderid"], 'DUYIQUICK', 1);
        }
		else
		{

            exit("error");
        }
    }

    // 服务器点对点返回
    public function notifyurl()
    {
		file_put_contents( dirname( __FILE__ ).'/duyikj_get.txt', var_export($_GET, true), FILE_APPEND );
		file_put_contents( dirname( __FILE__ ).'/duyikj_post.txt', var_export($_POST, true), FILE_APPEND );
        file_put_contents( dirname( __FILE__ ).'/log_input.txt', file_get_contents("php://input"), FILE_APPEND );

$public_key="-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSFku2Ry/8IkjhnIZlfA4nc9JB
sxb4KvsQ2sfvKjL8H2izSqJxaALGen39Azb0b5zznkU9dyc+Dqc/+9n8Hb3RQKm5
Fy0drMhECnsusDMX4mGv+cALoCuN77NO2qgi9DDezy9dH7ranpLttwCYkeSYKDHQ
tKVlVNos1qqfgExypQIDAQAB
-----END PUBLIC KEY-----";
		$arr = $_POST ;
		$public_key=openssl_get_publickey($public_key);
		$sign=base64_decode($arr['SIGN']);
		$original_str="ORDERNO=".$arr['ORDERNO']."&RECODE=".$arr['RECODE']."&REMSG=".urlencode($arr['REMSG'])."&TXNAMT=".$arr['TXNAMT']."&PAYORDNO=".$arr['PAYORDNO']."&ORDSTATUS=".$arr['ORDSTATUS']."&SIGN=".$arr['SIGN'];
		$original_str="ORDERNO=".$arr['ORDERNO']."&TXNAMT=".$arr['TXNAMT']."&ORDSTATUS=".$arr['ORDSTATUS'];
		$result= openssl_verify( $original_str,$sign,$public_key,OPENSSL_ALGO_SHA1 );
		if($result)
		{
			if( $arr['RECODE']=="000000"&&$arr['ORDSTATUS']=="01" )
			{

				//支付记录
				$rows = array(
					'out_trade_no'=>$arr['ORDERNO'],
					'result_code'=> '1',
					'transaction_id'=>$arr['ORDERNO'],
					'fromuser'=> '1',
					'time_end'=> date("YmdHis"),
					'total_fee'=>$arr['TXNAMT']/100,
					'bank_type'=>'1',
					'trade_type'=>'DUYIQUICK',
					'payname'=> 'DUYIQUICK'
				);

				M('Paylog')->add($rows);
				//处理支付
				$this->EditMoney($arr['ORDERNO'], 'DUYIQUICK', 0);
				exit("000000");
			}
		}
		else
		{
            echo 'fail!';
        }
    }




}

?>
