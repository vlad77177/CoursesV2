<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
        exit(FALSE);
    }
    
    switch($data['mode']){
        case 1:{
            $res= mysqli_query($db, 'DELETE FROM curator_student WHERE id_curator='.$data['curator_id'].' AND id_student='.$data['student_id'].'');
            break;
        }
        case 2:{
            $res= mysqli_query($db, 'DELETE FROM curator_teacher WHERE id_curator='.$data['curator_id'].' AND id_teacher='.$data['teacher_id'].'');
            break;
        }
        case 3:{
            $res= mysqli_query($db, 'DELETE FROM teacher_course WHERE id_teacher='.$data['teacher_id'].' AND id_course='.$data['course_id'].'');
            break;
        }
        case 4:{
            $res=mysqli_query($db,'DELETE FROM user_result WHERE user_id='.$data['student_id'].' AND id_course='.$data['course_id'].'');
            break;
        }
    }
    
    exit();
    
?>

