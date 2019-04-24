<?php

/**
 * @author zhangjianwei
 * @date   2018-06-01
 */

namespace Pay\Controller;

use Think\Log;
use Think\Think;


/**
 * 合付宝银联
 * 官网地址：http://www.hefupal.com
 * @package Pay\Controller
 */
class HfbBankCodeController extends PayController
{

    //公钥文件
    const PUBLIC_KEY_PATH = './Data/hfb_cert/SS20180802047437_20180813161129490.cer';
    //秘钥文件
    const PRIVATE_KEY_PATH = './Data/hfb_cert/CS20180802047437_20180813161129490.pfx';
    //私钥密码
    const PRIVATE_KEY_PWD = '732318';

    //支付方式code
    private $code = '';

    //防封跳转加密秘钥
    private $encryptPwd = '*AS&DKJHL*&S(AD*';

    private $exchange = 1;

    private $desc = '合付宝银联扫码';

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    public function Pay($channel)
    {
        $exchange = $this->exchange;
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);

        if($return['unlockdomain'])
        {
            $return['notifyurl'] = $return['unlockdomain'] . "/Pay_{$this->code}_notifyurl.html";
        }

        $paramter = [
            'merchantNo' => $return['mch_id'],
            'version'    => "v1",
            'channelNo'  => "05",
            'tranCode'   => "YS1003",
            'tranFlow'   => $return['orderid'],
            'tranDate'   => date("Ymd"),
            'tranTime'   => date("His"),
            'amount'     => strval(round($return['amount'], 2) * 100),
            'payType'    => '15',//银联扫码
            'bindId'     => $return['signkey'],
            'notifyUrl'  => $return['notifyurl'],
            'bizType'    => '16',
            'goodsName'  => $return['subject'],
            'goodsInfo'  => '',
            'goodsNum'   => '',
            'buyerName'  => '会员',
            'contact'    => '',
            'buyerId'    => '007',
            'remark'     => '摘要',
            'ext1'       => '',
            'ext2'       => '',
            'YUL1'       => '',
            'YUL2'       => '',
            'YUL3'       => get_client_ip(),
        ];

        $paramter['buyerName'] = $this->_encryptData($paramter['buyerName']);
        $this->_sign($paramter);

        $errorMsg = '';
        $res      = $this->_post($paramter, $return['gateway'], $errorMsg);
        if($errorMsg)
        {
            exit($errorMsg);
        }

        $resArr = $this->_convertStringToArray($res);

        if($resArr['rtnCode'] != '0000')
        {
            exit($resArr['rtnMsg']);
        }

        $encrypt = encryptDecrypt(serialize([
            'return'    => $return,
            'qrCodeURL' => $resArr['qrCodeURL']
        ]), $this->encryptPwd);

