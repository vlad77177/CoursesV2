<?php
    session_start();
    
    require 'db.php';
    
    $data=json_decode(file_get_contents('php://input'),true);
    $user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
    if($user['administrator']==0){
        exit();
    }
    
    $courses= mysqli_fetch_all(mysqli_query($db,'SELECT courses.id,name,src FROM courses LEFT OUTER JOIN images ON courses.logo=images.id'),MYSQLI_ASSOC);
    
    for($i=0;$i<count($courses);$i++){
        $lessons=mysqli_query($db,'SELECT * FROM lessons WHERE id_course='.$courses[$i]['id'].' ORDER BY number');
        if(mysqli_num_rows($lessons)!=0){
            $max= mysqli_num_rows($lessons);
            $j=0;
            while($j<$max){
                $courses[$i]['lessons'][$j]= mysqli_fetch_assoc($lessons);
                $j++;
            }
        }
        //$courses[$i]['lessons']=$lessons;
    }
    
    exit(json_encode($courses));
?>

