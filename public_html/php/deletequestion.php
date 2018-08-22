<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['id']= mysqli_real_escape_string($db,$data['id']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0){
    exit(FALSE);
}


//удаляю вопрос
if($user['administrator']==1){
    $res=mysqli_query($db,'DELETE FROM questions WHERE id='.$data['id'].'');
}
if($user['curator']==1){
    $res=mysqli_query($db,'DELETE FROM questions WHERE id='.$data['id'].' AND id_test IN (SELECT id_test FROM curator_test WHERE id_curator='.$user['id'].')');   
}
if($user['teacher']==1){
    $res=mysqli_query($db,'DELETE FROM questions WHERE id='.$data['id'].' AND id_test IN '
            . '(SELECT id FROM tests WHERE for_course_id IN '
            . '(SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].'))');   
}

exit();

?>

