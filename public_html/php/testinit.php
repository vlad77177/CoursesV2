<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);
$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

//получаю данные теста
$test= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM tests WHERE for_course_id='.$data['cid'].''));
//вычисляю дату начала и завершения теста
$date_start=time();
$date_end=$date_start+60*$test['minute_on_pass'];
$date_start=date('Y-m-d H:i:s',$date_start);
$date_end=date('Y-m-d H:i:s',$date_end);
//запись сессии
$res=mysqli_query($db,'INSERT INTO test_session_temp(date_start,date_end,try_counter) VALUES(\''.$date_start.'\',\''.$date_end.'\',0)');
$session_id=mysqli_insert_id($db);//id-сессии
//обновляю статус обучения пользователя
$res= mysqli_query($db, 'UPDATE user_result SET test_id='.$test['id'].', test_active=1, session_id='.$session_id.' WHERE user_id='.$user['id'].'');

//получаю вопросы, создаю массив всех вопросов, их общее колличество
$questions_result=mysqli_query($db,'SELECT * FROM questions WHERE id_test='.$test['id'].' ORDER BY number');
$questions_all=null;
$q_count_all=0;
while($qrow = mysqli_fetch_assoc($questions_result)){
    $questions_all[$q_count_all]=$qrow;
    $q_count_all++;
}

$questions=null;
$unused_numbers=null;
for($i=0;$i<count($questions_all);$i++){
    $unused_numbers[$i]=$i;
}

for($i=0;$i<count($questions_all);$i++){
    //случайно выбираю вопросы
    $r=null;
    if($test['mix_q']==true){
        if((count($questions_all)-1)>0){
            $r=rand(0,count($unused_numbers)-1);
        }
        else{
            $r=0;
        }
    }
    else{
        $r=$i;
    }
    $questions[$i]=$questions_all[$unused_numbers[$r]];
    $questions[$i]['number']=$i+1;
    if($test['mix_q']==true){
        $unused_numbers_keep=null;
        $key_keep=$unused_numbers[$r];
        for($k=0;$k<count($unused_numbers);$k++){
            $unused_numbers_keep[$k]=$unused_numbers[$k];
        }
        $unused_numbers=null;
        for($k=0,$n=0;$k<count($unused_numbers_keep);$k++){
            if($unused_numbers_keep[$k]!=$key_keep){
                $unused_numbers[$n]=$unused_numbers_keep[$k];
                $n++;
            }
        }
        //exit(json_encode($unused_numbers));ok
    }
    //запись сессии
    $res= mysqli_query($db, 'INSERT INTO gen_questions_temp(id_gen_session,id_question,number,ansver) VALUES('.$session_id.
            ','.$questions[$i]['id'].
            ','.$questions[$i]['number'].
            ',0)');
    $session_question_id= mysqli_insert_id($db);
    //случайно выбираю варианты
        
    $variants_result=mysqli_query($db,'SELECT * FROM variants WHERE id_question='.$questions[$i]['id'].' ORDER BY number');
    $variants_all=null;
    $v_count=0;
    while($vrow = mysqli_fetch_assoc($variants_result)){
        $variants_all[$v_count]=$vrow;
        $v_count++;
    }
    //exit(json_encode(count($variants_all)));ok
    $unused_numbers_v=null;
    for($l=0;$l<count($variants_all);$l++){
        $unused_numbers_v[$l]=$l;
    }
    
    for($j=0;$j<count($variants_all);$j++){
        $r=null;
        if($test['mix_var']==true){
            if((count($variants_all)-1)>0){
                $r=rand(0,count($unused_numbers_v)-1);
            }
            else{
                $r=0;
            }
        }
        else{
            $r=$j;
        }
        $questions[$i]['variants'][$j]=$variants_all[$unused_numbers_v[$r]];
        $questions[$i]['variants'][$j]['number']=$j+1;
        if($test['mix_var']==true){
            $unused_numbers_keep_v=null;
            $key_keep_v=$unused_numbers_v[$r];
            for($k=0;$k<count($unused_numbers_v);$k++){
                $unused_numbers_keep_v[$k]=$unused_numbers_v[$k];
            }
            $unused_numbers_v=null;
            for($k=0,$n=0;$k<count($unused_numbers_keep_v);$k++){
                if($unused_numbers_keep_v[$k]!=$key_keep_v){
                    $unused_numbers_v[$n]=$unused_numbers_keep_v[$k];
                    $n++;
                }
            }
        }
        $res=mysqli_query($db,'INSERT INTO gen_variants_temp(id_gen_question,id_variant,number) VALUES('.$session_question_id.
                ','.$questions[$i]['variants'][$j]['id'].
                ','.$questions[$i]['variants'][$j]['number'].')');
    }
}

exit(json_encode($questions));

?>

