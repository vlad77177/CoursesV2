<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0){
        exit(FALSE);
    }
    
    $pass= password_hash($data['currentUser']['newpass'],PASSWORD_BCRYPT);
    $res=mysqli_query($db,'UPDATE users SET login=\''.$data['currentUser']['login'].'\', password=\''.$pass.'\', email=\''.$data['currentUser']['email'].'\' WHERE id='.$data['currentUser']['id'].'');
    
    exit(TRUE);
?>

