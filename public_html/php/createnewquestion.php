<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['data']= mysqli_real_escape_string($db,$data['data']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0){
    exit(FALSE);
}

if($user['administrator']==1){
    $res= mysqli_query($db, 'INSERT INTO questions(id_test) VALUES('.$data['data'].')');
}
if($user['curator']==1){
    $res= mysqli_query($db,'SELECT * FROM curator_test WHERE id_test='.$data['data'].' AND id_curator='.$user['id'].'');
    if($res!==FALSE){
        $res= mysqli_query($db, 'INSERT INTO questions(id_test) VALUES('.$data['data'].')');
    }
}
if($user['teacher']==1){
    $res= mysqli_query($db,'SELECT * FROM teacher_course WHERE id_teacher='.$user['id'].' AND id_course=(SELECT for_course_id FROM tests WHERE id='.$data['data'].')');
    if($res!==FALSE){
        $res= mysqli_query($db, 'INSERT INTO questions(id_test) VALUES('.$data['data'].')');
    }
}

echo json_encode(mysqli_insert_id($db));

exit();

?>

