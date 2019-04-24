-- MySQL dump 10.13  Distrib 5.5.60, for Linux (x86_64)
--
-- Host: localhost    Database: pay
-- ------------------------------------------------------
-- Server version	5.5.60-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pay_admin`
--

DROP TABLE IF EXISTS `pay_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) NOT NULL COMMENT '后台用户名',
  `password` varchar(32) NOT NULL COMMENT '后台用户密码',
  `groupid` tinyint(1) unsigned DEFAULT '0' COMMENT '用户组',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `google_secret_key` varchar(128) NOT NULL DEFAULT '' COMMENT '谷歌令牌密钥',
  `mobile` varchar(255) NOT NULL DEFAULT '' COMMENT '手机号码',
  `session_random` varchar(50) NOT NULL DEFAULT '' COMMENT 'session随机字符串',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_admin`
--

LOCK TABLES `pay_admin` WRITE;
/*!40000 ALTER TABLE `pay_admin` DISABLE KEYS */;
INSERT INTO `pay_admin` VALUES (1,'adminroot','81b5234976a55e5181f24d9eab8fb697',1,0,'','','KXLzjAjYdzyd6dNRaRiNR86O1NzSrhSS');
/*!40000 ALTER TABLE `pay_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_apimoney`
--

DROP TABLE IF EXISTS `pay_apimoney`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_apimoney` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `payapiid` int(11) DEFAULT NULL,
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `freezemoney` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '冻结金额',
  `status` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_apimoney`
--

LOCK TABLES `pay_apimoney` WRITE;
/*!40000 ALTER TABLE `pay_apimoney` DISABLE KEYS */;
INSERT INTO `pay_apimoney` VALUES (10,6,207,18000.0000,0.000,1);
/*!40000 ALTER TABLE `pay_apimoney` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_article`
--

DROP TABLE IF EXISTS `pay_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `groupid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分组  0：所有 1：商户 2：代理',
  `title` varchar(300) NOT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL COMMENT '描述',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1显示 0 不显示',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_article`
--

