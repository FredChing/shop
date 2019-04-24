<!doctype html>
<base href="/Application/Pay/Controller/page/" />
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">
    <title>京东扫码支付</title>

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="icon" type="image/png" href="static/js/assets/i/favicon.png">

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="static/js/assets/i/app-icon72x72@2x.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="apple-touch-icon-precomposed" href="static/js/assets/i/app-icon72x72@2x.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="static/js/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">

    <link rel="stylesheet" href="static/js/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="static/js/assets/css/wx.css?<?php echo time();?>">
</head>
<body>
    <header class="jdpay">
        <h1><a href="#" class="am-text-ir am-center">京东扫码支付</a></h1>
    </header>
    <div class="am-g am-g-fixed am-margin-vertical wx-box">
        <div class="am-u-md-8 am-u-sm-12 am-u-sm-centered am-margin-vertical am-text-center">
            <!--<div class="am-cf">
                <div class="am-center">因微信官方风控，若出现充值异常，请使用微信充值！！</div>
            </div>
            <hr>
            <div class="am-cf">
                <div class="am-center">请在订单提交后5分钟内完成支付！！</div>
            </div>
            <hr>-->
            </div>

            <div class="am-u-md-8 am-u-sm-12 am-u-sm-centered am-margin-vertical am-text-center">支付完成前，请勿关闭此页面！</div>
           
            <div class="am-u-md-8 am-u-sm-12 am-u-sm-centered am-margin-vertical am-text-center wx-code" id="qrcode">
			<img width="200" src="qrcode.php?text=<?php echo $code_url;?>"/>
			</div>

             
            <div class="am-u-md-8 am-u-sm-12 am-u-sm-centered am-margin-vertical am-text-center">
                <hr>
                <p class="am-text-xxxl">￥<?php echo $paymoney;?></p>
                <hr>
                
                <div class="am-cf">
                    <div class="am-fl">支付订单号：<?php echo $payorderid; ?></div><div class="am-fr">订单时间：<?php echo date("Y/m/d H:i:s");?></div>
                </div>
                <hr>             
                <div class="am-cf">
                    <div class="am-fl">请在订单提交后5分钟内完成支付！！</div> 
                </div>
                <hr>
                
            </div>
        </div>
    <!--在这里编写你的代码-->
    <!--[if (gte IE 9)|!(IE)]><!-->
    <script src="static/js/assets/js/jquery.min.js"></script>
    <!--<![endif]-->
    <!--[if lte IE 8 ]>
    <script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
    <script src="static/js/assets/js/amazeui.ie8polyfill.min.js"></script>
    <![endif]-->
 <script>
		$(document).ready(function(){
		refresh();
        
        setInterval(refresh, 3000);
    });
	
		function refresh() {
            var orderno = "<?php echo $payorderid?>";
            $.ajax({
                url: '/Pay_JDPAY_checkorder.html?orderid=' + orderno,
                type: 'GET',
                cache: false,
                success: function(data) {
                    if (data == "0")
					{
					
					
					}else
					{
						location.href = '/Pay_JDPAY_callbackurl.html?orderid=' + orderno;
					
					}
                       
                }
            });
        }
</script>
</body>
</html>
 
