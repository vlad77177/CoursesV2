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
    
    $pass= password_hash($data['currentUser']['newpass'],PASSWORD_BCRYPT);
    if($user['administrator']){
        $res=mysqli_query($db,'UPDATE users SET login=\''.$data['currentUser']['login'].'\', password=\''.$pass.'\', email=\''.$data['currentUser']['email'].'\' WHERE id='.$data['currentUser']['id'].'');
    }
    if($user['curator']==1){
        $res=mysqli_query($db,'UPDATE users SET login=\''.$data['currentUser']['login'].'\', password=\''.$pass.'\', email=\''.$data['currentUser']['email'].'\' WHERE id='.$data['currentUser']['id'].' AND '
                . '(id IN (SELECT id_teacher FROM curator_teacher WHERE id_curator='.$user['id'].') OR '
                . ' id IN (SELECT id_student FROM curator_student WHERE id_curator='.$user['id'].') OR id='.$data['currentUser']['id'].')');
    }
    exit(TRUE);
?>

