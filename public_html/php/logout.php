<?php
    session_start();
    unset($_SESSION['login']);
    unset($_SESSION['password']);
    unset($_SESSION['admin']);
    unset($_SESSION['id']);
    exit();
?>
