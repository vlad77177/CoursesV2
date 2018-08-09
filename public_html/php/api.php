<?php

session_start();

require 'classes/SQLExec.php';
require 'classes/SessionAccess.php';
require 'classes/SQLConstructor.php';
require 'classes/UserAccessControl.php';
require 'classes/Condition.php';

$host='localhost';
$database='database';
$username='root';
$password='';

$exec=new SQLExec($host,$username,$password,$database);
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
    $user=$exec->ExecuteQuery($sqlc->GetSelectSQLString('users',array(),array(new Condition('login','=',$data['login']))));
    if($user===undefined){
        exit('Bad login');
    }   
    if(password_verify($data['password'], $user['password'])==false){
        exit('Bad password');
    }
    $sa->SetSession($user);
    exit(json_encode($user));
}

$result=undefined;

switch($data['action']){
    case "getSession":{
        exit(json_encode($sa->GetSession()));
        break;
    }
    case "getUsers":{
        $target_table='users';
        break;
    }
    case "getUserSigned":{
        $c=new Condition('id','=',$user['id']);
        $usersigned=$exec->ExecuteQuery($sqlc->GetSelectSQLString('user_result',array(),array($c)));
        break;
    }
}

?>

