<?php
	error_reporting( 0 );
	$totalAmount = 1;
	$outTradeNo = date("YmdHis");
	header("Content-type: text/html; charset=utf-8");
	require_once 'model/builder/AlipayTradePrecreateContentBuilder.php';
	require_once 'service/AlipayTradeService.php';
	$subject = "在线支付";
	$body = "在线支付";
	// 业务扩展参数，目前可添加由支付宝分配的系统商编号(通过setSysServiceProviderId方法)，系统商开发使用,详情请咨询支付宝技术支持
	$providerId = ""; //系统商pid,作为系统商返佣数据提取的依据
	$extendParams = new ExtendParams();
	$extendParams->setSysServiceProviderId($providerId);
	$extendParamsArr = $extendParams->getExtendParams();

	// 支付超时，线下扫码交易定义为5分钟
	$timeExpress = "4m";

	// 商品明细列表，需填写购买商品详细信息，
	$goodsDetailList = array();

	// 创建一个商品信息，参数含义分别为商品id（使用国标）、名称、单价（单位为分）、数量，如果需要添加商品类别，详见GoodsDetail
	$goods1 = new GoodsDetail();
	$goods1->setGoodsId("apple-01");
	$goods1->setGoodsName("iphone");
	$goods1->setPrice(3000);
	$goods1->setQuantity(1);
	//得到商品1明细数组
	$goods1Arr = $goods1->getGoodsDetail();

	// 继续创建并添加第一条商品信息，用户购买的产品为“xx牙刷”，单价为5.05元，购买了两件
	$goods2 = new GoodsDetail();
	$goods2->setGoodsId("apple-02");
	$goods2->setGoodsName("ipad");
	$goods2->setPrice(1000);
	$goods2->setQuantity(1);
	//得到商品1明细数组
	$goods2Arr = $goods2->getGoodsDetail();

	$goodsDetailList = array($goods1Arr,$goods2Arr);

	$appAuthToken = "";//根据真实值填写

	$qrPayRequestBuilder = new AlipayTradePrecreateContentBuilder();
	$qrPayRequestBuilder->setOutTradeNo($outTradeNo);
	$qrPayRequestBuilder->setTotalAmount($totalAmount);
	$qrPayRequestBuilder->setTimeExpress($timeExpress);
	$qrPayRequestBuilder->setSubject($subject);
	$qrPayRequestBuilder->setBody($body);
	$qrPayRequestBuilder->setUndiscountableAmount($undiscountableAmount);
	$qrPayRequestBuilder->setExtendParams($extendParamsArr);
	$qrPayRequestBuilder->setGoodsDetailList($goodsDetailList);

	$qrPayRequestBuilder->setAppAuthToken($appAuthToken);
	
	// 调用qrPay方法获取当面付应答
	$qrPay = new AlipayTradeService($config);

	$qrPayResult = $qrPay->qrPay($qrPayRequestBuilder);
	//	根据状态值进行业务处理
	echo $res = $qrPayResult->getTradeStatus();
	if( $res == "SUCCESS" )
	{
		$response = $qrPayResult->getResponse();
		header("Location: ".$response->qr_code);
		exit;
	}
	else
	{
		echo "<Pre>";
		print_r( $res );
		exit;
	}
	
?>