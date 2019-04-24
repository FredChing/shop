<?php

/**
 * @author zhangjianwei
 * @date   2018-06-01
 */

namespace Pay\Controller;

use Think\Exception;
use Think\Log;
use Think\Think;


/**
 * 天下支付-天付宝-银联扫码
 * 官网地址：http://www.tfb8.com/
 * @package Pay\Controller
 */
class TfbYlcodeController extends PayController
{

    //支付方式code
    private $code = '';

    private $desc = '天下支付-天付宝-银联扫码';

    private $exchange = 1;

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    /**
     * @param $channel
     *
     * @throws Exception
     */
    public function Pay($channel)
    {
        $exchange = $this->exchange;
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);

        $gateway = $return['gateway'];

        $notifyurl   = $this->_site . "Pay_{$this->code}_notifyurl.html"; //异步通知
        $callbackurl = $this->_site . "Pay_{$this->code}_callbackurl.html"; //返回通知
        $parameter   = array(
            "spid"         => $return['mch_id'],
            "notify_url"   => $notifyurl,
            "pay_show_url" => $callbackurl,
            "sp_billno"    => $return['orderid'],
            "pay_type"     => '800201',
            "tran_time"    => date('YmdHis'),
            "tran_amt"     => intval(round($return['amount'], 2) * 100),
            "cur_type"     => 'CNY',
            "item_name"    => 'trade',
        );

        $parameter['sign'] = $this->_createSign($parameter, $return['signkey']);

        $qrcodeRes = $this->_requrestQrcodeData($gateway, $parameter);


        if(!is_array($qrcodeRes) || $qrcodeRes['retcode'] != '00')
        {
            throw new Exception('支付渠道不可用');
        }

        $qrcode = $qrcodeRes['qrcode'];

        $this->showQRcode($qrcode, $return, 'bank');
    }

    /**
     * 请求二维码
     *
     * @param $gateway
     * @param $data
     *
     * @return mixed
     */
    private function _requrestQrcodeData($gateway, $data)
    {
        $responseOfGbk = curlPost($gateway, http_build_query($data));
        return xmlToArray($responseOfGbk);
    }


    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        $postData = $_POST;
        $data     = $postData;

        if(empty($data))
        {
            exit('传输数据失败');
        }

        unset($data['sign_type']);
        unset($data['input_charset']);
        unset($data['sign']);
        unset($data['retcode']);
        unset($data['retmsg']);

        $retcode = $postData['retcode'];

        $orderId = $data['sp_billno'];
        $key     = getKey($orderId);
        if(empty($key))
        {
            exit('无效的订单');
        }

        $sign = $this->_createSign($data, $key, false);

        if($sign == $data['sign'])
        {
            if($retcode == '0')
            {
                //修改订单信息
                $this->EditMoney($orderId, '', 0);
                Log::record("{$this->desc}异步通知：" . "交易成功！订单号：" . $orderId, Log::INFO);
                exit("SUCCESS");
            }
            else
            {
                Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($data), Log::ERR);
                exit("交易失败");
            }
        }
        else
        {
            Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($data), Log::ERR);
            exit('验签失败');
        }
    }

    //同步回调地址
    public function callbackurl()
    {
    }

    /**
     * 规则是:按参数名称a-z排序,遇到空值的参数不参加签名。
     */
    private function _createSign($data, $key,$convert = true)
    {
        // 参数原串
        $signPars = "";
        // 按照键名排序
        ksort($data);
        // 生成原串
        foreach($data as $k => $v)
        {
            // 值不为空或键不是sign
            if("" != $v && "sign" != $k)
            {
                if($convert)
                {
                    $signPars .= $k . "=" . mb_convert_encoding($v, 'GBK', 'UTF-8') . "&";
                }
                else
                {
                    $signPars .= $k . "=" . $v . "&";
                }
            }
        }
        // md5签名
        // 再拼接key字段
        $signPars .= "key=" . $key;
        $sign     = md5($signPars);

        return $sign;
    }

    public function log()
    {
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】回调post\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】回调get\r\n" . $_SERVER["QUERY_STRING"] . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }

//    public function query()
//    {
//        $data         = [
//            'spid'      => '1800776625',
//            'sp_billno' => '20180802161741534954',
//        ];
//        $data['sign'] = $this->_createSign($data, '12345');
//        $res          =
//            curlPost('http://apitest.tfb8.com/cgi-bin/v2.0/api_yl_pay_single_qry.cgi', http_build_query($data));
//        $arr          = xmlToArray($res);
//        header("Content-Type:application/json");
//        echo json_encode($arr);
//        exit;
//    }
//
//    public function test(){
//        echo  $this->_createSign([
//            'name'=>'简单爱',
//            'order_id'=>321321,
//        ],'12345');
//    }
}