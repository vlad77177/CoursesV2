<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['student']==0){
    exit(FALSE);
}

$res=mysqli_query($db,'UPDATE gen_questions_temp SET ansver=1 WHERE id='.$data['qsid'].' AND number='.$data['number'].' AND id_gen_session IN (SELECT id FROM test_session_tmp WHERE id=(SELECT session_id FROM user_result WHERE user_id='.$user['id'].'))');
$res=mysqli_query($db,'INSERT INTO gen_questions_ansver_temp(id_gen_question,ansver) VALUES('.$data['qsid'].','.$data['ansver'].')');

exit(json_encode($data));

?>

