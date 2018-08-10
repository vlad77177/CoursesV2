<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0){
    exit(FALSE);
}

//удаляювопросы и вариатны ответов
$res=mysqli_query($db,'SELECT * FROM questions WHERE id_test='.$data['id'].'');
while($raw_result= mysqli_fetch_assoc($res)){
    $r = mysqli_query($db, 'DELETE FROM text WHERE id_text='.$raw_result['id_text']);
    $resv=mysqli_query($db,'SELECT * FROM variants WHERE id_question='.$raw_result['id']);
    while($rowv = mysqli_fetch_assoc($resv)){
        $r= mysqli_query($db, 'DELETE FROM text WHERE id_text='.$rowv['id_text']);
        $r=mysqli_query($db,'DELETE FROM variants WHERE id_question='.$rowv['id_question']);
    }
    $r= mysqli_query($db, 'DELETE FROM questions WHERE id_test='.$data['id']);
}

$res= mysqli_query($db, 'DELETE FROM tests WHERE id='.$data['id'].'');
mysqli_query($db,'DELETE FROM curator_test WHERE id_test='.$data['id'].'');

exit();

?>

