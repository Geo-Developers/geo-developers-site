<?php
require_once '../modules/prettyprint.php';
require_once '../vendor/autoload.php';
require_once '../config.php';
require_once 'init.php';

$videos = $db->get("videos");

$logFile = fopen("updateVideos_log.txt", "a+") or die("Unable to open file!");
$date = getdate();
$date = $date["year"] ."-". $date["mon"]."-".$date["mday"];
$txt = "Date = $date\n";
fwrite($logFile, $txt);

foreach($videos as $v){
    $youtubeId = $v["youtubeId"];
    $statistiscs = file_get_contents("https://www.googleapis.com/youtube/v3/videos?id=$youtubeId&part=statistics&key=$youtubeApiKey");
    $statistiscs = json_decode($statistiscs);
    $data = array(
        "viewCount" => $statistiscs->items[0]->statistics->viewCount,
        "likeCount" => $statistiscs->items[0]->statistics->likeCount
    );

    $db->where("youtubeId",$youtubeId);
    $db->update("videos", $data);

    $txt = "$youtubeId, {$data['viewCount']}, {$data['likeCount']}\n";
    fwrite($logFile, $txt);
}
fclose($logFile);


    prettyprint($data);


/*
$contentDetails = file_get_contents("https://www.googleapis.com/youtube/v3/videos?id=$youtubeId&part=contentDetails&key=$apikey");
$snippet = file_get_contents("https://www.googleapis.com/youtube/v3/videos?id=$youtubeId&part=snippet&key=$apikey");
$contentDetails = json_decode($contentDetails);
$snippet = json_decode($snippet);
 */
?>