<?php
session_start();

require_once 'meetup.php';
require_once '../vendor/joshcam/mysqli-database-class/MysqliDb.php';
$config = "../config.php";

if( file_exists($config) && is_readable($config) && require_once($config)) {

    if(isset($_SESSION['returnURL'])){
        $returnURL = $_SESSION['returnURL'];
    }else{
        $returnURL = "/";
    }

    if( !isset($_SESSION['logged']) ){
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

            //get an access token
            $response = $meetup->access();
            //now we can re-use this object for several requests using our access
            //token
            $meetup = new Meetup(array("access_token"  => $response->access_token));
            //store details for later in case we need to do requests elsewhere
            //or refresh token
            $_SESSION['access_token'] = $response->access_token;
            $_SESSION['refresh_token'] = $response->refresh_token;
            $_SESSION['expires'] = time() + intval($response->expires_in); //use if >= intval($_SESSION['expires']) to check


            $response = $meetup->getMemberInfo(array('member_id' => 'self'));

            $_SESSION['user_id'] = $response->id;
            $_SESSION['bio'] = $response->bio;
            $_SESSION['name'] = $response->name;
            $_SESSION['member_url'] = $response->link;
            $_SESSION['photo'] = $response->photo->highres_link;
            $_SESSION['twitter'] = $response->other_services->twitter->identifier;
            $_SESSION['city'] = $response->city;

            $db = new MysqliDb (Array (
                    'host' => $dbhost,
                    'username' => $dbuser,
                    'password' => $dbpass,
                    'db'=> $dbname,
                    'charset' => 'utf8')
            );
            $db->where ("id", $_SESSION['user_id']);
            $user = $db->getOne ("users");

            $_SESSION['name'] = $user['name'];
            $_SESSION['email'] = $user['email'];

            if($user){
                $_SESSION['logged'] = true;
                header('Location: '.$returnURL);
            }else{
                header('Location: ../register');
            }
        }
    }else{
        header('Location: '.$returnURL);
    }
}else{
    echo "$config can not be found or read";
}
?>