<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$result['score']=null;
$result['all']=null;
$result['threshold']=null;

$result_counter=0;

$session= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM test_session_temp WHERE id='.$data['sid'].''));
$user_result=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM user_result WHERE session_id='.$data['sid'].''));
$questions=mysqli_query($db,'SELECT * FROM gen_questions_temp WHERE id_gen_session='.$data['sid'].' ORDER BY number');
$res= mysqli_query($db, 'DELETE FROM gen_questions_temp WHERE id_gen_session='.$data['sid'].'');

$q_count=0;
while($qrow= mysqli_fetch_assoc($questions)){
    $v_count=0;
    $variants=null;
    $variants_session=mysqli_query($db,'SELECT * FROM gen_variants_temp WHERE id_gen_question='.$qrow['id'].' ORDER BY number');
    $res= mysqli_query($db, 'DELETE FROM gen_variants_temp WHERE id_gen_question='.$qrow['id'].'');
    
    while($vrow=mysqli_fetch_assoc($variants_session)){
        $variants[$v_count]= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$vrow['id_variant'].''));
        $v_count++;
    }
    
    $qa_count=0;
    $qansvers=mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question='.$qrow['id'].'');
    $res= mysqli_query($db, 'DELETE FROM gen_questions_ansver_temp WHERE id_gen_question='.$qrow['id'].'');
    
    $result_enable=false;
    $ansver_count=0;
    $right_ansver_count=0;
    while($qarow= mysqli_fetch_assoc($qansvers)){
        for($i=0;$i<count($variants);$i++){
            if($variants[$i]['isright']==true){
                if($qarow['ansver']==$i+1){
                    $result_enable=true;
                    $right_ansver_count++;
                }
                $ansver_count++;
            }
        }
    }
    if($result_enable==true && $ansver_count==$right_ansver_count){
        $result_counter++;
    }
    
}

$res= mysqli_query($db,'UPDATE user_result SET test_active=0, test_result='.$result_counter.' WHERE session_id='.$data['sid'].'');
$res= mysqli_query($db, 'DELETE FROM test_session_temp WHERE id='.$data['sid'].'');

$test=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM tests WHERE id='.$user_result['test_id'].''));

$result['score']=$result_counter;
$result['all']=$test['display_q'];
$result['threshold']=$test['threshold'];

exit(json_encode($result));

?>

