<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0){
    exit(FALSE);
}

$res= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$data['id'].''));
//exit(json_encode($res));
$v=1;
if($res['isright']==1){
    $v=0;
}
$res=mysqli_query($db,'UPDATE variants SET isright='.$v.' WHERE id='.$data['id'].'');
    

?>

