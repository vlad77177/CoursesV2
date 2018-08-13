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
        $result=array();
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
        if($userlog[0]['teacher']==1){
            $sql='SELECT * FROM users WHERE id='.$userlog[0]['id'].
                    ' OR id IN (SELECT user_id FROM user_result WHERE id_course IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$userlog[0]['id'].'));';
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
            
            if($res->curator==1){
                
                $r=$exec->ExecuteQuery(
                        $sqlc->GetSelectSQLString(
                                'curator_teacher',
                                array('id_teacher'),
                                array(new Condition('id_curator','=',$res->id))
                                )
                        );
                if($r===FALSE){
                    $res->cur_teachers=array();
                }
                else{
                    for($j=0;$j<count($r);$j++){
                        $res->cur_teachers[count($res->cur_teachers)]=$r[$j]['id_teacher'];
                    }
                }
                
                $r=$exec->ExecuteQuery(
                        $sqlc->GetSelectSQLString(
                                'curator_student',
                                array('id_student'),
                                array(new Condition('id_curator','=',$res->id))
                                )
                        );
                if($r===FALSE){
                    $res->cur_students=array();
                }
                else{
                    for($j=0;$j<count($r);$j++){
                        $res->cur_students[count($res->cur_students)]=$r[$j]['id_student'];
                    }
                }
                
                $r=$exec->ExecuteQuery(
                        $sqlc->GetSelectSQLString(
                                'curator_course',
                                array('id_course'),
                                array(new Condition('id_curator','=',$res->id))
                                )
                        );
                if($r===FALSE){
                    $res->cur_courses=array();
                }
                else{
                    for($j=0;$j<count($r);$j++){
                        $res->cur_courses[count($res->cur_courses)]=$r[$j]['id_course'];
                    }
                }
                
            }
            
            if($res->teacher==1){
                
                $r=$exec->ExecuteQuery(
                        $sqlc->GetSelectSQLString(
                                'teacher_course',
                                array('id_course'),
                                array(new Condition('id_teacher','=',$res->id))
                                )
                        );
                if($r===FALSE){
                    $res->teach_courses=array();
                }
                else{
                    for($j=0;$j<count($r);$j++){
                        $res->teach_courses[count($res->teach_courses)]=$r[$j]['id_course'];
                    }
                }
                
            }
            
            if($res->student==1){
                
                $rc=$exec->ExecuteQuery(
                        $sqlc->GetSelectSQLString(
                                'user_result',
                                array('id_course'),
                                array(new Condition('user_id','=',$res->id))
                                )
                        );
                for($j=0;$j<count($rc);$j++){
                    $res->courses[count($res->courses)]=$rc[$j]['id_course'];
                    $res->results[count($res->results)]=$rc[$j]['test_result'];
                    $res->learneds[count($res->learneds)]=$rc[$j]['learned'];

                    $r=$exec->ExecuteQuery(
                            $sqlc->GetSelectSQLString(
                                    'user_result',
                                    array('COUNT(*) AS count'),
                                    array(new Condition('id_course','=',$rc[$j]['id_course']))
                                    )
                            );
                    $res->need_learns[count($res->need_learns)]=$r[0]['count'];

                    $r=$exec->ExecuteQuery(
                            $sqlc->GetSelectSQLString(
                                    'teacher_course',
                                    array(),
                                    array(new Condition('id_course','=',$rc[$j]['id_course']))
                                    )
                            );
                    for($k=0;$k<count($r);$k++){
                        $res->teachers[count($res->teachers)]=$r[$k]['id_teacher'];
                    }                 
                }
                
            }
            
            $result[count($result)]= $res;
        }
        break;
    }
    case "getCourses":{
        
        $res=undefined;
        
        if($userlog[0]['administrator']){
            $res=$exec->ExecuteQuery($sqlc->GetSelectSQLString('courses',array(),array()));
        }
        if($userlog[0]['curator']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM courses WHERE id IN (SELECT id_course FROM curator_course WHERE id_curator='.$userlog[0]['id'].');'
                    );
        }
        if($userlog[0]['teacher']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM courses WHERE id IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$userlog[0]['id'].');'
                    );
        }
        if($userlog[0]['student']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM courses WHERE id IN (SELECT id_course FROM user_result WHERE user_id='.$userlog[0]['id'].');'
                    );
        }
        
        $result=$res;
        
        break;
    }
    
    case "getTests":{
        
        $res=undefined;
        
        if($userlog[0]['administrator']){
            $res=$exec->ExecuteQuery($sqlc->GetSelectSQLString('tests',array(),array()));
        }
        if($userlog[0]['curator']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM tests WHERE id IN (SELECT id_test FROM curator_test WHERE id_curator='.$userlog[0]['id'].');'
                    );
        }
        if($userlog[0]['teacher']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM tests WHERE id IN '
                    . '(SELECT id_test FROM curator_test WHERE id_curator IN '
                    . '(SELECT id_curator FROM curator_teacher WHERE id_teacher='.$userlog[0]['id'].'));'
                    );
        }
        if($userlog[0]['student']==1){
            $res=$exec->ExecuteQuery(
                    'SELECT * FROM tests WHERE id IN (SELECT test_id FROM user_result WHERE user_id='.$userlog[0]['id'].');'
                    );
        }
        
        $result=$res;
        
        break;
    }
    
    case 'getStudentData':{
        if($userlog[0]['student']){
            $result=$exec->ExecuteQuery($sqlc->GetSelectSQLString('user_result', array()));
        }
        break;
    }
    
    case 'getActiveTest':{
        if($userlog[0]['student']){
            $test=null;

            $user_result= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM user_result WHERE user_id='.$data['uid'].' AND id_course='.$data['cid'].''));

            if ($user_result['test_active'] == false) {
                exit(false);
            }

            $session= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM test_session_temp WHERE id='.$user_result['session_id'].''));

            $test['seconds']=strtotime($session['date_end'])-time();
            $test['session_id']=$user_result['session_id'];

            $questions=mysqli_query($db,'SELECT * FROM gen_questions_temp WHERE id_gen_session='.$session['id'].'');
            $q_count=0;
            while($qrow= mysqli_fetch_assoc($questions)){
                $question= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM questions WHERE id='.$qrow['id_question'].''));
                $qtext=mysqli_fetch_assoc(mysqli_query($db, 'SELECT text FROM text WHERE id_text='.$question['id_text'].''));
                $test['questions'][$q_count]=$question;
                $test['questions'][$q_count]['text']=$qtext['text'];
                $test['questions'][$q_count]['number']=$qrow['number'];
                $test['questions'][$q_count]['ansver']=$qrow['ansver'];
                $test['questions'][$q_count]['id_session']=$qrow['id'];
                $test['questions'][$q_count]['ansvers']=array();

                if($qrow['ansver']==1){
                    $qa_count=0;
                    $ansvers=mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question='.$qrow['id'].'');
                    while($qarow= mysqli_fetch_assoc($ansvers)){
                        $test['questions'][$q_count]['ansvers'][$qa_count]=$qarow;
                        $qa_count++;
                    }
                }

                $variants= mysqli_query($db, 'SELECT * FROM gen_variants_temp WHERE id_gen_question='.$qrow['id'].'');
                $v_count=0;
                while($vrow= mysqli_fetch_assoc($variants)){
                    $variant=mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$vrow['id_variant'].''));
                    $vtext=mysqli_fetch_assoc(mysqli_query($db, 'SELECT text FROM text WHERE id_text='.$variant['id_text'].''));
                    $test['questions'][$q_count]['variants'][$v_count]['text']=$vtext['text'];
                    $test['questions'][$q_count]['variants'][$v_count]['number']=$vrow['number'];
                    $v_count++;
                }
                $q_count++;
            }

            $result=$test;
        }
        break;
    }
}

exit(json_encode($result));

?>

