<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\'')); 
if($user['administrator']==0 and $user['curator']==0){
    exit();
}

$name='Новый курс';
$logo=0;

$res=mysqli_query($db,'INSERT INTO courses(name,logo) VALUES(\''.$name.'\','.$logo.')');
if($user['curator']==1){
    $res= mysqli_query($db,'INSERT INTO curator_course(id_curator,id_course) VALUES('.$user['id'].',(SELECT LAST_INSERT_ID()));');
}

exit();

?>

