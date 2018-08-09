<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class UserAccessControl{
    
    public function __construct(){
        
    }
    
    public function GetLimitAccessConditions($table,$user,$base_cond=array()){
        
        $conditions=array();
        
        if(is_array($base_cond)){
            if(count($base_cond)>0){
                for($i=0;$i<count($base_cond);$i++){
                    $conditions[count($conditions)]=$base_cond[$i];
                }
            }
        }
        else{
            $conditions[count($conditions)]=$base_cond;
        }
        
    }
    
    private function GetLimitAccessForCurator($table){
        switch ($table){
            case 'users':{
                break;
            }
            case 'courses':{
                break;
            }
            case 'course_description':{
                break;
            }
            case 'tests':{
            }
        }
    }
    
}

?>

