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
    
    // Helper method to get a string description for an HTTP status code
    // From http://www.gen-x-design.com/archives/create-a-rest-api-with-php/ 
    function getStatusCodeMessage($status)
    {
        // these could be stored in a .ini file and loaded
        // via parse_ini_file()... however, this will suffice
        // for an example
        $codes = Array(
            100 => 'Continue',
            101 => 'Switching Protocols',
            200 => 'OK',
            201 => 'Created',
            202 => 'Accepted',
            203 => 'Non-Authoritative Information',
            204 => 'No Content',
            205 => 'Reset Content',
            206 => 'Partial Content',
            300 => 'Multiple Choices',
            301 => 'Moved Permanently',
            302 => 'Found',
            303 => 'See Other',
            304 => 'Not Modified',
            305 => 'Use Proxy',
            306 => '(Unused)',
            307 => 'Temporary Redirect',
            400 => 'Bad Request',
            401 => 'Unauthorized',
            402 => 'Payment Required',
            403 => 'Forbidden',
            404 => 'Not Found',
            405 => 'Method Not Allowed',
            406 => 'Not Acceptable',
            407 => 'Proxy Authentication Required',
            408 => 'Request Timeout',
            409 => 'Conflict',
            410 => 'Gone',
            411 => 'Length Required',
            412 => 'Precondition Failed',
            413 => 'Request Entity Too Large',
            414 => 'Request-URI Too Long',
            415 => 'Unsupported Media Type',
            416 => 'Requested Range Not Satisfiable',
            417 => 'Expectation Failed',
            500 => 'Internal Server Error',
            501 => 'Not Implemented',
            502 => 'Bad Gateway',
            503 => 'Service Unavailable',
            504 => 'Gateway Timeout',
            505 => 'HTTP Version Not Supported'
        );
        
        return (isset($codes[$status])) ? $codes[$status] : '';
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
    
    //registers a user in the database
    public function registerNewUser($userName, $password)
    {
        $hash      = md5($password);
        $sql       = "INSERT INTO Users (user_name, password) VALUES (?, ?)";
        $statement = $this->conn->prepare($sql);
        
        if (!$statement)
            throw new Exception($statement->error);
        
        $statement->bind_param("ss", $userName, $hash);
        $returnValue = $statement->execute();
        
        return $returnValue;
    }
    
    public function getUserID($userName){
          $returnValue = array();
      $sql = "Select user_id from Users where user_name = ?";
        
        $statement = $this->conn->prepare($sql);
        
        if (!$statement)
            throw new Exception($statement->error);
        
        $statement->bind_param("s", $userName);
        
        $statement->execute();
        
        $result = $statement->get_result();
        
        while ($myrow = $result->fetch_assoc()) {
            $returnValue[] = $myrow;
        }
        return $returnValue;
    }//ends function getUserID
    
} //ends class MySQLDAO
?>










