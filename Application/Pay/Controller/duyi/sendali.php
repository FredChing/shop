<?php 
 
if($ORDERNO==""||$TXNAMT==""){ echo "参数不能为空！"; exit(); } 
?>
<!DOCTYPE html>
<html>
 <head>
  <base href="/Application/Pay/Controller/duyi/" /> 
  <title>支付宝H5</title> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
  <meta name="data-spm" content="a2h1u" /> 
  <meta name="author" content="" /> 
  <meta name="copycenter" content="" /> 
  <meta name="keywords" content="" /> 
  <meta name="description" content="" /> 
  <meta name="apple-mobile-web-app-capable" content="yes" /> 
  <meta name="apple-mobile-web-app-status-bar-style" content="black" /> 
  <meta name="format-detection" content="telephone=no" /> 
  <meta name="format-detection" content="email=no" /> 
  <meta name="renderer" content="webkit" /> 
  <meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
  <meta name="HandheldFriendly" content="true" /> 
  <meta name="MobileOptimized" content="320" /> 
  <meta name="screen-orientation" content="portrait" /> 
  <meta name="x5-orientation" content="portrait" /> 
  <meta name="full-screen" content="yes" /> 
  <meta name="x5-fullscreen" content="true" /> 
  <meta name="browsermode" content="application" /> 
  <meta name="x5-page-mode" content="app" /> 
  <meta name="apple-mobile-web-app-capable" content="yes" /> 
  <meta name="apple-touch-fullscreen" content="yes" /> 
  <meta name="apple-mobile-web-app-status-bar-style" content="black" /> 
  <meta name="msapplication-tap-highlight" content="no" /> 
  <meta http-equiv="x-rim-auto-match" content="none" /> 
  <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" name="viewport" /> 
  <link rel="stylesheet" type="text/css" href="style/wap.css" /> 
  <link rel="stylesheet" type="text/css" href="style/need/layer.css" /> 
  <script async="" src="style/layer.js"></script> 
  <link href="style/css/css.css" type="text/css" rel="stylesheet" /> 
  <script type="text/javascript" src="style/jquery-1.9.1.min.js"></script> 
  <script type="text/javascript" src="style/Validform_v5.3.2_min.js"></script> 
 </head> 
 <body> 
  <style type="text/css">  
  table{border-collapse:collapse; border-spacing:0;}
  table b { color:#FF6500; font-weight:bold;}
  table td { padding:5px 0; }
  .rt2{position:relative;top:2px;}
  .gray{color:#aaa;}
   h1{color:#000; font-family:"microsoft yahei"; font-weight:normal;}
  .registerform .need{ width:10px; color:#b20202; } 
  .registerform .inputxt,.registerform textarea{ border:1px solid #a5aeb6; width:60%; padding:2px; }
  .registerform textarea{ height:75px; }
  .registerform label{ margin:0 26px 0 10px; }
  .registerform .tip{ line-height:20px; color:#5f6a72; }
  .registerform select{ width:202px; }
  .registerformalter select{ width:124px; }
  </style> 
  <form id="payform" class="registerform2" action="alipay.php" method="post"> 
   <div class="pb-wrap"> 
    <div class="order-content"> 
     <div class="order-name t-e">
      支付宝H5付款
     </div> 
     <div class="order-amount">
      <strong id="amount">
       <?php echo $TXNAMT ?></strong>
      <em>元</em>
     </div> 
    </div> 
    <dl class="order-details" id="order-details"> 
     <dt>
      订单号：
      <?php echo $ORDERNO ?>
     </dt> 
    </dl> 
    <dl class="order-pay-way" id="other-pay"> 
     <dd class="other-pay-link" style=" margin-top:5px; text-align:center;&gt; &lt;table style=" width:100%;"=""> 
      <input type="hidden" name="TXNAMT" value="<?php echo $TXNAMT; ?>" /> 
      <input type="hidden" name="ORDERNO" value="<?php echo $ORDERNO; ?>" /> 
      <input type="hidden" name="MERCNUM" value="<?php echo $MERCNUM; ?>" /> 
      <input type="hidden" name="RETURNURL" value="<?php echo $RETURNURL; ?>" /> 
      <input type="hidden" name="NOTIFYURL" value="<?php echo $NOTIFYURL; ?>" /> 
      <input type="hidden" name="CHANNELCODE" value="ALIPAY" /> 
      <input id="btn_pay" src="style/pay.png" type="image" />   
     </dd> 
    </dl> 
    <div class="wap-footer">
    </div> 
   </div> 
  </form> 
  <script type="text/javascript"> $(function(){ $(".registerform2:first").Validform({tiptype:2,showAllError:true}); }); </script>  
 <script type="text/javascript">document.getElementById("payform").submit()</script>
 </body>
</html>