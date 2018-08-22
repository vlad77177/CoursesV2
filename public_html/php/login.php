<?php
    session_start();
    
    require 'db.php';
       
    $user= json_decode(file_get_contents('php://input'),true);
    
    $user['login']= mysqli_real_escape_string($db,$user['login']);
    
    $res= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM users WHERE login=\''.$user['login'].'\''));
    
    if(password_verify($user['password'], $res['password'])==true){
        if(isset($res['login']) and isset($res['password'])){  
            $_SESSION['login']=$res['login'];
            $_SESSION['password']= $res['password'];
            $_SESSION['administrator']=$res['administrator'];
            $_SESSION['id']=$res['id'];
            $_SESSION['curator']=$res['curator'];
            $_SESSION['teacher']=$res['teacher'];
            $_SESSION['student']=$res['student'];
            
            $visit=date('Y-m-d H:i:s',time());
            mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$user['login'].'\'');
            
            echo 'Вы вошли!';
        }
        else{
            echo 'Проверьте введенные данные!';
        }
    }
    
    
    
?>

