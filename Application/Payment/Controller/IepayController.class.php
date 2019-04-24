<?php
namespace Payment\Controller;

class IepayController extends PaymentController
{

    public function __construct()
    {
        parent::__construct();
    }

    public function PaymentExec($wttlList, $pfaList)
    {
        $url = 'https://rpi.ie-pay.com/agentpay/pay';
        $biz_content = [
            'version' => '1.0',
            'mch_id' => $pfaList['mch_id'],
            'out_order_no' => $wttlList['orderid'],
            'payment_fee' => $wttlList['money']*100,
            'payee_acct_no' => $wttlList['banknumber'],
            'payee_acct_name' => $wttlList['bankfullname'],
            'card_type' => '1',
            'payee_acct_type' => '1',
            'settle_type' => '0',
            'remark' => '结算',
            'notify_url' => sprintf(
                '%s://%s:%d/Payment_Iepay_notifyurl.html',
                is_https() ? 'https' : 'http',
                $_SERVER['SERVER_NAME'],
                $_SERVER["SERVER_PORT"]),
        ];
        $biz_content = json_encode($biz_content,JSON_UNESCAPED_UNICODE);
        $signature = strtoupper(md5('biz_content='.$biz_content."&key=".$pfaList['signkey']));
        $data = [
              'sign_type' => 'MD5',
              'signature' => $signature,
              'biz_content' => $biz_content
        ];
        file_put_contents('./Data/IeDf.txt', "【".date('Y-m-d H:i:s')."】代付提交数据：\r\n".$biz_content."\r\n\r\n",FILE_APPEND);
        $returnJson= curlPost($url, $data);
        file_put_contents('./Data/IeDf.txt', "【".date('Y-m-d H:i:s')."】代付返回数据：\r\n".$returnJson."\r\n\r\n",FILE_APPEND);
        if($returnJson) {
            $returnData = json_decode($returnJson, true);
            if($returnData['ret_code'] == '0') {
                $biz_content  = json_encode($returnData['biz_content'], JSON_UNESCAPED_UNICODE);
                $newSign = strtoupper(md5('biz_content='.$biz_content."&key=".$pfaList['signkey']));
                if($returnData['signature'] == $newSign) {
                    M('wttklist')->where(['id'=>$wttlList['id']])->save(['transaction_id' => $returnData['biz_content']['order_no']]);
                    $return = ['status' => 1, 'msg' => '处理中'];
                } else {
                    $return = ['status' => 3, 'msg' => "签名错误"];
                }
            } else {
                $return = ['status' => 3, 'msg' => "错误：{$returnData['ret_msg']}"];
            }
        } else {
            $return = ['status' => 3, 'msg' => "请求接口失败"];
        }
        return $return;
    }

    public function PaymentQuery($wttlList, $pfaList)
    {
        $url = 'https://rpi.ie-pay.com/agentpay/query';
        $biz_content = [
            'mch_id' => $pfaList['mch_id'],
            'order_no' => $wttlList['transaction_id']
        ];
        $biz_content = json_encode($biz_content,JSON_UNESCAPED_UNICODE);
        $signature = strtoupper(md5('biz_content='.$biz_content."&key=".$pfaList['signkey']));
        $data = [
            'sign_type' => 'MD5',
            'signature' => $signature,
            'biz_content' => $biz_content
        ];
        file_put_contents('./Data/IeDf.txt', "【".date('Y-m-d H:i:s')."】代付查询提交数据：\r\n".$biz_content."\r\n\r\n",FILE_APPEND);
        $returnJson= curlPost($url, $data);
        file_put_contents('./Data/IeDf.txt', "【".date('Y-m-d H:i:s')."】代付查询返回数据：\r\n".$returnJson."\r\n\r\n",FILE_APPEND);
        if($returnJson) {
            $returnData = json_decode($returnJson, true);
            if($returnData['ret_code'] == '0') {
                $biz_content  = json_encode($returnData['biz_content'], JSON_UNESCAPED_UNICODE);
                $newSign = strtoupper(md5('biz_content='.$biz_content."&key=".$pfaList['signkey']));
                if($returnData['signature'] == $newSign) {
                    switch ($returnData['biz_content']['lists'][0]['order_status']) {
                        case '1'://处理中
                            $return = ['status' => 1, 'msg' => '处理中'];
                            break;
                        case '2'://成功
                            $return = ['status' => 2, 'msg' => '成功'];
                            break;
                        case '3'://失败
                            $return = ['status' => 3, 'msg' => '失败'];
                            break;
                    }
                } else {
                    $return = ['status' => 3, 'msg' => "签名错误"];
                }
            } else {
                $return = ['status' => 1, 'msg' => $returnData['ret_msg']];
            }

        } else {
            $return = ['status' => 1, 'msg' => "请求接口失败"];
        }
        return $return;
    }

