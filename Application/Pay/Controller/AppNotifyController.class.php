<?php
namespace Pay\Controller;

/**
 * Class AppNotifyController
 * http://dpays-s.test/Pay_AppNotify_Create.html
 *
 */
class AppNotifyController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Login()
    {
        $username = I("request.username", '', 'trim');
        $password = I("request.password", '', 'trim');
        if (!$username || !$password) {
            $this->showmessage('用户名、密码不能为空！');
        }

        $fans = M('Member')->where(['username' => $username])->find();
        if (md5($password . $fans['salt']) != $fans['password']) {
            log_auth_error($fans['id'], 0);
            $this->showmessage('密码输入有误！');
        } else {
            clear_auth_error($fans['id'], 6);
            M('Member')->where(['id' => $fans['id']])->save(['login_error_num' => 0, 'last_login_time' => time()]);
            $this->showSuccess('登录成功');
        }
    }


    public function Device()
    {
        $username = I("request.username", '', 'trim');
        $device_no = I("request.device_no", '', 'trim');

        $fans = M('Member')->where(['username' => $username])->find();
        $qrcode = M('Qrcode')->where(['user_id' => $fans['id'], 'id' => $device_no, 'status' => 1])->find();

        if ($qrcode) {
            $this->showSuccess('设备验证成功');
        } else {
            $this->showmessage('设备验证失败');
        }
    }

    /**
     *  记录APP通知
     */
    public function Create()
    {
        C('TOKEN_ON', false);

        $device_no  = I("request.device_no");
        $pay_type   = I("request.pay_type");
        $pay_amount = I('request.pay_amount');

        if (!$device_no || !$pay_type || !$pay_amount) {
            $this->showmessage('参数不完整');
        }

        $qrcode = M('Qrcode')->where(['id' => $device_no, 'status' => 1])->find();
        $user_id     = intval($qrcode['user_id'] + 10000); // 商户ID

        $Order = M('Order');
        $orderItem = $Order
            ->where([
                'pay_status'    => 0,
                'pay_applydate' => ['gt', strtotime("-1 hours")],
                'qrcode_id'     => $device_no,
                'pay_amount'    => $pay_amount,
                'pay_memberid'  => $user_id
            ])
            ->order('id desc')
            ->find();

        // 触发回调
        $this->EditMoney($orderItem['pay_orderid'], 'Qrcode', 0);

        // 记录数据
        $parameter  = array(
            'qrcode_id'  => $device_no,
            'pay_type'   => $pay_type,
            'pay_amount' => $pay_amount,
            'order_id'   => $order_id ? $order_id : 0,
            'created_at' => date("Y-m-d H:i:s"),
        );
        $AppNotify = M("app_notify");
        $data = $AppNotify->add($parameter);

        $data = array('status' => 'success', 'msg' => '收到通知', 'data' => $data);
        echo json_encode($data);
        exit;
    }
}
