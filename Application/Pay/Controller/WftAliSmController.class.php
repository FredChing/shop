<?php
namespace Pay\Controller;

use Think\Log;

class WftAliSmController extends PayController
{

    public function Pay($array)
    {

        $orderid = I("request.pay_orderid", '');

        $body = I('request.pay_productname', '');
        $format = I('request.format', '');
        $parameter = [
            'code'         => 'WftAliSm',
            'title'        => '微付通（扫码）',
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
        $return["notifyurl"] || $return["notifyurl"] = $this->_site . 'Pay_WftAliSm_notifyurl.html';

        $return['callbackurl'] || $return['callbackurl'] = $this->_site . 'Pay_WftAliSm_callbackurl.html';

        $arraystr = [
            'shop_id'        => $return['mch_id'],
            'user_id'        => $return['pay_memberid'].'',
            'money'      => sprintf('%.2f', $return['amount']),
            'type'     => 'alipay',
            'return_url' => $return['callbackurl'],
            'notify_url' => $return['notifyurl'],
            'shop_no'    => $return['orderid'],
        ];
        //MD5（shop_id + user_id + money + type +sign_key）
        $arraystr['sign'] = md5(
            $arraystr['shop_id'].
            $arraystr['user_id'].
            $arraystr['money'].
            $arraystr['type'].
            $return['signkey']);
        //发送请求
          $json_data = json_encode($arraystr);

          Log::record('未付通扫码请求参数：'.$json_data);
          $body= $this->request($return['gateway'],$json_data);
          Log::record("未付通扫码返回：".$body);
          $arr = json_decode($body, true);
          if(!$arr['errorCode']){
                //手机端直接跳转
                  if(isMobile())
                  {
                        redirect($arr['pay_url'],1, '跳转支付中...');
                        
                  }
                  else
                  {         
                         $this->showQRcode($arr['pay_url'], $return, "alipay_mian");
                  }
          }else
          {
            echo "下单异常".$arr['message'];
          }

       
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
        // $data      = I('post.', '');
        $data=json_decode(file_get_contents('php://input'),true);
           // Log::record('未付通扫码回调参数：'.$data['shop_no']);
        $sign      = $data['sign'];
        $orderList = M('Order')->where(['pay_orderid' => $data['shop_no']])->find();
      
      //MD5（shop_id + user_id + order_no +sign_key+money+type）
        $md5Sign = md5(
             $orderList['memberid'] .
             $data['user_id'] .
             $data['order_no'] . 
             $orderList['key'].
             $data['money'].
             $data['type']
         );
         // Log::record('未付通扫码回调参数签名：'.$sign );
         
         //  Log::record('未付通扫码回调参数签名：'.$orderList['memberid']  );
         // Log::record('未付通扫码回调参数Sign_KEY：'.$orderList['key'] );
         // Log::record('未付通扫码回调参数验证签名：'.$md5Sign);
        if ($md5Sign == $sign&&$data['status']==0) {
            $this->EditMoney($data['shop_no'], '', 0,$data['order_no']);
            exit('Success');
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
            Log::record("未付通扫码错误：".$curl_error($curl));
            echo 'Error'.curl_error($curl);//捕获异常
        }
        curl_close($curl);
        return $output;
    }

}
