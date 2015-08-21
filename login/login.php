<?php
require_once 'meetup.php';
$config = "../config.php";

if( file_exists($config) && is_readable($config) && require_once($config)) {

    require_once 'init.php';
    require_once 'vendor/joshcam/mysqli-database-class/MysqliDb.php';
    require_once 'modules/prettyprint.php';


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

            $GeodevDB = new GeodevDB(array("meetup_id" => $r2->id));
            $user = $GeodevDB->getUser(array("type" => "userprofile"));


            if(isset($user["meetup_id"])){
                $_SESSION['user'] = $user;
            }else{
                // Set $_SESSION var
                $_SESSION['user'] = array(
                    "meetup_id"     => $r2->id,
                    "name"          => $r2->name,
                    "photo_id"          => $r2->photo->photo_id,
                );
                $_SESSION['meetup_member'] = $r2;

                if(isset($r2->photo)){
                    if (isset($r2->photo->highres_link)) {
                        $photo = $r2->photo->highres_link;
                    } elseif (isset($r2->photo->photo_link)) {
                        $photo = $r2->photo->photo_link;
                    } elseif (isset($r2->photo->thumb_link)) {
                        $photo = $r2->photo->thumb_link;
                    }
                }elseif (isset($r2->photo_url)) {
                    $photo = $r2->photo_url;
                }else{
                    $email = strtolower( $r2->id."@gmail.com" );
                    $photo = "http://www.gravatar.com/avatar/".md5($email);
                }
                $_SESSION['photo_url'] = $photo;
            }

            // Check if user is in the database and it has an email

            if($user && $user["email"]){
                prettyprint($user);
                die();
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