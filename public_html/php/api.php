<?php

include "classes/SQLExec";

$host='localhost';
$database='database';
$user='root';
$password='';

$exec=new SQLExec($host,$user,$password,$database);
if($exec->IsConnect()===FALSE){
    exit();
}

?>

