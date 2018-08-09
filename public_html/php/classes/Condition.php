<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class Condition{
    private $column;
    private $cond;
    private $value;
    
    public function __construct($col,$cond,$val){
        $this->SetColumn($col);
        $this->cond=$cond;
        $this->value=$val;
    }
    
    public function SetColumn($col){
        $this->column=$col;
    }
    
    public function SetCond($cond){
        $this->cond=$cond;
    }
    
    public function SetValue($val){
        $this->value=$val;
    }
    
    public function GetColumn(){
        return $this->column;
    }
    
    public function GetCondition(){
        return $this->cond;
    }
    
    public function GetValue(){
        return $this->value;
    }
}

?>

