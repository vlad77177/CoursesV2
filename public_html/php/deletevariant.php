<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0){
    exit(FALSE);
}

$res=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM variants WHERE id='.$data['id'].''));
$res=mysqli_query($db,'DELETE FROM text WHERE id_text='.$res['id_text'].'');
$res= mysqli_query($db, 'DELETE FROM variants WHERE id='.$data['id'].'');

exit();

?>

