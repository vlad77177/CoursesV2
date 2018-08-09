App.factory('LoggedUserService',function($http){
    var promice;
    var myservice={
        get:function(){
            if(!promice || promice===null){
                console.log('первичный запуск сервиса пользователя');
                var userlogged={
                            data:null,
                            ulog:false,
                            uadmin:false,
                            ucurator:false,
                            uteacher:false,
                            ustudent:false,
                            usersigned:[]
                        };
                var data={
                    action:'getSession'
                };
                promice=$http({method: 'POST',data:data, url: 'php/api.php'}).
                    then(function(data) {
                        console.log('returned session data:');
                        console.log(data);
                        userlogged.data=data.data;
                        if(data.data.login!==null){
                            userlogged.ulog=true;
                        }
                        if(data.data.administrator==true){
                           userlogged.uadmin=true;
                        }
                        if(data.data.curator==true){
                           userlogged.ucurator=true;
                        }
                        if(data.data.teacher==true){
                           userlogged.uteacher=true;
                        }
                        if(data.data.student==true){
                           userlogged.ustudent=true;
                        }
                        var data1={
                           login:userlogged.data.login,
                           pass:userlogged.data.password,
                           uid:userlogged.data.id
                        };
                        $http({method:'POST',data:data1,url:'php/getusersigned.php'})
                           .then(function(data){
                               for(var i=0;i<data.data.length;i++){
                                   userlogged.usersigned[i]=data.data[i];
                               }
                        });
                           console.log('loggedUser:');
                           console.log(userlogged);
                           return userlogged;
                        });
            }
            return promice;
        },
        reset:function(){
            promice=null;
            return this.get();
        }
    };
    return myservice;
});

App.factory('UsersService',function($http){
    var promice;
    var myservice={
        get:function(login,password){
            if(!promice || promice===null){
                console.log('загружаю Users');
                var data={
                    user:{
                        login:login,
                        password:password
                    }
                };
                promice=$http({method:'POST',data:data,url:'php/getusers.php'})
                    .then(function(data){
                        console.log(data.data);
                        return data.data;
                });
            }
            return promice;
        },
        reset:function(login,password){
            promice=null;
            return this.get(login,password);
        }
    };
    return myservice;
});

App.factory('CoursesService',function($http){
    var promice;
    var myservice={
        get:function(login,password){
            if(!promice || promice===null){
                console.log('загружаю Courses');
                var data={
                    user:{
                        login:login,
                        password:password
                    }
                };
                promice=$http({method:'POST',data:data,url:'php/getcourses.php'})
                    .then(function(data){
                        console.log(data.data);
                        return data.data;
                });
            }
            return promice;
        },
        reset:function(login,password){
            promice=null;
            return this.get(login,password);
        }
    };
    return myservice;
});

App.factory('TestsService',function($http){
    var promice;
    var myservice={
        get:function(login,password){
            if(!promice || promice===null){
                console.log('загружаю Tests');
                var data={
                    user:{
                        login:login,
                        password:password
                    }
                };
                promice=$http({method:'POST',data:data,url:'php/gettests.php'})
                    .then(function(data){
                        console.log(data.data);
                        return data.data;
                });
            }
            return promice;
        },
        reset:function(login,password){
            promice=null;
            return this.get(login,password);
        }
    };
    return myservice;
});

