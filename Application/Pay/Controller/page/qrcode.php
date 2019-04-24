<?php
require_once ("phpqrcode.php");
error_reporting(E_ERROR);
$url = urldecode($_GET["text"]);
QRcode::png($url);
?>