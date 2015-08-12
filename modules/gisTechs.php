<?php
require("../vendor/autoload.php");
require("../config.php");
require("modules/prettyprint.php");
require("../init.php");

/**
 * Created by IntelliJ IDEA.
 * User: raul.jimenez
 * Date: 11/08/2015
 * Time: 11:33
 */
$GISTech = array(
    array("name" => "3D"),
    array("name" => "52North"),
    array("name" => "ArcGIS Add-ins"),
    array("name" => "AGS"),
    array("name" => "ArcGIS"),
    array("name" => "ArcGIS Online"),
    array("name" => "ArcGIS Server"),
    array("name" => "ArcIMS"),
    array("name" => "ArcInfo"),
    array("name" => "ArcMAP"),
    array("name" => "ArcObjects"),
    array("name" => "ArcPad"),
    array("name" => "ArcPy"),
    array("name" => "ArcSDE"),
    array("name" => "ArcView"),
    array("name" => "AutoCAD"),
    array("name" => "Bing"),
    array("name" => "CartoDB"),
    array("name" => "Cartografía"),
    array("name" => "Cloudmade"),
    array("name" => "Deegree"),
    array("name" => "Degree"),
    array("name" => "Drones"),
    array("name" => "ERDAS"),
    array("name" => "Esri"),
    array("name" => "Fiona"),
    array("name" => "Fusion Tables"),
    array("name" => "GARMIN"),
    array("name" => "GDAL"),
    array("name" => "GeoAnalytics"),
    array("name" => "Geocommons"),
    array("name" => "Geodesia"),
    array("name" => "Geoestadistica"),
    array(
        "name" => "Geofencing",
        "synonyms" => array("Geo-Fencing")
    ),
    array("name" => "Geomarketing"),
    array("name" => "Geomática"),
    array("name" => "Geomedia"),
    array("name" => "GeoNetwork"),
    array("name" => "georeferenciación"),
    array("name" => "Geoserver"),
    array("name" => "GeoTools"),
    array(
        "name" => "Geotrigger",
        "synonyms" => array("Geotriggers")
    ),
    array("name" => "GisCloud"),
    array(
        "name" => "Google Maps",
        "synonyms" => array("GoogleMaps")
    ),
    array("name" => "GPS"),
    array("name" => "GRASS"),
    array("name" => "gvSIG"),
    array(
        "name" => "Hibernate Spatial",
        "synonyms" => array("HibernateSpatial")
    ),
    array("name" => "Idrisi"),
    array("name" => "JTS"),
    array("name" => "Leaflet"),
    array("name" => "Location analytics"),
    array("name" => "Lucene"),
    array(
        "name" => "MangoMap",
        "synonyms" => array("Mango")
    ),
    array("name" => "MapBox"),
    array("name" => "MapObject"),
    array("name" => "MapProxy"),
    array("name" => "Mapserver"),
    array("name" => "MicroStation"),
    array("name" => "Neocartografía"),
    array("name" => "OGR"),
    array("name" => "OpenGeo"),
    array("name" => "Openlayers"),
    array("name" => "OpenScales"),
    array(
        "name" => "OpenStreetMap",
        "synonyms" => array("OSM")
    ),
    array("name" => "OSRM"),
    array("name" => "Pathfinder"),
    array("name" => "PostGIS"),
    array("name" => "Presagis"),
    array("name" => "Proj4"),
    array("name" => "PyQGIS"),
    array(
        "name" => "QGIS",
        "synonyms" => array("QuantumGIS")
    ),
    array("name" => "Shapely"),
    array("name" => "Sharpmap"),
    array(
        "name" => "SIG",
        "synonyms" => array("GIS")
    ),
    array("name" => "SOS"),
    array("name" => "Teledeteccion"),
    array("name" => "Terrasync"),
    array("name" => "TileCache"),
    array("name" => "TileMil"),
    array("name" => "Topografía"),
    array("name" => "TRIMBLE"),
    array("name" => "WinMap"),
    array("name" => "Workstation")
);

$GISTechLower=array();
foreach($GISTech as $tech){
  $data=array(
    "name" => strtolower($tech["name"])
  );
      if(isset($tech["synonyms"])){
          $data["synonyms"] = array_map('strtolower', $tech["synonyms"]);
      }
    array_push($GISTechLower,$data);
}

//prettyprint($GISTechLower);
//die("ya");
//$GISTechLower = array_map('strtolower', $GISTech);

/*function in_arrayi($needle, $haystack) {
    if(is_array($haystack)){
        in_arrayi($needle)
    }
    return in_array(strtolower($needle), array_map('strtolower', $haystack));
}*/

$skills = $db->get("skills");
//prettyprint($skills);
//die("ya");
//prettyprint($GISTechLower);
//echo "<hr>Existe Science?:";

//echo in_array_r("Scienceasd",$skills);
/*
 * Existe el skill 3D
Existe el skill 52North

ya
 * */

/*
foreach($GISTech as $tech){
    $res = skill_exists($skills, $tech);
    //prettyprint($res);
    if($res["exists"]!==1){
        $data= array(
            "is_gis" => 1,
            "name" => $tech["name"],
            "slug" => slugify($tech["name"])
        );
        //$db->insert("skills", $data);

        if($id = $db->insert ('skills', $data))
            echo $db->count . ' records were added';
        else
            echo 'insetion failed: ' . $db->getLastError();
        prettyprint($data);
            echo "<hr>";
    }
}
*/
//die("ya");
/*
    $db->insert("skills", $data);
    $data = array(
        "skill_id" => $skill["id"]
    );
    $db->update("user_skills",$data);*/


function skill_exists($skills, $tech)
{
    $response = array(
        "exists" => -1,
        "name" => "asdasd"
    );

    if (in_array_r(strtolower($tech["name"]), $skills)) {
        $response["exists"] = true;
        $response["name"] = $tech["name"];
    }

    //Check synonyms
    if (!$response["exists"] && isset($tech["synonyms"])) {
        foreach ($tech["synonyms"] as $syn) {
            if (in_array_r(strtolower($syn), $skills)) {
                $response["exists"] = true;
                $response["name"] = $syn;
            }
        }
    }


    return $response;

}


function slugify($text)
{
    // replace non letter or digits by -
    $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

    // trim
    $text = trim($text, '-');

    // transliterate
    $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);

    // lowercase
    $text = strtolower($text);

    // remove unwanted characters
    $text = preg_replace('~[^-\w]+~', '', $text);

    if (empty($text))
    {
        return 'n-a';
    }

    return $text;
}

function in_array_r($needle, $haystack, $strict = false) {
    foreach ($haystack as $item) {
        if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && in_array_r($needle, $item, $strict))) {
            return true;
        }
    }

    return false;
}
//prettyprint($GISTech);
?>