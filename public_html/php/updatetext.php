<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['id']= mysqli_real_escape_string($db,$data['id']);
$data['text']= mysqli_real_escape_string($db,$data['text']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0){
    exit(FALSE);
}

$filter='';
if($user['curator']==1){
    $filter=' AND ('
            . 'id_text IN (SELECT id_text FROM course_description WHERE id_course IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].'))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM lessons WHERE id_course IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].'))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM questions WHERE id_test IN (SELECT id FROM tests WHERE for_course_id In (SELECT id_course FROM curator_course where id_curator='.$user['id'].')))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM variants WHERE id_question IN (SELECT id FROM questions WHERE id_test IN (SELECT id FROM tests WHERE for_course_id IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].'))))'
            . ')';
}
if($user['teacher']==1){
    $filter=' AND ('
            . 'id_text IN (SELECT id_text FROM course_description WHERE id_course IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].'))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM lessons WHERE id_course IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].'))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM questions WHERE id_test IN (SELECT id FROM tests WHERE for_course_id In (SELECT id_course FROM teacher_course where id_teacher='.$user['id'].')))'
            . ' OR '
            . 'id_text IN (SELECT id_text FROM variants WHERE id_question IN (SELECT id FROM questions WHERE id_test IN (SELECT id FROM tests WHERE for_course_id IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].'))))'
            . ')';
}

$res=mysqli_query($db,'UPDATE text SET text=\''.$data['text'].'\' WHERE id_text='.$data['id'].''.$filter.'');
error_log('UPDATE text SET text=\''.$data['text'].'\' WHERE id_text='.$data['id'].''.$filter.'');

exit();

?>