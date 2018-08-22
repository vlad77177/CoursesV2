<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);
    
    $data['curator_id']= mysqli_real_escape_string($db,$data['curator_id']);
    $data['student_id']= mysqli_real_escape_string($db,$data['student_id']);
    $data['teacher_id']= mysqli_real_escape_string($db,$data['teacher_id']);
    $data['course_id']= mysqli_real_escape_string($db,$data['course_id']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0){
        exit(FALSE);
    }
    
    switch($data['mode']){
        //отписываю студента от куратора
        case 1:{
            if($user['administrator']==1){
                $res= mysqli_query($db, 'DELETE FROM curator_student WHERE id_curator='.$data['curator_id'].' AND id_student='.$data['student_id'].'');
            }
            if($user['curator']==1){
                $res= mysqli_query($db, 'DELETE FROM curator_student WHERE id_curator='.$user['id'].' AND id_student='.$data['student_id'].'');
            }
            break;
        }
        //отписываю учителя от куратора
        case 2:{
            if($user['administrator']==1){
                $res= mysqli_query($db, 'DELETE FROM curator_teacher WHERE id_curator='.$data['curator_id'].' AND id_teacher='.$data['teacher_id'].'');
            }
            if($user['curator']==1){
                $res= mysqli_query($db, 'DELETE FROM curator_teacher WHERE id_curator='.$user['id'].' AND id_teacher='.$data['teacher_id'].'');
            }
            break;
        }
        //отписать учителя от курса
        case 3:{
            if($user['administrator']==1){
                $res= mysqli_query($db, 'DELETE FROM teacher_course WHERE id_teacher='.$data['teacher_id'].' AND id_course='.$data['course_id'].'');
            }
            if($user['curator']==1){
                $res= mysqli_query($db, 'DELETE FROM teacher_course WHERE id_teacher='.$data['teacher_id'].' AND id_course='.$data['course_id'].' AND id_teacher IN '
                        . '(SELECT id_tecaher FROM curator_teacher WHERE id_curator='.$user['id'].')');
            }
            break;
        }
        //отписать пользователя от курса
        case 4:{
            if($user['administrator']==1){
                $res=mysqli_query($db,'DELETE FROM user_result WHERE user_id='.$data['student_id'].' AND id_course='.$data['course_id'].'');
            }
            if($user['curator']==1){
                $res=mysqli_query($db,'DELETE FROM user_result WHERE user_id='.$data['student_id'].' AND id_course='.$data['course_id'].' AND user_id IN '
                        . '(SELECT id_student FROM curator_student WHERE id_curator='.$user['id'].')');
            }
            break;
        }
    }
    
    exit();
    
?>

