<?php

session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0){
        exit(FALSE);
    }
    
    if($user['curator']==1){
        $res= mysqli_query($db, 'SELECT * FROM curator_course WHERE id_course='.$data['course_id'].' AND id_curator='.$user['id'].'');
        if($res===FALSE){
            exit(FALSE);
        }
    }
    
    $res= mysqli_query($db, 'INSERT INTO teacher_course(id_teacher,id_course) VALUES('.$data['teacher_id'].','.$data['course_id'].')');
    exit();
    
?>
