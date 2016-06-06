<?php

header('Content-Type: application/json');
require_once '../config.php';
require_once 'init.php';
require_once 'vendor/slim/slim/Slim/Slim.php';

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

/* MIDDLEWARES */
function authenticated() {
  global $ROOT;

  if (!isset($_SESSION['user']['meetup_id'])) {
    $app = \Slim\Slim::getInstance();
    $app->flash('error', 'Login required');
    $app->redirect($ROOT.'login');
  }
};

function same_user(\Slim\Route $route) {
  $params = $route->getParams();

  if (intval($params["userid"]) !== intval($_SESSION['user']['meetup_id'])) {
    $data = array(
      'status' => 'error',
      'message' => 'You are not'.$params["userid"]
    );
    die(json_encode($data));
  }

};

function not_same_user(\Slim\Route $route) {
  $params = $route->getParams();

  if (intval($params["userid"]) === intval($_SESSION['user']['meetup_id'])) {
    $data = array(
      'status' => 'error',
      'message' => 'You are not'.$params["userid"]
    );
    die(json_encode($data));
  }

};
/* END MIDDLEWARES */

$app->post('/user/:userid', 'authenticated', 'same_user', function ($userId) use ($app, $db){
  $userAttrs = array("cookies", "mailchimp_euid");
  $data = insertOrUpdate($db, 'users', $userAttrs, $userId, "meetup_id");
  echo json_encode($data);
});

$app->post('/speak',function () use ($app, $db) {
  global $ROOT;

  $to = 'root@geodevelopers.org';
  $subject = 'Ofrecimiento para dar una charla';

  if(isset($_SESSION['user'])){
    $GeodevDB = new GeodevDB(array("meetup_id" => $_SESSION['user']['meetup_id']));
    $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));


    $replyTo = $userprofile['email'];
    $message = "
              Nombre: <a href='http://{$_SERVER['HTTP_HOST']}".$ROOT."miembros/{$userprofile['meetup_id']}'>
                          {$userprofile['name']} {$userprofile['last_name']}
                      </a><br>
              Email: {$userprofile['email']}<br>
              ";
  }else{
    $replyTo = $_POST["email"];
    $message = "";
  }
  $data = sendMail($to, $subject, $message, $replyTo);
  echo json_encode($data);
});

$app->post('/video/suggest', 'authenticated',function () use ($app, $db) {
  global $ROOT;

  $GeodevDB = new GeodevDB(array("meetup_id" => $_SESSION["user"]['meetup_id']));
  $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));

  $to = 'root@geodevelopers.org';
  $replyTo = $userprofile['email'];
  $subject = 'Nuevos vídeos sugeridos';
  $message = "
            Nombre: <a href='http://{$_SERVER['HTTP_HOST']}".$ROOT."miembros/{$userprofile['meetup_id']}'>
                        {$userprofile['name']} {$userprofile['last_name']}
                    </a><br>
            Email: {$userprofile['email']}<br>
            ";

  foreach($_POST["videos"] as $v){
    $message .= "<a href='{$v['url']}'>{$v['title']}</a><br>";
  }

  $data = sendMail($to, $subject, $message, $replyTo);
  echo json_encode($data);
});

function sendMail($to, $subject, $message, $replyTo){

  $message = wordwrap($message, 70, "\r\n");
  $headers = "From: " . strip_tags($to) . "\r\n";
  $headers .= "Reply-To: ". strip_tags($replyTo) . "\r\n";
  $headers .= "MIME-Version: 1.0\r\n";
  $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

  if(@mail($to, $subject, $message, $headers))
  {
    $data = array(
      'status' => 'success',
      'message' => "Mail sent successfully to $to, replyTo $replyTo!"
    );
  }else{
    $data = array(
      'status' => 'error',
      'message' => 'Inténtalo de nuevo por favor'
    );
  }
  return $data;
}

$app->delete('/user/:userid/skill', 'authenticated', 'same_user', function ($userId) use ($app, $db) {

  $db->where("skill_id",$_POST["skill_id"]);
  if($db->delete('user_skills')){
    $data = array(
      'status' => 'success',
      'message' => 'Skill removed from the user'
    );
  }else{
    $data = array(
      'status' => 'error',
      'message' => 'The skill could not be removed from the user'
    );
  }

  echo json_encode($data);
});



