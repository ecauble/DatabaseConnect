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

$userName = htmlentities($_POST["user_name"]);
$password = htmlentities($_POST["password"]);

$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
$dao->openConnection();

$clientID = $dao->registerNewUser($userName, $password);
$userID = $dao->getUserID($userName);
$dao->closeConnection();
$returnValue=$userID;
echo json_encode($returnValue);
?>