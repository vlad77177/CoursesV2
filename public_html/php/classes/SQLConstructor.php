<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class SQLConstructor{
    
    private $validator;
    
    public function __construct(){
        
    }
    
    public function GetSelectSQLString($table,$columns,$conditions=array()){
        $sql='SELECT ';       
        if(count($columns)>0){
            $first=true;
            for($i=0;$i<count($columns);$i++){
                if(!first){
                    $sql=$sql.',';
                }
                $sql=$sql.$columns[$i];
                $first=false;
            }
        }
        else{
            $sql=$sql.'*';
        }        
        $sql=$sql.' FROM '.$table;
        if(is_array($conditions)){
            if(count($conditions)>0){
                $sql=$sql.' WHERE ';
                $first=true;
                for($i=0;$i<count($conditions);$i++){
                    if(!$first){
                        $sql=$sql.',';
                    }
                    $c=new Condition(null,null,null);
                    $c->SetData($conditions[$i]);
                    $sql=$sql.$c->GetColumn().$c->GetCondition();
                    if(is_string($c->GetValue())){
                        $sql=$sql.'\''.$c->GetValue().'\'';
                    }
                    else{
                        $sql=$sql.$c->GetValue();
                    }
                }
            }
        }
        error_log($sql);
        return $sql=$sql.';';
    }
}

?>

