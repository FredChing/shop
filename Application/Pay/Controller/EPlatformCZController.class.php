<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;

class EPlatformCZController extends PayController
{

    const MER_CODE = '205413';

    const MER_ACC_CODE = '2054130022';

    const KEY = 'A3vAjbR0ktVr9PZ7cp9sz1bm8WepTH7JbN3qcrYghQ0tsdLDJrdDlAcMEfWu0L5lhoOrbbrmq1eFDSewESt1A0YECTlLvPuVvJlOS78zm5ASnNNl3LUTg1VfPSErgCHu';

    const GATEWAY = 'http://bctrade.ips.com.cn/psfp-webfmp/recharge.do';

    const IV       = 'Bgtrq2xO';
    const TDES_KEY = 'YnqPSZARUDCFBbfUyqx0kQ9o';

    //支付
    public function Pay($array)
    {
        $return = $this->getParameter('e平台充值', $array, __CLASS__, 1);

        $userid      = I('pay_memberid', '') - 10000;
        $info        = M('ApplyEPlatform')->where(['user_id' => $userid])->find();
        $payPoundage = M('Order')->where(['pay_orderid' => $return['orderid']])->getField('pay_poundage');

        $request = [
            'Head' => [
                'version' => 'V1.0.0',
            ],
            'Body' => [

                'merCode'    => self::MER_CODE,
                'merAccCode' => self::MER_ACC_CODE,
                'userName'   => $info['user_name'],
                'accCode'    => $info['acc_code'],
                'crCode'     => '156',
                'merBillNo'  => $return['orderid'],
                'merDate'    => date('Ymd'),
                'amount'     => $return['amount'],
                'fee'        => $payPoundage,
                'pageUrl'    => $return['callbackurl'],
                's2sUrl'     => $return['notifyurl'],
                'checkUrl'   => '',
                'memo'       => '',
                'remark1'    => '',
                'remark2'    => '',
            ],
        ];

        $signStr = $this->toIPSXml(['Body' => $request['Body']]) . self::KEY;

        $request['Head']['sign'] = md5($signStr);

        $xml = '<Req>' . $this->toIPSXml($request) . '</Req>';

        $ciphertext = TDEA::encrypt($xml, self::TDES_KEY, self::IV); //加密

        echo createForm(self::GATEWAY, ['argMerCode' => self::MER_CODE, 'arg3DesXmlPara' => $ciphertext]);

    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $data = $_REQUEST;
        file_put_contents('./Data/EPlatformCZ.txt', "【" . date('Y-m-d H:i:s') . "】callbackurl\r\n" . serialize($data) . "\r\n\r\n", FILE_APPEND);
        $params = TDEA::decrypt($data['p3DesXmlPara'], self::TDES_KEY, self::IV);
        $params = xmlToArray($params);
        $Order  = M("Order");
        if ($params['Body']['status'] == 10) {
            $pay_status = $Order->where(['pay_orderid' => $params['Body']['merBillNo']])->getField("pay_status");
            if ($pay_status != 0) {
                $this->EditMoney($params['Body']['merBillNo'], '', 1);
            } else {
                exit("error");
            }
        }
    }

    //异步通知
    public function notifyurl()
    {
        $data = $_REQUEST;
        file_put_contents('./Data/EPlatformCZ.txt', "【" . date('Y-m-d H:i:s') . "】notifyurl\r\n" . serialize($data) . "\r\n\r\n", FILE_APPEND);

        if ($data['errCode'] == '000000') {
            $params = TDEA::decrypt($data['p3DesXmlPara'], self::TDES_KEY, self::IV);
            $params = xmlToArray($params);
            if ($params['Body']['status'] == 10) {

                $this->EditMoney($params['Body']['merBillNo'], '', 0);
            }
        }
    }

    public function toIPSXml($data)
    {

        $xmlStr = '';
        foreach ($data as $k => $v) {

            $xmlStr .= '<' . $k . '>';
            foreach ($v as $k1 => $v1) {
                $xmlStr .= '<' . $k1 . '>' . trim($v1) . '</' . $k1 . '>';
            }
            $xmlStr .= '</' . $k . '>';

        }
        return $xmlStr;
    }

