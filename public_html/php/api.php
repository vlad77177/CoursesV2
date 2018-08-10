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
    if(password_verify($data['password'], $user[0]['password'])==false){
        exit('Bad password');
    }
    $sa->SetSession($user[0]);
    exit(json_encode($user[0]));
}

$result=undefined;//результат
$userlog=undefined;
//проверка залогиненого пользователя
if($data['action']!=='getSession'){
    error_log(json_encode($data));
    $sec_cond=array(
        new Condition('login','=',$data['user']['login'])
    );
    $userlog=$exec->ExecuteQuery($sqlc->GetSelectSQLString('users',array(),$sec_cond));
    if($userlog!==FALSE){
        error_log(json_encode($userlog));
        if($data['user']['password']!==$userlog[0]['password']){
            exit('Bad password');
        }
    }
    else{
        exit();
    }
}

switch($data['action']){
    case "getSession":{
        $result=$sa->GetSession();
        break;
    }
    case "getUsers":{
        $raw_result=undefined;
        if($userlog[0]['administrator']==1){
            $raw_result=$exec->ExecuteQuery($sqlc->GetSelectSQLString('users',array(),array()));
        }
        if($userlog[0]['curator']==1){
            $sql='SELECT * FROM users WHERE id='.$userlog[0]['id'].
                    ' OR id IN (SELECT id_teacher FROM curator_teacher WHERE id_curator='.$userlog[0]['id'].
                    ') OR id IN (SELECT id_student FROM curator_student WHERE id_curator='.$userlog[0]['id'].
            ');';
            $raw_result=$exec->ExecuteQuery($sql);           
        }
        //добавочная логика
        $user_json='{"id":null,"login":null,"email":null,"administrator":false,"curator":false,"teacher":false,"student":false,"cur_students":[],"cur_teachers":[],"cur_courses":[],"teach_courses":[],"teach_students":[],"results":[],"learneds":[],"need_learns":[],"curator":null,"teachers":[],"courses":[]}';
        for($i=0;$i<count($raw_result);$i++){
            $res= json_decode($user_json);

            $res->id=$raw_result[$i]['id'];
            $res->login=$raw_result[$i]['login'];
            $res->email=$raw_result[$i]['email'];
            $res->administrator=$raw_result[$i]['administrator'];
            $res->curator=$raw_result[$i]['curator'];
            $res->teacher=$raw_result[$i]['teacher'];
            $res->student=$raw_result[$i]['student'];

            $r->cur_teachers=$exec->ExecuteQuery(
                    $sqlc->GetSelectSQLString(
                            'curator_teacher',
                            array('id_teacher'),
                            array(new Condition('id_curator','=',$result->id))
                            )
                    );
            if($r->cur_teachers===FALSE){
                $r->cur_teachers=array();
            }
            for($j=0;$j<count($r);$j++){
                $res->cur_teachers[count($res->cut_teachers)]=$r[$j]['id_teacher'];
            }

            $result[count($result)]=$res;
        }
        break;
    }
    case "getCourses":{
        break;
    }
}

exit(json_encode($result));

?>

