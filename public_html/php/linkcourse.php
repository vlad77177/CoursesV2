<?php

session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0){
        exit();
    }
    
    $res= mysqli_query($db, 'INSERT INTO teacher_course(id_teacher,id_course) VALUES('.$data['teacher_id'].','.$data['course_id'].')');
    exit();
    
?>
