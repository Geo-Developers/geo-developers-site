<?php

require_once '../config.php';
require_once 'init.php';

$db = new MysqliDb (Array (
        'host' => $dbhost,
        'username' => $dbuser,
        'password' => $dbpass,
        'db'=> $dbname,
        'charset' => 'utf8')
);
$db->where ("id", $_SESSION['user_id']);
$user = $db->getOne ("users");

if($user && $user["email"] !== null){
    $_SESSION['logged'] = true;
    $_SESSION['email'] = $user['email'];
    $_SESSION['name'] = $user['name'];
    header('Location: '.$returnURL);
}else{
    $new_user = true;
}

//New user without trying to register
if($new_user && isset($_POST["name"]) ){


    // Add user to mailchimp
    $MailChimp = new \Drewm\MailChimp($mailchimp_apikey);
    $result = $MailChimp->call('lists/subscribe', array(
        'id'                => $mailchimp_listid,
        'email'             => array('email'=> $_POST["email"]),
        'merge_vars'        => array('FNAME'=> $_POST["name"]),
        'double_optin'      => false,
        'update_existing'   => true,
        'replace_interests' => false,
        'send_welcome'      => false,
    ));

    // Add user to the database
    $data = Array (
        "mailchimp_euid" => $result["euid"],
        "name" => $_POST["name"],
        "email" => $_POST["email"]
    );

    if($user){

        if ($db->update('users', $data))
            echo $db->count . ' records were updated';
        else {
            $message = 'update failed: ' . $db->getLastError();
            die($message);
        }
    }else{
        $data["id"] = $_POST["id"];
        $id = $db->insert ('users', $data);
        if(!$id){
            die("The user could not be added, please contact to the webmaster at root@geodevelopers.org");
        }
    }

    $_SESSION['logged'] = true;
    $_SESSION['email'] = $data['email'];
    $_SESSION['name'] = $data['name'];
    header('Location: '. $returnURL);

}

if( isset($_SESSION['user_id']) && !isset($_SESSION['logged']) ){
    $smarty->assign('USER_ID', $_SESSION['user_id']);
    $smarty->assign('NAME', $_SESSION['name']);
    $smarty->assign('PHOTO', $_SESSION['photo']);
    if(isset($_SESSION['returnURL'])){
        $smarty->assign('returnURL', $_SESSION['returnURL']);
    }
    $smarty->display('register.tpl');

}else{

    if(isset($_GET['returnURL'])){
        header('Location: '.$_GET['returnURL']);
    }else{
        header('Location: '.$ROOT);
    }
}
?>