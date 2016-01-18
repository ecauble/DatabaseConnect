<?php
require("db/Conn.php");
require("db/MySQLDAO.php");

$returnValue = array();

if(empty($_POST["user_name"]) || empty($_POST["password"]) )
{
    $returnValue["message"]="Username or password are empty";
    echo json_encode($returnValue);
    return;
}
$registerString = htmlentities($_POST["user_name"]);

$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
$dao->openConnection();

$clientID = $dao->registerDevice($registerString);

$dao->closeConnection();

$returnValue["registerString"]=$registerString;
echo json_encode($returnValue);
return;
?>