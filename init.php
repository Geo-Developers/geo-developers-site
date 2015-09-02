<?php
session_start();

require_once 'smarty-3.1.21/libs/Smarty.class.php';
require_once 'vendor/autoload.php';
require_once $ROOTPATH.'modules/GeodevDB.php';
require_once $ROOTPATH.'modules/Member.php';
require_once $ROOTPATH.'modules/convTime.php';

ini_set('date.timezone', 'Europe/Berlin');
$smarty = new Smarty();

$smarty->setTemplateDir($ROOTPATH.'smarty/templates');
$smarty->setCompileDir($ROOTPATH.'smarty/templates_c');
$smarty->setCacheDir($ROOTPATH.'smarty/cache');
$smarty->setConfigDir($ROOTPATH.'smarty/configs');

$smarty->assign('returnURL', $_SERVER['REQUEST_URI']);
$smarty->assign('ROOT', $ROOT);

$db = new MysqliDb (Array (
        'host' => $dbhost,
        'username' => $dbuser,
        'password' => $dbpass,
        'db'=> $dbname,
        'charset' => 'utf8')
);

if($_SERVER['HTTP_HOST']=='localhost'){
  ini_set('display_errors',1);
  ini_set('display_startup_errors',1);
  error_reporting(-1);
}

if(isset($_SESSION["user"]["meetup_id"]) ){
    if(isset($_SESSION['logged'])){
        $db->where ("meetup_id", $_SESSION["user"]['meetup_id']);
        $user = $db->getOne ("users");

        $_SESSION["user"]['cookies']    = $user['cookies'];
        $_SESSION["user"]['newsletter'] = $user['mailchimp_euid'] ? $user['mailchimp_euid'] : 0;
    }


    $smarty->assign("USER", $_SESSION["user"]);
  $smarty->assign("SESSION", $_SESSION);

}

?>