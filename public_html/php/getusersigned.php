<?php

session_start();
    
require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['uid']= mysqli_real_escape_string($db,$data['uid']);

if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$visit=date('Y-m-d H:i:s',time());
mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');

$res= mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$data['uid'].'');
$result=null;
$i=0;

while($row = mysqli_fetch_assoc($res)){
    $result[$i]=$row;
    $i++;
}

exit(json_encode($result));

?>
