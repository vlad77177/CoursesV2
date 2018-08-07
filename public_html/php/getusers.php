<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user_log= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    /*if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
        exit(FALSE);
    }*/
    
    $res=mysqli_query($db,'SELECT * FROM users');
    
    $users=array();
    
    while($row=mysqli_fetch_assoc($res)){
        if($user_log['administrator']==1 or ($user_log['curator']==1 and ($row['administrator']==0 and ($row['curator']==0 or $row['id']==$user_log['id'])))){
            
            if($user_log['curator']==1 and $row['id']!==$user_log['id'] and $user_log['administrator']==0){
                $continue=true;
                $res_teachers=mysqli_query($db,'SELECT * FROM curator_teacher WHERE id_curator='.$user_log['id'].'');
                $res_students=mysqli_query($db,'SELECT * FROM curator_student WHERE id_curator='.$user_log['id'].'');
                while($r=mysqli_fetch_assoc($res_teachers)){
                    if($r['id_teacher']==$row['id']){
                        $continue=false;
                    }
                }
                while($r=mysqli_fetch_assoc($res_students)){
                    if($r['id_student']==$row['id']){
                        $continue=false;
                    }
                }
                if($continue===true){
                    continue;
                }
            }
            
            $user_json='{"id":null,"login":null,"email":null,"administrator":false,"curator":false,"teacher":false,"student":false,"cur_students":[],"cur_teachers":[],"teach_courses":[],"teach_students":[],"results":[],"learneds":[],"need_learns":[],"curator":null,"teachers":[],"courses":[]}';
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
                    $res4= mysqli_query($db,'SELECT * FROM user_result WHERE id_course='.$course['id_course'].'');
                    while($stud=mysqli_fetch_assoc($res4)){
                        $user->teach_students[count($user->teach_students)]=$stud['user_id'];
                    }
                }               
            }
            if($row['student']==1){
                $u_res=mysqli_query($db,'SELECT * FROM user_result WHERE user_id='.$row['id'].'');
                while($r=mysqli_fetch_assoc($u_res)){
                    $user->courses[count($user->courses)]=$r['id_course'];
                    $user->results[count($user->results)]=$r['test_result'];
                    $user->learneds[count($user->learneds)]=$r['learned'];
                    $course=mysqli_fetch_assoc(mysqli_query($db,'SELECT COUNT(*) AS count FROM lessons WHERE id_course='.$r['id_course'].''));
                    $user->need_learns[count($user->need_learns)]=$course['count'];
                    $teacher=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM teacher_course WHERE id_course='.$r['id_course'].''));
                    $user->teachers[count($user->teachers)]=$teacher['id_teacher'];
                }
                $cur=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM curator_student WHERE id_student='.$row['id'].''));
                $user->curator=$cur['id_curator'];
            }

            $users[count($users)]=$user;
        }
    }
    
    exit(json_encode($users));
?>

