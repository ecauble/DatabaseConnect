<?php
require("db/Conn.php");
require("db/MySQLDAO.php");
$returnValue = array();

if(empty($_POST["device_id"]) || empty($_POST["user_id"]) )
{
    $returnValue["message"]="device id, or user id are empty";
    echo json_encode($returnValue);
    return;
}

$deviceID = htmlentities($_POST["device_id"]);
$userID = htmlentities($_POST["user_id"]);
$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
$dao->openConnection();

$userInfo = $dao->registerNewDevice($deviceID, $userID);
$dao->closeConnection();
$returnValue["message"]="device was registered";
echo json_encode($returnValue);
return; 
?>