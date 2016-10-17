<?php

require_once '../../config.php';
require_once 'init.php';

// PDO connect *********
function connect($dbhost, $dbname, $dbuser, $dbpass) {
    return new PDO('mysql:host='.$dbhost.';dbname='.$dbname, $dbuser, $dbpass, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
}

$pdo = connect($dbhost, $dbname, $dbuser, $dbpass);

// posts *******************************
$sql = 'SELECT * FROM jobs ORDER BY id DESC';
$query = $pdo->prepare($sql);
$query->execute();
$rs_post = $query->fetchAll();

// The XML structure
$data = '<?xml version="1.0" encoding="UTF-8" ?>';
$data .= '<rss version="2.0">';
$data .= '<channel>';
$data .= '<title>GeoDevelopers: Ofertas de empleo</title>';
$data .= '<link>http://www.geodevelopers.org</link>';
$data .= '<description>Comunidad de profesionales del mundo de los SIG</description>';
$data .= '<image>
            <title>GeoDevelopers: Ofertas de empleo</title>
            <url>http://geodevelopers.org/images/code-editor.png</url>
            <link>http://www.geodevelopers.org</link>
          </image>
          ';

foreach ($rs_post as $row) {
    $data .= '<item>';
    $data .= '<title>'.$row['title'].'</title>';
    $data .= '<link>http://geodevelopers.org/jobs/#'.$row['id'].'</link>';
    $data .= '<description><![CDATA['.substr($row['offer_details'],0, 255).']]></description>';
    $data .= '<guid>'.$row['id'].'</guid>';
    $data .= '<pubDate>'.date("D, d M Y H:i:s T", strtotime($row['date'])).'</pubDate>';
    $data .= '</item>';
}
$data .= '</channel>';
$data .= '</rss> ';

header('Content-Type: application/xml');
echo $data;
?>
