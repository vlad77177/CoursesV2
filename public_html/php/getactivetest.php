<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['student']==0){
    exit(FALSE);
}

$test=null;

$user_result= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM user_result WHERE user_id='.$data['uid'].' AND id_course='.$data['cid'].''));

if ($user_result['test_active'] == false) {
    exit(false);
}

$session= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM test_session_temp WHERE id='.$user_result['session_id'].''));

$test['seconds']=strtotime($session['date_end'])-time();
$test['session_id']=$user_result['session_id'];

$questions=mysqli_query($db,'SELECT * FROM gen_questions_temp WHERE id_gen_session='.$session['id'].'');
$q_count=0;
while($qrow= mysqli_fetch_assoc($questions)){
    $question= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM questions WHERE id='.$qrow['id_question'].''));
    $qtext=mysqli_fetch_assoc(mysqli_query($db, 'SELECT text FROM text WHERE id_text='.$question['id_text'].''));
    $test['questions'][$q_count]=$question;
    $test['questions'][$q_count]['text']=$qtext['text'];
    $test['questions'][$q_count]['number']=$qrow['number'];
    $test['questions'][$q_count]['ansver']=$qrow['ansver'];
    $test['questions'][$q_count]['id_session']=$qrow['id'];
    $test['questions'][$q_count]['ansvers']=array();
    
    if($qrow['ansver']==1){
        error_log('ANSVER');
        $qa_count=0;
        $ansvers=mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question='.$qrow['id'].'');
        while($qarow= mysqli_fetch_assoc($ansvers)){
            $test['questions'][$q_count]['ansvers'][$qa_count]=$qarow['ansver'];
            $qa_count++;
        }
    }
    
    $variants= mysqli_query($db, 'SELECT * FROM gen_variants_temp WHERE id_gen_question='.$qrow['id'].'');
    $v_count=0;
    while($vrow= mysqli_fetch_assoc($variants)){
        $variant=mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$vrow['id_variant'].''));
        $vtext=mysqli_fetch_assoc(mysqli_query($db, 'SELECT text FROM text WHERE id_text='.$variant['id_text'].''));
        //$test['questions'][$q_count]['variants'][$v_count]=$variant;
        $test['questions'][$q_count]['variants'][$v_count]['text']=$vtext['text'];
        $test['questions'][$q_count]['variants'][$v_count]['number']=$vrow['number'];
        $v_count++;
    }
    $q_count++;
}

exit(json_encode($test));

?>

