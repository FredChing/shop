<?php
/**
 * Created by PhpStorm.
 * User: mapeijian
 * Date: 2018-04-11
 * Time: 17:37
 */
namespace Pay\Controller;

/**
 * Payback 快捷支付
 *
 * Class PaybackKjController
 * @package Pay\Controller
 */
class PaybackKjController extends PayController
{

    private $gateway = 'https://www.19pay.fun/Pay_Index.html';

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site ."Pay_PaybackKj_notifyurl.html"; //异步通知
        $callbackurl = $this->_site . 'Pay_PaybackKj_callbackurl.html'; //跳转通知
        $bank_code=I("request.bank_code");

        $parameter = array(
            'code' => 'PaybackKj',
            'title' => 'Payback(网银支付)',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid'=>'',
            'out_trade_id' => $orderid, //外部订单号
            'channel'=>$array,
            'body'=>$body
        );

        //支付金额
        $pay_amount = I("request.pay_amount", 0);

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);

        $params  = [
            "pay_memberid"    => $return['mch_id'],
            "pay_orderid"     => $return['orderid'],
            "pay_amount"      => $return['amount'],
            "pay_applydate"   => date('Y-m-d H:i:s'),
            "pay_bankcode"    => '912',
            "pay_notifyurl"   => $notifyurl,
            "pay_callbackurl" => $callbackurl,
        ];
        $params['pay_md5sign'] = strtoupper(md5Sign($params, $return['signkey'], '&key='));
        echo createForm($this->gateway, $params);
    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $Order      = M("Order");
        $orderid    = I('post.orderid', '');
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            $this->EditMoney($orderid, '', 1);
        } else {
            exit("error");
        }
    }

    /**
     *  服务器通知
     */
    public function notifyurl()
    {
        $this->log();
        $data = I('request.', '');
        if ($data['returncode'] == '00') {

            $key = getKey($data['orderid']);

            $signitem = [ // 返回字段
                "memberid"       => $data["memberid"], // 商户ID
                "orderid"        => $data["orderid"], // 订单号
                "amount"         => $data["amount"], // 交易金额
                "datetime"       => $data["datetime"], // 交易时间
                "transaction_id" => $data["transaction_id"], // 支付流水号
                "returncode"     => $data["returncode"],
            ];
            $newSign = strtoupper(md5Sign($signitem, $key, '&key='));
            if ($newSign == $data['sign']) {
                $this->EditMoney($data['orderid'], 'LbfBank', 0);
                exit('ok');
            }
        }
    }

    public function log(){
        $res =  file_put_contents('./Data/paybackkj_notify.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
    }

}