        if($return['unlockdomain'])
        {
            echo createForm($return['unlockdomain'] . "/Pay_{$this->code}_gopay.html", ['encrypt' => $encrypt]);
        }
        else
        {
            echo createForm($this->_site . "Pay_{$this->code}_gopay.html", ['encrypt' => $encrypt]);
        }
    }

    public function gopay(){
        //接收传输的数据
        $postData = I('post.', '');
        $encryp   = $postData['encrypt'];
        //将数据解密并反序列化
        $data = unserialize(encryptDecrypt($encryp, $this->encryptPwd, 1));

        $return    = $data['return'];
        $qrCodeURL = $data['qrCodeURL'];

        $this->showQRcode($qrCodeURL, $return, 'bank');
    }


    //异步通知地址
    public function notifyurl()
    {
        $this->log();
        // 验签
        $flag = $this->_verify($_POST);
        $retcode = $_POST['rtnCode'];
        $orderId = $_POST['tranFlow'];

        if($flag)
        {
            if($retcode == "0000")
            {
                //修改订单信息
                $this->EditMoney($orderId, '', 0);
                Log::record("{$this->desc}异步通知：" . "交易成功！订单号：" . $orderId, Log::INFO);
                exit("YYYYYY");
            }
            else
            {
                Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($_POST), Log::ERR);
                exit("交易失败");
            }
        }
        else
        {
            Log::record("{$this->desc}异步通知：" . "交易失败！订单号：" . $orderId . "，参数：" . json_encode($_POST), Log::ERR);
            exit('验签失败');
        }
    }

    //同步回调地址
    public function callbackurl()
    {
        $orderId = $_REQUEST['orderid'];
        if(!$orderId) {
            exit;
        }
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderId])->getField("pay_status");
        if($pay_status <> 0){
            $this->EditMoney($orderId, 'Gtzfkj', 1);
        }else{
            exit("error");
        }
    }

    /**
     * 加密数据
     *
     * @param string $data数据
     * @param string $cert_path 证书配置路径
     *
     * @return unknown
     */
    private function _encryptData($data, $cert_path = self::PUBLIC_KEY_PATH)
    {
        $public_key = $this->_getPublicKey($cert_path);
        openssl_public_encrypt($data, $crypted, $public_key);
        return base64_encode($crypted);
    }

    /**
     * 签名
     *
     * @param $params
     */
    private function _sign(&$params)
    {
        if(isset($params['sign']))
        {
            unset($params['sign']);
        }
        // 转换成key=val&串
        $params_str = $this->_createLinkString($params, false);

        // 签名证书路径
        $cert_path = self::PRIVATE_KEY_PATH;

        $private_key = $this->_getPrivateKey($cert_path);
        // 签名
        $sign_falg = openssl_sign($params_str, $sign, $private_key, OPENSSL_ALGO_SHA1);
        if($sign_falg)
        {
            $sign_base64     = base64_encode($sign);
            $params ['sign'] = $sign_base64;
        }
        else
        {
        }
    }


    /**
     * 讲数组转换为string
     *
     * @param $para 数组
     * @param $encode 是否需要URL编码
     *
     * @return string
     */
    private function _createLinkString($para, $encode)
    {
        ksort($para);   //排序
        $linkString = "";
        while(list ($key, $value) = each($para))
        {
            if($encode)
            {
                $value = urlencode($value);
            }
            $linkString .= $key . "=" . $value . "&";
        }
        // 去掉最后一个&字符
        $linkString = substr($linkString, 0, count($linkString) - 2);

        return $linkString;
    }

    /**
     * 返回(签名)证书私钥 -
     *
     * @return unknown
     */
    private function _getPrivateKey($cert_path)
    {
        $pkcs12 = file_get_contents($cert_path);
        openssl_pkcs12_read($pkcs12, $certs, self::PRIVATE_KEY_PWD);
        return $certs ['pkey'];
    }


    /**
     * 读取公钥
     *
     * @param $cert_path
     *
     * @return bool|string
     */
    private function _getPublicKey($cert_path)
    {
        return file_get_contents($cert_path);
    }

    /**
     * 后台交易 HttpClient通信
     *
     * @param unknown_type $params
     * @param unknown_type $url
     *
     * @return mixed
     */
    private function _post($params, $url, &$errmsg)
    {
        $opts = $this->_createLinkString($params, false, true);
        $ch   = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 不验证证书
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false); // 不验证HOST
        curl_setopt($ch, CURLOPT_SSLVERSION, 4);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-type:application/x-www-form-urlencoded;charset=UTF-8'
        ));
        curl_setopt($ch, CURLOPT_POSTFIELDS, $opts);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $html = curl_exec($ch);
        if(curl_errno($ch))
        {
            $errmsg = curl_error($ch);
            curl_close($ch);
            return false;
        }
        if(curl_getinfo($ch, CURLINFO_HTTP_CODE) != "200")
        {
            $errmsg = "http状态=" . curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_close($ch);
            return false;
        }
        curl_close($ch);
        return $html;
    }

    /**
     * 字符串转换为 数组
     *
     * @param $str
     *
     * @return array
     */
    function _convertStringToArray($str)
    {
        $result = array();

        if(!empty ($str))
        {
            $temp = preg_split('/&/', $str);
            if(!empty ($temp))
            {
                foreach($temp as $key => $val)
                {
                    $arr = preg_split('/=/', $val, 2);
                    if(!empty ($arr))
                    {
                        $k           = $arr ['0'];
                        $v           = $arr ['1'];
                        $result [$k] = $v;
                    }
                }
            }
        }
        return $result;
    }

    /**
     * 验签
     *
     * @param $params
     *
     * @return string
     */
    private function _verify($params)
    {
//        global $log;
        // 公钥
        $public_key = $this->_getPublicKey(self::PUBLIC_KEY_PATH);
        // 签名串
        $sign_str = $params ['sign'];
        $sign_str = str_replace(" ", "+", $sign_str);
//        $log->LogInfo ( '签名串为' . $sign_str );
        // 转码

        unset ($params ['sign']);
        $params_str = $this->_createLinkString($params, false);
//        $log->LogInfo ( '报文去[sign] key=val&串>' . $params_str );
        $sign      = base64_decode($sign_str);
        $isSuccess = openssl_verify($params_str, $sign, $public_key);
//        $log->LogInfo ( $isSuccess ? '验签成功' : '验签失败' );
        if($isSuccess == '1')
        {
            return true;
        }
        else
        {
            return false;
        }
    }


    public function log()
    {
        file_put_contents("./Data/{$this->code}_notify.txt",
            "【" . date('Y-m-d H:i:s') . "】\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . $_SERVER["QUERY_STRING"] . "\r\n\r\n", FILE_APPEND);
//        file_put_contents("./Data/{$this->code}_notify.txt",
//            "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }
}