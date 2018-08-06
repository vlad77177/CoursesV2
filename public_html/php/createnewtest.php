<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$name='Новый тест';
$question="Текст первого вопроса";
$question_name="Первый вопрос";
$var1="Вариант 1";
$var2="Вариант 2";

$res=mysqli_query($db,'INSERT INTO tests(name) VALUES(\''.$name.'\')');
$lastid=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$question.'\')');
$lastidquestiontext=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO questions(id_test,number,id_text,name) VALUES('.$lastid.',1,'.$lastidquestiontext.',\''.$question_name.'\')');
$lastidquestion=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$var1.'\')');
$lastidvar1=mysqli_insert_id($db);
$res=$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$var2.'\')');
$lastidvar2=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO variants(id_question,number,id_text,isright) VALUES('.$lastidquestion.',1,'.$lastidvar1.',1)');
$res=$res=mysqli_query($db,'INSERT INTO variants(id_question,number,id_text,isright) VALUES('.$lastidquestion.',2,'.$lastidvar2.',0)');

exit();

?>

