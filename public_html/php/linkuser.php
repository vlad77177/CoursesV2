<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    
    $data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
    $data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);
    
    $data['curator_id']= mysqli_real_escape_string($db,$data['curator_id']);
    $data['student_id']= mysqli_real_escape_string($db,$data['student_id']);
    $data['course_id']= mysqli_real_escape_string($db,$data['course_id']);

    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0 and $user['curator']==0){
        exit(FALSE);
    }
    
    $visit=date('Y-m-d H:i:s',time());
    mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');
    
    switch($data['mode']){
        //приписываю студета к куратору
        case 1:{
            if($user['administrator']==1){
                $res= mysqli_query($db, 'INSERT INTO curator_student(id_curator,id_student) VALUES('.$data['curator_id'].','.$data['student_id'].')');
            }
            break;
        }
        //приписываю преподавателя к куратору
        case 2:{
            if($user['administrator']==1){
                $res= mysqli_query($db, 'INSERT INTO curator_teacher(id_curator,id_teacher) VALUES('.$data['curator_id'].','.$data['teacher_id'].')');
            }
            break;
        }
        //приписываю учителя к курсу
        case 3:{
            if($user['administrator']==1){
                mysqli_query($db, 'INSERT INTO teacher_course(id_teacher,id_course) VALUES('.$data['teacher_id'].','.$data['course_id'].')');
            }
            if($user['curator']==1){
                $res= mysqli_query($db, 'SELECT * FROM curator_course WHERE id_course='.$data['course_id'].' AND id_curator='.$user['id'].'');
                if($res===FALSE){
                    exit(FALSE);
                }
                mysqli_query($db, 'INSERT INTO teacher_course(id_teacher,id_course) VALUES('.$data['teacher_id'].','.$data['course_id'].')');
            }
            break;
        }
        //приписать студента к курсу
        case 4:{
            if($user['administrator']==1){
                mysqli_query($db,'INSERT INTO user_result(user_id,id_course) VALUES('.$data['student_id'].','.$data['course_id'].')');
            }
            if($user['curator']==1){
                $c= mysqli_query($db,'SELECT * FROM curator_course WHERE id_curator='.$user['id'].' AND id_course='.$data['course_id'].'');
                $u= mysqli_query($db,'SELECT * FROM curator_student WHERE id_curator='.$user['id'].' AND id_student='.$data['student_id'].'');
                if($c===FALSE or $u===FALSE){
                    exit(FALSE);
                }
                mysqli_query($db,'INSERT INTO user_result(user_id,id_course) VALUES('.$data['student_id'].','.$data['course_id'].')');
            }
            break;
        }
        //приисать курс куратору
        case 5:{
            if($user['administrator']==1){
                mysqli_query($db,'DELETE FROM curator_course WHERE id_course='.$data['course_id'].'');
            }
            if($user['curator']==1){
                mysqli_query($db,'DELETE FROM curator_course WHERE id_course='.$data['course_id'].' AND id_curator='.$user['id'].'');
            }
            mysqli_query($db,'INSERT INTO curator_course(id_curator,id_course) VALUES('.$data['curator_id'].','.$data['course_id'].')');
            break;
        }
    }
    
    exit();
    
?>

