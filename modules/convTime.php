<?php
// Parse PT40M2S to 40:02
function covtime($youtube_time){
  if($youtube_time){
    $start = new DateTime('@0'); // Unix epoch
    $start->add(new DateInterval($youtube_time));
    $time = $start->format('H:i:s');
    if(substr($time,0,3)==="00:"){
      $time = substr($time,3);
    }
    return $time;
  }
}


// Parse 05:10 to 310
function timeToSeconds($time){
  $vals = explode(":",$time);
  $num = sizeof($vals)-1;
  $seconds = intval($vals[$num]);
  $pow = 1;

  while ($num > 0){
    $num--;
    $seconds += intval($vals[$num])*pow(60,$pow);
    $pow++;
  }
  return $seconds;
}
?>