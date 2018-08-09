/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
App.filter('intToBoolean',function(){
    return function(input){
        if(input==true)
            return true;
        else
            return false;
    };
});*/
App.filter('UserFilter',function(){
    return function(users,flag,id){
        if(users===undefined)
            return;
        //console.log('Filter: UserFilter flag='+flag);
        var filtered=[];
        for(var i=0;i<users.length;i++){
            switch(flag){
                case 'administrator':{
                        if(users[i].administrator==true){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
                case 'curator':{
                        if(users[i].curator==true){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
                case 'teacher':{
                        if(users[i].teacher==true){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
                case 'student':{
                        if(users[i].student==true){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
                case 'id':{
                        if(id===undefined)
                            return;
                        if(users[i].id==id){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
                case 'ids':{
                        if(id===undefined)
                            return;
                        for(var j=0;j<id.length;j++){
                            if(users[i].id===id[j]){
                                var a=true;
                                for(var k=0;k<filtered.length;k++){
                                    if(filtered[k]===users[i])
                                        a=false;
                                }
                                if(a===true)
                                    filtered[filtered.length]=users[i];
                            }
                        }
                        break;
                }
                case 'unids':{
                        if(id===undefined)
                            return;
                        var add=true;
                        for(var j=0;j<id.length;j++){
                            if(users[i].id===id[j]){
                                add=false;
                            }
                        }
                        if(add===true){
                            filtered[filtered.length]=users[i];
                        }
                        break;
                }
            }
        }
        return filtered;
    };
});

App.filter('UserInIDArrayFilter',function(){
    return function(users,array){
        if(users===undefined)
            return;
        var filtered=[];
        
        for(var i=0;i<array.length;i++){
            for(var j=0;j<users.length;j++){
                if(users[j].id===array[i]){
                    filtered[filtered.length]=users[j];
                    break;
                }
            }
        }
        return filtered;
    };
});

App.filter('CourseFilter',function(){
    return function(courses,flag,id){
        if(courses===undefined)
            return;
        var filtered=[];
        for(var i=0;i<courses.length;i++){
            switch(flag){
                case 'ids':{
                        if(id===undefined)
                            return;
                        for(var j=0;j<id.length;j++){
                            if(courses[i].id===id[j]){
                                var a=true;
                                for(var k=0;k<filtered.length;k++){
                                    if(filtered[k]===courses[i])
                                        a=false;
                                }
                                if(a===true)
                                    filtered[filtered.length]=courses[i];
                            }
                        }
                        break;
                }
                case 'unids':{
                        if(id===undefined)
                            return;
                        var add=true;
                        for(var j=0;j<id.length;j++){
                            if(courses[i].id===id[j]){
                                add=false;
                            }
                        }
                        if(add===true){
                            filtered[filtered.length]=courses[i];
                        }
                        break;
                }
            }
        }
        return filtered;
    };
});

App.filter('trusted', function($sce){
    return function(html){
        return $sce.trustAsHtml(html);
    };
});

