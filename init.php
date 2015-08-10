<?php
session_start();

require_once 'smarty-3.1.21/libs/Smarty.class.php';
require_once 'vendor/autoload.php';
ini_set('date.timezone', 'Europe/Berlin');
$smarty = new Smarty();

$smarty->setTemplateDir($ROOTPATH.'smarty/templates');
$smarty->setCompileDir($ROOTPATH.'smarty/templates_c');
$smarty->setCacheDir($ROOTPATH.'smarty/cache');
$smarty->setConfigDir($ROOTPATH.'smarty/configs');

$smarty->assign('ROOT', $ROOT);

$db = new MysqliDb (Array (
        'host' => $dbhost,
        'username' => $dbuser,
        'password' => $dbpass,
        'db'=> $dbname,
        'charset' => 'utf8')
);

if( isset($_SESSION['logged']) ){
    $smarty->assign('LOGGED', $_SESSION['logged']);
    $smarty->assign('USER_ID', $_SESSION['user_id']);
    $smarty->assign('BIO', $_SESSION['bio']);
    $smarty->assign('EMAIL', $_SESSION['user_id']);
    $smarty->assign('NAME', $_SESSION['name']);
    $smarty->assign('EMAIL', $_SESSION['email']);
    $smarty->assign('MEMBER_URL', $_SESSION['member_url']);
    $smarty->assign('PHOTO', $_SESSION['photo']);
    $smarty->assign('TWITTER', $_SESSION['twitter']);
    $smarty->assign('CITY', $_SESSION['city']);

    $db->where ("id", $_SESSION['user_id']);
    $user = $db->getOne ("users");
    $smarty->assign('COOKIES', $user['cookies']);
    $smarty->assign('NEWSLETTER', $user['mailchimp_euid']);
}

?>