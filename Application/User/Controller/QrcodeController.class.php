<?php
namespace User\Controller;

use Think\Page;
use Think\Upload;

/**
 * 二维码
 * Class QrcodeController
 * @package User\Controller
 */

class QrcodeController extends UserController
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 列表
     */
    public function index()
    {
        $list = M('Qrcode')
            ->where(['user_id' => $this->fans['uid']])
            ->order('id desc')
            ->select();
        $this->assign("list", $list);
        $this->display();
    }

    /**
     *  新增、修改二维码
     */
    public function detail()
    {

        if (IS_POST) {
            $id   = I('post.id', 0, 'intval');
            $rows = I('post.b', '', 'trim');
            $userid = session('user_auth.uid');

            if (!$rows['name']) {
                $this->ajaxReturn(['status' => 0, 'msg' => '：数据不完整']);
            }

            if ($id) {
                M('Qrcode')->where(['id' => $id, 'userid' => $this->fans['uid']])->save($rows);
                $res = 1;
            } else {
                $rows['user_id'] = $this->fans['uid'];
                $rows['create_at'] = date("Y-m-d H:i:s");
                $res = M('Qrcode')->add($rows);
            }

            $this->ajaxReturn(['status' => $res]);
        } else {
            $id = I('get.id', 0, 'intval');

            if ($id) {
                $data = M('Qrcode')->where(['id' => $id, 'userid' => $this->fans['uid']])->find();
                $this->assign('b', $data);
            }
            $this->display();
        }
    }

    /**
     *  修改默认
     */
    public function editStatus()
    {
        if (IS_POST) {
            $id        = I('post.id');
            $status = I('post.isopen');
            if ($id) {
                $res = M('Qrcode')->where(['id' => $id, 'userid' => $this->fans['uid']])->save(['status' => $status]);
                $this->ajaxReturn(['status' => $res]);
            }
        }
    }

    public function upload()
    {
        if (IS_POST) {
            $upload           = new \Think\Upload();
            $upload->maxSize  = 5097152;
            $upload->exts     = array('jpg', 'gif', 'png');
            $upload->savePath = '/qrcode/'.$this->fans['uid'].'/';
            $info             = $upload->uploadOne($_FILES['file']);

            if (! $info) {
                $this->error();
                $res = [
                    'code' => 1,
                    'msg' => $upload->getError(),
                    'data'=>['src'=>''],
                ];
            } else {
                $res = [
                    'code' => 0,
                    'msg' => '图片上传成功',
                    'data'=>['src'=>'Uploads'.$info['savepath'].$info['savename']],
                ];
            }
            $this->ajaxReturn($res);
        }
    }

    /**
     *  删除
     */
    public function remove()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            if ($id) {
                $res = M('Qrcode')->where(['id' => $id, 'userid' => $this->fans['uid']])->delete();
                $this->ajaxReturn(['status' => $res]);
            }
        }
    }
}