    /**
     * 回调处理订单
     * @param $TransID
     * @param $PayName
     * @param int $returntype
     */
    protected function EditMoney($trans_id, $pay_name = '', $returntype = 1, $transaction_id = '')
    {

        $m_Order    = M("Order");
        $order_info = $m_Order->where(['pay_orderid' => $trans_id])->find(); //获取订单信息
        $userid     = intval($order_info["pay_memberid"] - 10000); // 商户ID
        $time       = time(); //当前时间

        //查询用户信息
        $m_Member    = M('Member');
        $member_info = $m_Member->where(['id' => $userid])->find();

        //********************************************订单支付成功上游回调处理********************************************//
        if ($order_info["pay_status"] == 0) {
            //开启事物
            M()->startTrans();
            //更新订单状态 1 已成功未返回 2 已成功已返回
            $m_Order->where(['pay_orderid' => $trans_id])
                ->save(['pay_status' => 1, 'pay_successdate' => $time]);

            //-----------------------------------------修改用户数据 商户余额、冻结余额start-----------------------------------
            //查询用户的提现规则
            $m_Tikuanconfig = M('Tikuanconfig');
            $tikuanconfig   = $m_Tikuanconfig->where(['userid' => $userid])->find();
            if (!$tikuanconfig || $tikuanconfig['tkzt'] != 1) {
                $tikuanconfig = $m_Tikuanconfig->where(['issystem' => 1])->find();
            }

            //创建修改用户修改信息
            $member_data = [
                'last_paying_time'   => $time,
                'unit_paying_number' => ['exp', 'unit_paying_number+1'],
                'unit_paying_amount' => ['exp', 'unit_paying_amount+' . $order_info['pay_actualamount']],
                'paying_money'       => ['exp', 'paying_money+' . $order_info['pay_actualamount']],
            ];

            //判断用结算方式
            switch ($tikuanconfig['t1zt']) {
                case '0':
                    //t+0结算
                    $ymoney                 = $member_info['balance']; //改动前的金额
                    $gmoney                 = bcadd($member_info['balance'], $order_info['pay_actualamount'], 4); //改动后的金额
                    $member_data['balance'] = ['exp', 'balance+' . $order_info['pay_actualamount']]; //防止数据库并发脏读
                    break;

                case '1':
                    //t+1结算，记录冻结资金
                    $blockedlog_data = [
                        'userid'     => $userid,
                        'orderid'    => $order_info['pay_orderid'],
                        'amount'     => $order_info['pay_actualamount'],
                        'thawtime'   => (strtotime('tomorrow') + rand(0, 7200)),
                        'pid'        => $order_info['pay_bankcode'],
                        'createtime' => $time,
                        'status'     => 0,
                    ];
                    $blockedlog_result = M('Blockedlog')->add($blockedlog_data);
                    if (!$blockedlog_result) {
                        M()->rollback();
                        return false;
                    }
                    $ymoney                        = $member_info['blockedbalance']; //原冻结资金
                    $gmoney                        = bcadd($member_info['blockedbalance'], $order_info['pay_actualamount'], 4); //改动后的冻结资金
                    $member_data['blockedbalance'] = ['exp', 'blockedbalance+' . $order_info['pay_actualamount']]; //防止数据库并发脏读

                    break;
                default:
                    # code...
                    break;
            }

            // $member_result = $m_Member->where(['id' => $userid])->save($member_data);
            // if ($member_result != 1) {
            //     M()->rollback();
            //     return false;
            // }

            // 商户充值金额变动
            $moneychange_data = [
                'userid'     => $userid,
                'ymoney'     => $ymoney, //原金额或原冻结资金
                'money'      => $order_info['pay_actualamount'],
                'gmoney'     => $gmoney, //改动后的金额或冻结资金
                'datetime'   => date('Y-m-d H:i:s'),
                'tongdao'    => $order_info['pay_bankcode'],
                'transid'    => $trans_id,
                'orderid'    => $order_info['out_trade_id'],
                'contentstr' => $order_info['out_trade_id'] . '订单充值,结算方式：t+' . $tikuanconfig['t1zt'],
                'lx'         => 1,
            ];

            $moneychange_result = $this->MoenyChange($moneychange_data); // 资金变动记录

            if ($moneychange_result == false) {
                M()->rollback();
                return false;
            }
            // 通道ID
            $bianliticheng_data = [
                "userid"  => $userid, // 用户ID
                "transid" => $trans_id, // 订单号
                "money"   => $order_info["pay_amount"], // 金额
                "tongdao" => $order_info['pay_bankcode'],
            ];
            $this->bianliticheng($bianliticheng_data); // 提成处理
            M()->commit();

            //-----------------------------------------修改用户数据 商户余额、冻结余额end-----------------------------------

            //-----------------------------------------修改通道风控支付数据start----------------------------------------------
            $m_Channel     = M('Channel');
            $channel_where = ['id' => $order_info['channel_id']];
            $channel_info  = $m_Channel->where($channel_where)->find();
            //判断当天交易金额并修改支付状态
            $channel_res = $this->saveOfflineStatus(
                $m_Channel,
                $order_info['channel_id'],
                $order_info['pay_amount'],
                $channel_info
            );

            //-----------------------------------------修改通道风控支付数据end------------------------------------------------

            //-----------------------------------------修改子账号风控支付数据start--------------------------------------------
            $m_ChannelAccount      = M('ChannelAccount');
            $channel_account_where = ['id' => $order_info['account_id']];
            $channel_account_info  = $m_ChannelAccount->where($channel_account_where)->find();
            if ($channel_account_info['is_defined'] == 0) {
                //继承自定义风控规则
                $channel_info['paying_money'] = $channel_account_info['paying_money']; //当天已交易金额应该为子账号的交易金额
                $channel_account_info         = $channel_info;
            }
            //判断当天交易金额并修改支付状态
            $channel_account_res = $this->saveOfflineStatus(
                $m_ChannelAccount,
                $order_info['account_id'],
                $order_info['pay_amount'],
                $channel_account_info
            );
            if ($channel_account_info['unit_interval']) {
                $m_ChannelAccount->where([
                    'id' => $order_info['account_id'],
                ])->save([
                    'unit_paying_number' => ['exp', 'unit_paying_number+1'],
                    'unit_paying_amount' => ['exp', 'unit_paying_amount+' . $order_info['pay_actualamount']],
                ]);
            }

            //-----------------------------------------修改子账号风控支付数据end----------------------------------------------

        }

        //************************************************回调，支付跳转*******************************************//
        $return_array = [ // 返回字段
            "memberid"       => $order_info["pay_memberid"], // 商户ID
            "orderid"        => $order_info['out_trade_id'], // 订单号
            'transaction_id' => $order_info["pay_orderid"], //支付流水号
            "amount"         => $order_info["pay_amount"], // 交易金额
            "datetime"       => date("YmdHis"), // 交易时间
            "returncode"     => "00", // 交易状态
        ];
        $sign                   = $this->createSign($member_info['apikey'], $return_array);
        $return_array["sign"]   = $sign;
        $return_array["attach"] = $order_info["attach"];

        switch ($returntype) {
            case '0':
                $notifystr = "";
                foreach ($return_array as $key => $val) {
                    $notifystr = $notifystr . $key . "=" . $val . "&";
                }
                $notifystr = rtrim($notifystr, '&');
                $ch        = curl_init();
                curl_setopt($ch, CURLOPT_TIMEOUT, 10);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_URL, $order_info["pay_notifyurl"]);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $notifystr);
                $contents = curl_exec($ch);
                curl_close($ch);
                if (strstr(strtolower($contents), "ok") != false) {
                    //更新交易状态
                    $order_where = [
                        'id'          => $order_info['id'],
                        'pay_orderid' => $order_info["pay_orderid"],
                    ];
                    $order_result = $m_Order->where($order_where)->setField("pay_status", 2);
                } else {
                    // $this->jiankong($order_info['pay_orderid']);
                }
                break;

            case '1':
                $this->setHtml($order_info["pay_callbackurl"], $return_array);
                break;

            default:
                # code...
                break;
        }
    }

}
/**
 *
 */
class TDEA
{
    public static function encrypt($input, $key, $iv, $base64 = true)
    {
        $size                  = 8;
        $input                 = self::pkcs5_pad($input, $size);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $data = mcrypt_generic($encryption_descriptor, $input);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        return base64_encode($data);
    }

    public static function decrypt($crypt, $key, $iv, $base64 = true)
    {
        $crypt                 = base64_decode($crypt);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $decrypted_data = mdecrypt_generic($encryption_descriptor, $crypt);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        $decrypted_data = self::pkcs5_unpad($decrypted_data);
        return rtrim($decrypted_data);
    }

    private static function pkcs5_pad($text, $blocksize)
    {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }

    private static function pkcs5_unpad($text)
    {
        $pad = ord($text{strlen($text) - 1});
        if ($pad > strlen($text)) {
            return false;
        }
        return substr($text, 0, -1 * $pad);
    }

}
