<?php

session_start();
    
require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$res= mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$data['uid'].'');
$result=null;
$i=0;

while($raw_result = mysqli_fetch_assoc($res)){
    $result[$i]=$raw_result;
    $i++;
}

exit(json_encode($result));

?>
