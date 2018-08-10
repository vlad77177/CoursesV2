<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0){
    exit(FALSE);
}

$name='Новый тест';
$question="Текст первого вопроса";
$question_name="Вопрос 1";
$var1="Вариант 1";
$var2="Вариант 2";

$res=mysqli_query($db,'INSERT INTO tests(name) VALUES(\''.$name.'\')');

$lastid=mysqli_insert_id($db);

if($user['curator']==1){
    mysqli_query($db,'INSERT INTO curator_test(id_curator,id_test) VALUES('.$user['id'].','.$lastid.')');
}

exit();

?>

