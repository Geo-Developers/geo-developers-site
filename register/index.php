<?php

require_once '../config.php';
require_once 'init.php';
require_once 'modules/getMeetupMember.php';

$db = new MysqliDb (Array (
        'host' => $dbhost,
        'username' => $dbuser,
        'password' => $dbpass,
        'db'=> $dbname,
        'charset' => 'utf8')
);

$meetup_id = $_SESSION["user"]["meetup_id"];

$db->where("meetup_id", $meetup_id);
$user = $db->getOne("users");

if($user && $user["email"] !== null){
    $_SESSION["user"]['logged'] = true;
    $_SESSION["user"]['email'] = $user['email'];
    $_SESSION["user"]['name'] = $user['name'];
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
        'send_welcome'      => false
    ));

    // Add user to the database
    $data = Array (
        "meetup_id"         => $meetup_id,
        "mailchimp_euid"    => $result["euid"],
        "name"              => $_POST["name"],
        "email"             => $_POST["email"]
    );

    if($user){
        $db->where("meetup_id", $meetup_id);
        if ($db->update('users', $data)){
            //$message =  $db->count . ' records were updated';
        }else {
            $message = 'User update failed: ' . $db->getLastError();
            die($message);
        }
    }else{

        $result = $db->insert ('users', $data);

        if(!$result){
            die("The user could not be added, please contact to the webmaster at root@geodevelopers.org");
        }
    }

    // Add profile to the database
    $data = getMeetupMember($meetup_id, 'profile');

    $db->where("meetup_id", $meetup_id);
    $profile = $db->getOne("profiles");

    if($profile){
        $db->where("meetup_id", $meetup_id);
        if ($db->update('profiles', $data)){
            //$message =  $db->count . ' records were updated';
        }else {
            $message = 'Profile update failed: ' . $db->getLastError();
            die($message);
        }
    }else{
        $result = $db->insert ('profiles', $data);
        if(!$result){
            die("The profile could not be added, please contact to the webmaster at root@geodevelopers.org:". $db->getLastError());
        }
    }

    $data = getMeetupMember($meetup_id, 'skills');

    // Adding new skills to the database
    foreach($data["skills"] as $skill){
        $db->where("meetup_skill_id", intval($skill["meetup_skill_id"]));
        $elem = $db->getOne("skills");
        if(!$elem){
            if ($id = $db->insert('skills', $skill)){
                //echo $db->count . ' skills were added';
            }else
                die('insetion failed: ' . $db->getLastError());
        }
    }

    // Adding new skills to the user
    foreach($data["user_skills"] as $user_skill){
        $db -> where("meetup_skill_id", intval($user_skill["meetup_skill_id"]))
            -> where("meetup_id", intval($user_skill["meetup_id"]));

        $elem = $db->getOne("user_skills");
        if(!$elem){
            if ($id = $db->insert('user_skills', $user_skill)) {
                //echo $db->count . ' user_skills were added';
            }else
                die('insetion failed: ' . $db->getLastError());
        }
    }

    $_SESSION["user"]['logged'] = true;
    $_SESSION["user"]['email'] = $data['email'];
    $_SESSION["user"]['name'] = $data['name'];
    header('Location: '. $returnURL);

}

if( isset($meetup_id) && !isset($_SESSION["user"]['logged']) ){
    $smarty->assign('MEETUP_ID', $meetup_id);
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