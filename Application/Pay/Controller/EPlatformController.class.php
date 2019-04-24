<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;

class EPlatformController extends PayController
{

    const IV       = 'Bgtrq2xO';
    const TDES_KEY = 'YnqPSZARUDCFBbfUyqx0kQ9o';

    //同步通知
    public function callbackurl()
    {
        echo "申请中，请等待审核！";
        file_put_contents('./Data/EPlatform.txt', "【" . date('Y-m-d H:i:s') . "】callbackurl\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        file_put_contents('./Data/EPlatform.txt', "【" . date('Y-m-d H:i:s') . "】callbackurl\r\n" . serialize($_REQUEST) . "\r\n\r\n", FILE_APPEND);

    }

    //异步通知
    public function notifyurl()
    {
        // $data = unserialize('a:4:{s:7:"merCode";s:6:"205413";s:12:"p3DesXmlPara";s:416:"lMg21jS350DbZgXYllgpMsbcMEIsQsvNXEMKoXEku+mbUK9JGTuFqtG+uPEaCy+S4IVVj+Y5uVIG71BVD2tV7T9lus1vKBdX7zrAcIZnmnRgCXR+3vBI85Jtxn/kVE5pD+h7AJYIzUlCgannQcFjWgdPLTwpEXVEeJC6byAdtl6/GNLME7xpyqqDrG4e/p3agArI+QlEa62vTzZbuK0fGntUoc/iwhlkX5YWASU4BFSNNbxHPJFZehxWca4T+bnDTS1ytFIw0xGcYURUzy+x5eC/RBQZYJspSY8Vqj8BOCZfcvhH/B+PTsK1YAw2WFr2e+GjcxGUrRs3IjZTLBF+osEQW5KlWI5JxVrkvmYEn5n4T6HMRuqgTbzd0WQAfHcf1X45jfHbWgbQ2AdlKlS7+6hQpcI9DGBO";s:7:"errCode";s:6:"000000";s:6:"errMsg";s:19:"000000|操作成功";}');

        $data   = $_REQUEST;
        $params = TDEA::decrypt($data['p3DesXmlPara'], self::TDES_KEY, self::IV);
        $params = xmlToArray($params);
        if ($params) {
            $res = M('ApplyEPlatform')
                ->where([
                    'user_name' => $params['Body']['userName'],
                ])
                ->save([
                    'acc_code' => $params['Body']['accCode'],
                    'status'   => 2,
                ]);
        }

        file_put_contents('./Data/EPlatform.txt', "【" . date('Y-m-d H:i:s') . "】notifyurl\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        file_put_contents('./Data/EPlatform.txt', "【" . date('Y-m-d H:i:s') . "】notifyurl\r\n" . serialize($_REQUEST) . "\r\n\r\n", FILE_APPEND);
    }

}

/**
 *
 */
class TDEA
{
    public static function encrypt($input, $key, $iv, $base64 = true)
    {
        $size                  = 8;
        $input                 = self::pkcs5_pad($input, $size);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $data = mcrypt_generic($encryption_descriptor, $input);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        return base64_encode($data);
    }

    public static function decrypt($crypt, $key, $iv, $base64 = true)
    {
        $crypt                 = base64_decode($crypt);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $decrypted_data = mdecrypt_generic($encryption_descriptor, $crypt);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        $decrypted_data = self::pkcs5_unpad($decrypted_data);
        return rtrim($decrypted_data);
    }

    private static function pkcs5_pad($text, $blocksize)
    {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }

    private static function pkcs5_unpad($text)
    {
        $pad = ord($text{strlen($text) - 1});
        if ($pad > strlen($text)) {
            return false;
        }
        return substr($text, 0, -1 * $pad);
    }

}
