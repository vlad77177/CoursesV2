<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$id_q=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM variants WHERE id='.$data['id'].''));
$res= mysqli_query($db, 'DELETE FROM variants WHERE id='.$data['id'].'');

$res=mysqli_query($db,'SELECT * FROM variants WHERE id_question='.$id_q['id_question'].' ORDER BY number ASC');
$i=1;
while($row= mysqli_fetch_assoc($res)){
    $r=mysqli_query($db,'UPDATE variants SET number='.$i.' WHERE id='.$row['id'].'');
    $i++;
}

exit();

?>

