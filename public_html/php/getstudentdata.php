<?php

session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    
    if($user['student']==0){
        exit(FALSE);
    }
    
    $res=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$user['id'].''));
    
    exit(json_encode($res));
?>
