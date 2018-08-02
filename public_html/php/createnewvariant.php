<?php

session_start();

require 'db.php';

$data=json_decode(file_get_contents('php://input'),true);

$res= mysqli_fetch_assoc(mysqli_query($db,'SELECT MAX(number) AS max FROM variants WHERE id_question='.$data['question'].''));

$is_first=0;
if($res['max']==1)
    $is_first=1;

$n=++$res['max'];
$text='Вариант '.$n;

$res=mysqli_query($db,'INSERT INTO text(text) VALUES(\''.$text.'\')');

$id=mysqli_insert_id($db);
$res=mysqli_query($db,'INSERT INTO variants(id_question,number,id_text) VALUES('.$data['question'].','.$n.','.$id.')');

exit();

?>
