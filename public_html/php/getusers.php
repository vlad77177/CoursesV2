<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0){
        exit();
    }
    
    $res=mysqli_query($db,'SELECT * FROM users');
    
    $users=array();
    
    while($row=mysqli_fetch_assoc($res)){
        $user_json='{"id":null,"login":null,"email":null,"administrator":false,"curator":false,"teacher":false,"student":false,"cur_students":[],"cur_teachers":[],"teach_courses":[],"teach_students":[]}';
        $user= json_decode($user_json);
        
        $user->id=$row['id'];
        $user->login=$row['login'];
        $user->email=$row['email'];
        $user->administrator=$row['administrator'];
        $user->curator=$row['curator'];
        $user->teacher=$row['teacher'];
        $user->student=$row['student'];
        
        if($row['curator']==1){
            $res2= mysqli_query($db,'SELECT id_student FROM curator_student WHERE id_curator='.$row['id'].'');
            while($stud= mysqli_fetch_assoc($res2)){
                $user->cur_students[count($user->cur_students)]=$stud['id_student'];
            }
            $res2= mysqli_query($db,'SELECT id_teacher FROM curator_teacher WHERE id_curator='.$row['id'].'');
            while($teach= mysqli_fetch_assoc($res2)){
                $user->cur_teachers[count($user->cur_teachers)]=$teach['id_teacher'];
            }
        }
        if($row['teacher']==1){
            $res3= mysqli_query($db,'SELECT id_course FROM teacher_course WHERE id_teacher='.$row['id'].'');
            while($course= mysqli_fetch_assoc($res3)){
                $user->teach_courses[count($user->teach_courses)]=$course['id_course'];
            }
            /*
            $res4= mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM user_result WHERE id_course='.$course['id_course'].''));
            $user->teach_students[count($user->teach_students)]=$res4['user_id'];*/
        }
        
        $users[count($users)]=$user;
    }
    
    exit(json_encode($users));
?>

