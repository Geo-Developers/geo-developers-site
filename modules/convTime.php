<?php
// Parse PT40M2S to 40:02
function convtime($youtube_time){
    if($youtube_time){
        $start = new DateTime('@0'); // Unix epoch
        $start->add(new DateInterval($youtube_time));
        if(phpversion() === "5.3.29"){
            // Datetime->add on this version have a different behaviour
            // http://bit.ly/1JCWH8q
            $start->sub(new DateInterval("PT2H"));
        }
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