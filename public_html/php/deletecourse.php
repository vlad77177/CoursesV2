<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));   
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit();
}

$res= mysqli_query($db, 'DELETE FROM courses WHERE id='.$data['id']);

exit();

?>

