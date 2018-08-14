<?php

session_start();
    
require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$res= mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$data['uid'].'');
$result=null;
$i=0;

while($row = mysqli_fetch_assoc($res)){
    $result[$i]=$row;
    $i++;
}

exit(json_encode($result));

?>
