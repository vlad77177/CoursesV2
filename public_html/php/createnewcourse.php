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
$description='Введите краткое описание курса';
$lessonname="Новый урок";
$lessoncontent="Введите содержимое урока";

$res=mysqli_query($db,'INSERT INTO courses(name,logo) VALUES(\''.$name.'\','.$logo.')');
$lastid=mysqli_insert_id($db);
if($user['curator']==1){
    mysqli_query($db,'INSERT INTO curator_course(id_curator,id_course) VALUES('.$user['id'].','.$lastid.')');
}

$res=$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$description.'\')');
$lastiddesc=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$lessoncontent.'\')');
$lastidlessoncontent=mysqli_insert_id($db);

$res=$res=mysqli_query($db,'INSERT INTO lessons(id_course,number,id_text,name) VALUES('.$lastid.',1,'.$lastidlessoncontent.',\''.$lessonname.'\')');
$res=$res=mysqli_query($db,'INSERT INTO course_description(id_course,id_text) VALUES('.$lastid.','.$lastiddesc.')');

exit();

?>

