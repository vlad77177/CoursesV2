<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['question']= mysqli_real_escape_string($db,$data['question']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0){
    exit(FALSE);
}

$visit=date('Y-m-d H:i:s',time());
mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');

if($user['administrator']==1){
    $res=mysqli_query($db,'INSERT INTO variants(id_question) VALUES('.$data['question'].')');
}
if($user['curator']==1){
    $res= mysqli_query($db,'SELECT * FROM curator_test WHERE id_test IN (SELECT id_test FROM questions WHERE id='.$data['question'].') AND id_curator='.$user['id'].'');
    if($res!==FALSE){
        $res=mysqli_query($db,'INSERT INTO variants(id_question) VALUES('.$data['question'].')');
    }
}
if($user['teacher']==1){
    $res= mysqli_query($db,'SELECT * FROM teacher_course WHERE id_teacher='.$user['id'].' AND id_course IN '
            . '(SELECT for_course_id FROM tests WHERE id IN '
            . '(SELECT id_test FROM questions WHERE id='.$data['question'].'))');
    if($res!==FALSE){
        $res=mysqli_query($db,'INSERT INTO variants(id_question) VALUES('.$data['question'].')');
    }
}

exit();

?>
