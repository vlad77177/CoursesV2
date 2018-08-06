<?php

session_start();

require 'db.php';

$data = json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\'')); 
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit();
}

$name='Новый урок';

$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$name.'\')');
$lastid=mysqli_insert_id($db);

$r = mysqli_fetch_assoc(mysqli_query($db,'SELECT MAX(number) AS number FROM lessons WHERE id_course='.$data['id'].''));
$n=$r['number']+1;

$res=mysqli_query($db,'INSERT INTO lessons(id_course,number,id_text,name) VALUES('.$data['id'].','.$n.','.$lastid.',\''.$name.'\')');

exit();

?>

