<?php
require_once '../modules/prettyprint.php';
require_once '../vendor/autoload.php';
require_once '../config.php';
require_once 'init.php';

ini_set('max_execution_time', 10000);

$client = DMS\Service\Meetup\MeetupKeyAuthClient::factory(array(
    'key' => $meetup_api_key
));

$i = 0;

$options = array(
    'group_urlname' => 'Geo-Developers',
    'page'          => 200,
    'order'         => 'name',
    'offset'        => $i // 0,1,2,3,... until count is 0
);

$GeodevDB = new GeodevDB();
do{
    $members = $client->getMembers($options);
    foreach($members as $member){
        $user = $GeodevDB->getUser(array(
            "type" => "user",
            "meetup_id" =>  $member["id"]
        ));

        if($user){

            $last_visit = parseEpoch($member["visited"]);
            echo $member["id"]." is registered, update just last_visit: $last_visit<br>";
            $db->where("meetup_id", $member["id"]);
            $db->update("profiles",array(
                "last_visit" => $last_visit
            ));
        }
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