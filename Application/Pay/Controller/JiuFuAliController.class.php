<?php
namespace Pay\Controller;

use Org\Util\HttpClient;

class JiuFuAliController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $parameter = array
		(
            'code' => 'JiuFuAli', // 通道名称
            'title' => '支付宝扫码【玖付】',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => I("request.pay_orderid"),
            'body'=>I('request.pay_productname'),
            'channel'=>$array
        );
 
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
	 
		$pay_memberid = $return['mch_id'];   //商户ID
		$payorderid = $pay_orderid = $return['orderid']; //订单号
		$paymoney = $pay_amount = $return['amount'];   //交易金额
		$pay_applydate = date("Y-m-d H:i:s");  //订单时间
		$pay_bankcode = "903";   //银行编码
		$pay_notifyurl =    $return['notifyurl'];   //服务端返回地址
		$pay_callbackurl =  $return['callbackurl'];//页面跳转返回地址
		$Md5key =  $return['signkey'];   //密钥
		$tjurl = "https://www.o9n.cn/Pay_Index.html";   //网关提交地址

		$jsapi = array(
			"pay_memberid" => $pay_memberid,
			"pay_orderid" => $pay_orderid,
			"pay_applydate" => $pay_applydate,
			"pay_bankcode" => $pay_bankcode,
			"pay_notifyurl" => $pay_notifyurl,
			"pay_callbackurl" => $pay_callbackurl,
			"pay_amount" => $pay_amount,
		);

		ksort($jsapi);
		$md5str = "";
		foreach ($jsapi as $key => $val) {
			$md5str = $md5str . $key . "=" . $val . "&";
		}
		//echo($md5str . "key=" . $Md5key."<br>");
		$sign = strtoupper(md5($md5str . "key=" . $Md5key));
		 
		$jsapi["pay_md5sign"] = $sign;
		$this->create( $jsapi, $tjurl );
		exit;
        
    }
	 
	 
 

	 private function create($data, $submitUrl)
    {
		 
        header("Content-type: text/html; charset=utf-8");
        $inputstr = "";
        foreach ($data as $key => $v) {
            $inputstr .= '<input type="hidden"  id="' . $key . '" name="' . $key . '" value="' . $v . '"/>';
        }

        $form = '<form action="' . $submitUrl . '" name="pay" id="pay" method="POST">';
        $form .= $inputstr;
        $form .= '</form>';

        $html = '<!DOCTYPE html><html lang="en"><head><title>请不要关闭页面,支付跳转中.....</title></head><body><div>';
        $html .= $form;
        $html .= '</div>';
        $html .= '<script type="text/javascript">document.getElementById("pay").submit()</script>';
        $html .= '</body></html>';
       
        echo $html;
        exit;
    }
	
	

	 
    public function callbackurl()
    {
        $Order = M("Order");
        $pay_status = $Order->where("pay_orderid = '".$_REQUEST["orderid"]."'")->getField("pay_status");
        if($pay_status <> 0)
		{
            $this->EditMoney($_REQUEST["orderid"], 'JiuFuAli', 1);
        }
		else
		{
		 
            exit("error");
        }
    }

    // 服务器点对点返回
    public function notifyurl()
    {
	
		 file_put_contents( dirname( __FILE__ ).'/zhizhu.txt', var_export($_POST, true), FILE_APPEND );
		 
		 $returnArray = array( // 返回字段
            "memberid" => $_REQUEST["memberid"], // 商户ID
            "orderid" =>  $_REQUEST["orderid"], // 订单号
            "amount" =>  $_REQUEST["amount"], // 交易金额
            "datetime" =>  $_REQUEST["datetime"], // 交易时间
            "transaction_id" =>  $_REQUEST["transaction_id"], // 支付流水号
            "returncode" => $_REQUEST["returncode"],
        );
	 
		$Md5key = $this->getSignkey('JiuFuAli', $returnArray['memberid'] ); // 密钥
        ksort($returnArray);
        $md5str = "";
        foreach ($returnArray as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }
	 
        $sign = strtoupper(md5($md5str . "key=" . $Md5key));
        if ($sign == $_REQUEST["sign"]) 
		{
            if ($_REQUEST["returncode"] == "00") 
			{
				$arraystr = $_REQUEST;
				//$handle=@new Handleorder($_POST['out_trade_no'],$_POST['total_amount'] );
	 
				//支付记录
				$rows = array(
					'out_trade_no'=>$arraystr['orderid'],
					'result_code'=> '1',
					'transaction_id'=>$arraystr['transaction_id'],
					'fromuser'=> '1',
					'time_end'=> date("YmdHis"),
					'total_fee'=>$arraystr['amount'],
					'bank_type'=>'1',
					'trade_type'=>'JiuFuAli',
					'payname'=> 'JiuFuAli'
				);
			
				M('Paylog')->add($rows);
				//处理支付
				$this->EditMoney($arraystr['orderid'], 'JiuFuAli', 0);
				
			}
			exit("ok");
		}
		else
		{
            echo 'fail!';
        }
    }

    

    
}

?>
