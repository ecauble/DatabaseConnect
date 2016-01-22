<?php
require("db/Conn.php");
require("db/MySQLDAO.php");

$returnValue = array();

if(empty($_POST["registerString"]))
{
    $returnValue["message"]="Device ID unavailable";
    echo json_encode($returnValue);
    return;
}
$registerString = htmlentities($_POST["registerString"]);

$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
$dao->openConnection();

$clientID = $dao->registerDevice($registerString);

$dao->closeConnection();

$returnValue["registerString"]=$registerString;
//echo $clientID;
echo json_encode($returnValue);
return;
?>