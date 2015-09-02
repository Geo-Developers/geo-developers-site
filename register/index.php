<?php
require_once '../config.php';
require_once 'init.php';
require_once 'modules/getMeetupMember.php';
require_once 'modules/Member.php';
require_once 'modules/Skill.php';

// The constructor loads all information available from
// the database or directly using the Meetup API
if(!isset($_SESSION["user"])){
    header('Location: '. $ROOT.'login');
}

$member = new Member(array(
    "meetup_id" => $_SESSION["user"]["meetup_id"]
));


if(isset($_SESSION['returnURL'])){
    $returnURL = $_SESSION['returnURL'];
}

if($member->isRegistered()){
    $_SESSION['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    if(isset($returnURL)){
        unset($_SESSION['returnURL']);
        header('Location: '. $returnURL);
    }else{
        header('Location: '. $ROOT);
    }
}else{
    $new_user = true;
}

//Add new user to the database $_POST
if($new_user && isset($_POST["name"]) ){
    /*prettyprint($_POST);
    prettyprint($member);
    die();*/

    $member->email = $_POST["email"];
    $member->name = $_POST["name"];

    if(isset($_POST['skills'])){
        $service = new Skill();
        foreach($_POST['skills'] as $skill){
            $s = $service->find(array("name" => $skill));
            //TODO: FIX THIS and submit profile
            if(!isset($member->skills[$s["name"]])){
                $member->skills[$s["name"]] = $s;
            }
        }
    }

    if(isset($_POST['linkedin'])){
        $member->linkedin_url = $_POST['linkedin'];
    }
    if(isset($_POST['linkedin'])) {
        $member->name = $_POST["last_name"];
    }

    $member->save();

    $_SESSION['logged'] = true;
    $_SESSION["user"]['email'] = $member->email;
    $_SESSION["user"]['name'] = $member->name;
    if(isset($returnURL)){
        unset($_SESSION['returnURL']);
        header('Location: '. $returnURL);
    }else{
        header('Location: '. $ROOT);
    }
}

// Register $_GET
if( isset($_SESSION["user"]['meetup_id']) && !isset($_SESSION['logged']) ){

    $GeodevDB = new GeodevDB(array("meetup_id" => $member->meetup_id));
    $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));

    if($userprofile){
        //User is not in the database
        $smarty->assign('USER', $userprofile);
    }
    $smarty->assign('GEOSKILLS', $GeodevDB->getSkills(array("type" => "geo")));
    $smarty->assign("SESSION",$_SESSION);

    //die();
    /*prettyprint($userprofile);
    prettyprint($userprofile);
    die();
    // Load vars from session (established when the login)
    $smarty->assign('MEETUP_ID', $_SESSION["user"]["meetup_id"]);
    $smarty->assign('NAME', $_SESSION["user"]['name']);

    if(isset($_SESSION["user"]['photo_url'])){
        $smarty->assign('PHOTO_URL', $_SESSION["user"]['photo_url']);
    }

    if(isset($_SESSION['returnURL'])){
        $smarty->assign('returnURL', $_SESSION['returnURL']);
    }*/
    $smarty->display('register.tpl');

}else{
    if(isset($_GET['returnURL'])){
        header('Location: '.$_GET['returnURL']);
    }else{
        header('Location: '.$ROOT);
    }
}
?>