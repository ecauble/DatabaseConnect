<?php

class MySQLDAO
{
    
    var $dbhost = null;
    var $dbuser = null;
    var $dbpass = null;
    var $conn = null;
    var $dbname = null;
    var $result = null;
    
    function __construct($dbhost, $dbuser, $dbpassword, $dbname)
    {
        $this->dbhost = $dbhost;
        $this->dbuser = $dbuser;
        $this->dbpass = $dbpassword;
        $this->dbname = $dbname;
    }
    
    
    public function openConnection()
    {
        $this->conn = new mysqli($this->dbhost, $this->dbuser, $this->dbpass, $this->dbname);
        if (mysqli_connect_errno())
            throw new Exception("Could not establish connection with database");
        $this->conn->set_charset("utf8");
    }
    
    public function closeConnection()
    {
        if ($this->conn != null)
            $this->conn->close();
    }
    
    
    public function findFriends($searchWord, $userId)
    {
        $returnValue = array();
        $sql         = "select * from friends where (first_name like ? or last_name like ?) or user_id=?";
        
        $statement = $this->conn->prepare($sql);
        
        if (!$statement)
            throw new Exception($statement->error);
        
        $searchWord = '%' . $searchWord . "%";
        $statement->bind_param("ssi", $searchWord, $searchWord, $userId);
        
        $statement->execute();
        
        $result = $statement->get_result();
        
        while ($myrow = $result->fetch_assoc()) {
            $returnValue[] = $myrow;
        }
        return $returnValue;
    }
    
    
    public function findAllFriends()
    {
        $returnValue = array();
        $sql         = "select * from friends";
        
        $statement = $this->conn->prepare($sql);
        
        if (!$statement)
            throw new Exception($statement->error);
        
        $searchWord = '%' . $searchWord . "%";
        $statement->bind_param("ssi", $searchWord, $searchWord, $userId);
        
        $statement->execute();
        
        $result = $statement->get_result();
        
        while ($myrow = $result->fetch_assoc()) {
            $returnValue[] = $myrow;
        }
        return $returnValue;
    }
    
    //registers a user's unique device id from their phone/tablet
    public function registerDevice($registrationToken)
    {
        
        $sql       = "insert into Registered_Devices set device_id=?";
        $statement = $this->conn->prepare($sql);

        if (!$statement)
            throw new Exception($statement->error);
        
        $statement->bind_param("s", $registrationToken);
        $returnValue = $statement->execute();
        
        return $returnValue;
    }
}//ends class MySQLDAO
?>