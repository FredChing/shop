<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;


class DyAliwapController extends PayController
{
    const PRIVATE_PEM = './cert/dyzf/rsa_private_key_M37.pem';
    const PUBLIC_PEM  = './cert/dyzf/dyzf.pem';
    const GATEWAY = 'http://111.231.217.165:28080';

    public function __construct()
    {
        parent::__construct();
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_DyAliwap_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_DyAliwap_callbackurl.html'; //返回通知
        $parameter = [
            'code' => 'DyAliwap', // 通道名称
            'title' => '独依支付（支付宝H5）',
            'exchange' => 100, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body' => $body,
            'channel' => $array
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $return['subject'] = $body;

        $data['ORDERNO'] = $return['orderid'];//订单号
        $data['TXNAMT'] = $return['amount'];//订单金额
        $data['CHANNELCODE'] = 'ALIPAY';//支付通道
        $data['REMARK'] = $body;//订单描述
        $data['RETURNURL'] = $callbackurl;//前台通知地址
        $data['NOTIFYURL'] = $notifyurl;//后台通知地址
        $trandata = $this->gen($data); // 参数拼接
        $arr['MERCNUM'] = $return['mch_id']; // 商户号
        $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
        $arr['TRANDATA'] = urlencode($trandata); // 支付主参数

        $url = self::GATEWAY.'/Pay/trans/h5PayOrder';
        echo createForm($url, $arr);
    }

    //同步通知
    public function callbackurl()
    {
        $response = $_GET;
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $response['out_trade_no']])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($response['out_trade_no'], '', 1);
        } else {
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents('./Data/dyzf_notify.txt',"【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        $data = I('post.');
        if($data['RECODE'] == '000000') {
            $signData['ORDERNO'] = $data['ORDERNO'];
            $signData['TXNAMT'] = $data['TXNAMT'];
            $signData['ORDSTATUS'] = $data['ORDSTATUS'];
            $signStr = $this->gen($signData);
            $pubkeyid = openssl_pkey_get_public(file_get_contents(self::PUBLIC_PEM));
            $res = openssl_verify($signStr, base64_decode($data['SIGN']), $pubkeyid);
            if ($res == 1) {
                if($data['ORDSTATUS'] == '01') {
                    $this->EditMoney($data['ORDERNO'], 'DyAliwap', 0);
                    exit('success');
                } else {
                    exit('fail');
                }
            } else {
                exit('check sign fail');
            }
        } else {
            exit('fail');
        }

    }

    // 参数拼接
    private function gen($param)
    {
        $buff = "";
        foreach ($param as $k => $v) {
            if ($v !== "") {
                $buff .= $k . '=' . $v . '&';
            }
        }
        $string = rtrim($buff, '&');
        return $string;
    }

    // 生成签名字符串
    private function gen_sign($string)
    {
        $signature = '';
        $privatekey = openssl_pkey_get_private(file_get_contents(self::PRIVATE_PEM));
        $res = openssl_get_privatekey($privatekey);
        openssl_sign($string, $signature, $res);
        openssl_free_key($res);
        return base64_encode($signature);
    }

    private function http_post_data($url, $data_string)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
                "Content-Type: application/json; charset=utf-8",
                "Content-Length: " . strlen($data_string)]
        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return [$return_code, $return_content];
    }
}