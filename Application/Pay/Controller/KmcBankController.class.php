<?php
/**
 * Created by PhpStorm.
 * User: mapeijian
 * Date: 2018-06-13
 * Time: 11:33
 */
namespace Pay\Controller;
use Org\Util\Kmc\pkg8583;
use Think\Exception;

class KmcBankController extends PayController
{
    public $gateway = 'http://online.lhsjsz.com:11088/webservice/order';
    public function __construct()
    {
        parent::__construct();
    }

    //直连参数
    protected $_bank_code = array(
        "9021"=>'中国银行',
        "9009"=>'农业银行',
        "9040" =>'工商银行',
        "9008"=>'建设银行',
        "9012"=>'广发银行',
        "9006"=>'邮储银行',
        "9010"=>'民生银行',
        "9002"=>'光大银行',
        "9128"=>'北京银行',
        "9126"=>'上海银行',
        "9004"=>'招商银行',
    );

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_KmcBank_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_KmcBank_callbackurl.html'; //返回通知
        $bank_code = I("request.bank_code",'');
        if($bank_code) {
            if (!array_key_exists($bank_code, $this->_bank_code)) {
                $bank_code = '';
            }
        }
        $parameter = array(
            'code' => 'KmcBank', // 通道名称
            'title' => '凯美晨网关支付',
            'exchange' => 100, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body'=>$body,
            'channel'=>$array
        );
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $return['subject'] = $body;
        if($bank_code) {
            $return['bank_code'] = $bank_code;
            $encryp  = encryptDecrypt(serialize($return), 'KmcBank');
            if($return['unlockdomain']) {
                echo createForm( $return['unlockdomain'] . '/Pay_KmcBank_Rpay', ['encryp' => $encryp]);
            } else {
                echo createForm($this->_site .'Pay_KmcBank_Rpay', ['encryp' => $encryp]);
            }
        } else {
            $encryp  = encryptDecrypt(serialize($return), 'KmcBank');
            if($return['unlockdomain']) {
                echo createForm( $return['unlockdomain'] . '/Pay_KmcBank_Gopay', ['encryp' => $encryp]);
            } else {
                echo createForm($this->_site .'Pay_KmcBank_Gopay', ['encryp' => $encryp]);
            }
        }
    }

    public function Gopay(){
        //接收传输的数据
        $postData = I('post.', '');
        $encryp = $postData['encryp'];
        //将数据解密并反序列化
        $data = unserialize(encryptDecrypt($encryp, 'KmcBank', 1));
        if($data['unlockdomain']) {
            $rpay_url = $data['unlockdomain'].'/Pay_KmcBank_Rpay';
        } else {
            $rpay_url = $this->_site .'Pay_KmcBank_Rpay';
        }
        $bank_array = $bank_array = [
            "104"=>'9021',//中国银行
            "103"=>'9009',//农业银行
            "102" =>'9040',//工商银行
            "105"=>'9008',//建设银行
            "306"=>'9012',//广发银行
            "403"=>'9006',//邮储银行
            "305"=>'9010',//民生银行
            "303"=>'9002',//光大银行
            "370"=>'9128',//北京银行
            "420"=>'9126',//上海银行
            "3001"=>'9004',//招商银行
        ];
        $this->assign([
            'bank_array' => $bank_array,
            'rpay_url'   => $rpay_url,
            'orderid'    => $data['orderid'],
            'body'       => $data['subject'],
            'money'      => $data['amount']/100,
            'encryp'     => $encryp,
        ]);
        $this->display('KmcBank/bank');
    }

    public function Rpay()
    {
        if(IS_POST) {
            //接收传输的数据
            $postData = I('post.', '');

            //将数据解密并反序列化
            $data = unserialize(encryptDecrypt($postData['encryp'], 'KmcBank', 1));


            //检测数据是否正确
            $data || $this->error('传输数据不正确！');
            $bank_code = I("post.bank_code");
            if(!$bank_code) {
                $this->showmessage("银行编号不能为空");
            }
            if (!array_key_exists($bank_code, $this->_bank_code)) {
                $this->showmessage("银行编号错误");
            }
            if($data['unlockdomain']) {
                $notifyurl = $data['unlockdomain'] . '/Pay_KmcBank_notifyurl.html'; //异步通知
            } else {
                $notifyurl = $this->_site . 'Pay_KmcBank_notifyurl.html'; //异步通知
            }
            $pkg8583 = new pkg8583();
            $pkg8583->setTxcode("F60002");
            $pkg8583->setTxdate(date('Ymd'));
            $pkg8583->setTxtime(date('His'));
            $pkg8583->setVersion("2.0.0");
            $pkg8583->setField003("900033");
            $pkg8583->setField004((string)($data['amount']));
            $pkg8583->setField011("000000");
            $pkg8583->setField031("26080");
            $pkg8583->setField041($data['mch_id']);
            $pkg8583->setField042($data['appid']);
            $pkg8583->setField048($data['orderid']);
            $pkg8583->setField055($bank_code);
            $pkg8583->setField060($notifyurl);
            $pkg8583->setField125($data['mch_id'] . date('mdHis') . rand(10, 99));
            $signStr = $pkg8583->getSignData() . $data['signkey'];
            $signStr = mb_convert_encoding($signStr, "GBK", "utf-8");
            $signStr = strtoupper(md5($signStr));
            $signStr = substr($signStr, 0, 16);
            $pkg8583->setField128($signStr);
            $jsonStr = $pkg8583->getJsonStr();
            file_put_contents('./Data/KmcBank.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单提交" . $jsonStr . "\r\n\r\n", FILE_APPEND);
            list($returnCode, $returnContent) = $this->http_post_json($this->gateway, $jsonStr);
            file_put_contents('./Data/KmcBank.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单返回" . $returnContent . "\r\n\r\n", FILE_APPEND);
            $result = json_decode($returnContent, true);
            if ($result['field039'] == '00') {
                header('Location: ' . $result['field055']);
            } else {
                $this->showmessage($result['field124']);
            }
        }
    }

    //同步通知
    public function callbackurl()
    {
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $_REQUEST["orderid"]])->getField("pay_status");
        if($pay_status <> 0){
            $this->EditMoney($_REQUEST["orderid"], 'KmcBank', 1);
        }else{
            exit("error");
        }

    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents('./Data/notify.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        header("Content-Type: text/html; charset=utf-8");
        $returnContent = file_get_contents("php://input");
        if($returnContent == null) {
            echo 'null request';
            exit;
        }
        $obj = json_decode($returnContent);
        $field055 = explode('|',$obj->{'field055'});
        $rescode = $field055[1];
        $payno = $field055[0];
        $money = $field055[3]/100;
        $typ = $field055[4];
        $paytime = $field055[2];
        if($rescode != '00')
        {
            //失败逻辑--处理开始
            //...
            //失败逻辑--处理结束
            $array = array("field039"=> "99");
            echo json_encode($array);
            exit;
	    } else {
            //成功--业务逻辑开始
            $this->EditMoney($payno , 'KmcBank', 0);
            //成功--业务逻辑结束
            $array = array("field039"=> "00");
            echo json_encode($array);
            exit;
	    }
    }

    //发送post请求，提交json字符串
    private function http_post_json($url, $jsonStr)
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonStr);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json; charset=utf-8',
                'Content-Length: ' . strlen($jsonStr)
            )
        );
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        return array($httpCode, $response);
    }
}