<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class SQLExec{
    
    private $connection;
    
    function __construct($host,$user,$password,$database){
        $this->Connect($host,$user,$password,$database);
    }
    
    public function Connect($host,$user,$password,$database){
        $this->connection=mysqli_connect($host,$user,$password,$database);
    }
    
    public function IsConnect(){
        return $this->connection;
    }
    
    public function ExecuteQuery($sql){
        $result=array();
        $res=mysqli_query($this->connection,$sql);
        if($res!==null){
            while($r=mysqli_fetch_assoc($res)){
                $result[count($result)]=$r;
            }
        }
        return $result;
    }
}

?>