    //异步通知
    public function notifyurl() {

        $json = file_get_contents("php://input");
        file_put_contents('./Data/IeDf_notify.txt', "【".date('Y-m-d H:i:s')."】".$json."\r\n\r\n",FILE_APPEND);
        if(!$json) {
            exit('error');
        }
        $pfaList = M('PayForAnother')->where(['code' => 'Iepay'])->find();
        if(empty($pfaList)) {
            exit('代付渠道不存在');
        }
        $data = json_decode($json, true);
        $widthdraw = M('wttklist')->where(['orderid'=>$data['biz_content']['out_order_no']])->find();
        if(empty($widthdraw)) {
            exit('代付订单不存在');
        }
        if($data['ret_code'] == '0') {
            $biz_content  = json_encode($data['biz_content'], JSON_UNESCAPED_UNICODE);
            $newSign = strtoupper(md5('biz_content='.$biz_content."&key=".$pfaList['signkey']));
            if($data['signature'] == $newSign) {
                switch ($data['biz_content']['order_status']) {
                    case '1'://处理中,不做处理
                        break;
                    case '2'://成功
                        M('wttklist')->where(['orderid'=>$data['biz_content']['out_order_no'], 'status'=>['neq', 2]])->save(['status' => 2, 'memo' => '成功', 'cldatetime'=>date('Y-m-d H:i:s', time())]);
                        break;
                    case '3'://失败
                        M('wttklist')->where(['orderid'=>$data['biz_content']['out_order_no'],'status'=>['neq', 3]])->save(['status' => 4, 'memo' => '失败']);
                        break;
                }
                exit('SUCCESS');
            } else {
                exit("签名错误");
            }
        } else {
            exit("错误：{$data['ret_msg']}");
        }

    }

    //查询余额
    public function queryBalance()
    {
        if (IS_AJAX) {
            $url = 'https://rpi.ie-pay.com/amountquery';
            $config = M('PayForAnother')->where(['code' => 'Iepay'])->find();
            if(empty($config)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '代付渠道不存在']);
            }
            $biz_content = [
                'mch_id' => $config['mch_id'],
                'type' => 1
            ];
            $biz_content = json_encode($biz_content,JSON_UNESCAPED_UNICODE);
            $signature = strtoupper(md5('biz_content='.$biz_content."&key=".$config['signkey']));
            $data = [
                'sign_type' => 'MD5',
                'signature' => $signature,
                'biz_content' => $biz_content
            ];
            $returnJson= curlPost($url, $data);
            if($returnJson) {
                $returnData = json_decode($returnJson, true);
                if($returnData['ret_code'] == '0') {
                    $result['balance'] = $returnData['biz_content']['amount']/100;
                    $data = [
                        [
                            'key'   => '账户余额',
                            'value' => $result['balance'] . '元',
                        ],
                    ];
                    $this->assign('data', $data);
                    $html = $this->fetch('Public/queryBalance');
                    $this->ajaxReturn(['status' => 1, 'msg' => '成功', 'data' => $html]);
                } else {
                    $this->ajaxReturn(['status' => 0, 'msg' => $returnData['ret_msg']]);
                }
            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => '请求接口失败']);
            }
        }
    }
}