$app->post('/user/:userid/skill', 'authenticated', 'same_user', function ($userId) use ($app, $db) {

  $skill_name = trim($_POST["skill_name"]);
  $db->where("name", $skill_name);
  $elem = $db->getOne("skills");

  if(!$elem){
    // Its a new skill
    $data = array(
      "name" => $skill_name,
      "is_important" => 1
    );
    if(isset($_POST["is_gis"])){
      $data["is_gis"] = 1;
    }
    $id = $db->insert("skills",$data);
    if(!$id){
      return array(
        'status' => 'error',
        'message' => 'The skill could not be added to the database'
      );
    }
  }else{
    $id = $elem["id"];
  }

  $meetup_id = $_SESSION['user']['meetup_id'];
  $db->where("skill_id", $id);
  $db->where("meetup_id", $meetup_id);
  $elem = $db->getOne("user_skills");

  if(!$elem){

    $res = $db->insert("user_skills",array(
      "meetup_id" => $meetup_id,
      "skill_id" => $id
    ));
    if($res){
      $data = array(
        'status' => 'success',
        'message' => $id
      );
    }else{
      $data = array(
        'status' => 'error',
        'message' => 'The skill could not be added to the user: '.$db->getLastError()
      );
    }
  }else{
    /* $db->where("skill_id", $id);
     $db->where("meetup_id", $meetup_id);
     $res = $db->update("user_skills",array(
         "meetup_id" => $meetup_id,
         "skill_id" => $id,
         "level" => $_POST["level"]
     ));
     if($res){
         $data = array(
             'status' => 'success',
             'message' => $id
         );
     }else{
         $data = array(
             'status' => 'error',
             'message' => 'The skill could not be added to the user'
         );
     }*/
    $data = array(
      'status' => 'error',
      'message' => 'You already have this skill'
    );
  }

  echo json_encode($data);
});

$app->post('/vote/:userid', 'authenticated', 'not_same_user', function ($userId) use ($app, $db){

  $meetup_id = $_SESSION['user']['meetup_id'];

  $db->where("referrer",$meetup_id)->where("refered",$userId);
  if($elem = $db->getOne('votes')){
    $db->where("referrer",$meetup_id)->where("refered",$userId);
    $db->delete('votes');
    $data = array(
      'status' => 'success',
      'recommended' => false,
      'message' => 'Vote successfully removed'
    );
  }else{
    $db->insert('votes', array(
      "referrer" => $meetup_id,
      "refered" => $userId
    ));
    $data = array(
      'status' => 'success',
      'recommended' => true,
      'message' => 'Vote successfully added'
    );
  }

  echo json_encode($data);
});

$app->post('/video/:videoid/rate',function ($videoid) use ($app, $db){

  if(isset($_SESSION['user'])){
    $db -> where('userid', $_SESSION['user']['id'])
      -> where('videoid', $videoid);

    $rating = $db->getOne('video_ratings');
  }else{
    $rating = false;
  }

  $date = new DateTime();

  $vals = array(
    'date' => date('Y-m-d H:i:s',$date->getTimestamp())
  );

  if($_POST['general-rate']){ $vals['general-rate'] = $_POST['general-rate'];}
  if($_POST['speaker-rate']){ $vals['speaker-rate'] = $_POST['speaker-rate'];}
  if($_POST['tech-rate']){ $vals['tech-rate'] = $_POST['tech-rate'];}
  if($_POST['comments']){ $vals['comments'] = $_POST['comments'];}

  if(!$rating){

    if(isset($_SESSION['user'])){
      $vals = array_merge($vals, array(
        'userid'=> $_SESSION['user']['id'],
        'videoid' => $videoid,
      ));
    }else{
      $vals = array_merge($vals, array(
        'videoid' => $videoid,
      ));
    }

    $res = $db->insert('video_ratings', $vals);

    if($res){
      $data = array(
        'status' => 'success',
        'message' => '¡Gracias! la valoración ha sido guardada'
      );
    }else{
      $data = array(
        'status' => 'error',
        'message' => 'The rating could not be saved: '.$db->getLastError()
      );
    }

  }else{
    $db -> where('userid', $_SESSION['user']['id'])
      -> where('videoid', $videoid);

    $res = $db->update('video_ratings', $vals);

    if($res){
      $data = array(
        'status' => 'success',
        'message' => '¡Gracias! la valoración ha sido actualizada'
      );
    }else{
      $data = array(
        'status' => 'error',
        'message' => 'The rating could not be update: '.$db->getLastError()
      );
    }
  }

  echo json_encode($data);

  //echo json_encode($data);
});

