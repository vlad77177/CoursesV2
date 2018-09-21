<?php
    $db= mysqli_connect('mysql.db', 'kibertest', 'qwe*asd', 'kibertest') or die('Ошибка подключения к базе данных!');
    mysqli_set_charset($db,"utf8");
    date_default_timezone_set('Europe/Moscow');
?>

