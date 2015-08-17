<?php
require_once '../modules/prettyprint.php';
require_once '../vendor/autoload.php';
require_once '../config.php';
require_once 'init.php';

ini_set('max_execution_time', 10000);

$client = DMS\Service\Meetup\MeetupKeyAuthClient::factory(array(
    'key' => '78754570446272d60b377e702e3917'
));

$i = 0;

$options = array(
    'group_urlname' => 'Geo-Developers',
    'page'          => 200,
    'order'         => 'name',
    'offset'        => $i // 0,1,2,3,... until count is 0
);

do{
    $members = $client->getMembers($options);

    foreach($members as $member){



        $GeodevDB = new GeodevDB(array("meetup_id" => $member["id"]));
        $user = $GeodevDB->getUser(array("type" => "user"));
        /*prettyprint($member);
        die();*/
        if($user){

            $last_visit = parseEpoch($member["visited"]);
            echo $member["id"]." is registered, update just last_visit: $last_visit<br>";
            $db->where("meetup_id", $member["id"]);
            $db->update("profiles",array(
                "last_visit" => $last_visit
            ));
        }else{
            /*$m = new Member(array("meetup_response"=>$member));
            echo $m->meetup_id." is not registered, add or update all fields<br>";
            $m->save();*/

        }
        /*if($m->save()){
            echo "Miembro ($j): ".$member["id"].", name = ".$member["name"]." actualizado con éxito.<br>";
        }*/
    }

    $i++;
    $options["offset"] = $i;
}while($members->count()!=0);

function parseEpoch($date){
    $epoch = $date;
    $epoch = substr($epoch,0, -3);
    $dt = new DateTime("@$epoch");
    return $dt->format('Y-m-d');
}
?>