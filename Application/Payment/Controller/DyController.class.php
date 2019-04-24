<?php
/**
 * Created by PhpStorm.
 * User: win 10
 * Date: 2018/6/11
 * Time: 11:41
 */

namespace Payment\Controller;

/**
 * 独依代付
 *
 * Class DyController
 * @package Payment\Controller
 */
class DyController extends PaymentController
{
    const PRIVATE_PEM = './cert/dyzf/rsa_private_key_M37.pem';
    const PUBLIC_PEM  = './cert/dyzf/dyzf.pem';
    const GATEWAY = 'http://111.231.217.165:28080';

    public function __construct()
    {
        parent::__construct();
    }

    public function PaymentExec($data, $config)
    {
        $opnbnk = $data['opnbnk'][0];
        if (!$opnbnk) {
            $opnbnk = json_decode($data['extends'], true)['opnbnk'];
        }
        if(!$opnbnk) {
            $result = [
                'status' => 3,
                'msg'    => "错误：缺少银行编码"
            ];
            return $result;
        }
        $postData['CP_NO'] = $data['orderid'];//代付订单号
        $postData['TXNAMT'] = intval(round($data['money'], 2) * 100);//订单金额
        $postData['OPNBNK'] = $opnbnk;//银行编码
        $postData['OPNBNKNAM'] = $data['bankname'].$data['bankzhiname'];//银行名称
        $postData['ACTNO'] = $data['banknumber'];//卡号
        $postData['ACTNAM'] = $data['bankfullname'];//户名
        $postData['PROVINCE'] = $data['sheng'];//开户所在省
        $postData['CITY'] = $data['shi'];//开户所在市
        $trandata = $this->gen($postData); // 参数拼接
        $arr['MERCNUM'] = $config['mch_id']; // 商户号
        $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
        $arr['TRANDATA'] = urlencode($trandata); // 交易核心数据

        $url = self::GATEWAY.'/Pay/trans/proxyPayOrder';
        file_put_contents('./Data/Dydf.txt', "【".date('Y-m-d H:i:s')."】代付提交数据：\r\n".json_encode($arr)."\r\n",FILE_APPEND);
        $header[] = 'Content-Type:application/x-www-form-urlencoded';
        $response = curlPost($url, $arr, $header);
        file_put_contents('./Data/Dydf.txt', "【".date('Y-m-d H:i:s')."】代付提交结果：\r\n".$response."\r\n\r\n",FILE_APPEND);
        $response = json_decode($response,true);
        if(empty($response)) {
            $result = ['status' => 3, 'msg' => "错误：服务不可用"];
        } else {
            if($response['RECODE'] == '000000') {
                $result = ['status' => 1, 'msg' => '提交成功'];
            } else {
                $result = [
                    'status' => 3,
                    'msg'    => "错误：{$response['RECODE']}：{$response['REMSG']}"
                ];
            }
        }
        return $result;
    }

    public function PaymentQuery($data, $config)
    {
        $data['CP_NO'] = $data['orderid'];//代付订单号
        $trandata = $this->gen($data); // 参数拼接
        $arr['MERCNUM'] = $config['mch_id']; // 商户号
        $arr['SIGN'] = $this->gen_sign($trandata); // 生成签名
        $arr['TRANDATA'] = urlencode($trandata); // 交易核心数据

        $url = self::GATEWAY.'/Pay/trans/queryProxyOrder';
        file_put_contents('./Data/Dydf.txt', "【".date('Y-m-d H:i:s')."】代付查询提交数据：\r\n".json_encode($arr)."\r\n",FILE_APPEND);
        $response = curlPost($url, $arr);
        file_put_contents('./Data/Dydf.txt', "【".date('Y-m-d H:i:s')."】代付查询返回数据：\r\n".$response."\r\n",FILE_APPEND);
        $response = json_decode($response,true);
        if(empty($response)) {
            $result = ['status' => 3, 'msg' => "错误：服务不可用"];
        } else {
            if($response['RECODE'] == '000000') {
                switch ($response['STLSTS']) {
                    case '0':
                        $result = ['status' => 1, 'msg' => '申请成功'];
                        break;
                    case '1':
                        $result = ['status' => 2, 'msg' => '支付成功'];
                        break;
                    case '2':
                        $result = ['status' => 3, 'msg' => '申请失败'];
                        break;
                }
            } else {
                $result = [
                    'status' => 4,
                    'msg'    => "错误：{$response['RECODE']}：{$response['REMSG']}"
                ];
            }
        }
        return $result;
    }

    public function notifyurl()
    {
        exit('ok');
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
}