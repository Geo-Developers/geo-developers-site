<?php
require_once '../config.php';
require_once 'init.php';
require_once 'modules/getMeetupMember.php';
require_once 'modules/Member.php';
require_once 'modules/Skill.php';

// The constructor loads all information available from
// the database or directly using the Meetup API
$member = new Member($_SESSION["user"]["meetup_id"]);

if($member->isRegistered()){
    $_SESSION["user"]['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    header('Location: '.$returnURL);
}else{
    $new_user = true;
}

//New user without trying to register
if($new_user && isset($_POST["name"]) ){
    // Add user to mailchimp
    $member->email = $_POST["email"];
    $member->name = $_POST["name"];

    $member->save();

    $_SESSION["user"]['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    header('Location: '. $returnURL);
}

if( isset($_SESSION["user"]['meetup_id']) && !isset($_SESSION["user"]['logged']) ){
    // Load vars from session (established when the login)
    $smarty->assign('MEETUP_ID', $_SESSION["user"]["meetup_id"]);
    $smarty->assign('NAME', $_SESSION["user"]['name']);

    if(isset($_SESSION["user"]['photo_url'])){
        $smarty->assign('PHOTO_URL', $_SESSION["user"]['photo_url']);
    }

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