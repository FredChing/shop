<?php


namespace Pay\Controller;

class JytAliwapController extends PayController
{

    private $gateway = 'https://97623.com/pay.php';

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site ."Pay_JytAliwap_notifyurl.html"; //异步通知

        $parameter = array(
            'code' => 'JytAliwap',
            'title' => '金银通（支付宝WAP）',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid'=>'',
            'out_trade_id' => $orderid, //外部订单号
            'channel'=>$array,
            'body'=>$body
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $callbackurl = $this->_site . 'Pay_JytAliwap_notifyurl_orderId_'.$return['orderid'].'.html'; //跳转通知
        $params = array(
            'notify_url'	=> $notifyurl,
            'return_url'	=> $callbackurl,
            'user_account'	=> $return['mch_id'],
            'out_trade_no'	=> $return['orderid'],
            'payment_type'	=> 'alipay',
            'total_fee'		=> $return['amount'],
            'trade_time'	=> date('Y-m-d H:i:s', time()),
            'body'			=> $body,
        );

        $params['sign'] = $this->_make_sign($params, $return['signkey']);
        echo createForm($this->gateway, $params);
    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $Order      = M("Order");
        $orderid    = I('request.orderId', '');
        if(!$orderid) {
            exit('error');
        }
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if($pay_status == 0)
        {
            sleep(3);//等待3秒
            $pay_status = M('Order')->where(['pay_orderid' => $orderid])->getField("pay_status");
        }
        if($pay_status <> 0)
        {
            $this->EditMoney($orderid, '', 1);
        }
        else
        {
            exit('页面已过期请刷新');
        }
    }

    /**
     *  服务器通知
     */
    public function notifyurl()
    {
        file_put_contents('./Data/notify.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        $post = file_get_contents("php://input");
        $data = json_decode($post, true);
        if(!$data['out_trade_no']) {
            exit('FAIL');
        }
        $key = getKey($data['out_trade_no']);//密钥
        if($this->_validate_sign($data, $key)) {
            //业务逻辑处理
            if($data['status'] == 'SUCCESS') {
                //支付成功
                $this->EditMoney($data['out_trade_no'], 'JytAliwap', 0);
                exit('SUCCESS');
            } else {
                //支付失败
                exit('FAIL');
            }
        } else {
            exit('FAIL');
        }
    }

    private function _make_sign($data, $key)
    {
        //签名步骤一：按字典序排序参数
        ksort($data);
        //签名步骤二：使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串
        $string = $this->_to_url_params($data);
        //签名步骤三：在string后加入KEY
        $string = $string . "&key=".$key;
        //签名步骤四：MD5加密
        $string = md5($string);
        //签名步骤五：所有字符转为大写
        $result = strtoupper($string);

        return $result;
    }

    private function _to_url_params($data) {
        $buff = "";
        foreach ($data as $k => $v) {
            if($k != "sign" && $v != "" && !is_array($v)) {
                $buff .= $k . "=" . $v . "&";
            }
        }
        $buff = trim($buff, "&");
        return $buff;
    }

    private function _validate_sign($data, $key) {

        $sign = $data['sign'];
        unset($data['sign']);

        //签名步骤一：按字典序排序参数
        ksort($data);
        //签名步骤二：使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串
        $string = $this->_to_url_params($data);
        //签名步骤三：在string后加入KEY
        $string = $string . "&key=".$key;
        //签名步骤四：MD5加密
        $string = md5($string);
        //签名步骤五：所有字符转为大写
        $result = strtoupper($string);

        if($result == $sign) {
            return true;
        } else {
            return false;
        }
    }
}
