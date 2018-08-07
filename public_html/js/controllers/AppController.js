App.controller('AppController',['$scope','$http','$interval','LoggedUserService','UsersService','CoursesService','TestsService',
    function AppController($scope, $http,$interval,LoggedUser,Users,Courses,Tests){
        
        $scope.contentDownload={
            courses:false
        };
        
        $scope.loggedUser=undefined;
        $scope.users=undefined;
        $scope.courses=undefined;
        $scope.tests=undefined;
        
        $scope.test=null;
        $scope.clockmodel=null;
        $scope.testactive=false;
        $scope.alreadyinit=false;
        $scope.testpage=0;
        
        $scope.currentStudent={
            data:undefined
        };
        
        $scope.tick=function(){
            if($scope.test!=undefined){
                $scope.test.seconds=$scope.test.seconds-1;
                var hour=Math.floor($scope.test.seconds/(60*60));
                var minute=Math.floor($scope.test.seconds/60)-hour*60;
                var second=$scope.test.seconds-(hour*(60*60))-minute*60;
                $scope.clockmodel=""+hour+":"+minute+":"+second;
            }
        };
        
        $scope.continueTest=function(){
            for(var i=0;i<$scope.test.questions.length;i++){
                if($scope.test.questions[i].ansver==0){
                    $scope.testpage=i;
                    break;
                }
            }
            $scope.testactive=true;
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
                console.log($scope.users);
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
                    if($scope.currentStudent.data.test_active==1){
                        var data1={
                            user:$scope.loggedUser,
                            uid:$scope.loggedUser.id,
                            cid:$scope.currentStudent.data.id_course
                        };
                        $http({method:'POST',data:data1,url:'php/getactivetest.php'})
                                .then(function(data){
                                    if(data.data!=false){
                                        $scope.alreadyinit=true;
                                        $scope.testactive=true;
                                        $scope.test=data.data;
                                        $interval(function(){$scope.tick();},1000);
                                        $scope.continueTest();
                                    }
                        });
                    }
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


