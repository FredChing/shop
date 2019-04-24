<?php
/**
 * Created by PhpStorm.
 * User: mapeijian
 * Date: 2018-07-11
 * Time: 11:33
 */
namespace Pay\Controller;

use Think\Exception;

/**
 * Class GtzfBankController
 * @package Pay\Controller
 */
class GtzfBankController extends PayController
{

    //支付方式code
    private $code = '';

    private $desc = '国通支付-网银';

    private $exchange = 100;

    private $gateway = 'http://api.ayc168.cn:8089/pay/gatewaypaybywy';

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    //支付
    public function  Pay($channel)
    {
        $exchange = $this->exchange;
        $return   = $this->getParameter($this->desc, $channel, __CLASS__, $exchange);
        $this->topay($return);
    }

    public function topay($order = null)
    {
        if($order !== null)
        {
            $rpay_url = "{$this->_site}Pay_{$this->code}_topay.html";
            $this->assign('product_name', $order['subject']);
            $this->assign('orderid', $order['orderid']);
            $this->assign('rpay_url', $rpay_url);
            $this->assign('money', round($order['amount'], 4) / $this->exchange);
            $this->display('GtzfBank/bank');
        }
        else
        {
            $orderid     = I("post.orderid");
            $bankSegment = I("post.bankSegment");
            if(!$orderid)
            {
                $this->showmessage("参数错误");
            }
            $order = M('order')->where(array('pay_orderid' => $orderid))->find();
            if(empty($order))
            {
                $this->showmessage("订单不存在");
            }
            if($order['pay_status'] != 0)
            {
                $this->showmessage("订单已支付");
            }
            $notifyurl         = "{$this->_site}Pay_{$this->code}_notifyurl.html"; //异步通知
            $callbackurl       = "{$this->_site}Pay_{$this->code}_callbackurl_orderid_{$orderid}.html"; //返回通知
            $parameter         = array(
                "version"     => '1.0',
                "spid"        => $order['memberid'],
                "spbillno"    => $orderid,
                "tranAmt"     => intval(round($order['pay_amount'], 4) * 100),
                "cardType"    => '1',
                "channel"     => !isMobile() ? '1' : '2',
                "userType"    => 1,
                "bankSegment" => $bankSegment,
                "backUrl"     => $callbackurl,
                "notifyUrl"   => $notifyurl,
                "productName" => $order['pay_productname'],
                "productDesc" => 'trade',
            );
            $parameter['sign'] = $this->createSign($order['key'], $parameter);

            echo createForm($this->gateway, [
                'req_data' => $this->arrayToXml($parameter),
            ]);
        }

    }

    //同步通知
    public function callbackurl()
    {
        $orderId = $_GET['orderid'];
        if(!$orderId)
        {
            exit;
        }
        $Order      = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderId])->getField("pay_status");
        if($pay_status <> 0)
        {
            $this->EditMoney($orderId, $this->code, 1);
        }
        else
        {
            exit("error");
        }

    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents("./Data/{$this->code}_notify.txt", "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        file_put_contents("./Data/{$this->code}_notify.txt", "【".date('Y-m-d H:i:s')."】\r\n".json_encode($_REQUEST)."\r\n\r\n",FILE_APPEND);
        $originData = file_get_contents('php://input');
        $data = xmlToArray($originData)?:[];
        $parameter = $data;
        if($parameter['retcode'] == '0') {
            $sign = $parameter['sign'];
            unset($parameter['sign']);
            $key = getKey($parameter['spbillno']);
            $newsign = $this->createSign($key, $parameter);
            if($sign == $newsign) {
                if($parameter['result'] == 1) {
                    $this->EditMoney($parameter['spbillno'], $this->code, 0);
                    exit('success');
                }
            }
            exit('失败');
        } else {
            exit($parameter['retmsg'] ?: 'error');
        }
    }

    public function arrayToXml($arr){
        $xml = "<xml>";
        foreach ($arr as $key=>$val){
            if(is_array($val)){
                $xml.="<".$key.">".arrayToXml($val)."</".$key.">";
            }else{
                $xml.="<".$key.">".$val."</".$key.">";
            }
        }
        $xml.="</xml>";
        return $xml;
    }

    /**
     * 创建签名
     * @param $Md5key
     * @param $list
     * @return string
     */
    protected function createSign($Md5key, $list)
    {
        ksort($list);
        $md5str = "";
        foreach($list as $key => $val)
        {
            if(!empty($val))
            {
                $md5str = $md5str . $key . "=" . $val . "&";
            }
            else if(is_numeric($val) && $val == '0')
            {
                $md5str = $md5str . $key . "=" . $val . "&";
            }
        }
        $sign = strtoupper(md5($md5str . "key=" . $Md5key));
        return $sign;
    }
}