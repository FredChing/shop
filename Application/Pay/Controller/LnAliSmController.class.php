<?php
namespace Pay\Controller;

use Think\Log;

class LnAliSmController extends PayController
{

    public function Pay($array)
    {

        $orderid = I("request.pay_orderid", '');

        $body = I('request.pay_productname', '');
        $format = I('request.format', 'json');
        $parameter = [
            'code'         => 'LnAliSm',
            'title'        => '老牛支付（扫码）',
            'exchange'     => 1, // 金额比例 聚友
            'gateway'      => '',
            'orderid'      => '',
            'out_trade_id' => $orderid, //外部订单号
            'channel'      => $array,
            'body'         => $body,
        ];

        //支付金额
        $pay_amount = I("request.pay_amount", 0);

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);

        //如果生成错误，自动跳转错误页面
        $return["status"] == "error" && $this->showmessage($return["errorcontent"]);

        //跳转页面，优先取数据库中的跳转页面
        $return["notifyurl"] || $return["notifyurl"] = $this->_site . 'Pay_LnAliSm_notifyurl.html';

        $return['callbackurl'] || $return['callbackurl'] = $this->_site . 'Pay_LnAliSm_callbackurl.html';

        $return['callbackurl']=$return['callbackurl'].'?orderid='.$return['orderid'];

        $arraystr = [
            'account_id'        => $return['mch_id'],
            'amount'      => sprintf('%.2f', $return['amount']),
            'content_type'     => $format,
            'type' =>2,
            'thoroughfare' =>'service_auto',
            'robin'=>2,
            'success_url' => $return['callbackurl'],
            'callback_url' => $return['notifyurl'],
            'error_url' =>$return['callbackurl'],
            'out_trade_no'    => $return['orderid'],
        ];
       $arraystr['sign'] = $this->sign($return['signkey'],$arraystr);
        //发送请求 支付通测试 暂时不用
        if($format=="json")
        {
          //{"code":200,"msg":"success","data":{"order_id":"3","qrcode":""}}
           $res = curlPost($return['gateway'], $arraystr);
            $at=json_decode($res,true);
            if($at['code']==200&&$at['msg']=='success')
            {
              //$this->showQRcode($at['data']['qrcode'], $return, "alipay_mian");

                 $this->assign('params', $return);
                 $this->assign('orderid', $return['orderid']);
                 $this->assign("out_orderid",$at['data']['order_id']);
                 $this->assign("diff_time",$return['pay_applydate']+300-time());
                 $this->assign('money', $return['amount']);
				 if(isMobile())
                 $this->display("WeiXin/alipay_laoniu_h5");
				else   $this->display("WeiXin/alipay_laoniu");

              


            }
            else{
                echo $res;
            }
         
       }
       else
       {
             echo   $this->_createForm($return['gateway'],$arraystr);
       }
    }
     function _showQRcode($url, $return, $view = 'weixin')
    {
        import("Vendor.phpqrcode.phpqrcode", '', ".php");
        $QR = "Uploads/codepay/" . $return["orderid"] . ".png"; //已经生成的原始二维码图
        \QRcode::png($url, $QR, "L", 20);
        $return['qrurl']=$url;
        $this->assign("imgurl", $this->_site . $QR);
        $this->assign('params', $return);
        $this->assign('orderid', $return['orderid']);
        $this->assign('money', $return['amount']);
        $this->display("WeiXin/" . $view);
    }
    protected function _createForm($url, $data)
    {
        $str = '<!doctype html>
                <html>
                    <head>
                        <meta charset="utf8">
                        <title>正在跳转付款页</title>
                    </head>
                    <body onLoad="document.pay.submit()">
                    <form method="post" action="' . $url . '" name="pay">';

        foreach ($data as $k => $vo) {
            $str .= '<input type="hidden" name="' . $k . '" value="' . $vo . '">';
        }

        $str .= '</form>
                    <body>
                </html>';
        return $str;
    }

    
	public function query()
	{
			 $orderid=I("request.orderid");
			 if($orderid){
			 $url='http://47.244.114.153/gateway/pay/serviceQuery.do?id='.$orderid;
			 echo curlPost($url,[]);
			 }
			 else{
				 
				 echo array("code"=>"-1","msg"=>"请求移仓");
			 }
			 
			
	}
    public function callbackurl()
    {
        $orderid    = I('request.orderid', '');
        $pay_status = M("Order")->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            $this->EditMoney($orderid, '', 1);
        } else {
            exit("error");
        }

    }

    public function notifyurl()
    {
         $data      = I('post.', '');
       // Log::record('老牛支付扫码回调参数：'.$data['shop_no']);
        $sign      = $data['sign'];
        $account_key=$data['account_key'];
        $orderList = M('Order')->where(['pay_orderid' => $data['out_trade_no']])->find();
      
      //MD5（shop_id + user_id + order_no +sign_key+money+type）
        if($account_key!=$orderList['key'])
        {

          Log::record('老牛支付扫码回调参数key错误：'.$account_key );
          exit("key错误");
        }
        if($this->sign($account_key,['amount'=>$data['amount'],'out_trade_no'=>$data['out_trade_no']])!=$sign)
        {
             Log::record('老牛支付扫码回调参数签名错误：'.$sign );
             exit("签名错误 ");
        }
        {
            $this->EditMoney($data['out_trade_no'], '', 0,$data['trade_no']);
            echo 'success';
        }


    }

    // HTTP请求（支持HTTP/HTTPS，支持GET/POST）
    public function request($url, $data = null)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        if (!empty($data)) {
            curl_setopt($curl, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($data)
            ));

            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }


        curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
        $output = curl_exec($curl);
        if(curl_errno($url))
        {
            Log::record("老牛支付扫码错误：".$curl_error($curl));
            echo 'Error'.curl_error($curl);//捕获异常
        }
        curl_close($curl);
        return $output;
    }
   public function sign ($key_id, $array)
  {
         $data = md5(sprintf("%.2f", $array['amount']) . $array['out_trade_no']);
        $key[] ="";
        $box[] ="";
        $pwd_length = strlen($key_id);
        $data_length = strlen($data);
        for ($i = 0; $i < 256; $i++)
        {
            $key[$i] = ord($key_id[$i % $pwd_length]);
            $box[$i] = $i;
        }
        for ($j = $i = 0; $i < 256; $i++)
        {
            $j = ($j + $box[$i] + $key[$i]) % 256;
            $tmp = $box[$i];
            $box[$i] = $box[$j];
            $box[$j] = $tmp;
        }
        for ($a = $j = $i = 0; $i < $data_length; $i++)
        {
            $a = ($a + 1) % 256;
            $j = ($j + $box[$a]) % 256;
            
            $tmp = $box[$a];
            $box[$a] = $box[$j];
            $box[$j] = $tmp;
            
            $k = $box[(($box[$a] + $box[$j]) % 256)];
            $cipher .= chr(ord($data[$i]) ^ $k);
        }
        return md5($cipher);
  }


}
