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
            $res= mysqli_query($db, 'INSERT INTO curator_student(id_curator,id_student) VALUES('.$data['curator_id'].','.$data['student_id'].')');
            break;
        }
        case 2:{
            $res= mysqli_query($db, 'INSERT INTO curator_teacher(id_curator,id_teacher) VALUES('.$data['curator_id'].','.$data['teacher_id'].')');
            break;
        }
        case 3:{
            $res= mysqli_query($db, 'INSERT INTO teacher_course(id_teacher,id_course) VALUES('.$data['teacher_id'].','.$data['course_id'].')');
            break;
        }
        case 4:{
            $res=mysqli_query($db,'INSERT INTO user_result(user_id,id_course) VALUES('.$data['student_id'].','.$data['course_id'].')');
            break;
        }
        case 5:{
            $res1=mysqli_query($db,'DELETE FROM curator_course WHERE id_course='.$data['course_id'].'');
            $res2=mysqli_query($db,'INSERT INTO curator_course(id_curator,id_course) VALUES('.$data['curator_id'].','.$data['course_id'].')');
            break;
        }
    }
    
    exit();
    
?>

