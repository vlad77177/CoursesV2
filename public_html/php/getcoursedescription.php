<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    /*
    if($user['administrator']==0){
        exit();
    }*/
    
    $res=mysqli_fetch_assoc(mysqli_query($db,'SELECT id_course, text.id_text, text FROM course_description INNER JOIN text ON course_description.id_text=text.id_text WHERE course_description.id_course='.$data['id'].''));
    
    $course_d= json_decode('{"description":{"id_course:"null,"id_text":null,"text":null},"curator":null,"teachers":[],"users":[],"lessons":[]}');
    
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


