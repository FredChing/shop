<?php
namespace Admin\Controller;
use Think\Page;

class AppNotifyController extends AdminController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {

        $count = M('App_notify')->count();
        $size = 15;
        $rows = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('App_notify')
        ->order('id desc')
        ->limit($page->firstRow . ',' . $page->listRows)
        ->select();

        $this->assign("list", $list);
        $this->assign('rows', $rows);
        $this->assign('page', $page->show());
        $this->display();
    }

}
