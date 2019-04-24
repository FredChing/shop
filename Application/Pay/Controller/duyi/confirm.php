<?php
require 'inc.php';
function curl_post($url, $data)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json; charset=utf-8'
)
);
    $tmpInfo = curl_exec($ch);
    if (curl_errno($ch)) {
        return curl_error($ch);
    }
    return $tmpInfo;
}
$amount = number_format($_REQUEST["TXNAMT"], 2, ".", "");
$data['ORDERNO'] = $_REQUEST["ORDERNO"];
$data['TXNAMT'] = $_REQUEST["TXNAMT"] * 100;
$data['CARDNO'] = $_REQUEST['CARDNO'];
$data['REMARK'] = "ABC";
$data['RETURNURL'] = $_REQUEST['RETURNURL'];
$data['NOTIFYURL'] = 'http://s.91dpays.com/Pay_DUYIQUICK_notifyurl.html';// $_REQUEST['NOTIFYURL'];

if ($data['ORDERNO'] == "" || $_REQUEST["TXNAMT"] == "" || $data['CARDNO'] == ""  )
{
    echo "参数不能为空！";
    echo $_REQUEST["ORDERNO"]. $_REQUEST["TXNAMT"].$_REQUEST['CARDNO'];
    exit();
}



$TRANDATA = "ORDERNO=" . $data['ORDERNO'] . "&TXNAMT=" . $data['TXNAMT']. "&RETURNURL=" . $data['RETURNURL'] . "&NOTIFYURL=" . $data['NOTIFYURL'] . "&CARDNO=" . $data['CARDNO'] . "&REMARK=" . $data['REMARK'] ;

$pi_key = openssl_pkey_get_private($private);
openssl_sign($TRANDATA, $SIGN, $pi_key, OPENSSL_ALGO_SHA1);

$SIGN = base64_encode($SIGN);
$gateway = 'http://111.231.217.165:28080/Pay/trans/quickApiPay';
$arr['MERCNUM'] = $_REQUEST['MERCNUM'];
$arr['TRANDATA'] = $TRANDATA;
$arr['SIGN'] = $SIGN;

buildform( $arr, $gateway );exit;

$parameters = json_encode($arr);


$result = curl_post($gateway, $parameters);
$resArr = json_decode($result, true);
print_r( $resArr );
exit;
if (isset($resArr["RECODE"]) && $resArr["RECODE"] == "0000")
{
    $orderId = isset($resArr["orderId"]) ? $resArr["orderId"] : "";
    $platSeq = isset($resArr["platSeq"]) ? $resArr["platSeq"] : "";
?>


<?php
}
else
{
    if (isset($resArr["RECODE"]) && $resArr["RECODE"] == "ERR011")
	{
        echo "提交的信息不符合或";
    }
    echo isset($resArr["REMSG"]) ? $resArr["REMSG"] : "未知错误";
}

function buildform($data, $submitUrl)
{
  header("Content-type: text/html; charset=utf-8");
  $inputstr = "";
  foreach ($data as $key => $v) {
    $inputstr .= '<input type="hidden"  id="' . $key . '" name="' . $key . '" value="' . $v . '"/>';
  }

  $form = '<form action="' . $submitUrl . '" name="pay" id="pay" method="POST">'."\r\n";
  $form .= $inputstr;
  $form .= '</form>';


  $form .= '<script type="text/javascript">document.getElementById("pay").submit()</script>';

  ob_clean();
  echo $form ;
  exit;
}

?>
