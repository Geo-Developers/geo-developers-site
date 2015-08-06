<?php
session_start();

require 'meetup.php';
$config = "../config.php";

if( file_exists($config) && is_readable($config) && include($config)) { 

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
      //print_r($response);
      
      $_SESSION['user_id'] = $response->id;
      $_SESSION['bio'] = $response->bio;
      $_SESSION['name'] = $response->name;
      $_SESSION['member_url'] = $response->link;
      $_SESSION['photo'] = $response->photo->highres_link;
      $_SESSION['twitter'] = $response->other_services->twitter->identifier;
      $_SESSION['city'] = $response->city;
      
      $mysqli = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
      if ($mysqli->connect_error) {
        die('Connect Error (' . $mysqli->connect_errno . ') '. $mysqli->connect_error);
      }

      $query = 'SELECT * FROM `users` WHERE id=1231123';


      if (!$result = $mysqli->query($query)) {
        die('Invalid query: '. $query . mysql_error());
      }else{
        if($result->num_rows == 1){
          $_SESSION['logged'] = true;
          header('Location: '.$returnURL);
        }else{
          header('Location: ../register');
        }
        $result->close();
      }


      $mysqli->close();


      }
        //
             //get all events for this member
             //$response = $meetup->getEvents(array('member_id' => '<member id>'));
    
  }else{
    header('Location: '.$returnURL);
  }
}else{
  echo "$config can not be found or read";
}
?>