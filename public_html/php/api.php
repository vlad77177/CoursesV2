<?php

session_start();

require '/classes/SQLExec.php';
require '/classes/SessionAccess.php';
require '/classes/SQLConstructor.php';
require '/classes/UserAccessControl.php';
require '/classes/Condition.php';

$host='localhost';
$database='database';
$user='root';
$password='';

$exec=new SQLExec($host,$user,$password,$database);
$sqlc=new SQLConstructor();
$sa=new SessionAccess();

if($exec->IsConnect()===FALSE){
    exit();
}

$data=json_decode(file_get_contents('php://input'),true);

if($data['action']==undefined){
    exit();
}
if($data['action']==='Login'){
    $user=$exec->ExecuteQuery($sqlc->GetSelectSQLString('users',array(),new Condition('login','=',$data['login'])));
}

$result=undefined;

switch($data['action']){
    case 'Login':{
        break;
    }
    case 'getUsers':{
        $target_table='users';
        break;
    }
}

?>

