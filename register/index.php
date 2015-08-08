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

if($user){
    $_SESSION['logged'] = true;
    $_SESSION['email'] = $user['email'];
    $_SESSION['name'] = $user['name'];
    header('Location: '.$returnURL);
}else{
    $new_user = true;
}

//New user without trying to register
if($new_user && isset($_POST["name"]) ){
    $data = Array (
        "id" => $_POST["id"],
        "name" => $_POST["name"],
        "email" => $_POST["email"]
    );

    $id = $db->insert ('users', $data);

    if($id){
        $_SESSION['logged'] = true;
        $_SESSION['email'] = $data['email'];
        $_SESSION['name'] = $data['name'];
        header('Location: '. $returnURL);
    }else{
        die("The user could not be added, please contact to the webmaster at root@geodevelopers.org");
    }
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