/*$app->post('/video/:videoid', function ($userId) use ($app, $db){


    if(isset($_SESSION['user']['meetup_id'])) {
        $videoAttrs = array("id", "title", "publishedAt", "duration", "viewCount", "likeCount", "tags");
        $data = insertOrUpdate($db, 'videos', $videoAttrs, $_POST['id'], "id");

    }
    echo json_encode($data);
});*/
$app->post('/getTitle/', function () use ($app) {
  $tags = get_meta_tags($_POST["url"]);
  $res = array(
    'status' => 'success',
    'message' => $tags
  );
  echo json_encode($res);
});

$app->post('/user/:userid/video', 'authenticated', 'same_user', function ($userId) use ($app, $db) {

  $db->where("video_id",$_POST["video_id"]);
  $db->where("meetup_id", $_SESSION['user']['meetup_id']);
  $elem = $db->getOne("progress");

  $indexes = $_POST["indexes"];
  for($i = 0; $i < sizeof($indexes) ; $i++){
    $indexes[$i] = implode(",",$indexes[$i]);
  }
  $indexes = implode("|",$indexes);

  $data= array(
    "progress" => $_POST["progress"],
    "indexes" => $indexes
  );

  if($elem){

    $db->where("video_id",$_POST["video_id"]);
    $db->where("meetup_id", $_SESSION['user']['meetup_id']);
    if(!$db->update("progress", $data)){
      $res = array(
        'status' => 'error',
        'message' => 'Progress could no be updated: '.$db->getLastError()
      );
    }
  }else{
    $data["video_id"] = $_POST["video_id"];
    $data["meetup_id"] = $_SESSION['user']['meetup_id'];
    if(!$db->insert("progress", $data)){
      $res = array(
        'status' => 'error',
        'message' => 'Progress could no be added: '.$db->getLastError()
      );
    }
  }

  if(!isset($res)){
    $res = array(
      'status' => 'success',
      'message' => $data
    );
  }

  echo json_encode($res);
});


$app->post('/user/:userid/preferences', 'authenticated', 'same_user', function ($userId) use ($app, $db) {

  global $mailchimp_listid, $mailchimp_apikey;
  $MailChimp = new \Drewm\MailChimp($mailchimp_apikey);

  $user = new Member(array("meetup_id" => $_SESSION["user"]["meetup_id"]));

  $data = array(
    'email'             => array("euid"=> $user->mailchimp_euid),
    'merge_vars'        => array('groupings' => array()),
    'id'                => $mailchimp_listid,
    'replace_interests' => true
  );

  foreach($_POST["groups"] as $group){
    $grouping = array(
      'id'=>$group,
      "groups" => array()
    );

    if(!empty($_POST["$group"])){
      foreach($_POST["$group"] as $g){
        array_push($grouping["groups"],$g);
      }
      array_push($data["merge_vars"]["groupings"],$grouping);
    }
  }

  $result = $MailChimp->call('/lists/update-member', $data);
  if($result){
    $data = array(
      'status' => 'success',
      'message' => 'Tus preferencias han sido actualizadas'
    );
  }else{
    $data = array(
      'status' => 'error',
      'message' => 'Tus preferencias no han podido ser guardadas, vuelve a intentarlo más tarde'
    );
  }

  echo json_encode($data);
});

$app->get('/jobs',function () use ($app, $db) {

  $db->where('is_open', 1);
  $jobs = $db->get('jobs');
  /*$res = array(
    'status' => 'error',
    'message' => 'Tus preferencias no han podido ser guardadas, vuelve a intentarlo más tarde'
  );
  nombre({
    asdasd: 123 as
  })
  */
  $jobs = json_encode($jobs);
  if(isset($_GET['callback'])){
    $jobs = $_GET['callback'] . "(" . $jobs . ")";
  }
  echo $jobs;
});


function insertOrUpdate($db, $table, $attrs, $id, $where){
  $data = array();

  foreach($attrs as $attr){
    if(isset($_POST[$attr])){

      if(is_array($_POST[$attr])){
        //print_r($_POST[$attr]);
        $data[$attr] = implode(',', $_POST[$attr]);
      }else{
        $data[$attr] = $_POST[$attr];
      }
    }
  }

  $db->where($where, $id);
  $elem = $db->getOne($table);
  if($elem){

    $db->where($where, $id);

    if ($db->update($table, $data))
      $message = $db->count . ' records were updated';
    else
      $message = 'update failed: ' . $db->getLastError();
  }else{
    if($id = $db->insert($table, $data))
      $message = $db->count . ' records were added';
    else
      $message = 'insetion failed: ' . $db->getLastError();
  }
  return array(
    'status' => 'success',
    'message' => $message
  );
}

$app->run();
?>
