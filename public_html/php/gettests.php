<?php


session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$data['user']['login']= mysqli_real_escape_string($db,$data['user']['login']);
$data['user']['password']= mysqli_real_escape_string($db,$data['user']['password']);

$user= mysqli_fetch_assoc(mysqli_query($db, 'SELECT id,login,email,administrator,curator,teacher,student FROM users WHERE login=\''.$data['user']['login'].'\' AND password=\''.$data['user']['password'].'\''));
if($user['administrator']==0 and $user['curator']==0 and $user['teacher']==0 and $user['student']==0){
    exit(FALSE);
}

$visit=date('Y-m-d H:i:s',time());
mysqli_query($db,'UPDATE users SET last_visit=\''.$visit.'\' WHERE login=\''.$data['user']['login'].'\'');

$testsf=[];
$rt=undefined;
if($user['administrator']==1){
    $rt=mysqli_query($db,'SELECT * FROM tests');
}
if($user['curator']==1){
    $rt=mysqli_query($db,'SELECT * FROM tests WHERE for_course_id IN (SELECT id_course FROM curator_course WHERE id_curator='.$user['id'].')');
}
if($user['teacher']==1){
    $rt=mysqli_query($db,'SELECT * FROM tests WHERE for_course_id IN (SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].')');
}
if($user['student']==1){
    $rt=mysqli_query($db,'SELECT * FROM tests WHERE for_course_id IN (SELECT id_course FROM user_result WHERE user_id='.$user['id'].')');
}
$i=0;
while($row=mysqli_fetch_assoc($rt)){
        $testsf[$i]=$row;
        $i++;
}

$tests;
$course_ids;
$tests_ids;

/*
if($user['administrator']==0){
    if($user['curator']==1){
        $tests_ids=mysqli_query($db,'SELECT * FROM curator_test WHERE id_curator='.$user['id'].'');
        while($r=mysqli_fetch_assoc($tests_ids)){
            $id_test=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM tests WHERE id='.$r['id_test'].''));
            for($i=0;$i<count($testsf);$i++){
                if($testsf[$i]['id']===$id_test['id']){
                    $tests[count($tests)]=$testsf[$i];
                }
            }
        }
    }
    else if($user['teacher']==1){
        $course_ids=mysqli_query($db,'SELECT id_course FROM teacher_course WHERE id_teacher='.$user['id'].'');
        while($r=mysqli_fetch_assoc($course_ids)){
            $id_test=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM tests WHERE for_course_id='.$r['id_course'].''));
            for($i=0;$i<count($testsf);$i++){
                if($testsf[$i]['id']===$id_test['id']){
                    $tests[count($tests)]=$testsf[$i];
                }
            }
        }
    }
    else{
        $tests=$testsf;
    }
}*/

$tests=$testsf;

for($i=0;$i<count($tests);$i++){
    $curator=mysqli_fetch_assoc(mysqli_query($db,'SELECT * FROM curator_test WHERE id_test='.$tests[$i]['id'].''));
    $tests[$i]['curator_id']=$curator['id_curator'];
    $questions=mysqli_query($db,'SELECT id,text.text,number,text.id_text,name FROM questions INNER JOIN text ON questions.id_text=text.id_text WHERE questions.id_test='.$tests[$i]['id'].'');
    if(mysqli_num_rows($questions)!=0){
        $max= mysqli_num_rows($questions);
        $j=0;
        while($j<$max){
            $tests[$i]['questions'][$j]= mysqli_fetch_assoc($questions);
            $result= mysqli_query($db, 'SELECT variants.id AS id,text.text AS text,variants.isright AS isright,text.id_text AS id_text FROM variants JOIN text ON variants.id_text=text.id_text WHERE id_question='.$tests[$i]['questions'][$j]['id'].'');
            $n=0;
            while($now= mysqli_fetch_assoc($result)){
                $tests[$i]['questions'][$j]['variants'][$n]=$now;
                $n++;
            }
            $j++;           
        }
    }
}

exit(json_encode($tests));

?>

