<?php
require("db/Conn.php");
require("db/MySQLDAO.php");
$returnValue = array();

if(empty($_POST["first_name"]) || empty($_POST["last_name"])|| empty($_POST["user_id"]) )
{
    $returnValue["message"]="first name, last name, or user id are empty";
    echo json_encode($returnValue);
    return;
}

$firstName = htmlentities($_POST["first_name"]);
$lastName = htmlentities($_POST["last_name"]);
$userID = htmlentities($_POST["user_id"]);
$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
$dao->openConnection();

$userInfo = $dao->addUserInfo($firstName, $lastName, $userID);
$dao->closeConnection();
$returnValue["message"]="user info was submitted";
echo json_encode($returnValue);
return; 
?>