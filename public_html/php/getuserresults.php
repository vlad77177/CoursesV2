<?php

session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);
    
    $data['id']= mysqli_real_escape_string($db,$data['id']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
        exit(FALSE);
    }
    
    $visit=date('Y-m-d H:i:s',time());
    mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');
    
    $res= json_decode('{"sessions":[]}');
    $res=new stdClass();
    
    $session_history= mysqli_query($db,'SELECT * FROM test_history WHERE user_id='.$data['id'].'');
    $s_count=0;
    while($s=mysqli_fetch_assoc($session_history)){
        $sobj=new stdClass();
        
        $sobj->id=$s['id'];
        $sobj->user_id=$s['user_id'];
        $sobj->name=$s['name'];
        $sobj->data_start=$s['data_start'];
        $sobj->data_end=$s['data_end'];
        $sobj->time_limit=$s['time_limit'];
        $sobj->question_count=$s['question_count'];
        $sobj->threshold=$s['threshold'];
        $sobj->answers=$s['answers'];
        $sobj->questions=array();
        
        $res->sessions[$s_count]=$sobj;
               
        $question_history= mysqli_query($db,'SELECT * FROM test_history_questions WHERE id_history='.$s['id'].'');
        $q_count=0;
        while($q=mysqli_fetch_assoc($question_history)){
            $qobj=new stdClass();
            
            $qobj->id=$q['id'];
            $qobj->number=$q['number'];
            $qobj->text=$q['text'];
            $qobj->variants=array();
            
            $res->sessions[$s_count]->questions[$q_count]=$qobj;
                       
            $variants_history= mysqli_query($db,'SELECT * FROM test_history_variants WHERE id_question='.$q['id'].'');
            $v_count=0;
            while($v=mysqli_fetch_assoc($variants_history)){
                $res->sessions[$s_count]->questions[$q_count]->variants[$v_count]=$v;
                $v_count++;
            }
            
            $q_count++;
        }
        
        $s_count++;
    }   
    
    exit(json_encode($res));
?>

