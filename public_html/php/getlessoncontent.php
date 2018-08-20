<?php

require 'db.php';

$data = json_decode(file_get_contents('php://input'),true);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));

if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit();
}

$filter='';
if($user['curator']==1){
    $filter=' AND id_course IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].')';
}
if($user['teacher']==1){
    $filter=' AND id_course IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].')';
}
if($user['student']==1){
    $filter=' AND id_course IN (SELECT id_course FROM user_result WHERE user_id='.$user['id'].')';
}
$res=mysqli_fetch_assoc(mysqli_query($db,'SELECT id_text FROM lessons WHERE id='.$data['lid'].' AND id_course='.$data['cid'].''.$filter.''));

if($res['id_text']==0){
    $val='Вы еще не создали текст урока!';
    $res2=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$val.'\')');
    $res2=mysqli_fetch_assoc(mysqli_query($db,'SELECT LAST_INSERT_ID()'));
    $res3=mysqli_query($db,'UPDATE lessons SET id_text='.$res2['LAST_INSERT_ID()'].' WHERE id='.$data['lid'].' AND id_course='.$data['cid'].'');
    $res=mysqli_fetch_assoc(mysqli_query($db,'SELECT id_course,id AS id_lesson,lessons.id_text, text FROM lessons INNER JOIN text ON lessons.id_text=text.id_text WHERE id='.$data['lid'].' AND id_course='.$data['cid'].''));
}
else{
    if($user['student']==1){
        $user_result=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$user['id'].''));
        $less=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM lessons WHERE id='.$data['lid'].''));
        if($less['number']>$user_result['lessons_learned']){
            $r=mysqli_query($db,'UPDATE user_result SET lessons_learned='.($user_result['lessons_learned']+1).' WHERE user_id='.$user['id'].'');
        }
    }
    $res=mysqli_fetch_assoc(mysqli_query($db,'SELECT id_course,id AS id_lesson,lessons.id_text,text FROM lessons INNER JOIN text ON lessons.id_text=text.id_text WHERE id='.$data['lid'].' AND id_course='.$data['cid'].''));
}



echo json_encode($res);

?>

