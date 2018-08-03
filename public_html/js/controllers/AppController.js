App.controller('AppController',['$scope','$http','LoggedUserService','UsersService','CoursesService','TestsService',
    function AppController($scope, $http,LoggedUser,Users,Courses,Tests){
        
        $scope.contentDownload={
            courses:false
        };
        
        $scope.loggedUser=undefined;
        $scope.users=undefined;
        $scope.courses=undefined;
        $scope.tests=undefined;
        
        $scope.currentStudent={
            data:undefined
        };
        
        LoggedUser.get().then(function(u){
            $scope.loggedUser=u.data;
            $scope.loggedUser.ulog=u.ulog;
            $scope.loggedUser.uadmin=u.uadmin;
            $scope.loggedUser.ucurator=u.ucurator;
            $scope.loggedUser.uteaher=u.uteacher;
            $scope.loggedUser.ustudent=u.ustudent;
            $scope.loggedUser.signed=u.usersigned;
            Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                $scope.users=us;
            });
            Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                $scope.courses=c;
                $scope.contentDownload.courses=true;
            });
            Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                $scope.tests=t;
            });
            if($scope.loggedUser.ustudent==true){
                var data={
                    user:$scope.loggedUser
                };
                $http({method:'POST',data:data,url:'php/getstudentdata.php'})
                .then(function(data){
                    $scope.currentStudent.data=data.data;
                });
            }            
        });
        
        
        $scope.loginFormModel={
            login:undefined,
            password:undefined
        };
        
        $scope.loginUser=function(){
            $http({method: 'POST', data:$scope.loginFormModel, url:'php/login.php'})
                    .then(function(data){
                        LoggedUser.reset().then(function(u){
                            $scope.loggedUser=u.data;
                            $scope.loggedUser.ulog=u.ulog;
                            $scope.loggedUser.uadmin=u.uadmin;
                            $scope.loggedUser.ucurator=u.ucurator;
                            $scope.loggedUser.uteaher=u.uteacher;
                            $scope.loggedUser.ustudent=u.ustudent;
                            $scope.loggedUser.signed=u.usersigned;
                            Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                                $scope.users=us;
                            });
                            Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                                $scope.courses=c;
                                $scope.contentDownload.courses=true;
                            });
                            Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                                $scope.tests=t;
                            });
                            if($scope.loggedUser.ustudent==true){
                                var data={
                                    user:$scope.loggedUser
                                };
                                $http({method:'POST',data:data,url:'php/getstudentdata.php'})
                                .then(function(data){
                                    $scope.currentStudent.data=data.data;
                                });
                            }
                        });
            });
        };
        
        $scope.logOut=function(){
            $http({method:'POST',url:'php/logout.php'})
                    .then(function(){
                        LoggedUser.reset().then(function(){
                            $scope.loggedUser.ulog=false;
                        });
            });
        };
        
        $scope.setEditableArea=function(content,areaname,editable){
            CKEDITOR.replace('input-'+areaname+'');
            CKEDITOR.instances['input-'+areaname+''].setData(content);
            console.log('create: '+areaname);
            editable.value=!editable.value;
        };
        
        $scope.saveChanges=function(id_text,text,areaname,editable){
            text=CKEDITOR.instances['input-'+areaname+''].getData();
            var data={
                user:$scope.loggedUser,
                id:id_text,
                text:text
            };
            $http({method:'POST',data:data,url:'php/updatetext.php'})
                    .then(function(){
                        CKEDITOR.instances['input-'+areaname+''].destroy();
                        editable.value=!editable.value;
                        
            });
        };
    }]
);


