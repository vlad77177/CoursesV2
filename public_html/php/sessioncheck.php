<?php
    session_start();

    if(isset($_SESSION['login']) and isset($_SESSION['password']) and isset($_SESSION['admin']) and isset($_SESSION['id'])){
        $user=array('login'=>$_SESSION['login'],'password'=>$_SESSION['password'],'administrator'=>$_SESSION['administrator'],'id'=>$_SESSION['id'],'curator'=>$_SESSION['curator'],'teacher'=>$_SESSION['teacher'],'student'=>$_SESSION['student']);
    }
    else{
        $user=array('login'=>$_SESSION['login'],'password'=>$_SESSION['password'],'administrator'=>$_SESSION['administrator'],'id'=>$_SESSION['id'],'curator'=>$_SESSION['curator'],'teacher'=>$_SESSION['teacher'],'student'=>$_SESSION['student']);
    }
    
    exit(json_encode($user));

?>