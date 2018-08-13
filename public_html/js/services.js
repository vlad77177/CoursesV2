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
                            ustudent:false
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
                    },
                    action:'getUsers'
                };
                promice=$http({method:'POST',data:data,url:'php/api.php'})
                    .then(function(data){
                        console.log(data);
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
                    action:'getCourses',
                    user:{
                        login:login,
                        password:password
                    }
                };
                promice=$http({method:'POST',data:data,url:'php/api.php'})
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
                    action:'getTests',
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

