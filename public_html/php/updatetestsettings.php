<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$query='UPDATE tests SET active='.$data['data']['active'].
        ', mix_q='.$data['data']['mix_q'].
        ', mix_var='.$data['data']['mix_var'].
        ', reload='.$data['data']['reload'].
        ', for_course_id='.$data['data']['for_course_id'].
        ', reload_try='.$data['data']['reload_try'].
        ', can_pass='.$data['data']['can_pass'].
        ', display_q='.$data['data']['display_q'].
        ', threshold='.$data['data']['threshold'].
        ', minute_on_pass='.$data['data']['minute_on_pass'].' WHERE id='.$data['data']['id'].'';

$res=mysqli_query($db,$query);

exit();

?>