LOCK TABLES `pay_article` WRITE;
/*!40000 ALTER TABLE `pay_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_attachment`
--

DROP TABLE IF EXISTS `pay_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `filename` varchar(100) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_attachment`
--

LOCK TABLES `pay_attachment` WRITE;
/*!40000 ALTER TABLE `pay_attachment` DISABLE KEYS */;
INSERT INTO `pay_attachment` VALUES (48,2,'242dd42a2834349b88359f1eccea15ce36d3be7e.jpg','Uploads/verifyinfo/59a2b65d0816c.jpg'),(46,2,'6-140F316125V44.jpg','Uploads/verifyinfo/59a2b65cd9877.jpg'),(47,2,'6-140F316132J02.jpg','Uploads/verifyinfo/59a2b65cea2ec.jpg');
/*!40000 ALTER TABLE `pay_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auth_error_log`
--

DROP TABLE IF EXISTS `pay_auth_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auth_error_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `auth_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：商户登录 1：后台登录 2：商户短信验证 3：后台短信验证 4：谷歌令牌验证 5：支付密码验证 ',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auth_error_log`
--

LOCK TABLES `pay_auth_error_log` WRITE;
/*!40000 ALTER TABLE `pay_auth_error_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_auth_error_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auth_group`
--

DROP TABLE IF EXISTS `pay_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_manager` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1需要验证权限 0 不需要验证权限',
  `rules` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auth_group`
--

LOCK TABLES `pay_auth_group` WRITE;
/*!40000 ALTER TABLE `pay_auth_group` DISABLE KEYS */;
INSERT INTO `pay_auth_group` VALUES (1,'超级管理员',1,0,'1,49,2,3,51,4,57,5,55,56,58,59,6,44,52,53,48,70,54,126,7,8,60,61,62,9,63,64,65,66,10,67,68,69,11,12,79,80,81,82,83,84,85,86,87,88,89,90,91,93,94,95,96,97,98,99,100,101,120,13,14,15,92,16,73,76,77,78,17,121,18,19,71,75,20,21,72,74,22,23,114,115,24,25,26,46,125,127,130,27,28,108,29,102,30,103,106,107,119,104,105,109,110,111,128,31,32,33,34,35,36,37,38,39,113,40,112,41,42,45,47,116,122,117,123,118,124'),(2,'运营管理员',1,0,'1,77,3,18,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,92,93,94,98,99,19,50,51,52,4,14,54,55,56,57,15,59,60,61,62,63,5,23,65,66,24,67,6,13,68,69,70,71,73,76,7,12,78,79,80,81,82,22,83,84,85,86,87'),(3,'财务管理员',1,1,'1,77,5,23,65,66,24,67,6,13,68,69,70,71,73,76,25,72,26,74,75'),(4,'普通商户',1,1,''),(5,'普通代理商',1,1,'');
/*!40000 ALTER TABLE `pay_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auth_group_access`
--

DROP TABLE IF EXISTS `pay_auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auth_group_access`
--

LOCK TABLES `pay_auth_group_access` WRITE;
/*!40000 ALTER TABLE `pay_auth_group_access` DISABLE KEYS */;
INSERT INTO `pay_auth_group_access` VALUES (1,1),(2,4),(7,2);
/*!40000 ALTER TABLE `pay_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auth_rule`
--

DROP TABLE IF EXISTS `pay_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) DEFAULT '' COMMENT '图标',
  `menu_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一标识Controller/action',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `pid` tinyint(5) NOT NULL DEFAULT '0' COMMENT '菜单ID ',
  `is_menu` tinyint(1) unsigned DEFAULT '0' COMMENT '1:是主菜单 0否',
  `is_race_menu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1:是 0:不是',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auth_rule`
--

LOCK TABLES `pay_auth_rule` WRITE;
/*!40000 ALTER TABLE `pay_auth_rule` DISABLE KEYS */;
INSERT INTO `pay_auth_rule` VALUES (1,'fa fa-home','Index/index','管理首页',0,1,0,1,1,''),(2,'fa fa-cogs','System/#','系统设置',0,1,0,1,1,''),(3,'fa fa-cog','System/base','基本设置',2,1,0,1,1,''),(4,'fa fa-envelope-o','System/email','邮件设置',2,1,0,1,1,''),(5,'fa fa-send','System/smssz','短信设置',2,1,0,1,1,''),(6,'fa fa-hourglass','System/planning','计划任务',2,1,0,1,1,''),(7,'fa fa-user-circle','Admin/#','管理员管理',0,1,0,1,1,''),(8,'fa fa-vcard ','Admin/index','管理员信息',7,1,0,1,1,''),(9,'fa fa-street-view','Auth/index','角色配置',7,1,0,1,1,''),(10,'fa fa-universal-access','Menu/index','权限配置',7,1,0,1,1,''),(11,'fa fa-users','User/#','用户管理',0,1,0,1,1,''),(12,'fa fa-user','User/index?status=1&authorized=1','已认证用户',11,1,0,1,1,''),(13,'fa fa-user-o','User/index?status=1&authorized=2','待认证用户',11,1,0,1,1,''),(14,'fa fa-user-plus','User/index?status=1&authorized=0','未认证用户',11,1,0,1,1,''),(15,'fa fa-user-times','User/index?status=0','冻结用户',11,1,0,1,1,''),(16,'fa fa-gift','User/invitecode','邀请码',11,1,0,1,1,''),(17,'fa fa-address-book','User/loginrecord','登录记录',11,1,0,1,1,''),(18,'fa fa-handshake-o','Agent/#','代理管理',0,1,0,1,1,''),(19,'fa fa-hand-lizard-o','User/agentList','代理列表',18,1,0,1,1,''),(20,'fa fa-signing','Order/changeRecord?bank=9','佣金记录',18,1,0,1,1,''),(21,'fa fa-sellsy','Order/dfApiOrderList','代付Api订单',18,1,0,1,1,''),(22,'fa fa-reorder','User/#','订单管理',0,1,0,1,1,''),(23,'fa fa-indent','Order/changeRecord','流水记录',22,1,0,1,1,''),(24,'fa fa-thumbs-up','Order/index?status=1or2','成功订单',22,1,0,1,1,''),(25,'fa fa-thumbs-down','Order/index?status=0','未支付订单',22,1,0,1,1,''),(26,'fa fa-hand-o-right','Order/index?status=1','异常订单',22,1,0,1,1,''),(27,'fa fa-user-secret','Withdrawal','提款管理',0,1,0,1,1,''),(28,'fa fa-wrench','Withdrawal/setting','提款设置',27,1,0,1,1,''),(29,'fa fa-asl-interpreting','Withdrawal/index','手动结算',27,1,0,1,1,''),(30,'fa fa-window-restore','Withdrawal/payment','代付结算',27,1,0,1,1,''),(31,'fa fa-bank','Channel/#','通道管理',0,1,0,1,1,''),(32,'fa fa-product-hunt','Channel/index','入金渠道设置',31,1,0,1,1,''),(33,'fa fa-sitemap','Channel/product','支付产品设置',31,1,0,1,1,''),(34,'fa fa-sliders','PayForAnother/index','代付渠道设置',31,1,0,1,1,''),(35,'fa fa-book','Content/#','文章管理',0,1,0,1,1,''),(36,'fa fa-tags','Content/category','栏目列表',35,1,0,1,1,''),(37,'fa fa-list-alt','Content/article','文章列表',35,1,0,1,1,''),(38,'fa fa-line-chart','Statistics/#','财务分析',0,1,0,1,1,''),(39,'fa fa-bar-chart-o','Statistics/index','交易统计',38,1,0,1,1,''),(40,'fa fa-area-chart','Statistics/userFinance','商户交易统计',38,1,0,1,1,''),(41,'fa fa-industry','Statistics/userFinance?groupid=agent','代理商交易统计',38,1,0,1,1,''),(42,'fa fa-pie-chart','Statistics/channelFinance','接口交易统计',38,1,0,1,1,''),(43,'fa fa-cubes','Template/index','模板设置',2,1,0,1,0,''),(44,'fa fa-mobile','System/mobile','手机设置',2,1,0,1,1,''),(45,'fa fa-signal','Statistics/chargeRank','充值排行榜',38,1,0,1,1,''),(46,'fa fa-first-order','Deposit/index','投诉保证金设置',22,1,0,1,1,''),(47,'fa fa-asterisk','Statistics/complaintsDeposit','投诉保证金统计',38,1,0,1,1,''),(48,'fa fa-database','System/clearData','数据清理',2,1,0,1,1,''),(49,'','Index/main','Dashboard',1,1,0,1,1,''),(51,'','System/SaveBase','保存设置',3,0,0,1,1,''),(52,'','System/BindMobileShow','绑定手机号码',44,0,0,1,1,''),(53,'','System/editMobileShow','手机修改',44,0,0,1,1,''),(54,'fa fa-lock','System/editPassword','修改密码',2,1,0,1,1,''),(55,'','System/editSmstemplate','短信模板',5,0,0,1,1,''),(56,'','System/saveSmstemplate','保存短信模板',5,0,0,1,1,''),(57,'','System/saveEmail','邮件保存',4,0,0,1,1,''),(58,'','System/testMobile','测试短信',5,0,0,1,1,''),(59,'','System/deleteAdmin','删除短信模板',5,0,0,1,1,''),(60,'','Admin/addAdmin','管理员添加',8,0,0,1,1,''),(61,'','Admin/editAdmin','管理员修改',8,0,0,1,1,''),(62,'','Admin/deleteAdmin','管理员删除',8,0,0,1,1,''),(63,'','Auth/addGroup','添加角色',9,0,0,1,1,''),(64,'','Auth/editGroup','修改角色',9,0,0,1,1,''),(65,'','Auth/giveRole','选择角色',9,0,0,1,1,''),(66,'','Auth/ruleGroup','分配权限',9,0,0,1,1,''),(67,'','Menu/addMenu','添加菜单',10,0,0,1,1,''),(68,'','Menu/editMenu','修改菜单',10,0,0,1,1,''),(69,'','Menu/delMenu','删除菜单',10,0,0,1,1,''),(70,'','System/clearDataSend','数据清理提交',48,0,0,1,1,''),(71,'','User/addAgentCate','代理级别',19,0,0,1,1,''),(72,'','User/saveAgentCate','保存代理级别',18,0,0,1,1,''),(73,'','User/addInvitecode','添加激活码',16,0,0,1,1,''),(74,'','User/EditAgentCate','修改代理分类',18,0,0,1,1,''),(75,'','User/deleteAgentCate','删除代理分类',19,0,0,1,1,''),(76,'','User/setInvite','邀请码设置',16,0,0,1,1,''),(77,'','User/addInvite','创建邀请码',16,0,0,1,1,''),(78,'','User/delInvitecode','删除邀请码',16,0,0,1,1,''),(79,'','User/editUser','用户编辑',12,0,0,1,1,''),(80,'','User/changeuser','修改状态',12,0,0,1,1,''),(81,'','User/authorize','用户认证',12,0,0,1,1,''),(82,'','User/usermoney','用户资金管理',12,0,0,1,1,''),(83,'','User/userWithdrawal','用户提现设置',12,0,0,1,1,''),(84,'','User/userRateEdit','用户费率设置',12,0,0,1,1,''),(85,'','User/editPassword','用户密码修改',12,0,0,1,1,''),(86,'','User/editStatus','用户状态修改',12,0,0,1,1,''),(87,'','User/delUser','用户删除',12,0,0,1,1,''),(88,'','User/thawingFunds','T1解冻任务管理',12,0,0,1,1,''),(89,'','User/exportuser','导出用户',12,0,0,1,1,''),(90,'','User/editAuthoize','修改用户认证',12,0,0,1,1,''),(91,'','User/getRandstr','切换商户密钥',12,0,0,1,1,''),(92,'','User/suoding','用户锁定',15,0,0,1,1,''),(93,'','User/editbankcard','银行卡管理',12,0,0,1,1,''),(94,'','User/saveUser','添加用户',12,0,0,1,1,''),(95,'','User/saveUserProduct','保存用户产品',12,0,0,1,1,''),(96,'','User/saveUserRate','保存用户费率',12,0,0,1,1,''),(97,'','User/edittongdao','编辑通道',12,0,0,1,1,''),(98,'','User/frozenMoney','用户资金冻结',12,0,0,1,1,''),(99,'','User/unfrozenHandles','T1资金解冻',12,0,0,1,1,''),(100,'','User/frozenOrder','冻结订单列表',12,0,0,1,1,''),(101,'','User/frozenHandles','T1订单解冻展示',12,0,0,1,1,''),(102,'','Withdrawal/editStatus','操作状态',29,0,0,1,1,''),(103,'','Withdrawal/editwtStatus','操作订单状态',30,0,0,1,1,''),(104,'','Withdrawal/exportorder','导出数据',27,0,0,1,1,''),(105,'','Withdrawal/editwtAllStatus','批量修改提款状态',27,0,0,1,1,''),(106,'','Withdrawal/exportweituo','导出委托提现',30,0,0,1,1,''),(107,'','Payment/index','提交上游',30,0,0,1,1,''),(108,'','Withdrawal/saveWithdrawal','保存设置',28,0,0,1,1,''),(109,'','Withdrawal/AddHoliday','添加假日',27,0,0,1,1,''),(110,'','Withdrawal/settimeEdit','编辑提款时间',27,0,0,1,1,''),(111,'','Withdrawal/delHoliday','删除节假日',27,0,0,1,1,''),(112,'','Statistics/exportorder','订单数据导出',40,0,0,1,1,''),(113,'','Statistics/details','查看详情',39,0,0,1,1,''),(114,'','Order/exportorder','订单导出',23,0,0,1,1,''),(115,'','Order/exceldownload','记录导出',23,0,0,1,1,''),(116,'fa fa-area-chart','Statistics/platformReport','平台报表',38,1,0,1,1,''),(117,'fa fa-area-chart','Statistics/merchantReport','商户报表',38,1,0,1,1,''),(118,'fa fa-area-chart','Statistics/agentReport','代理报表',38,1,0,1,1,''),(119,'','Withdrawal/submitDf','代付提交',30,0,0,1,1,''),(120,'','User/editUserProduct','分配用户通道',12,0,0,1,1,''),(121,'fa fa-wrench','Transaction/index','风控设置',11,1,0,1,1,''),(122,'','Statistics/exportPlatform','导出平台报表',116,0,0,1,1,''),(123,'','Statistics/exportMerchant','导出商户报表',117,0,0,1,1,''),(124,'','Statistics/exportAgent','导出代理报表',118,0,0,1,1,''),(125,'','Order/show','查看订单',22,0,0,1,1,''),(126,'fa fa-cog','Withdrawal/checkNotice','提现申请声音提示',2,0,0,1,1,''),(127,'fa fa-bars','Order/index','全部订单',22,1,0,1,1,''),(128,'','Withdrawal/rejectAllDf','批量驳回代付',27,0,0,1,1,''),(129,'','User/saveWithdrawal','保存用户提款设置',28,0,0,1,1,''),(130,'fa fa-snowflake-o','Order/frozenOrder','冻结订单',22,1,0,1,1,'');
/*!40000 ALTER TABLE `pay_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auto_df_log`
--

DROP TABLE IF EXISTS `pay_auto_df_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auto_df_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `df_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型：1提交 2查询',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '结果 0：提交失败 1：提交成功 2：代付成功 3：代付失败',
  `msg` varchar(255) DEFAULT '' COMMENT '描述',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auto_df_log`
--

LOCK TABLES `pay_auto_df_log` WRITE;
/*!40000 ALTER TABLE `pay_auto_df_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_auto_df_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_auto_unfrozen_order`
--

DROP TABLE IF EXISTS `pay_auto_unfrozen_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_auto_unfrozen_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `freeze_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_auto_unfrozen_order`
--

LOCK TABLES `pay_auto_unfrozen_order` WRITE;
/*!40000 ALTER TABLE `pay_auto_unfrozen_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_auto_unfrozen_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_bankcard`
--

DROP TABLE IF EXISTS `pay_bankcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_bankcard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `bankname` varchar(100) NOT NULL COMMENT '银行名称',
  `subbranch` varchar(100) NOT NULL COMMENT '支行名称',
  `accountname` varchar(100) NOT NULL COMMENT '开户名',
  `cardnumber` varchar(100) NOT NULL COMMENT '银行卡号',
  `province` varchar(100) NOT NULL COMMENT '所属省',
  `city` varchar(100) NOT NULL COMMENT '所属市',
  `ip` varchar(100) DEFAULT NULL COMMENT '上次修改IP',
  `ipaddress` varchar(300) DEFAULT NULL COMMENT 'IP地址',
  `alias` varchar(255) DEFAULT '' COMMENT '备注',
  `isdefault` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认 1是 0 否',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `IND_UID` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_bankcard`
--

LOCK TABLES `pay_bankcard` WRITE;
/*!40000 ALTER TABLE `pay_bankcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_bankcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_blockedlog`
--

DROP TABLE IF EXISTS `pay_blockedlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_blockedlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) NOT NULL COMMENT '订单号',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `amount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `thawtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '解冻时间',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '商户支付通道',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1 解冻 0 冻结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金冻结待解冻记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_blockedlog`
--

LOCK TABLES `pay_blockedlog` WRITE;
/*!40000 ALTER TABLE `pay_blockedlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_blockedlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_browserecord`
--

DROP TABLE IF EXISTS `pay_browserecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_browserecord` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `articleid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_browserecord`
--

LOCK TABLES `pay_browserecord` WRITE;
/*!40000 ALTER TABLE `pay_browserecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_browserecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_category`
--

DROP TABLE IF EXISTS `pay_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文章栏目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_category`
--

LOCK TABLES `pay_category` WRITE;
/*!40000 ALTER TABLE `pay_category` DISABLE KEYS */;
INSERT INTO `pay_category` VALUES (1,'最新资讯',0,1),(2,'公司新闻',0,1),(3,'公告通知',0,1),(4,'站内公告',3,1),(5,'公司新闻',3,1);
/*!40000 ALTER TABLE `pay_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_channel`
--

DROP TABLE IF EXISTS `pay_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_channel` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商通道ID',
  `code` varchar(200) DEFAULT NULL COMMENT '供应商通道英文编码',
  `title` varchar(200) DEFAULT NULL COMMENT '供应商通道名称',
  `mch_id` varchar(100) DEFAULT NULL COMMENT '商户号',
  `signkey` varchar(500) DEFAULT NULL COMMENT '签文密钥',
  `appid` varchar(100) DEFAULT NULL COMMENT '应用APPID',
  `appsecret` varchar(100) DEFAULT NULL COMMENT '安全密钥',
  `gateway` varchar(300) DEFAULT NULL COMMENT '网关地址',
  `pagereturn` varchar(255) DEFAULT NULL COMMENT '页面跳转网址',
  `serverreturn` varchar(255) DEFAULT NULL COMMENT '服务器通知网址',
  `defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '下家费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶手续费',
  `rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '银行费率',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更改时间',
  `unlockdomain` varchar(100) NOT NULL COMMENT '防封域名',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型: 1 微信扫码 2 微信H5 3 支付宝扫码 4 支付宝H5 5网银跳转 6网银直连 7百度钱包 8 QQ钱包 9 京东钱包',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `paying_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天上游可交易量',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后交易时间',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小交易额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大交易额',
  `control_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '风控状态:0否1是',
  `offline_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '通道上线状态:0已下线，1上线',
  `t0defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶手续费',
  `t0rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0成本费率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='供应商列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_channel`
--

LOCK TABLES `pay_channel` WRITE;
/*!40000 ALTER TABLE `pay_channel` DISABLE KEYS */;
INSERT INTO `pay_channel` VALUES (199,'WxSm','微信扫码支付','','','','','','','',0.0400,0.0900,0.0000,1534648705,'',1,1,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(200,'WxGzh','微信H5','','','wxf33668d58442ff6e','','','','',0.0000,0.0000,0.0000,1502378687,'',1,2,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(201,'Aliscan','支付宝扫码','','','','','','','',0.0000,0.0000,0.0000,1503857975,'',1,3,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(202,'Aliscan','支付宝H5','','','','','','','',0.0000,0.0000,0.0000,1535081131,'',1,4,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(203,'QQSCAN','QQ扫码','','','','','','','',0.0050,0.0000,0.0000,1503280494,'',1,8,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(205,'QpayAliSm','贝尔支付','','','','','https://bell.eysj.net/pay','','',0.0000,0.0000,0.0000,1534738900,'',1,4,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000),(206,'QpayAliSm','贝尔支付扫码-我自己添加的','','','','','https://bell.eysj.net/pay','','',0.0000,0.0000,0.0000,1534738460,'',1,3,0,0,0.00,0.00,0,0.00,0.00,0,1,0.0000,0.0000,0.0000);
/*!40000 ALTER TABLE `pay_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_channel_account`
--

DROP TABLE IF EXISTS `pay_channel_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_channel_account` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商通道账号ID',
  `channel_id` smallint(6) unsigned NOT NULL COMMENT '通道id',
  `mch_id` varchar(100) DEFAULT NULL COMMENT '商户号',
  `signkey` varchar(500) DEFAULT NULL COMMENT '签文密钥',
  `appid` varchar(100) DEFAULT NULL COMMENT '应用APPID',
  `appsecret` varchar(2500) DEFAULT NULL COMMENT '安全密钥',
  `defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '下家费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶手续费',
  `rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '银行费率',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更改时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `title` varchar(100) DEFAULT NULL COMMENT '账户标题',
  `weight` tinyint(2) DEFAULT NULL COMMENT '轮询权重',
  `custom_rate` tinyint(1) DEFAULT NULL COMMENT '是否自定义费率',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始交易时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一笔交易时间',
  `paying_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单日可交易金额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔交易最大金额',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔交易最小金额',
  `offline_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '上线状态-1上线,0下线',
  `control_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '风控状态-0不风控,1风控中',
  `is_defined` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否自定义:1-是,0-否',
  `unit_frist_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间第一笔交易时间',
  `unit_paying_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单时间交易笔数',
  `unit_paying_amount` decimal(11,0) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间交易金额',
  `unit_interval` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间数值',
  `time_unit` char(1) NOT NULL DEFAULT 's' COMMENT '限制时间单位',
  `unit_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间次数',
  `unit_all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间金额',
  `t0defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶手续费',
  `t0rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0成本费率',
  `unlockdomain` varchar(255) NOT NULL COMMENT '防封域名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='供应商账号列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_channel_account`
--

LOCK TABLES `pay_channel_account` WRITE;
/*!40000 ALTER TABLE `pay_channel_account` DISABLE KEYS */;
INSERT INTO `pay_channel_account` VALUES (6,206,'1068733','e5a219c50793308eaaeeb2e8332b4c26','','',0.0000,0.0000,0.0000,1534673611,1,'1068733-扫码',1,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,''),(2,202,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','','MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCWq3BEdrJvaKQZ1/BTg7tJvf7yyU27LSvoNQ+0zqHsIf8hH6HbOrwqiu/UXU1WZL/c4wRXQaUwr7RT9b5H0LFcfaL08z4KHs3tA/E4XiEoQP5kIuAK2Q8mb3RjDOOzUjRlnjYyjta72/bOKzWAb5TsLhoM842J+VWy4AdLX8HbzajNM78G12Sn+qUAKsfT2dt5XRTgQBUYngZSycYR+l0F1Fy66UgqiRXvlOBNI2iYNa58OH6UEDVSvfDeLgaCTLf9IVq2EhRFJ4IpdVOlkrolkazKFBHG20rjvIS9iAiqiPf/U6FT8xjunxXOHz91seGGmyT7ULApY1Y9UiIxwsqDAgMBAAECggEAPzMWWoF3g2ffPb/oXP+qtdnucSSjaFogSrzHI85w+T2haOF94RmYCDhTNT8Vy6FjIWJQVdGBWxS4jWdNM46Edwl0K09EvLYDJuI6cqx5OAtbKeG/HI3D3xltNocXlAZtWBqvHTHxPMedlQlm3cLwMsl7v+cBfdiKbAewx5sZE/thgukmtiLjTQKTKFHeqyNmo20wGtl3pIk/+7X6s1W7CMghfcOmF2IeJnjDdS6bu+iIQtPeBhRdj9KIsmPTb3X7aj9ugjZvySNUakU3d+AFLiV3y2M9e1d1lWsdlkRCdJaysjmNpD9TEj2LobF5ekpkKPPocOD5Pcl04aMedl35QQKBgQDH/whVwQ3iRW+zZrnBBNncrNOWYv6hH+XqrjqEqsu9uv+i/dOtvfK0nNtxXo9yDjqAVXcMtszKha3ksw7vL/ODVo6ApXd2Nu8LS4W4cK3dw75a8oLX0L5vY0eZzW21GpRaEs7KbHqK2s4GttJGYuBwjS+0IGNDRQVvmR7zd7ZTEwKBgQDA3F/OhkU9eTqmZvCPowHXXLuskStzzcyI40nt+DqwEZEm03E9RWrNV6bFk2O8CH99iXK1jEKCBkvY8PNqziwuVa11t4fX7V/Xda1JBe02sWdjfZSbqZe3tw7+G9XtyaUYUYnQRorVGTGJk2g12VL5Qlq4paWbPhOjFBlBcxoo0QJ/Y/8gK8BbMMeHEixKtDe4tp2zLX5R0j4gtzZmC+9Z74OQTe6b6EMRFz1We1jMYDq9BW22GKVNv/UW/UKKNQ3Es+aTWb9h+7l7zCn2skGkrT0x8EdRJJc6oHcDVeNg9yxTALZmrs+Odd7xJGpEuOy3S49MSsPm3buk/CeTUiiJAQKBgQCTBu4bGg2rIcJunUeDmTeMIWwJ0NoZfKkTKoNv4a+MDrhjqwpHNaaISOwg7443CRt4btJ+SSFi0r378yT/JZJU+Ig2l+X93T8VmOa0JsqCyZgSJuimCxJYwjuxyTK8Bt/PvEmd+Elaz8wOH8xwUO+KiuVyowWvZhG+X1IprUAiIQKBgEKdjN3mHYYbStP0zr7pj2+ySNtkqS8dfMubeDwmdMeKC0/JQTRJleGvoR7mrapYGTdCZ5ljeBC+HsZ7X2e29xxjG/oZIizchofFpDZVgtZ71Xk1+pLGt+XEA01SARH4xMAugmOsEAyVj6Bgzi1x4NLSln+6GddXmF9+cCzC+Gvl',0.0000,0.0000,0.0000,1534647107,1,'大鸟',9,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,''),(3,199,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2','',0.0000,0.0000,0.0000,1534653997,1,'会生活',1,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,''),(4,201,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','','MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCWq3BEdrJvaKQZ1/BTg7tJvf7yyU27LSvoNQ+0zqHsIf8hH6HbOrwqiu/UXU1WZL/c4wRXQaUwr7RT9b5H0LFcfaL08z4KHs3tA/E4XiEoQP5kIuAK2Q8mb3RjDOOzUjRlnjYyjta72/bOKzWAb5TsLhoM842J+VWy4AdLX8HbzajNM78G12Sn+qUAKsfT2dt5XRTgQBUYngZSycYR+l0F1Fy66UgqiRXvlOBNI2iYNa58OH6UEDVSvfDeLgaCTLf9IVq2EhRFJ4IpdVOlkrolkazKFBHG20rjvIS9iAiqiPf/U6FT8xjunxXOHz91seGGmyT7ULApY1Y9UiIxwsqDAgMBAAECggEAPzMWWoF3g2ffPb/oXP+qtdnucSSjaFogSrzHI85w+T2haOF94RmYCDhTNT8Vy6FjIWJQVdGBWxS4jWdNM46Edwl0K09EvLYDJuI6cqx5OAtbKeG/HI3D3xltNocXlAZtWBqvHTHxPMedlQlm3cLwMsl7v+cBfdiKbAewx5sZE/thgukmtiLjTQKTKFHeqyNmo20wGtl3pIk/+7X6s1W7CMghfcOmF2IeJnjDdS6bu+iIQtPeBhRdj9KIsmPTb3X7aj9ugjZvySNUakU3d+AFLiV3y2M9e1d1lWsdlkRCdJaysjmNpD9TEj2LobF5ekpkKPPocOD5Pcl04aMedl35QQKBgQDH/whVwQ3iRW+zZrnBBNncrNOWYv6hH+XqrjqEqsu9uv+i/dOtvfK0nNtxXo9yDjqAVXcMtszKha3ksw7vL/ODVo6ApXd2Nu8LS4W4cK3dw75a8oLX0L5vY0eZzW21GpRaEs7KbHqK2s4GttJGYuBwjS+0IGNDRQVvmR7zd7ZTEwKBgQDA3F/OhkU9eTqmZvCPowHXXLuskStzzcyI40nt+DqwEZEm03E9RWrNV6bFk2O8CH99iXK1jEKCBkvY8PNqziwuVa11t4fX7V/Xda1JBe02sWdjfZSbqZe3tw7+G9XtyaUYUYnQRorVGTGJk2g12VL5Qlq4paWbPhOjFBlBcxoo0QJ/Y/8gK8BbMMeHEixKtDe4tp2zLX5R0j4gtzZmC+9Z74OQTe6b6EMRFz1We1jMYDq9BW22GKVNv/UW/UKKNQ3Es+aTWb9h+7l7zCn2skGkrT0x8EdRJJc6oHcDVeNg9yxTALZmrs+Odd7xJGpEuOy3S49MSsPm3buk/CeTUiiJAQKBgQCTBu4bGg2rIcJunUeDmTeMIWwJ0NoZfKkTKoNv4a+MDrhjqwpHNaaISOwg7443CRt4btJ+SSFi0r378yT/JZJU+Ig2l+X93T8VmOa0JsqCyZgSJuimCxJYwjuxyTK8Bt/PvEmd+Elaz8wOH8xwUO+KiuVyowWvZhG+X1IprUAiIQKBgEKdjN3mHYYbStP0zr7pj2+ySNtkqS8dfMubeDwmdMeKC0/JQTRJleGvoR7mrapYGTdCZ5ljeBC+HsZ7X2e29xxjG/oZIizchofFpDZVgtZ71Xk1+pLGt+XEA01SARH4xMAugmOsEAyVj6Bgzi1x4NLSln+6GddXmF9+cCzC+Gvl',0.0000,0.0000,0.0000,1534655268,1,'大鸟扫码',1,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,''),(5,205,'1068733','e5a219c50793308eaaeeb2e8332b4c26','','',0.0000,0.0000,0.0000,1534672137,1,'1068733',1,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,''),(7,201,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','','MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC44twRrNEmFHQMO5z36IEjaC7Yu4KVFbzC8SyQQ5W3CMwXUGl+/Wg1HPTA/RUQkuuzrcHmq/S7+UZhMTpk499vzMgWapee2gWqRQ92E+25va3r8OPhGmwewGG7UUwBD9QPEm7xSAAoKg4xuMcgeefNFmgMB/qiYnX7DwgqN+SKstpOQKDziKF27MirStF7XYe5ZhxgghKwWIXUTLxkWs9ptr+PpQu1nxd4C4Fc/d8dfxW/uw3ZpA72i9zM86dsloHikGT2siR0rd5YUzZrla9HRxDnuQx+XmiKFyHzGqh5e63WgiFYOXMzJKyvcmfJ3ZIjyCVyG/HP0rMPJV8WjfmRAgMBAAECggEBAKXXSJPKMqk3u4iliH2PXxcFgtACEnXsU6+BafnVxduy1m8rQBYa9HiACsN5wIVnZGl9uOpS4GokhY70+244QNomFGyXHH3vDxnWbLH72ke77uAu6hmm+8jxxDikCcsCCbOjU0S20v00DBtppaRp9RUvvhDcr2MtcqrKpwZHsIb/tDeob2v0Iy7u2pAbpT3ec0/VOF3hvET+Iuq2BJzrddbG8sX+2ffdcNog1n5fWZyuCqVZkPTRyA/prMt024AKHpJ7g/rgjmETplrNv34GygQg+P8rYUz75SEbtC2U5/bfi84JH2t7x47gh9whZ5gm4YgpjrrUm28xKn/IerpEJeECgYEA6UCSuR65mvcz5fHmaoMtC6r+gJa2Wsvf4Z1B4iMBCY04LoNUt7rmoFjYNF4o9MGGsI/sv33SbT0eYfMg5kxgk40XYwQT2sX+oV6MXb0ktaIOWcHwRYb7w6bFFw9I90dmMA87fstTKKzgc4xJX0CtrevQ2tm74CdwAY5E2HVmHC0CgYEAyurEwThaJZrTgRX7isAeXRM8eCBk+tBDaLdh4aMLottHxJz/olhH/KrZzHRb8JYiXGAVAA7d4dqn39eK+YrcYG0rxygRB9/iep61jEYA+Ff7G5peZ8TxbZYtInGUcJkKsELF/Qx7C7nIe7pM6MGzia2gme3K85Wj0yTxhBm6HXUCgYA75V4H9XDZ71K/YG+3uDmP/nfeE1V+WU4DRHuPk0eH6WCc6RKPH4prcIUMZYWE3FE2865queeYL5KmumUfXkuKeDeiMIDcs+0gCQRoadKMZbHjsJ5/bBsocaG4uy8UeJwwCSlQ9OtEzafRZBvPPu+acqyuFi1dcSMc8yiQoQz4fQKBgQCkEZsxF91b1on5L8sJbzmdzDXyc07ytX4rp0sPZAO+lEq9IKxZmcPq+kHMXLESIHJ7+nxAZcTmHyPpi6AlETALD3p8N1s94LqApt7oIpoaMxkoQnLeuJD1KJ4p4WhCepv31KW9a1/6JSeDUylocWY3hhn7HBgjR/UEfjSBuUORGQKBgGMWT48vB/1MOZxYGyt6KCMMJTK3414L1Tpig5YvD9qXmkudbEfL4BfHkRMSLukiZ1NfptSHFsTDXOph9ycEllRaO9CGW4spn6FbG5Q6IKCVR3Sw+7ixRxWGUR17+22ORcWJ0YqwL6Grm78QxuaOQ26GGSxtSM075R4B5xviK2ro',0.0000,0.0000,0.0000,1535001512,1,'个人扫码',1,0,0,0,0,0.00,0.00,0.00,0.00,0,0,0,0,0,0,0,'s',0,0.00,0.0000,0.0000,0.0000,'');
/*!40000 ALTER TABLE `pay_channel_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_complaints_deposit`
--

DROP TABLE IF EXISTS `pay_complaints_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_complaints_deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pay_orderid` varchar(100) NOT NULL DEFAULT '0' COMMENT '系统订单号',
  `out_trade_id` varchar(50) NOT NULL DEFAULT '' COMMENT '下游订单号',
  `freeze_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结保证金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_complaints_deposit`
--

LOCK TABLES `pay_complaints_deposit` WRITE;
/*!40000 ALTER TABLE `pay_complaints_deposit` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_complaints_deposit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_complaints_deposit_rule`
--

DROP TABLE IF EXISTS `pay_complaints_deposit_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_complaints_deposit_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_system` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否系统规则 1是 0否',
  `ratio` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '投诉保证金比例（百分比）',
  `freeze_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '冻结时间（秒）',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '规则是否开启 1开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投诉保证金规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_complaints_deposit_rule`
--

LOCK TABLES `pay_complaints_deposit_rule` WRITE;
/*!40000 ALTER TABLE `pay_complaints_deposit_rule` DISABLE KEYS */;
INSERT INTO `pay_complaints_deposit_rule` VALUES (1,180586943,0,10.00,3,1);
/*!40000 ALTER TABLE `pay_complaints_deposit_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_df_api_order`
--

DROP TABLE IF EXISTS `pay_df_api_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_df_api_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '平台订单号',
  `out_trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '商户订单号',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '金额',
  `bankname` varchar(100) NOT NULL DEFAULT '' COMMENT '银行名称',
  `subbranch` varchar(100) NOT NULL DEFAULT '' COMMENT '支行名称',
  `accountname` varchar(100) NOT NULL DEFAULT '' COMMENT '开户名',
  `cardnumber` varchar(100) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `province` varchar(100) NOT NULL DEFAULT '' COMMENT '所属省',
  `city` varchar(100) NOT NULL DEFAULT '' COMMENT '所属市',
  `ip` varchar(100) DEFAULT '' COMMENT 'IP地址',
  `check_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：待审核 1：已提交后台审核 2：审核驳回',
  `extends` text COMMENT '扩展字段',
  `df_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付ID',
  `notifyurl` varchar(255) DEFAULT '' COMMENT '异步通知地址',
  `reject_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '驳回原因',
  `check_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`),
  KEY `IND_UID` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_df_api_order`
--

LOCK TABLES `pay_df_api_order` WRITE;
/*!40000 ALTER TABLE `pay_df_api_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_df_api_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_email`
--

DROP TABLE IF EXISTS `pay_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `smtp_host` varchar(300) DEFAULT NULL,
  `smtp_port` varchar(300) DEFAULT NULL,
  `smtp_user` varchar(300) DEFAULT NULL,
  `smtp_pass` varchar(300) DEFAULT NULL,
  `smtp_email` varchar(300) DEFAULT NULL,
  `smtp_name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_email`
--

LOCK TABLES `pay_email` WRITE;
/*!40000 ALTER TABLE `pay_email` DISABLE KEYS */;
INSERT INTO `pay_email` VALUES (1,'smtpdm.aliyun.com','465','info@mail.tianniu.cc','Mailpush123','info@mail.tianniu.cc','聚合API支付系统');
/*!40000 ALTER TABLE `pay_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_invitecode`
--

DROP TABLE IF EXISTS `pay_invitecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_invitecode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invitecode` varchar(32) NOT NULL,
  `fmusernameid` int(11) unsigned NOT NULL DEFAULT '0',
  `syusernameid` int(11) NOT NULL DEFAULT '0',
  `regtype` tinyint(1) unsigned NOT NULL DEFAULT '4' COMMENT '用户组 4 普通用户 5 代理商',
  `fbdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `yxdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `sydatetime` int(11) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '邀请码状态 0 禁用 1 未使用 2 已使用',
  `is_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否管理员添加',
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitecode` (`invitecode`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_invitecode`
--

LOCK TABLES `pay_invitecode` WRITE;
/*!40000 ALTER TABLE `pay_invitecode` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_invitecode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_inviteconfig`
--

DROP TABLE IF EXISTS `pay_inviteconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_inviteconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invitezt` tinyint(1) unsigned DEFAULT '1',
  `invitetype2number` int(11) NOT NULL DEFAULT '20',
  `invitetype2ff` smallint(6) NOT NULL DEFAULT '1',
  `invitetype5number` int(11) NOT NULL DEFAULT '20',
  `invitetype5ff` smallint(6) NOT NULL DEFAULT '1',
  `invitetype6number` int(11) NOT NULL DEFAULT '20',
  `invitetype6ff` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_inviteconfig`
--

LOCK TABLES `pay_inviteconfig` WRITE;
/*!40000 ALTER TABLE `pay_inviteconfig` DISABLE KEYS */;
INSERT INTO `pay_inviteconfig` VALUES (1,1,0,0,10,1,0,0);
/*!40000 ALTER TABLE `pay_inviteconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_loginrecord`
--

DROP TABLE IF EXISTS `pay_loginrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_loginrecord` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `logindatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginip` varchar(100) NOT NULL,
  `loginaddress` varchar(300) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型：0：前台用户 1：后台用户',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_loginrecord`
--

LOCK TABLES `pay_loginrecord` WRITE;
/*!40000 ALTER TABLE `pay_loginrecord` DISABLE KEYS */;
INSERT INTO `pay_loginrecord` VALUES (1,1,'2018-08-18 05:02:04','27.46.137.166','广东省广州市',1),(2,1,'2018-08-18 05:36:56','27.46.137.166','广东省广州市',1),(3,1,'2018-08-18 06:09:33','27.46.137.166','广东省广州市',1),(4,1,'2018-08-19 02:26:04','183.250.231.236','福建省',1),(5,1,'2018-08-19 03:52:04','59.42.29.179','广东省广州市越秀区',1),(6,1,'2018-08-19 04:46:15','59.41.160.108','广东省广州市天河区',1),(7,1,'2018-08-19 04:46:16','59.42.29.179','广东省广州市越秀区',1),(8,1,'2018-08-19 09:28:17','117.136.11.205','福建省',1),(9,1,'2018-08-19 13:43:46','117.136.11.205','福建省',1),(10,1,'2018-08-20 02:38:18','218.66.175.241','福建省泉州市',1),(11,1,'2018-08-20 03:16:49','27.46.137.180','广东省广州市',1),(12,1,'2018-08-20 03:53:59','27.46.137.180','广东省广州市',1),(13,1,'2018-08-20 06:49:00','27.153.8.149','福建省泉州市',1),(14,1,'2018-08-20 07:13:48','110.81.63.219','福建省泉州市',1),(15,1,'2018-08-20 10:46:05','218.66.175.241','福建省泉州市',1),(16,1,'2018-08-20 11:27:19','27.46.137.180','广东省广州市',1),(17,1,'2018-08-21 03:21:20','218.66.175.241','福建省泉州市',1),(18,1,'2018-08-21 03:40:33','110.81.63.219','福建省泉州市',1),(19,1,'2018-08-21 04:30:41','218.66.175.241','福建省泉州市',1),(20,1,'2018-08-21 07:37:04','218.66.175.241','福建省泉州市',1),(21,1,'2018-08-21 08:21:11','61.242.114.124','广东省江门市',1),(22,1,'2018-08-21 08:41:38','61.242.114.124','广东省江门市',1),(23,1,'2018-08-22 08:50:39','110.88.213.253','福建省泉州市',1),(24,1,'2018-08-22 15:50:21','223.74.87.79','中国',1),(25,1,'2018-08-23 03:49:11','218.66.175.241','福建省泉州市',1),(26,1,'2018-08-23 06:40:01','218.66.175.241','福建省泉州市',1),(27,1,'2018-08-24 03:01:41','120.37.29.245','福建省泉州市',1),(28,1,'2018-08-24 10:05:13','117.136.11.195','福建省',1),(29,1,'2018-08-24 11:16:40','61.242.114.102','广东省江门市',1),(30,1,'2018-08-24 11:24:16','61.242.114.102','广东省江门市',1),(31,1,'2018-08-24 13:32:53','111.142.161.255','福建省漳州市',1),(32,1,'2018-08-24 14:36:35','125.78.42.101','福建省泉州市晋江市',1),(33,1,'2018-08-24 15:00:16','111.142.161.255','福建省漳州市',1);
/*!40000 ALTER TABLE `pay_loginrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_member`
--

DROP TABLE IF EXISTS `pay_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `groupid` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户组',
  `salt` varchar(10) NOT NULL COMMENT '密码随机字符',
  `parentid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '代理ID',
  `agent_cate` int(11) NOT NULL DEFAULT '0' COMMENT '代理级别',
  `balance` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '可用余额',
  `blockedbalance` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结可用余额',
  `email` varchar(100) NOT NULL,
  `activate` varchar(200) NOT NULL,
  `regdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `activatedatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `realname` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别',
  `birthday` int(11) NOT NULL DEFAULT '0',
  `sfznumber` varchar(20) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL COMMENT '联系电话',
  `qq` varchar(15) DEFAULT NULL COMMENT 'QQ',
  `address` varchar(200) DEFAULT NULL COMMENT '联系地址',
  `paypassword` varchar(32) DEFAULT NULL COMMENT '支付密码',
  `authorized` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 已认证 0 未认证 2 待审核',
  `apidomain` varchar(500) DEFAULT NULL COMMENT '授权访问域名',
  `apikey` varchar(32) NOT NULL COMMENT 'APIKEY',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1激活 0未激活',
  `receiver` varchar(255) DEFAULT NULL COMMENT '台卡显示的收款人信息',
  `unit_paying_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易次数',
  `unit_paying_amount` decimal(15,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间已交易金额',
  `unit_frist_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易的第一笔时间',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天最后一笔已交易时间',
  `paying_money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '当天已交易金额',
  `login_ip` varchar(255) NOT NULL DEFAULT ' ' COMMENT '登录IP',
  `last_error_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录错误时间',
  `login_error_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误登录次数',
  `google_auth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启谷歌身份验证登录',
  `df_api` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启代付API',
  `open_charge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启充值功能',
  `df_domain` text NOT NULL COMMENT '代付域名报备',
  `df_auto_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API自动审核',
  `google_secret_key` varchar(255) NOT NULL DEFAULT '' COMMENT '谷歌密钥',
  `df_ip` text NOT NULL COMMENT '代付域名报备IP',
  `session_random` varchar(50) NOT NULL DEFAULT '' COMMENT 'session随机字符串',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_member`
--

LOCK TABLES `pay_member` WRITE;
/*!40000 ALTER TABLE `pay_member` DISABLE KEYS */;
INSERT INTO `pay_member` VALUES (1,'测试用户_勿删','27cf1b59d8b3b19af30953d35c5b4611',5,'2527',1,4,12.1200,0.0000,'1','0dc62bc4b51994eddaf247961c767ed4',1534572807,2018,'测试用户',0,-28800,'1','1','','1','e10adc3949ba59abbe56e057f20f883e',1,NULL,'k2ss33036fj2f534ui8e06acyk458ync',1,'测试商户',15,12.12,0,1534838799,12.1200,'',0,0,0,0,1,'',0,'','','',0,0),(2,'lee','b69941a415e60d70f6a7bd8ca670abbe',5,'5190',1,5,3.5501,0.0000,'1277582213@qq.com','016abdbb35e34a7ca5e7b539a5c04bd9',1534645695,2018,'李',0,661881600,'350521199012233532','15260888888','1277582213','asdf','e10adc3949ba59abbe56e057f20f883e',1,NULL,'n2crom3yec718aybzdch3mtifwiuom14',1,NULL,0,0.00,0,0,0.0000,'',0,0,0,0,0,'',0,'','','',0,0),(3,'ccbc','6d4137e169f781b67e619fc25acede3f',4,'6209',2,0,136.1197,0.0000,'6','b386434d9f3b94abb848b7af4f48ec94',1534749718,0,'ccbc',1,-28800,'6','6','6','6','e10adc3949ba59abbe56e057f20f883e',1,NULL,'oh0fdqze1lw7hxth3beidin47oajl3iu',1,NULL,6,136.12,0,1535108221,136.1197,' ',0,0,0,0,1,'',0,'','','',0,0),(4,'lqc','5b3f14d770bb59621abcfa9c38effead',4,'6371',1,4,29.1500,0.0000,'asdf@163.com','fbe284deb57e923953125d8f1a441ad1',1534824430,2018,'liquancai',0,-28800,'350521198912233639','15260887441','44545','asd','e10adc3949ba59abbe56e057f20f883e',1,NULL,'rvqd6gka1d8v9ryim6d9bhuvpd99fz1l',1,NULL,12,29.15,0,1535121297,29.1500,'asdf',0,0,0,0,1,'',0,'','','',0,0),(5,'icbc','59ebce09d5ed5dd7f1d7a75b8916ecdd',7,'6172',1,7,0.0300,0.0000,'12','90bf7295ec3ca976b9a35d56021ded2a',1534837573,2018,'icbc',0,-28800,'1','1','1','1','e10adc3949ba59abbe56e057f20f883e',1,NULL,'w9pbb9wkvxhufts8uxeq16wsu1e3x6yl',1,NULL,0,0.00,0,0,0.0000,'',0,0,0,0,0,'',0,'','','',0,0),(6,'cmbc','e39648514a76ffb37adb718cd95c9b17',4,'4125',5,0,9.8998,0.0000,'343','3548b45ba46713e602b258950a29a735',1534837753,0,'cmbc',0,-28800,'1','2','2','1','e10adc3949ba59abbe56e057f20f883e',1,NULL,'f5bg537j3lew4bvw9oheczjjcg11nnjb',1,NULL,3,9.90,0,1535123266,9.8998,' ',0,0,0,0,0,'',0,'','','',0,0);
/*!40000 ALTER TABLE `pay_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_member_agent_cate`
--

DROP TABLE IF EXISTS `pay_member_agent_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_member_agent_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(50) DEFAULT NULL COMMENT '等级名',
  `desc` varchar(255) DEFAULT NULL COMMENT '等级描述',
  `ctime` int(11) DEFAULT '0' COMMENT '添加时间',
  `sort` int(11) DEFAULT '99' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_member_agent_cate`
--

LOCK TABLES `pay_member_agent_cate` WRITE;
/*!40000 ALTER TABLE `pay_member_agent_cate` DISABLE KEYS */;
INSERT INTO `pay_member_agent_cate` VALUES (4,'普通商户','',1522638122,99),(5,'普通代理商户','',1522638122,99),(6,'中级代理商户','',1522638122,99),(7,'高级代理商户','',1522638122,99);
/*!40000 ALTER TABLE `pay_member_agent_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_moneychange`
--

DROP TABLE IF EXISTS `pay_moneychange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_moneychange` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `ymoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '原金额',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '变动金额',
  `gmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '变动后金额',
  `datetime` datetime DEFAULT NULL COMMENT '修改时间',
  `transid` varchar(50) DEFAULT NULL COMMENT '交易流水号',
  `tongdao` smallint(6) unsigned DEFAULT '0' COMMENT '支付通道ID',
  `lx` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `tcuserid` int(11) DEFAULT NULL,
  `tcdengji` int(11) DEFAULT NULL,
  `orderid` varchar(50) DEFAULT NULL COMMENT '订单号',
  `contentstr` varchar(255) DEFAULT NULL COMMENT '备注',
  `t` int(4) NOT NULL DEFAULT '0' COMMENT '结算方式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_moneychange`
--

LOCK TABLES `pay_moneychange` WRITE;
/*!40000 ALTER TABLE `pay_moneychange` DISABLE KEYS */;
INSERT INTO `pay_moneychange` VALUES (1,1,0.0000,0.0100,0.0100,'2018-08-18 14:25:24','20180818142458979852',903,1,NULL,NULL,'E2018081814244737028','E2018081814244737028订单充值,结算方式：t+0',0),(2,1,0.0100,0.0100,0.0200,'2018-08-18 14:37:44','20180818143732995410',904,1,NULL,NULL,'C20180818143732979659','C20180818143732979659订单充值,结算方式：t+0',0),(3,1,0.0200,0.0100,0.0300,'2018-08-19 10:53:00','20180819105253534810',904,1,NULL,NULL,'C20180819105252911866','C20180819105252911866订单充值,结算方式：t+0',0),(4,1,0.0300,10.0000,10.0300,'2018-08-19 11:04:28','20180819110418501014',904,1,NULL,NULL,'C20180819110418687502','C20180819110418687502订单充值,结算方式：t+0',0),(5,1,10.0300,1.0000,11.0300,'2018-08-19 13:12:26','20180819131219515350',904,1,NULL,NULL,'C20180819131219500129','C20180819131219500129订单充值,结算方式：t+0',0),(6,1,11.0300,0.0100,11.0400,'2018-08-19 13:13:24','20180819131316995010',903,1,NULL,NULL,'C20180819131316429211','C20180819131316429211订单充值,结算方式：t+0',0),(7,1,11.0400,0.0100,11.0500,'2018-08-19 17:37:13','20180819173705491014',904,1,NULL,NULL,'C20180819173705567560','C20180819173705567560订单充值,结算方式：t+0',0),(8,1,11.0500,0.0100,11.0600,'2018-08-19 17:53:31','20180819175240569852',904,1,NULL,NULL,'C20180819175240683589','C20180819175240683589订单充值,结算方式：t+0',0),(9,1,11.0600,0.0100,11.0700,'2018-08-19 18:09:36','20180819180929575749',904,1,NULL,NULL,'C20180819180929187750','C20180819180929187750订单充值,结算方式：t+0',0),(10,1,11.0700,0.0100,11.0800,'2018-08-19 19:01:31','20180819190122505497',904,1,NULL,NULL,'C20180819190122337111','C20180819190122337111订单充值,结算方式：t+0',0),(11,1,11.0800,0.0100,11.0900,'2018-08-19 19:02:40','20180819190228529951',903,1,NULL,NULL,'C20180819190228104573','C20180819190228104573订单充值,结算方式：t+0',0),(12,1,11.0900,0.0100,11.1000,'2018-08-20 10:37:47','20180820103733100575',903,1,NULL,NULL,'E2018082010372880437','E2018082010372880437订单充值,结算方式：t+0',0),(13,1,11.1000,0.0100,11.1100,'2018-08-20 10:41:22','20180820104114975699',904,1,NULL,NULL,'C20180820104114565108','C20180820104114565108订单充值,结算方式：t+0',0),(14,3,0.0000,9.9100,9.9100,'2018-08-20 18:51:34','20180820185127102575',904,1,NULL,NULL,'C20180820185127700051','C20180820185127700051订单充值,结算方式：t+0',0),(15,2,0.0000,0.0900,0.0900,'2018-08-20 18:51:34','20180820185127102575',904,9,3,1,'tx20180820185134',NULL,0),(16,3,9.9100,9.7000,19.6100,'2018-08-20 19:17:40','20180820191730975649',904,1,NULL,NULL,'C20180820191730451385','C20180820191730451385订单充值,结算方式：t+0',0),(17,2,0.0900,0.1200,0.2100,'2018-08-20 19:17:40','20180820191730975649',904,9,3,1,'tx20180820191740',NULL,0),(18,3,19.6100,9.7000,29.3100,'2018-08-20 19:18:28','20180820191820991005',904,1,NULL,NULL,'C20180820191820506420','C20180820191820506420订单充值,结算方式：t+0',0),(19,2,0.2100,0.1200,0.3300,'2018-08-20 19:18:28','20180820191820991005',904,9,3,1,'tx20180820191828',NULL,0),(20,4,0.0000,0.0100,0.0100,'2018-08-21 12:09:19','20180821120909535049',903,1,NULL,NULL,'C20180821120909979003','C20180821120909979003订单充值,结算方式：t+0',0),(21,4,0.0100,0.0100,0.0200,'2018-08-21 12:09:50','20180821120944565748',904,1,NULL,NULL,'C20180821120944954585','C20180821120944954585订单充值,结算方式：t+0',0),(22,4,0.0200,0.0300,0.0500,'2018-08-21 12:32:46','20180821123223554998',903,1,NULL,NULL,'E20180821123217244277','E20180821123217244277订单充值,结算方式：t+0',0),(23,4,0.0500,0.0300,0.0800,'2018-08-21 12:33:52','20180821123343555754',903,1,NULL,NULL,'E20180821123338715893','E20180821123338715893订单充值,结算方式：t+0',0),(24,4,0.0800,0.0300,0.1100,'2018-08-21 15:39:22','20180821153749100100',903,1,NULL,NULL,'E20180821153744830261','E20180821153744830261订单充值,结算方式：t+0',0),(25,1,11.1100,1.0000,12.1100,'2018-08-21 15:53:18','20180821155244995053',903,1,NULL,NULL,'E2018082115521441574','E2018082115521441574订单充值,结算方式：t+0',0),(26,1,12.1100,0.0100,12.1200,'2018-08-21 16:06:39','20180821160531981009',903,1,NULL,NULL,'E2018082116050667127','E2018082116050667127订单充值,结算方式：t+0',0),(27,3,29.3100,0.0097,29.3197,'2018-08-21 16:53:07','20180821165259981005',904,1,NULL,NULL,'E2018082116524521591','E2018082116524521591订单充值,结算方式：t+0',0),(28,2,0.3300,0.0001,0.3301,'2018-08-21 16:53:07','20180821165259981005',904,9,3,1,'tx20180821165307',NULL,0),(29,4,0.1100,0.0100,0.1200,'2018-08-23 13:19:12','20180823131842505448',903,1,NULL,NULL,'C20180823131842494404','C20180823131842494404订单充值,结算方式：t+0',0),(30,4,0.1200,0.0100,0.1300,'2018-08-23 13:32:06','20180823132800485152',903,1,NULL,NULL,'C20180823132800961841','C20180823132800961841订单充值,结算方式：t+0',0),(31,4,0.1300,0.0100,0.1400,'2018-08-24 11:30:27','20180824113019985410',904,1,NULL,NULL,'C20180824113019788379','C20180824113019788379订单充值,结算方式：t+0',0),(32,3,29.3197,9.8000,39.1197,'2018-08-24 18:23:17','20180824182306975150',904,1,NULL,NULL,'C20180824182305852672','C20180824182305852672订单充值,结算方式：t+0',0),(33,2,0.3301,0.0200,0.3501,'2018-08-24 18:23:17','20180824182306975150',904,9,3,1,'tx20180824182317',NULL,0),(34,3,39.1197,97.0000,136.1197,'2018-08-24 18:57:01','20180824185639555097',904,1,NULL,NULL,'C20180824185638756070','C20180824185638756070订单充值,结算方式：t+0',0),(35,2,0.3501,3.2000,3.5501,'2018-08-24 18:57:01','20180824185639555097',904,9,3,1,'tx20180824185701',NULL,0),(36,4,0.1400,0.0100,0.1500,'2018-08-24 19:37:05','20180824193644999850',903,1,NULL,NULL,'C20180824193644129106','C20180824193644129106订单充值,结算方式：t+0',0),(37,4,0.1500,10.0000,10.1500,'2018-08-24 22:01:12','20180824220101100524',903,1,NULL,NULL,'C20180824220101214036','C20180824220101214036订单充值,结算方式：t+0',0),(38,4,10.1500,9.5000,19.6500,'2018-08-24 22:29:09','20180824222859985249',903,1,NULL,NULL,'C20180824222859894380','C20180824222859894380订单充值,结算方式：t+0',0),(39,4,19.6500,9.5000,29.1500,'2018-08-24 22:34:57','20180824223449579855',903,1,NULL,NULL,'C20180824223449456069','C20180824223449456069订单充值,结算方式：t+0',0),(40,6,0.0000,9.8800,9.8800,'2018-08-24 22:48:55','20180824224814101102',903,1,NULL,NULL,'20180824010','20180824010订单充值,结算方式：t+0',0),(41,5,0.0000,0.0300,0.0300,'2018-08-24 22:48:55','20180824224814101102',903,9,6,1,'tx20180824224855',NULL,0),(42,6,9.8800,0.0099,9.8899,'2018-08-24 22:57:00','20180824225646101101',903,1,NULL,NULL,'20180824011','20180824011订单充值,结算方式：t+0',0),(43,5,0.0300,0.0000,0.0300,'2018-08-24 22:57:00','20180824225646101101',903,9,6,1,'tx20180824225700',NULL,0),(44,6,9.8899,0.0099,9.8998,'2018-08-24 23:07:46','20180824230704565310',903,1,NULL,NULL,'20180824012','20180824012订单充值,结算方式：t+0',0),(45,5,0.0300,0.0000,0.0300,'2018-08-24 23:07:46','20180824230704565310',903,9,6,1,'tx20180824230746',NULL,0);
/*!40000 ALTER TABLE `pay_moneychange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_order`
--

DROP TABLE IF EXISTS `pay_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pay_memberid` varchar(100) NOT NULL COMMENT '商户编号',
  `pay_orderid` varchar(100) NOT NULL COMMENT '系统订单号',
  `pay_amount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_poundage` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_actualamount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_applydate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单创建日期',
  `pay_successdate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付成功时间',
  `pay_bankcode` varchar(100) DEFAULT NULL COMMENT '银行编码',
  `pay_notifyurl` varchar(500) NOT NULL COMMENT '商家异步通知地址',
  `pay_callbackurl` varchar(500) NOT NULL COMMENT '商家页面通知地址',
  `pay_bankname` varchar(300) DEFAULT NULL,
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态: 0 未支付 1 已支付未返回 2 已支付已返回',
  `pay_productname` varchar(300) DEFAULT NULL COMMENT '商品名称',
  `pay_tongdao` varchar(50) DEFAULT NULL,
  `pay_zh_tongdao` varchar(50) DEFAULT NULL,
  `pay_tjurl` varchar(1000) DEFAULT NULL,
  `out_trade_id` varchar(50) NOT NULL COMMENT '商户订单号',
  `num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '已补发次数',
  `memberid` varchar(100) DEFAULT NULL COMMENT '支付渠道商家号',
  `key` varchar(500) DEFAULT NULL COMMENT '支付渠道密钥',
  `account` varchar(100) DEFAULT NULL COMMENT '渠道账号',
  `isdel` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '伪删除订单 1 删除 0 未删',
  `ddlx` int(11) DEFAULT '0',
  `pay_ytongdao` varchar(50) DEFAULT NULL,
  `pay_yzh_tongdao` varchar(50) DEFAULT NULL,
  `xx` smallint(6) unsigned NOT NULL DEFAULT '0',
  `attach` text CHARACTER SET utf8mb4 COMMENT '商家附加字段,原样返回',
  `pay_channel_account` varchar(255) DEFAULT NULL COMMENT '通道账户',
  `cost` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `account_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子账号id',
  `channel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '渠道id',
  `t` tinyint(2) NOT NULL DEFAULT '1' COMMENT '结算周期（计算费率）',
  `last_reissue_time` int(11) NOT NULL DEFAULT '11' COMMENT '最后补发时间',
  `lock_status` tinyint(1) DEFAULT '0' COMMENT '是否冻结订单，1冻结，2解冻',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_ORD` (`pay_orderid`),
  KEY `account_id` (`account_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_order`
--

LOCK TABLES `pay_order` WRITE;
/*!40000 ALTER TABLE `pay_order` DISABLE KEYS */;
INSERT INTO `pay_order` VALUES (1,'10001','20180818142023559853',0.0100,0.0000,0.0100,1534573223,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018081814202261573',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,1,204,0,11,0),(2,'10001','20180818142058975149',0.0100,0.0000,0.0100,1534573258,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018081814202261573',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,1,204,0,11,0),(3,'10001','20180818142119102101',0.0100,0.0000,0.0100,1534573279,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018081814210929818',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,1,204,0,11,0),(4,'10001','20180818142458979852',0.0100,0.0000,0.0100,1534573498,1534573524,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',2,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018081814244737028',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,1,204,0,11,0),(5,'10001','20180818143637535110',10.0000,0.0000,10.0000,1534574197,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180818143637980520',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,1,204,0,11,0),(6,'10001','20180818143732995410',0.0100,0.0000,0.0100,1534574252,1534574264,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180818143732979659',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,1,204,0,11,0),(7,'10001','20180818143839102539',1800.0000,0.0000,1800.0000,1534574319,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180818143839329897',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,1,204,0,11,0),(8,'10001','20180819104626505051',0.0100,0.0000,0.0100,1534646786,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819104625552525',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,1,204,0,11,0),(9,'10001','20180819105253534810',0.0100,0.0000,0.0100,1534647173,1534647180,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819105252911866',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(10,'10001','20180819110418501014',10.0000,0.0000,10.0000,1534647858,1534647868,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819110418687502',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(11,'10001','20180819115257571004',0.0100,0.0000,0.0100,1534650777,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081911525475683',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(12,'10001','20180819115350101549',0.0100,0.0000,0.0100,1534650830,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081911534798651',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(13,'10001','20180819115822101975',0.0100,0.0000,0.0100,1534651102,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081911535390667',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(14,'10001','20180819123259985099',0.0100,0.0000,0.0100,1534653179,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081911535390667',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(15,'10001','20180819123305495757',0.0100,0.0000,0.0100,1534653185,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912330392888',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(16,'10001','20180819123311555210',0.0100,0.0000,0.0100,1534653191,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912330980942',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(17,'10001','20180819124653100559',0.0100,0.0000,0.0100,1534654013,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912465090589',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(18,'10001','20180819124933100575',0.0100,0.0000,0.0100,1534654173,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912330980942',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(19,'10001','20180819125311551001',0.0100,0.0000,0.0100,1534654391,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912530812293',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(20,'10001','20180819125412525654',0.0100,0.0000,0.0100,1534654452,0,'902','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','微信扫码支付',0,'收款','WxSm','微信扫码支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819125412720701',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,1,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(21,'10001','20180819125601495255',0.0100,0.0000,0.0100,1534654561,0,'902','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','微信扫码支付',0,'收款','WxSm','微信扫码支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819125601623395',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,1,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(22,'10001','20180819125747981009',0.0100,0.0000,0.0100,1534654667,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018081912574064081',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(23,'10001','20180819130910545452',0.0100,0.0000,0.0100,1534655350,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018081913085019296',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,1,204,0,11,0),(24,'10001','20180819131052995610',0.0100,0.0000,0.0100,1534655452,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819131052516422',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(25,'10001','20180819131219515350',1.0000,0.0000,1.0000,1534655539,1534655546,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819131219500129',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(26,'10001','20180819131316995010',0.0100,0.0000,0.0100,1534655596,1534655604,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819131316429211',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(27,'10001','20180819173001575751',0.0100,0.0000,0.0100,1534671001,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819173001547548',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(28,'10001','20180819173705491014',0.0100,0.0000,0.0100,1534671425,1534671432,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819173705567560',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(29,'10001','20180819174057575154',0.0100,0.0000,0.0100,1534671657,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819174056482248',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,1,204,0,11,0),(30,'10001','20180819174522504950',0.0100,0.0000,0.0100,1534671922,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819174521385568',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','大鸟扫码',0.0000,0.0000,5,205,0,11,0),(31,'10001','20180819174533100575',0.0100,0.0000,0.0100,1534671933,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819174533533788',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','大鸟扫码',0.0000,0.0000,5,205,0,11,0),(32,'10001','20180819175240569852',0.0100,0.0000,0.0100,1534672360,1534672411,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819175240683589',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(33,'10001','20180819175710545351',0.0100,0.0000,0.0100,1534672630,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819175710901906',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(34,'10001','20180819175823102505',0.0100,0.0000,0.0100,1534672703,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819175822374103',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(35,'10001','20180819180243511005',0.0100,0.0000,0.0100,1534672963,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/demo/index1.php','E2018081918023882064',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(36,'10001','20180819180427985351',0.0100,0.0000,0.0100,1534673067,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819180427624860',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(37,'10001','20180819180509539952',0.0100,0.0000,0.0100,1534673109,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819180509354531',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(38,'10001','20180819180823554997',0.0100,0.0000,0.0100,1534673303,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/demo/index1.php','E2018081918081837853',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(39,'10001','20180819180844995410',0.0100,0.0000,0.0100,1534673324,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付-扫码','http://pay.jusogo.com/demo/index1.php','E2018081918083368490',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(40,'10001','20180819180913575599',0.0100,0.0000,0.0100,1534673353,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','Aliwap','支付宝H5','http://pay.jusogo.com/demo/index1.php','E2018081918083368490',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'1234|456','大鸟',0.0000,0.0000,2,202,0,11,0),(41,'10001','20180819180929575749',0.0100,0.0000,0.0100,1534673369,1534673376,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819180929187750',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(42,'10001','20180819182348525756',0.0100,0.0000,0.0100,1534674228,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819182348639554',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(43,'10001','20180819183919555110',0.0100,0.0000,0.0100,1534675159,0,'902','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','微信扫码支付',0,'收款','WxSm','微信扫码支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819183918632266',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,1,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(44,'10001','20180819190122505497',0.0100,0.0000,0.0100,1534676482,1534676491,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819190122337111',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(45,'10001','20180819190153495354',0.0100,0.0000,0.0100,1534676513,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819190153751552',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(46,'10001','20180819190206101994',0.0100,0.0000,0.0100,1534676526,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819190206324270',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(47,'10001','20180819190228529951',0.0100,0.0000,0.0100,1534676548,1534676560,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180819190228104573',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(48,'10001','20180820103733100575',0.0100,0.0000,0.0100,1534732653,1534732667,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',2,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082010372880437',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(49,'10001','20180820103910101574',0.0100,0.0000,0.0100,1534732750,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018082010390058491',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(50,'10001','20180820103914505710',0.0100,0.0000,0.0100,1534732754,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082010390058491',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(51,'10001','20180820103952565656',0.0100,0.0000,0.0100,1534732792,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820103952347204',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(52,'10001','20180820104114975699',0.0100,0.0000,0.0100,1534732874,1534732882,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820104114565108',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(53,'10001','20180820111732995450',0.0100,0.0000,0.0100,1534735052,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011172951321',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(54,'10001','20180820112019515610',0.0100,0.0000,0.0100,1534735219,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011200947876',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(55,'10001','20180820115325534910',0.0100,0.0000,0.0100,1534737205,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011532243995',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(56,'10001','20180820115510101565',0.0100,0.0000,0.0100,1534737310,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011550658186',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(57,'10001','20180820115925100539',0.0100,0.0000,0.0100,1534737565,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011550658186',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(58,'10001','20180820115937571005',0.0100,0.0000,0.0100,1534737577,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018082011593421707',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(59,'10001','20180820120041575410',0.0100,0.0000,0.0100,1534737641,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082011594252327',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(60,'10001','20180820120152485598',0.0100,0.0000,0.0100,1534737712,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012014919490',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(61,'10001','20180820120205100534',0.0100,0.0000,0.0100,1534737725,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012020367525',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(62,'10001','20180820120244525557',0.0100,0.0000,0.0100,1534737764,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012024275110',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(63,'10001','20180820120309100989',0.0100,0.0000,0.0100,1534737789,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012030890818',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(64,'10001','20180820120335559999',0.0100,0.0000,0.0100,1534737815,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012033441019',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(65,'10001','20180820120415102985',0.0100,0.0000,0.0100,1534737855,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012041454816',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(66,'10001','20180820120749531019',0.0100,0.0000,0.0100,1534738069,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012074786890',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(67,'10001','20180820120825575310',0.0100,0.0000,0.0100,1534738105,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012082334424',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(68,'10001','20180820121428529848',0.0100,0.0000,0.0100,1534738468,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082012142758615',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(69,'10001','20180820121952565451',0.0100,0.0000,0.0100,1534738792,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820121952862887',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(70,'10001','20180820122046101495',0.0100,0.0000,0.0100,1534738846,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820122045538781',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(71,'10001','20180820122148995310',0.0100,0.0000,0.0100,1534738908,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820122148639915',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(72,'10001','20180820122418505249',0.0100,0.0000,0.0100,1534739058,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820122418700981',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(73,'10001','20180820122441571005',0.0100,0.0000,0.0100,1534739081,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820122441628983',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(74,'10003','20180820172357100521',1.0000,0.0090,0.9910,1534757037,0,'903','http://www.xxxxxx.com/notify.aspx','http://www.xxxxxx.com/payresult.aspx','支付宝扫码支付',0,'','QpayAliSm','贝尔支付扫码-我自己添加的','http://localhost:11900/call.aspx','201808200001',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(75,'10003','20180820172602975050',1.0000,0.0090,0.9910,1534757162,0,'903','http://www.xxxxxx.com/notify.aspx','http://www.xxxxxx.com/payresult.aspx','支付宝扫码支付',0,'','QpayAliSm','贝尔支付扫码-我自己添加的','http://localhost:11900/call.aspx','201808200002',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(76,'10003','20180820172820529948',1.0000,0.0090,0.9910,1534757300,0,'904','http://www.xxxxxx.com/notify.aspx','http://www.xxxxxx.com/payresult.aspx','支付宝手机',0,'','QpayAliSm','贝尔支付','http://localhost:11900/call.aspx','201808200003',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(77,'10003','20180820172920489810',1.0000,0.0090,0.9910,1534757360,0,'902','http://www.xxxxxx.com/notify.aspx','http://www.xxxxxx.com/payresult.aspx','微信扫码支付',0,'','WxSm','微信扫码支付','http://localhost:11900/call.aspx','201808200004',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(78,'10001','20180820184437531025',0.0100,0.0000,0.0100,1534761877,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082018443279634',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(79,'10001','20180820184513579851',0.0100,0.0000,0.0100,1534761913,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','QpayAliSm','贝尔支付','http://pay.jusogo.com/demo/index1.php','E2018082018443279634',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733',0.0000,0.0000,5,205,0,11,0),(80,'10003','20180820185127102575',10.0000,0.0900,9.9100,1534762287,1534762294,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820185127700051',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(81,'10001','20180820191514505210',0.0400,0.0000,0.0400,1534763714,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820191514403648',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(82,'10001','20180820191559102534',10.0000,0.0000,10.0000,1534763759,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820191559717852',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(83,'10001','20180820191643985157',1.0000,0.0000,1.0000,1534763803,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820191643300930',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(84,'10003','20180820191730975649',10.0000,0.3000,9.7000,1534763850,1534763860,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820191730451385',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(85,'10003','20180820191820991005',10.0000,0.3000,9.7000,1534763900,1534763908,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180820191820506420',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(86,'10001','20180820192850505253',0.0100,0.0000,0.0100,1534764530,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://pay.jusogo.com/demo/index1.php','E2018082019284838107',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(87,'10003','20180821115341535150',1.0000,0.0300,0.9700,1534823621,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210008',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(88,'10003','20180821115703102101',1.0000,0.0300,0.9700,1534823823,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://localhost:15797/call.aspx','201808210008',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(89,'10003','20180821115742544910',1.0000,0.0300,0.9700,1534823862,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210009',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(90,'10003','20180821115932524953',1.0000,0.0300,0.9700,1534823972,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210011',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(91,'10003','20180821120056569948',1.0000,0.0300,0.9700,1534824056,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','QpayAliSm','贝尔支付扫码-我自己添加的','http://localhost:15797/call.aspx','201808210012',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(92,'10003','20180821120202975699',1.0000,0.0300,0.9700,1534824122,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210013',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(93,'10004','20180821120826975155',0.0100,0.0000,0.0100,1534824506,0,'902','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','微信扫码支付',0,'收款','WxSm','微信扫码支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180821120826551879',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,1,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(94,'10004','20180821120909535049',0.0100,0.0000,0.0100,1534824549,1534824559,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180821120909979003',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(95,'10004','20180821120944565748',0.0100,0.0000,0.0100,1534824584,1534824590,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180821120944954585',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(96,'10004','20180821121152564850',0.0100,0.0000,0.0100,1534824712,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','QpayAliSm','贝尔支付','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180821121151800103',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,1,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(97,'10004','20180821123159102989',0.0300,0.0000,0.0300,1534825919,0,'903','http://localhost/server.php','http://localhost/page.php','支付宝扫码支付',0,'VIP基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://localhost/index.php','E20180821123154204754',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(98,'10004','20180821123205535050',0.0300,0.0000,0.0300,1534825925,0,'903','http://localhost/server.php','http://localhost/page.php','支付宝扫码支付',0,'VIP基础服务','QpayAliSm','贝尔支付扫码-我自己添加的','http://localhost/index.php','E20180821123158788623',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'1234|456','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(99,'10004','20180821123223554998',0.0300,0.0000,0.0300,1534825943,1534825966,'903','http://localhost/server.php','http://localhost/page.php','支付宝扫码支付',1,'VIP基础服务','Aliscan','支付宝扫码','http://localhost/index.php','E20180821123217244277',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(100,'10004','20180821123343555754',0.0300,0.0000,0.0300,1534826023,1534826032,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',1,'VIP基础服务','Aliscan','支付宝扫码','http://localhost/index.php','E20180821123338715893',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(101,'10004','20180821123509100535',0.0300,0.0000,0.0300,1534826109,0,'903','http://localhost/server.php','http://localhost/page.php','支付宝扫码支付',0,'VIP基础服务','Aliscan','支付宝扫码','http://localhost/index.php','E20180821123503818231',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(102,'10003','20180821153336485648',1.0000,0.0300,0.9700,1534836816,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210014',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(103,'10003','20180821153341539948',1.0000,0.0300,0.9700,1534836821,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210014',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(104,'10003','20180821153405100531',1.0000,0.0300,0.9700,1534836845,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210015',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(105,'10003','20180821153553574949',1.0000,0.0300,0.9700,1534836953,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://localhost:15797/call.aspx','201808210016',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(106,'10003','20180821153623551014',1.0000,0.0300,0.9700,1534836983,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://localhost:15797/call.aspx','201808210017',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(107,'10004','20180821153749100100',0.0300,0.0000,0.0300,1534837069,1534837162,'903','http://localhost/server.php','http://localhost/page.php','支付宝扫码支付',1,'VIP基础服务','Aliscan','支付宝扫码','http://localhost/index.php','E20180821153744830261',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(108,'10003','20180821154021539848',1.0000,0.0300,0.9700,1534837221,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210018',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(109,'10003','20180821154321571015',1.0000,0.0300,0.9700,1534837401,0,'902','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','微信扫码支付',0,'','WxSm','微信扫码支付','http://localhost:15797/call.aspx','201808210019',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'','会生活',0.0000,0.0000,3,199,0,11,0),(110,'10004','20180821154513574998',0.0300,0.0000,0.0300,1534837513,0,'902','http://localhost/server.php','http://localhost/page.php','微信扫码支付',0,'VIP基础服务','WxSm','微信扫码支付','http://localhost/index.php','E20180821154508975692',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(111,'10004','20180821154519102495',0.0300,0.0000,0.0300,1534837519,0,'902','http://localhost/server.php','http://localhost/page.php','微信扫码支付',0,'VIP基础服务','WxSm','微信扫码支付','http://localhost/index.php','E20180821154513628936',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(112,'10001','20180821155217494956',0.0100,0.0000,0.0100,1534837937,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018082115521441574',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(113,'10001','20180821155234505255',0.0100,0.0000,0.0100,1534837954,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082115521441574',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(114,'10001','20180821155244995053',1.0000,0.0000,1.0000,1534837964,1534837998,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',2,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082115521441574',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(115,'10003','20180821155324529710',1.0000,0.0300,0.9700,1534838004,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210021',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(116,'10001','20180821160459985797',0.0100,0.0000,0.0100,1534838699,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082116044714919',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(117,'10001','20180821160508525210',0.0100,0.0000,0.0100,1534838708,0,'902','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','微信扫码支付',0,'Vip基础服务','WxSm','微信扫码支付','http://pay.jusogo.com/demo/index1.php','E2018082116050667127',0,'1487365822','778eb83eaf939c536de3a353b888213a','wx0a958262f63384f2',0,0,'WxSm','微信扫码支付-官方',0,'1234|456','会生活',0.0000,0.0000,3,199,0,11,0),(118,'10001','20180821160531981009',0.0100,0.0000,0.0100,1534838731,1534838799,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',2,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082116050667127',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(119,'10003','20180821162344489856',1.0000,0.0300,0.9700,1534839824,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210022',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(120,'10001','20180821162716521001',0.0100,0.0000,0.0100,1534840036,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082116271425791',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(121,'10001','20180821163612995499',0.0100,0.0000,0.0100,1534840572,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/index1.php','E2018082116360883839',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(122,'10006','20180821164442971005',10.0000,0.0600,9.9400,1534841082,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','QpayAliSm','贝尔支付扫码-我自己添加的','http://sytadmin.xeaxea.com/call.aspx','201808210023',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733-扫码',0.0000,0.0000,6,206,0,11,0),(123,'10006','20180821164738974850',10.0000,0.0600,9.9400,1534841258,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','QpayAliSm','贝尔支付','http://sytadmin.xeaxea.com/call.aspx','c20180821001',0,'1068733','e5a219c50793308eaaeeb2e8332b4c26','',0,0,'QpayAliSm','Qpay（支付宝扫码）',0,'','1068733',0.0000,0.0000,5,205,0,11,0),(124,'10006','20180821164906501009',10.0000,0.0600,9.9400,1534841346,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','c,20180821002',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(125,'10003','20180821165111102515',0.0100,0.0003,0.0097,1534841471,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/10003/index1.php','E2018082116510489927',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(126,'10006','20180821165222545098',10.0000,0.0600,9.9400,1534841542,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','c20180821005',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(127,'10003','20180821165259981005',0.0100,0.0003,0.0097,1534841579,1534841587,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',1,'Vip基础服务','Aliwap','支付宝H5','http://pay.jusogo.com/demo/10003/index1.php','E2018082116524521591',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'1234|456','大鸟',0.0000,0.0000,2,202,0,11,0),(128,'10003','20180821165508995253',0.0100,0.0003,0.0097,1534841708,0,'903','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝扫码支付',0,'Vip基础服务','Aliscan','支付宝扫码','http://pay.jusogo.com/demo/10003/index1.php','E2018082116535023313',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'1234|456','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(129,'10003','20180821171225575610',10.0000,0.3000,9.7000,1534842745,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210020',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(130,'10003','20180821171506979748',10.0000,0.3000,9.7000,1534842906,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','','201808210020',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(131,'10003','20180821171808489948',10.0000,0.3000,9.7000,1534843088,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','','201808210020',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(132,'10003','20180821171852999910',10.0000,0.3000,9.7000,1534843132,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','','201808210020',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(133,'10003','20180821172207102565',10.0000,0.3000,9.7000,1534843327,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210025',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(134,'10003','20180821172300525150',10.0000,0.3000,9.7000,1534843380,0,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','','201808210020',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(135,'10003','20180821173724525048',10.0000,0.3000,9.7000,1534844244,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','c20180820029',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(136,'10003','20180821174016489899',0.0100,0.0003,0.0097,1534844416,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','Aliwap','支付宝H5','http://pay.jusogo.com/demo/10003/index1.php','E2018082117401259536',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'1234|456','大鸟',0.0000,0.0000,2,202,0,11,0),(137,'10003','20180821174116995149',10.0000,0.3000,9.7000,1534844476,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'','Aliwap','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','20180821030',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(138,'10003','20180821174502101494',10.0000,0.3000,9.7000,1534844702,0,'903','http://www.xxxxx.com/notify.aspx','http://www.xxxxx.com/payresult.aspx','支付宝扫码支付',0,'商品名称','Aliscan','支付宝扫码','http://localhost:15797/call.aspx','201808210026',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(139,'10003','20180821174721575348',10.0000,0.3000,9.7000,1534844841,0,'904','http://www.xxxxx.com/notify.aspx','http://www.xxxxx.com/payresult.aspx','支付宝手机',0,'商品名称','Aliwap','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','2018021033',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(140,'10004','20180823131110101971',0.0100,0.0000,0.0100,1535001070,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823131110360808',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(141,'10004','20180823131842505448',0.0100,0.0000,0.0100,1535001522,1535001552,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823131842494404',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(142,'10004','20180823132156529910',0.0100,0.0000,0.0100,1535001716,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823132156973019',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','个人H5',0.0000,0.0000,8,202,0,11,0),(143,'10004','20180823132218979748',0.0100,0.0000,0.0100,1535001738,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliwap','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823132218481334',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliwap','支付宝官方（WAP）',0,'','个人H5',0.0000,0.0000,8,202,0,11,0),(144,'10004','20180823132800485152',0.0100,0.0000,0.0100,1535002080,1535002326,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823132800961841',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(145,'10001','20180823143914504950',0.0100,0.0000,0.0100,1535006354,0,'904','http://pay.jusogo.com/demo/server.php','http://pay.jusogo.com/demo/page.php','支付宝手机',0,'Vip基础服务','Aliwap','支付宝H5','http://pay.jusogo.com/demo/index1.php','E2018082314390919881',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliwap','支付宝官方（WAP）',0,'1234|456','大鸟',0.0000,0.0000,2,202,0,11,0),(146,'10004','20180823144445100100',0.0100,0.0000,0.0100,1535006685,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliscan','支付宝H5扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180823144445778386',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人手机扫码',0.0000,0.0000,9,207,0,11,0),(147,'10004','20180824112819519754',0.0100,0.0000,0.0100,1535081299,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824112819338423',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(148,'10004','20180824113019985410',0.0100,0.0000,0.0100,1535081419,1535081427,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824113019788379',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(149,'10003','20180824113326545053',10.0000,0.3000,9.7000,1535081606,0,'903','http://www.xxxxx.com/notify.aspx','http://www.xxxxx.com/payresult.aspx','支付宝扫码支付',0,'','Aliscan','支付宝扫码','http://sytadmin.xeaxea.com/call.aspx','201808240003',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(150,'10003','20180824113338501005',10.0000,0.3000,9.7000,1535081618,0,'903','http://www.xxxxx.com/notify.aspx','http://www.xxxxx.com/payresult.aspx','支付宝扫码支付',0,'12','Aliscan','支付宝扫码','http://sytadmin.xeaxea.com/call.aspx','20180824001',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(151,'10004','20180824113837100564',0.0100,0.0000,0.0100,1535081917,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824113837591671',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(152,'10003','20180824182257495454',0.0100,0.0002,0.0098,1535106177,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824182257959920',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(153,'10003','20180824182306975150',10.0000,0.2000,9.8000,1535106186,1535106197,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824182305852672',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(154,'10003','20180824185639555097',100.0000,3.0000,97.0000,1535108199,1535108221,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',2,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824185638756070',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(155,'10004','20180824193644999850',0.0100,0.0000,0.0100,1535110604,1535110625,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824193644129106',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(156,'10004','20180824193746979754',0.0100,0.0000,0.0100,1535110666,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824193746919617',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(157,'10003','20180824193914501019',0.0100,0.0003,0.0097,1535110754,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824193914479985',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(158,'10003','20180824194304565450',100.0000,3.0000,97.0000,1535110984,0,'904','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝手机',0,'收款','Aliscan','支付宝H5','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824194304813355',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(159,'10004','20180824220024565449',10.0000,0.0000,10.0000,1535119224,0,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',0,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824220024597365',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(160,'10004','20180824220101100524',10.0000,0.0000,10.0000,1535119261,1535119272,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824220101214036',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(161,'10004','20180824222859985249',10.0000,0.5000,9.5000,1535120939,1535120949,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824222859894380',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(162,'10004','20180824223449579855',10.0000,0.5000,9.5000,1535121289,1535121297,'903','http://pay.jusogo.com/Pay_Charges_notify.html','http://pay.jusogo.com/Pay_Charges_callback.html','支付宝扫码支付',2,'收款','Aliscan','支付宝扫码','http://pay.jusogo.com/Pay_Charges_checkout.html','C20180824223449456069',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,1,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(163,'10006','20180824224814101102',10.0000,0.1200,9.8800,1535122094,1535122135,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',2,'笔记本','Aliscan','支付宝扫码','http://sytadmin.xeaxea.com/call.aspx','20180824010',0,'2018082361117241','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl/vAS2IJ0dIX3oM2ZYnSrE3KdXyU9lVSy3N5SIhxW7dPTzmuh/0vZDdnBPtNA8+F/pLJORPZ0ukcphX/x2VAY9BOZk12FMGKJPVdJ6u496bz8xCYuWRPsYYtsRgoBzXtl3rhzB8HWECfteXAVZt+zbATcWZqSox7w9Yj2nDNHREc76Zikjwx9Dj/TEI6vDr3fnrhX439aayAJAuVX/stksi+bdqQcDK3NjaxajqulLxiz2srLQzwdvQArXb1BiFbs3exjPSfJCXso+iVk9/vQHR2+dYqcVFyBJG31goO4M3Tr73Lq4aoG8tLAQrYW6WkcI1l5i16hgn/KB6pK9yfIwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','个人扫码',0.0000,0.0000,7,201,0,11,0),(164,'10006','20180824225646101101',0.0100,0.0001,0.0099,1535122606,1535122620,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',2,'22','Aliscan','支付宝扫码','http://sytadmin.xeaxea.com/call.aspx','20180824011',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(165,'10006','20180824230704565310',0.0100,0.0001,0.0099,1535123224,1535123266,'903','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝扫码支付',2,'cc','Aliscan','支付宝扫码','http://sytadmin.xeaxea.com/call.aspx','20180824012',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟扫码',0.0000,0.0000,4,201,0,11,0),(166,'10006','20180824231133535353',0.0100,0.0001,0.0099,1535123493,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'bb','Aliscan','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','20180824016',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0),(167,'10006','20180824231259985710',0.0100,0.0001,0.0099,1535123579,0,'904','http://sytadmin.xeaxea.com/notify.aspx','http://sytadmin.xeaxea.com/payresult.aspx','支付宝手机',0,'tt','Aliscan','支付宝H5','http://sytadmin.xeaxea.com/call.aspx','20180824017',0,'2018080460935126','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAt5Gu9wGw7M+LzFRrKZZBaklcNY0LStXaLLzkjvVxc8AtMiA6xxTz7plMJ+ls1BV94G0yvTKOfF0ltgZZKMt0+kT4Wm6ffiIk2xe4hIpQJ/UHsIqbBL7JMk6MluyrCp0pSZnnqgQMwtg+HclOdSFIgmw5dF0ZfjznwAA50h0P8XGifwU1IhfTJcuSQoMw4iNItSzLF5VDRaMwFEpMfvIW5Yn6t0XIYnaeCJYxUE7LJSfB8ekfsYJsCGTDyT5UUFaW9ELuC940zqA5SD3vE4Ko7/RiZ6ODbVhpxzhpCTFnZPY+pYRO3cdtMucEFGTJrwse0OGEdddCeV1csZufkjqakwIDAQAB','',0,0,'Aliscan','支付宝官方扫码',0,'','大鸟',0.0000,0.0000,2,202,0,11,0);
/*!40000 ALTER TABLE `pay_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_pay_channel_extend_fields`
--

DROP TABLE IF EXISTS `pay_pay_channel_extend_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_pay_channel_extend_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付渠道ID',
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '代付渠道代码',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '扩展字段名',
  `alias` varchar(50) NOT NULL DEFAULT '' COMMENT '扩展字段别名',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `etime` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_pay_channel_extend_fields`
--

LOCK TABLES `pay_pay_channel_extend_fields` WRITE;
/*!40000 ALTER TABLE `pay_pay_channel_extend_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_pay_channel_extend_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_pay_for_another`
--

DROP TABLE IF EXISTS `pay_pay_for_another`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_pay_for_another` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(64) NOT NULL COMMENT '代付代码',
  `title` varchar(64) NOT NULL COMMENT '代付名称',
  `mch_id` varchar(255) NOT NULL DEFAULT ' ' COMMENT '商户号',
  `appid` varchar(100) NOT NULL DEFAULT ' ' COMMENT '应用APPID',
  `appsecret` varchar(100) NOT NULL DEFAULT ' ' COMMENT '应用密钥',
  `signkey` varchar(500) NOT NULL DEFAULT ' ' COMMENT '加密的秘钥',
  `public_key` varchar(1000) NOT NULL DEFAULT '  ' COMMENT '加密的公钥',
  `private_key` varchar(1000) NOT NULL DEFAULT '  ' COMMENT '加密的私钥',
  `exec_gateway` varchar(255) NOT NULL DEFAULT ' ' COMMENT '请求代付的地址',
  `query_gateway` varchar(255) NOT NULL DEFAULT ' ' COMMENT '查询代付的地址',
  `serverreturn` varchar(255) NOT NULL DEFAULT ' ' COMMENT '服务器通知网址',
  `unlockdomain` varchar(255) NOT NULL DEFAULT ' ' COMMENT '防封域名',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更改时间',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认：1是，0否',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `rate_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '费率类型：按单笔收费0，按比例收费：1',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `updatetime` (`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代付通道表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_pay_for_another`
--

LOCK TABLES `pay_pay_for_another` WRITE;
/*!40000 ALTER TABLE `pay_pay_for_another` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_pay_for_another` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_paylog`
--

DROP TABLE IF EXISTS `pay_paylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_paylog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(50) NOT NULL,
  `result_code` varchar(50) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `fromuser` varchar(50) NOT NULL,
  `time_end` int(11) unsigned NOT NULL DEFAULT '0',
  `total_fee` smallint(6) unsigned NOT NULL DEFAULT '0',
  `payname` varchar(50) NOT NULL,
  `bank_type` varchar(20) DEFAULT NULL,
  `trade_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_TRD` (`transaction_id`),
  UNIQUE KEY `IND_ORD` (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_paylog`
--

LOCK TABLES `pay_paylog` WRITE;
/*!40000 ALTER TABLE `pay_paylog` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_paylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_product`
--

DROP TABLE IF EXISTS `pay_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '通道名称',
  `code` varchar(50) NOT NULL COMMENT '通道代码',
  `polling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '接口模式 0 单独 1 轮询',
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型 1 微信扫码 2 微信H5 3 支付宝扫码 4 支付宝H5 5 网银跳转 6网银直连  7 百度钱包  8 QQ钱包 9 京东钱包',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `isdisplay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户端显示 1 显示 0 不显示',
  `channel` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '通道ID',
  `weight` text COMMENT '平台默认通道权重',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=911 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_product`
--

LOCK TABLES `pay_product` WRITE;
/*!40000 ALTER TABLE `pay_product` DISABLE KEYS */;
INSERT INTO `pay_product` VALUES (901,'微信公众号','WXJSAPI',0,2,1,1,0,''),(902,'微信扫码支付','WXSCAN',1,1,1,1,199,'199:9'),(903,'支付宝扫码支付','ALISCAN',0,3,1,1,201,''),(904,'支付宝手机','ALIWAP',0,4,1,1,202,''),(905,'QQ手机支付','QQWAP',1,2,0,0,0,'200:7'),(907,'网银支付','DBANK',0,5,0,0,205,''),(908,'QQ扫码支付','QSCAN',0,8,0,0,203,''),(909,'百度钱包','BAIDU',0,7,0,0,0,''),(910,'京东支付','JDPAY',0,9,0,0,0,'');
/*!40000 ALTER TABLE `pay_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_product_user`
--

DROP TABLE IF EXISTS `pay_product_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_product_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT ' ',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '商户通道ID',
  `polling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '接口模式：0 单独 1 轮询',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '通道状态 0 关闭 1 启用',
  `channel` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '指定单独通道ID',
  `weight` varchar(255) DEFAULT NULL COMMENT '通道权重',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_product_user`
--

LOCK TABLES `pay_product_user` WRITE;
/*!40000 ALTER TABLE `pay_product_user` DISABLE KEYS */;
INSERT INTO `pay_product_user` VALUES (1,1,901,0,1,0,'200:'),(2,1,902,0,1,199,''),(3,1,903,0,1,201,'201:|206:'),(4,1,904,1,1,205,'202:|205:'),(5,1,905,0,0,0,''),(6,1,907,0,0,0,''),(9,3,903,0,1,201,'201:|206:'),(8,3,902,0,1,199,''),(7,3,901,0,1,200,''),(10,3,904,0,1,202,'202:|205:'),(11,4,901,0,0,0,''),(12,4,902,0,1,199,''),(13,4,903,0,1,201,''),(14,4,904,0,1,202,''),(15,6,901,0,0,0,''),(16,6,902,0,0,0,''),(17,6,903,0,1,201,''),(18,6,904,0,1,202,''),(19,2,901,0,1,0,''),(20,2,902,0,1,0,''),(21,2,903,0,1,0,''),(22,2,904,0,1,0,'');
/*!40000 ALTER TABLE `pay_product_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_reconciliation`
--

DROP TABLE IF EXISTS `pay_reconciliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_reconciliation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT '0' COMMENT '用户ID',
  `order_total_count` int(11) DEFAULT '0' COMMENT '总订单数',
  `order_success_count` int(11) DEFAULT '0' COMMENT '成功订单数',
  `order_fail_count` int(11) DEFAULT '0' COMMENT '未支付订单数',
  `order_total_amount` decimal(11,4) DEFAULT '0.0000' COMMENT '订单总额',
  `order_success_amount` decimal(11,4) DEFAULT '0.0000' COMMENT '订单实付总额',
  `date` date DEFAULT NULL COMMENT '日期',
  `ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_reconciliation`
--

LOCK TABLES `pay_reconciliation` WRITE;
/*!40000 ALTER TABLE `pay_reconciliation` DISABLE KEYS */;
INSERT INTO `pay_reconciliation` VALUES (1,3,7,3,4,34.0000,29.3100,'2018-08-20',1534764604),(2,4,9,5,4,40.0500,29.0200,'2018-08-24',1535081234),(3,4,6,2,4,0.0600,0.0200,'2018-08-23',1535081234),(4,4,0,0,0,NULL,NULL,'2018-08-22',1535081234),(5,4,12,5,7,0.2800,0.1100,'2018-08-21',1535081234);
/*!40000 ALTER TABLE `pay_reconciliation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_redo_order`
--

DROP TABLE IF EXISTS `pay_redo_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_redo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `money` decimal(15,4) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：增加 2：减少',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '冲正备注',
  `date` datetime NOT NULL COMMENT '冲正周期',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_redo_order`
--

LOCK TABLES `pay_redo_order` WRITE;
/*!40000 ALTER TABLE `pay_redo_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_redo_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_route`
--

DROP TABLE IF EXISTS `pay_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `urlstr` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_route`
--

LOCK TABLES `pay_route` WRITE;
/*!40000 ALTER TABLE `pay_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_sms`
--

DROP TABLE IF EXISTS `pay_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_key` varchar(255) DEFAULT NULL COMMENT 'App Key',
  `app_secret` varchar(255) DEFAULT NULL COMMENT 'App Secret',
  `sign_name` varchar(255) DEFAULT NULL COMMENT '默认签名',
  `is_open` int(11) DEFAULT '0' COMMENT '是否开启，0关闭，1开启',
  `admin_mobile` varchar(255) DEFAULT NULL COMMENT '管理员接收手机',
  `is_receive` int(11) DEFAULT '0' COMMENT '是否开启，0关闭，1开启',
  `sms_channel` varchar(20) NOT NULL DEFAULT 'aliyun' COMMENT '短信通道',
  `smsbao_user` varchar(50) NOT NULL DEFAULT '' COMMENT '短信宝账号',
  `smsbao_pass` varchar(50) NOT NULL DEFAULT '' COMMENT '短信宝密码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_sms`
--

LOCK TABLES `pay_sms` WRITE;
/*!40000 ALTER TABLE `pay_sms` DISABLE KEYS */;
INSERT INTO `pay_sms` VALUES (3,'LTAI5URiDETOsWqP','o2YYyNbAzQgT1atlaL9sn7sQ1oQzZA1','asdf',1,NULL,0,'aliyun','1','1');
/*!40000 ALTER TABLE `pay_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_sms_template`
--

DROP TABLE IF EXISTS `pay_sms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_sms_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `template_code` varchar(255) DEFAULT NULL COMMENT '模板代码',
  `call_index` varchar(255) DEFAULT NULL COMMENT '调用字符串',
  `template_content` text COMMENT '模板内容',
  `ctime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_sms_template`
--

LOCK TABLES `pay_sms_template` WRITE;
/*!40000 ALTER TABLE `pay_sms_template` DISABLE KEYS */;
INSERT INTO `pay_sms_template` VALUES (3,'修改支付密码','SMS_110620028','editPayPassword','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1512202260),(4,'修改登录密码','SMS_110620028','editPassword','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1512190115),(5,'异地登录','SMS_110620028','loginWarning','您的账号于${time}登录异常，异常登录地址：${address}，如非本人操纵，请及时修改账号密码。',1512202260),(6,'申请结算','SMS_110620028','clearing','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1512202260),(7,'委托结算','SMS_110620028','entrusted','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1512202260),(8,'绑定手机','SMS_110620028','bindMobile','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1514534290),(9,'更新手机','SMS_110620028','editMobile','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1514535688),(10,'更新银行卡 ','SMS_110620028','addBankcardSend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1514535688),(11,'修改个人资料','SMS_110620028','saveProfile','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',NULL),(12,'绑定管理员手机号码','SMS_110620028','adminbindMobile','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(13,'修改管理员手机号码','SMS_110620028','admineditMobile','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(14,'批量删除订单','SMS_110620028','delOrderSend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(15,'解绑谷歌身份验证器','SMS_110620028','unbindGoogle','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(16,'设置订单为已支付','SMS_110620028','setOrderPaidSend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(17,'清理数据','SMS_110620028','clearDataSend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(18,'增加/减少余额（冲正）','SMS_110620028','adjustUserMoneySend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(19,'提交代付','SMS_110620028','submitDfSend','您的验证码为：${code} ，你正在进行${opration}操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(20,'测试短信','SMS_110620028','test','您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734),(21,'系统配置','SMS_110620028','sysconfig','您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。',1527670734);
/*!40000 ALTER TABLE `pay_sms_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_systembank`
--

DROP TABLE IF EXISTS `pay_systembank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_systembank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bankcode` varchar(100) DEFAULT NULL,
  `bankname` varchar(300) DEFAULT NULL,
  `images` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='结算银行';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_systembank`
--

LOCK TABLES `pay_systembank` WRITE;
/*!40000 ALTER TABLE `pay_systembank` DISABLE KEYS */;
INSERT INTO `pay_systembank` VALUES (162,'BOB','北京银行','BOB.gif'),(164,'BEA','东亚银行','BEA.gif'),(165,'ICBC','中国工商银行','ICBC.gif'),(166,'CEB','中国光大银行','CEB.gif'),(167,'GDB','广发银行','GDB.gif'),(168,'HXB','华夏银行','HXB.gif'),(169,'CCB','中国建设银行','CCB.gif'),(170,'BCM','交通银行','BCM.gif'),(171,'CMSB','中国民生银行','CMSB.gif'),(172,'NJCB','南京银行','NJCB.gif'),(173,'NBCB','宁波银行','NBCB.gif'),(174,'ABC','中国农业银行','5414c87492ad8.gif'),(175,'PAB','平安银行','5414c0929a632.gif'),(176,'BOS','上海银行','BOS.gif'),(177,'SPDB','上海浦东发展银行','SPDB.gif'),(178,'SDB','深圳发展银行','SDB.gif'),(179,'CIB','兴业银行','CIB.gif'),(180,'PSBC','中国邮政储蓄银行','PSBC.gif'),(181,'CMBC','招商银行','CMBC.gif'),(182,'CZB','浙商银行','CZB.gif'),(183,'BOC','中国银行','BOC.gif'),(184,'CNCB','中信银行','CNCB.gif'),(193,'ALIPAY','支付宝','58b83a5820644.jpg'),(194,'WXZF','微信支付','58b83a757a298.jpg');
/*!40000 ALTER TABLE `pay_systembank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_template`
--

DROP TABLE IF EXISTS `pay_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT ' ' COMMENT '模板名称',
  `theme` varchar(255) NOT NULL DEFAULT ' ' COMMENT '模板代码',
  `is_default` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认模板:1是，0否',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `remarks` varchar(255) NOT NULL DEFAULT ' ' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_template`
--

LOCK TABLES `pay_template` WRITE;
/*!40000 ALTER TABLE `pay_template` DISABLE KEYS */;
INSERT INTO `pay_template` VALUES (1,' 默认模板','default',0,1524299660,1524299660,' 默认模板'),(2,'模板一','view1',0,1524299660,1524299660,'模板一'),(3,'模板二','view2',0,0,1524623473,'模板二'),(4,'模板三','view3',1,0,1524623494,'模板三');
/*!40000 ALTER TABLE `pay_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tikuanconfig`
--

DROP TABLE IF EXISTS `pay_tikuanconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tikuanconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `tkzxmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小提款金额',
  `tkzdmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大提款金额',
  `dayzdmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当日提款最大总金额',
  `dayzdnum` int(11) NOT NULL DEFAULT '0' COMMENT '当日提款最大次数',
  `t1zt` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'T+1 ：1开启 0 关闭',
  `t0zt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'T+0 ：1开启 0 关闭',
  `gmt0` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买T0',
  `tkzt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '提款设置 1 开启 0 关闭',
  `tktype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '提款手续费类型 1 每笔 0 比例 ',
  `systemxz` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 系统规则 1 用户规则',
  `sxfrate` varchar(20) DEFAULT NULL COMMENT '单笔提款比例',
  `sxffixed` varchar(20) DEFAULT NULL COMMENT '单笔提款手续费',
  `issystem` tinyint(1) unsigned DEFAULT '0' COMMENT '平台规则 1 是 0 否',
  `allowstart` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '提款允许开始时间',
  `allowend` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '提款允许结束时间',
  `daycardzdmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单人单卡单日最高提现额',
  `auto_df_switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '自动代付开关',
  `auto_df_maxmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔代付最大金额限制',
  `auto_df_stime` varchar(20) NOT NULL DEFAULT '' COMMENT '自动代付开始时间',
  `auto_df_etime` varchar(20) NOT NULL DEFAULT '' COMMENT '自动代付结束时间',
  `auto_df_max_count` int(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付笔数限制',
  `auto_df_max_sum` int(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付最大总金额限制',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_UID` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tikuanconfig`
--

LOCK TABLES `pay_tikuanconfig` WRITE;
/*!40000 ALTER TABLE `pay_tikuanconfig` DISABLE KEYS */;
INSERT INTO `pay_tikuanconfig` VALUES (28,1,100.00,10000.00,5000.00,12,0,0,200.00,1,1,0,'2','5',1,0,0,2000.00,0,10000.00,'00:00','23:59',0,0,0),(29,2,10.00,1000.00,0.00,0,0,0,0.00,1,1,1,'','2',0,0,0,0.00,0,0.00,'','',0,0,0),(30,3,0.00,0.00,0.00,0,0,0,0.00,0,0,0,NULL,NULL,0,0,0,0.00,0,0.00,'','',0,0,0);
/*!40000 ALTER TABLE `pay_tikuanconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tikuanholiday`
--

DROP TABLE IF EXISTS `pay_tikuanholiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tikuanholiday` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排除日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='排除节假日';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tikuanholiday`
--

LOCK TABLES `pay_tikuanholiday` WRITE;
/*!40000 ALTER TABLE `pay_tikuanholiday` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_tikuanholiday` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tikuanmoney`
--

DROP TABLE IF EXISTS `pay_tikuanmoney`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tikuanmoney` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '结算用户ID',
  `websiteid` int(11) NOT NULL DEFAULT '0',
  `payapiid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '结算通道ID',
  `t` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '结算方式: 1 T+1 ,0 T+0',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `datetype` varchar(2) NOT NULL,
  `createtime` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=691 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tikuanmoney`
--

LOCK TABLES `pay_tikuanmoney` WRITE;
/*!40000 ALTER TABLE `pay_tikuanmoney` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_tikuanmoney` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tikuantime`
--

DROP TABLE IF EXISTS `pay_tikuantime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tikuantime` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `baiks` tinyint(2) unsigned DEFAULT '0' COMMENT '白天提款开始时间',
  `baijs` tinyint(2) unsigned DEFAULT '0' COMMENT '白天提款结束时间',
  `wanks` tinyint(2) unsigned DEFAULT '0' COMMENT '晚间提款开始时间',
  `wanjs` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='提款时间';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tikuantime`
--

LOCK TABLES `pay_tikuantime` WRITE;
/*!40000 ALTER TABLE `pay_tikuantime` DISABLE KEYS */;
INSERT INTO `pay_tikuantime` VALUES (1,24,17,18,24);
/*!40000 ALTER TABLE `pay_tikuantime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_tklist`
--

DROP TABLE IF EXISTS `pay_tklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_tklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `bankname` varchar(300) NOT NULL,
  `bankzhiname` varchar(300) NOT NULL,
  `banknumber` varchar(300) NOT NULL,
  `bankfullname` varchar(300) NOT NULL,
  `sheng` varchar(300) NOT NULL,
  `shi` varchar(300) NOT NULL,
  `sqdatetime` datetime DEFAULT NULL,
  `cldatetime` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tkmoney` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sxfmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `t` int(4) NOT NULL DEFAULT '1',
  `payapiid` int(11) NOT NULL DEFAULT '0',
  `memo` text COMMENT '备注',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_tklist`
--

LOCK TABLES `pay_tklist` WRITE;
/*!40000 ALTER TABLE `pay_tklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_tklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_updatelog`
--

DROP TABLE IF EXISTS `pay_updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_updatelog` (
  `version` varchar(20) NOT NULL,
  `lastupdate` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_updatelog`
--

LOCK TABLES `pay_updatelog` WRITE;
/*!40000 ALTER TABLE `pay_updatelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_updatelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_user_channel_account`
--

DROP TABLE IF EXISTS `pay_user_channel_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_user_channel_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `account_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '子账号id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启指定账号',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户指定指账号';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_user_channel_account`
--

LOCK TABLES `pay_user_channel_account` WRITE;
/*!40000 ALTER TABLE `pay_user_channel_account` DISABLE KEYS */;
INSERT INTO `pay_user_channel_account` VALUES (1,1,'',0),(2,4,'3,4,2',1);
/*!40000 ALTER TABLE `pay_user_channel_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_user_code`
--

DROP TABLE IF EXISTS `pay_user_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_user_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT '0' COMMENT '0找回密码',
  `code` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `ctime` int(11) DEFAULT NULL,
  `uptime` int(11) DEFAULT NULL COMMENT '更新时间',
  `endtime` int(11) DEFAULT NULL COMMENT '有效时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_user_code`
--

LOCK TABLES `pay_user_code` WRITE;
/*!40000 ALTER TABLE `pay_user_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_user_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_user_riskcontrol_config`
--

DROP TABLE IF EXISTS `pay_user_riskcontrol_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_user_riskcontrol_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小金额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大金额',
  `unit_all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间内交易总金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易总金额',
  `start_time` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '一天交易开始时间',
  `end_time` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '一天交易结束时间',
  `unit_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间内交易的总笔数',
  `is_system` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否平台规则',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态:1开通，0关闭',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `time_unit` char(1) NOT NULL DEFAULT 'i' COMMENT '限制的时间单位',
  `unit_interval` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间值',
  `domain` varchar(255) NOT NULL DEFAULT ' ' COMMENT '防封域名',
  `systemxz` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 系统规则 1 用户规则',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='交易配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_user_riskcontrol_config`
--

LOCK TABLES `pay_user_riskcontrol_config` WRITE;
/*!40000 ALTER TABLE `pay_user_riskcontrol_config` DISABLE KEYS */;
INSERT INTO `pay_user_riskcontrol_config` VALUES (1,0,1.00,20000.00,0.00,0.00,0,0,0,1,0,1534763369,0,'i',0,'',0);
/*!40000 ALTER TABLE `pay_user_riskcontrol_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_userrate`
--

DROP TABLE IF EXISTS `pay_userrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_userrate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `payapiid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '通道ID',
  `feilv` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '运营费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶费率',
  `t0feilv` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶费率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COMMENT='商户通道费率';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_userrate`
--

LOCK TABLES `pay_userrate` WRITE;
/*!40000 ALTER TABLE `pay_userrate` DISABLE KEYS */;
INSERT INTO `pay_userrate` VALUES (44,3,901,0.0350,0.0600,0.0350,0.0600),(45,3,902,0.0350,0.0600,0.0350,0.0600),(46,3,903,0.0350,0.0600,0.0350,0.0600),(47,3,904,0.0350,0.0600,0.0350,0.0600),(48,2,901,0.0180,0.0600,0.0180,0.0600),(49,2,902,0.0180,0.0600,0.0180,0.0600),(50,2,903,0.0180,0.0600,0.0180,0.0600),(51,2,904,0.0180,0.0600,0.0180,0.0600),(52,5,901,0.0000,0.0000,0.0090,0.0150),(53,5,902,0.0000,0.0000,0.0090,0.0150),(54,5,903,0.0000,0.0000,0.0090,0.0150),(55,5,904,0.0000,0.0000,0.0090,0.0150),(56,6,901,0.0000,0.0000,0.0120,0.0150),(57,6,902,0.0000,0.0000,0.0120,0.0150),(58,6,903,0.0000,0.0000,0.0120,0.0150),(59,6,904,0.0000,0.0000,0.0120,0.0150),(60,1,901,0.0180,0.0600,0.0180,0.0600),(61,1,902,0.0180,0.0600,0.0180,0.0600),(62,1,903,0.0180,0.0600,0.0180,0.0600),(63,1,904,0.0180,0.0600,0.0180,0.0600),(64,4,901,0.0500,0.0600,0.0500,0.0600),(65,4,902,0.0500,0.0600,0.0500,0.0600),(66,4,903,0.0500,0.0600,0.0500,0.0600),(67,4,904,0.0500,0.0600,0.0500,0.0600);
/*!40000 ALTER TABLE `pay_userrate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_version`
--

DROP TABLE IF EXISTS `pay_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL DEFAULT '0' COMMENT '版本',
  `author` varchar(255) NOT NULL DEFAULT ' ' COMMENT '作者',
  `save_time` varchar(255) NOT NULL DEFAULT '0000-00-00' COMMENT '修改时间,格式YYYY-mm-dd',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='数据库版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_version`
--

LOCK TABLES `pay_version` WRITE;
/*!40000 ALTER TABLE `pay_version` DISABLE KEYS */;
INSERT INTO `pay_version` VALUES (1,'5.5','陈嘉杰','2018-4-8'),(2,'5.6',' mapeijian','2018/4/17 17:45:33'),(3,'5.7',' mio','2018-4-17');
/*!40000 ALTER TABLE `pay_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_websiteconfig`
--

DROP TABLE IF EXISTS `pay_websiteconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_websiteconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `websitename` varchar(300) DEFAULT NULL COMMENT '网站名称',
  `domain` varchar(300) DEFAULT NULL COMMENT '网址',
  `email` varchar(100) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `qq` varchar(30) DEFAULT NULL,
  `directory` varchar(100) DEFAULT NULL COMMENT '后台目录名称',
  `icp` varchar(100) DEFAULT NULL,
  `tongji` varchar(1000) DEFAULT NULL COMMENT '统计',
  `login` varchar(100) DEFAULT NULL COMMENT '登录地址',
  `payingservice` tinyint(1) unsigned DEFAULT '0' COMMENT '商户代付 1 开启 0 关闭',
  `authorized` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商户认证 1 开启 0 关闭',
  `invitecode` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邀请码注册',
  `company` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `serverkey` varchar(50) DEFAULT NULL COMMENT '授权服务key',
  `withdraw` tinyint(1) DEFAULT '0' COMMENT '提现通知：0关闭，1开启',
  `login_warning_num` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT '前台可以错误登录次数',
  `login_ip` varchar(1000) NOT NULL DEFAULT ' ' COMMENT '登录IP',
  `is_repeat_order` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许重复订单:1是，0否',
  `google_auth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启谷歌身份验证登录',
  `df_api` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启代付API',
  `logo` varchar(255) NOT NULL DEFAULT ' ' COMMENT '公司logo',
  `random_mchno` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启随机商户号',
  `register_need_activate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户注册是否需激活',
  `admin_alone_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '管理员是否只允许同时一次登录',
  `max_auth_error_times` int(10) NOT NULL DEFAULT '5' COMMENT '验证错误最大次数',
  `auth_error_ban_time` int(10) NOT NULL DEFAULT '10' COMMENT '验证错误超限冻结时间（分钟）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_websiteconfig`
--

LOCK TABLES `pay_websiteconfig` WRITE;
/*!40000 ALTER TABLE `pay_websiteconfig` DISABLE KEYS */;
INSERT INTO `pay_websiteconfig` VALUES (1,'api支付系统','pay.jusogo.com','support@pay.com','4001234456','','manage','沪ICP备12031756号','','pay9',0,1,1,'','0d6de302cbc615de3b09463acea87662',0,3,' ',1,0,0,' ',0,1,0,5,10);
/*!40000 ALTER TABLE `pay_websiteconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_wttklist`
--

DROP TABLE IF EXISTS `pay_wttklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_wttklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `bankname` varchar(300) NOT NULL,
  `bankzhiname` varchar(300) NOT NULL,
  `banknumber` varchar(300) NOT NULL,
  `bankfullname` varchar(300) NOT NULL,
  `sheng` varchar(300) NOT NULL,
  `shi` varchar(300) NOT NULL,
  `sqdatetime` datetime DEFAULT NULL,
  `cldatetime` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tkmoney` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sxfmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '实际到账',
  `t` int(4) NOT NULL DEFAULT '1',
  `payapiid` int(11) NOT NULL DEFAULT '0',
  `memo` text COMMENT '备注',
  `additional` varchar(1000) NOT NULL DEFAULT ' ' COMMENT '额外的参数',
  `code` varchar(64) NOT NULL DEFAULT ' ' COMMENT '代码控制器名称',
  `df_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '代付通道id',
  `df_name` varchar(64) NOT NULL DEFAULT ' ' COMMENT '代付名称',
  `orderid` varchar(100) NOT NULL DEFAULT ' ' COMMENT '订单id',
  `cost` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '成本',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `rate_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '费率类型：按单笔收费0，按比例收费：1',
  `extends` text COMMENT '扩展数据',
  `out_trade_no` varchar(30) DEFAULT '' COMMENT '下游订单号',
  `df_api_id` int(11) DEFAULT '0' COMMENT '代付API申请ID',
  `auto_submit_try` int(10) NOT NULL DEFAULT '0' COMMENT '自动代付尝试提交次数',
  `is_auto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动提交',
  `last_submit_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后提交时间',
  `df_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付锁，防止重复提交',
  `auto_query_num` int(10) NOT NULL DEFAULT '0' COMMENT '自动查询次数',
  `channel_mch_id` varchar(50) NOT NULL DEFAULT '' COMMENT '通道商户号',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  `transaction_id` varchar(50) NOT NULL DEFAULT '' COMMENT '上游订单号',
  `billno` varchar(50) NOT NULL DEFAULT '' COMMENT '上游交易流水号',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `df_id` (`df_id`),
  KEY `orderid` (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_wttklist`
--

LOCK TABLES `pay_wttklist` WRITE;
/*!40000 ALTER TABLE `pay_wttklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_wttklist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-25  0:03:56
