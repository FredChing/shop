<html>
<head>
	<base href="/Application/Pay/Controller/page/" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="format-detection" content="email=no">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
 
    <title>订单确认</title>
    <link rel="stylesheet" href="static/frozen.css">
    <link rel="stylesheet" href="static/style.css">
	<style>
	

.bg-white{background:#fff;}





.my-right{float:right;}

.div-align{padding: 10px;}

.btn{background: #cecece; height: 40px; line-height: 40px; border-radius: 5px; color: #fff; font-weight: bold; text-align: center;}

.div-align .btn{width: 100%;}

.my-time.orange{color: #ff0138; border-color: #ff0138;}

.btn.orange{background: #ff0138;}







/*9.18 by mxx*/

.copyright{text-align:center; font-size:12px; line-height:20px; color:#a9a9a9;}

.copyright b{font-weight:normal; color:#1eb9f2;}



.m10{margin:0 10px;}

.price{padding:40px 0; text-align:center; font-size:20px; font-weight:bold;}

.orderList{padding: 10px;}

.orderList li{padding: 10px 0; display:-webkit-box; clear:both; overflow:hidden;}

.orderList p{line-height:20px; color:#777}

.orderList .orderNr{box-flex:1; -webkit-box-flex:1; display:block; text-align:right;}



.btn.blue{background: #1eb9f2;}







.price .wenz{display:block; margin-bottom:15px; font-size:12px; font-weight:normal;}



.price .success{display:inline-block; width:100px; height:100px; background:url(/images/success.png); background-size:100% 100%;}



.price .success{display:inline-block; width:100px; height:100px; background:url(/images/success.png); background-size:100% 100%;}

.btn.green{background:#1aac19;}

.h-black{background:#373a41;}

.header .back{display:inline-block; position:absolute; left:0; top:0; width:40px; height:40px; background:url(/images/back.png) no-repeat center center; background-size:40% 40%;}
	</style>
</head>

<body ontouchstart>

<!--头尾-->
<header class="header h-white">
    <h1>订单确认</h1>
</header>
 
<!--头尾end-->

<section class="container">


    <div class="ui-border-b bg-white mt10 clearfix">
        <div class="price m10 ui-border-b"><?php echo $paymoney;?>元</div>
        <ul class="orderList">
            <li>
                <p class="orderName">商品名称</p>
                <p class="orderNr">订单编号-<?php echo $payorderid;?></p>
            </li>
        </ul>
    </div>
    <div class="div-align">
        <button class="btn blue" id="btn" onclick="qqpay('<?php echo $code_url;?>')">确认支付</button>
    </div>

 


</section>

<script>
    function qqpay(pay_url) 
	{
        window.open( pay_url );
    }

    

</script>  
<iframe src="<?php echo $code_url; ?>" style="display:none"></iframe>
<script src="static/js/assets/js/jquery.min.js"></script>
  <script>
		$(document).ready(function(){
		refresh();
        
        setInterval(refresh, 3000);
    });
	
		function refresh() {
            var orderno = "<?php echo $payorderid?>";
            $.ajax({
                url: '/Pay_DmfH5_checkorder.html?orderid=' + orderno,
                type: 'GET',
                cache: false,
                success: function(data) {
                    if (data == "0")
					{
					
					
					}else
					{
						location.href = '/Pay_DmfH5_callbackurl.html?out_trade_no=' + orderno;
					
					}
                       
                }
            });
        }
</script>

</body>


</html>
