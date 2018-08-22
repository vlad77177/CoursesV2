<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);
    
    $data['newUser']['password']= mysqli_real_escape_string($db,$data['newUser']['password']);
    $data['newUser']['user_type']= mysqli_real_escape_string($db,$data['newUser']['user_type']);
    $data['newUser']['login']= mysqli_real_escape_string($db,$data['newUser']['login']);
    $data['newUser']['name']= mysqli_real_escape_string($db,$data['newUser']['name']);
    $data['newUser']['surname']= mysqli_real_escape_string($db,$data['newUser']['surname']);
    $data['newUser']['email']= mysqli_real_escape_string($db,$data['newUser']['email']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0){
        exit(FALSE);
    }

    
    $pass= password_hash($data['newUser']['password'], PASSWORD_BCRYPT);
    
    $query='INSERT INTO users(login,name,surname,password,email,';
    switch($data['newUser']['user_type']){
        case 1:{
            $query=$query.'curator';
            break;
        }
        case 2:{
            $query=$query.'teacher';
            break;
        }
        case 3:{
            $query=$query.'student';
            break;
        }
    }
    $query=$query.') VALUES(\''.$data['newUser']['login'].'\',\''.$data['newUser']['name'].'\',\''.$data['newUser']['surname'].'\',\''.$pass.'\',\''.$data['newUser']['email'].'\',1);';
    
    $query= mysqli_query($db,$query);
    $last_id=mysqli_insert_id($db);
    
    if($user['curator']==1){
        switch($data['newUser']['user_type']){
            case 2:{
                $res=mysqli_query($db,'INSERT INTO curator_teacher(id_curator,id_teacher) VALUES('.$user['id'].','.$last_id.')');
                break;
            }
            case 3:{
                $res=mysqli_query($db,'INSERT INTO curator_student(id_curator,id_student) VALUES('.$user['id'].','.$last_id.')');
                break;
            }
        }
    }
    
    exit($query);
?>


