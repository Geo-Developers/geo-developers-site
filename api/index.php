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
/* END MIDDLEWARES */

$app->post('/user/:userid', 'authenticated', 'same_user', function ($userId) use ($app, $db){
    $userAttrs = array("cookies", "mailchimp_euid");
    $data = insertOrUpdate($db, 'users', $userAttrs, $meetup_id, "meetup_id");
    echo json_encode($data);
});

$app->post('/user/:userid/speak', 'authenticated', 'same_user',function ($userId) use ($app, $db) {
    global $ROOT;

    $GeodevDB = new GeodevDB(array("meetup_id" => $userId));
    $userprofile = $GeodevDB->getUser(array("type" => "userprofile"));

    $message = "
            Nombre: <a href='http://{$_SERVER['HTTP_HOST']}".$ROOT."miembros/{$userprofile['meetup_id']}'>
                        {$userprofile['name']} {$userprofile['last_name']}
                    </a><br>
            Email: {$userprofile['email']}<br>
            ";
    $message = wordwrap($message, 70, "\r\n");

    $to = 'root@geodevelopers.org';
    $subject = 'Ofrecimiento para dar una charla';
    $headers = "From: " . strip_tags($to) . "\r\n";
    $headers .= "Reply-To: ". strip_tags($userprofile['email']) . "\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

    if(@mail($to, $subject, $message, $headers))
    {
        $data = array(
            'status' => 'success',
            'message' => 'Mail sent successfully!'
        );
    }else{
        $data = array(
            'status' => 'error',
            'message' => 'Inténtalo de nuevo por favor'
        );
    }
    echo json_encode($data);
});

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

    $meetup_id = $_SESSION['user']['meetup_id'];
    $skill_name = $_POST["skill_name"];
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
            $data = array(
                'status' => 'error',
                'message' => 'The skill could not be added to the database'
            );
        }
    }else{
        $id = $elem["id"];
    }

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
                'message' => 'The skill could not be added to the user'
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

$app->post('/vote/:userid', 'authenticated', 'same_user', function ($userId) use ($app, $db){

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

/*$app->post('/video/:videoid', function ($userId) use ($app, $db){


    if(isset($_SESSION['user']['meetup_id'])) {
        $videoAttrs = array("id", "title", "publishedAt", "duration", "viewCount", "likeCount", "tags");
        $data = insertOrUpdate($db, 'videos', $videoAttrs, $_POST['id'], "id");

    }
    echo json_encode($data);
});*/

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