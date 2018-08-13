<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0){
    exit(FALSE);
}

$deleted=false;
$id= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$data['id'].''));

if($user['administrator']==1){
    $res= mysqli_query($db, 'DELETE FROM variants WHERE id='.$data['id'].'');
    $deleted=true;
}
if($user['curator']==1){
    $res= mysqli_query($db, 'DELETE FROM variants WHERE id='.$data['id'].' AND id_question IN '
            . '(SELECT id FROM questions WHERE id_test IN '
            . '(SELECT id_test FROM curator_test WHERE id_curator='.$user['id'].'))');
    $deleted=true;
}
if($user['teacher']==1){
    $res= mysqli_query($db, 'DELETE FROM variants WHERE id='.$data['id'].' AND id_question IN '
            . '(SELECT id FROM questions WHERE id_test IN '
            . '(SELECT id FROM tests WHERE for_course_id IN '
            . '(SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].')))');
    $deleted=true;
}

if($deleted===true){
    $values= mysqli_query($db, 'SELECT * FROM variants WHERE id_question='.$id['id_question'].' ORDER BY number');
    $i=1;
    while($row=mysqli_fetch_assoc($values)){
        mysqli_query($db,'UPDATE variants SET number='.$i.' WHERE id='.$row['id'].'');
        $i++;
    }
}

exit();

?>

