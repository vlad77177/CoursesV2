<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$data['sid']= mysqli_real_escape_string($db,$data['sid']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['student']==0){
    exit(FALSE);
}

$visit=date('Y-m-d H:i:s',time());
mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');

$result['score']=null;
$result['all']=null;
$result['threshold']=null;

$result_counter=0;

$session= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM test_session_temp WHERE id='.$data['sid'].' AND id IN (SELECT session_id FROM user_result WHERE user_id='.$user['id'].')'));
$user_result=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM user_result WHERE session_id='.$data['sid'].''));
$questions=mysqli_query($db,'SELECT * FROM gen_questions_temp WHERE id_gen_session='.$data['sid'].' ORDER BY number');

//$res= mysqli_query($db, 'DELETE FROM gen_questions_temp WHERE id_gen_session='.$data['sid'].'');

$q_count=0;
while($qrow= mysqli_fetch_assoc($questions)){
    
    
    $v_count=0;
    $variants=null;
    $variants_session=mysqli_query($db,'SELECT * FROM gen_variants_temp WHERE id_gen_question='.$qrow['id'].' ORDER BY number');
    
    while($vrow=mysqli_fetch_assoc($variants_session)){
        $variants[$v_count]= mysqli_fetch_assoc(mysqli_query($db, 'SELECT * FROM variants WHERE id='.$vrow['id_variant'].''));
        $v_count++;
    }
    
    $qa_count=0;
    $qansvers=mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question='.$qrow['id'].'');
    
    $qansv_arr=array();
    while($qarow=mysqli_fetch_assoc($qansvers)){
        $qansv_arr[count($qansv_arr)]=$qarow;
    }
    
    $system_ansvers=0;
    $user_ansvers=0;
    
    for($i=0;$i<count($variants);$i++){
        if($variants[$i]['isright']==true){
            $system_ansvers++;
            for($j=0;$j<count($qansv_arr);$j++){
                if($qansv_arr[$j]['ansver']==$i+1){
                    $user_ansvers++;
                }
            }
        }        
    }
    
    if($system_ansvers===$user_ansvers){
        $result_counter++;
    }
    
    $q_count++;
}

$res= mysqli_query($db,'UPDATE user_result SET test_active=0, test_result='.$result_counter.' WHERE session_id='.$data['sid'].'');

//запись в историю тестов

$test=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM tests WHERE id='.$user_result['test_id'].''));

mysqli_query($db,'INSERT INTO test_history(user_id,name,data_start,data_end,time_limit,question_count,threshold,answers) VALUES('.$user['id'].
        ',\''.$test['name'].
        '\',\''.$session['date_start'].
        '\',\''.date('Y-m-d H:i:s',time()).
        '\','.$test['minute_on_pass'].
        ','.$q_count.
        ','.$test['threshold'].
        ','.$result_counter.')');

$last_id_h=mysqli_insert_id($db);

$questions=mysqli_query($db,'SELECT * FROM gen_questions_temp WHERE id_gen_session='.$data['sid'].' ORDER BY number');

while($q= mysqli_fetch_assoc($questions)){
    $text= mysqli_fetch_assoc(mysqli_query($db,'SELECT text FROM text WHERE id_text IN (SELECT id_text FROM questions WHERE id='.$q['id_question'].')'));
    mysqli_query($db,'INSERT INTO test_history_questions(id_history,number,text) VALUES('.$last_id_h.','.$q['number'].',\''.$text['text'].'\')');
    $last_id_q= mysqli_insert_id($db);
    
    $variants=mysqli_query($db,'SELECT * FROM gen_variants_temp WHERE id_gen_question='.$q['id'].' ORDER BY number');
    
    $qansvers=mysqli_query($db,'SELECT * FROM gen_questions_ansver_temp WHERE id_gen_question='.$q['id'].'');
    
    $qansv_arr=array();
    while($qarow=mysqli_fetch_assoc($qansvers)){
        $qansv_arr[count($qansv_arr)]=$qarow;
    }
    
    while($v= mysqli_fetch_assoc($variants)){
        $text= mysqli_fetch_assoc(mysqli_query($db,'SELECT text FROM text WHERE id_text IN (SELECT id_text FROM variants WHERE id='.$v['id_variant'].')'));
        $var=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM variants WHERE id='.$v['id_variant'].''));
        
        $ans=0;
        for($i=0;$i<count($qansv_arr);$i++){
            //error_log($qansv_arr[$i]['ansver'].'='.$v['number']);
            if($qansv_arr[$i]['ansver']==$v['number']){                
                $ans=1;
                break;
            }
        }
        //error_log('---');
        
        mysqli_query($db,'INSERT INTO test_history_variants(id_question,text,number,isright,answer) VALUES('.$last_id_q.',\''.$text['text'].'\','.$v['number'].','.$var['isright'].','.$ans.')');
    }
}


//конец записи

$res= mysqli_query($db, 'DELETE FROM test_session_temp WHERE id='.$data['sid'].'');

$result['score']=$result_counter;
$result['all']=$test['display_q'];
$result['threshold']=$test['threshold'];

exit(json_encode($result));

?>

