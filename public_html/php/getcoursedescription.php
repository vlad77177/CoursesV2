<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));   
    if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
        exit();
    }
    
    $filter='';
    if($user['curator']==1){
        $filter=' AND id_course IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].')';
    }
    if($user['teacher']==1){
        $filter=' AND id_course IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].')';
    }
    if($user['student']==1){
        $filter=' AND id_course IN (SELECT id_course FROM user_result WHERE user_id='.$user['id'].')';
    }
    
    $res=mysqli_fetch_assoc(mysqli_query($db,'SELECT id_course, text.id_text, text FROM course_description INNER JOIN text ON course_description.id_text=text.id_text WHERE course_description.id_course='.$data['id'].''.$filter.''));
    if(count($res)===0){
        exit(FALSE);
    }
    
    $course_d= json_decode('{"description":{id_course":null,"id_text":null,"text":null},"curator":null,"teachers":[],"users":[],"lessons":[]}');
    
    $course_d['description']['id_course']=$res['id_course'];
    $course_d['description']['id_text']=$res['id_text'];
    $course_d['description']['text']=$res['text'];
    
    $res= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM curator_course WHERE id_course='.$course_d['description']['id_course'].''));
    $course_d['curator']=$res['id_curator'];
    
    $res=mysqli_query($db,'SELECT * FROM teacher_course WHERE id_course='.$course_d['description']['id_course'].'');
    while($row= mysqli_fetch_assoc($res)){
        $course_d['teachers'][count($course_d['teachers'])]=$row['id_teacher'];
    }
    
    $res=mysqli_query($db,'SELECT * FROM user_result WHERE id_course='.$course_d['description']['id_course'].'');
    while($row= mysqli_fetch_assoc($res)){
        $course_d['users'][count($course_d['users'])]=$row['user_id'];
    }
    
    $res=mysqli_query($db,'SELECT * FROM lessons WHERE id_course='.$course_d['description']['id_course'].'');
    
    while($row= mysqli_fetch_assoc($res)){
        $course_d['lessons'][count($course_d['lessons'])]=$row;
    }
    
    exit(json_encode($course_d));
?>


