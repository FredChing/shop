<?php
namespace Pay\Controller;

use Think\Log;
/**
 * 第三方接口开发示例控制器
 * Class QrcodeController
 * @package Pay\Controller
 *
 * 三方通道接口开发说明：
 * 1. 管理员登录网站后台，供应商管理添加通道，通道英文代码即接口类名称
 * 2. 用户管理-》通道-》指定该通道（独立或轮询）
 * 3. 用户费率优先通道费率
 * 4. 用户通道指定优先系统默认支持产品通道指定
 * 5. 三方回调地址URL写法，如本接口 ：
 *    异步地址：http://www.yourdomain.com/Pay_Demo_notifyurl.html
 *    跳转地址：http://www.yourdomain.com/Pay_Demo_callbackurl.html
 *
 *    注：下游对接请查看商户API对接文档部分.
 */

class QrcodeController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     *  发起支付
     */
    public function Pay($array)
    {

        // 记录接口请求数据
        $M_Api_log = M('Api_log');
        $apiLogData['request'] = json_encode($_POST);
        $apiLogData['memberid'] = I("request.pay_memberid");
        $apiLogData['orderid'] = I("request.pay_orderid");
        $apiLogData['created_at'] = date("Y-m-d H:i:s");

        // 获取二维码
        $userInfo = M('Member')->find($array['userid']);
        $Qrcode = M('Qrcode');
        $qrcodeItem = $Qrcode
            ->where(['user_id' => $userInfo['parentid'], 'status' => 1])
            ->order('last_use_at ASC')
            ->find();

        $qrcodeId = $qrcodeItem['id'];

        if (!$qrcodeItem) {
            Log::record('二维码获取失败+++++++USERID:' . $array['userid']);
            $this->showmessage("二维码获取失败");
        }
        if (!$qrcodeItem['path']) {
            Log::record('二维码获取失败+++++++DEVICEID:' . $qrcodeId);
            $this->showmessage("二维码获取失败");
        }

        //生成系统订单
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site . 'Pay_Qrcode_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_Qrcode_callbackurl.html'; //跳转通知
        $parameter = array(
            'code'         => 'Qrcode',            // 通道代码
            'title'        => '二维码',               //通道名称
            'qrcode_id'    => $qrcodeId,   // 设备号
            'exchange'     => 100,                 // 金额比例
            'gateway'      => '',                  //网关地址
            'orderid'      => '',                  //平台订单号（有特殊需求的订单号接口使用）
            'out_trade_id' => $orderid,            //外部商家订单号
            'body'         => $body,               //商品名称
            'channel'      => $array,              //通道信息
        );
        $return = $this->orderadd($parameter);



        // 更新记录
        $Qrcode->last_use_at = date("Y-m-d H:i:s");
        $Qrcode->save();
        $return['qrcode'] = $this->_site . $qrcodeItem['path'];

        /**
         *  return 参数说名：
         *  memberid 商户编号 平台分配
         *  mch_id   商户号（三方分配）
         *  signkey  签文密钥或证书
         *  appid    微信APPID 或者 商家账号
         *  appsecret 微信密钥 或者 商家密钥
         *  gateway   三方网关
         *  amount   订单金额
         *  orderid  系统订单号
         *  subject  商品标题
         *  datetime 订单创建时间
         *  notifyurl 三方异步通知平台地址
         *  callbackurl 三方跳转通知平台地址
         *  out_trade_id 外部订单号（商家）
         *  bankcode 支付产品ID
         *  code     支付产品英文代码
         *  status    success 订单创建成功
         */
        //组装请求参数、并发起请求

        unset($return['mch_id']);
        unset($return['unlockdomain']);
        unset($return['signkey']);
        unset($return['appid']);
        unset($return['appsecret']);
        unset($return['gateway']);
        unset($return['notifyurl']);
        unset($return['callbackurl']);
        unset($return['out_trade_id']);
        unset($return['code']);

        // 记录接口返回
        $apiLogData['qrcode_id'] = $qrcodeId;
        $apiLogData['response'] = json_encode($return);
        $M_Api_log->add($apiLogData);

        return $this->showSuccess('请求成功', $return);

    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $orderid = ''; //系统订单号
        //处理验签
        // .............................. 省略部分代码
        //生成签文，开始验签
        $verify = false;
        if ($verify) {
            $Order = M("Order");
            $pay_status = $Order->where(["pay_orderid" => $orderid])->getField("pay_status");
            if ($pay_status <> 0) {
                //业务逻辑开始、并下发通知.
                $this->EditMoney($orderid, 'Demo', 1);
            }
        }
    }

    /**
     *  服务器通知
     */
    public function notifyurl()
    {
        $orderid = ''; //系统订单号
        //处理验签
        // .............................. 省略部分代码
        //生成签文，开始验签
        $verify = false;
        if ($verify) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($orderid, 'Demo', 0);
            //回写消息
            exit("success");
        }
    }
}
