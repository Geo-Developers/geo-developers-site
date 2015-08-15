<?php
session_start();

require_once 'meetup.php';
require_once '../vendor/joshcam/mysqli-database-class/MysqliDb.php';
$config = "../config.php";
require_once '../modules/prettyprint.php';

if( file_exists($config) && is_readable($config) && require_once($config)) {

    if(!isset($_SESSION['returnURL']) || isset($_GET['returnURL'])){
        if(isset($_GET['returnURL'])){
            $_SESSION['returnURL'] = $_GET['returnURL'];
        }else{
            $_SESSION['returnURL'] = $ROOT;
        }
    }

    if( !isset($_SESSION['logged']) ||  !isset($_SESSION['user'])){
        if( !isset($_GET['code']) )
        {
            $meetup = new Meetup();
            $meetup->authorize(array(
                'client_id'     => $client_id,
                'redirect_uri'  => $redirect_uri
            ));
        }
        else
        {
            $meetup = new Meetup(
                array(
                    "client_id"     => $client_id,
                    "client_secret" => $client_secret,
                    "redirect_uri"  => $redirect_uri,
                    "code"          => $_GET['code']
                )
            );

            $r1 = $meetup->access();

            $meetup = new Meetup(array("access_token"  => $r1->access_token));

            $r2 = $meetup->getMemberInfo(array('member_id' => 'self'));
            /*$array = array(
                "foo" => "bar",
                "bar" => "foo",
            );*/
            // Set $_SESSION var
            $_SESSION['user'] = array(
                "meetup_id"     => $r2->id,
                "name"          => $r2->name,
                "meetup_url"    => $r2->link,
                "lat"           => $r2->lat,
                "lon"           => $r2->lon,
                "location"      => $r2->city,
                "bio"           => (isset ($r2->bio)) ? $r2->bio : "",
                "joined"        => date("Y-m-d", strtotime($r2->joined))
            );


            if(isset($r2->photo->highres_link)){
                $_SESSION['user']['photo_url'] = $r2->photo->highres_link;
            }elseif(isset($r2->photo->photo_link)){
                $_SESSION['user']['photo_url'] = $r2->photo->photo_link;
            }

            if($r2->other_services){
                foreach($r2->other_services as $key => $service){
                    $_SESSION['user'][$key."_url"] = $service->identifier;
                }
            }

            // Recover local values (email and name)
            $db = new MysqliDb (Array (
                    'host' => $dbhost,
                    'username' => $dbuser,
                    'password' => $dbpass,
                    'db'=> $dbname,
                    'charset' => 'utf8')
            );

            $db->where("meetup_id", $_SESSION['user']['meetup_id']);
            $user = $db->getOne("users");

            if($user){
                $_SESSION['user']['name'] = $user['name'];
                $_SESSION['user']['email'] = $user['email'];
            }
            //echo "user=".$user;

            // Check if user is in the database and it has an email
            if($user && $user["email"] !== null){
                $_SESSION['logged'] = true;
                header('Location: '.$_SESSION['returnURL']);
            }else{
                header('Location: ../register');
            }
        }
    }else{
        header('Location: '.$_SESSION['returnURL']);
    }
}else{
    echo "$config can not be found or read";
}
?>