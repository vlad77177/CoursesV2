<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['qsid']= mysqli_real_escape_string($db,$data['qsid']);
$data['number']= mysqli_real_escape_string($db,$data['number']);
$data['ansver']= mysqli_real_escape_string($db,$data['ansver']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['student']==0){
    exit(FALSE);
}

//$res=mysqli_query($db,'UPDATE gen_questions_temp SET ansver=1 WHERE id='.$data['qsid'].' AND number='.$data['number'].' AND id_gen_session IN (SELECT id FROM test_session_tmp WHERE id IN (SELECT session_id FROM user_result WHERE user_id='.$user['id'].'))');
$res=mysqli_query($db,'UPDATE gen_questions_temp SET ansver=1 WHERE id='.$data['qsid'].' AND number='.$data['number'].'');
$exist= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question IN (SELECT id FROM gen_questions_temp WHERE id='.$data['qsid'].' AND number='.$data['number'].') AND ansver='.$data['ansver'].''));
if(count($exist)>0){
    mysqli_query($db,'DELETE FROM gen_questions_ansver_temp WHERE id_gen_question='.$data['qsid'].'');
    exit();
}
$res=mysqli_query($db,'INSERT INTO gen_questions_ansver_temp(id_gen_question,ansver) VALUES('.$data['qsid'].','.$data['ansver'].')');

exit();

?>

