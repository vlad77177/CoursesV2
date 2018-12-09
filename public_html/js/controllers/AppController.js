App.controller('AppController',['$scope','$http','$interval','LoggedUserService','UsersService','CoursesService','TestsService','EducationalService',
    function AppController($scope, $http,$interval,LoggedUser,Users,Courses,Tests,Educational){
        
        $scope.contentDownload={
            courses:false
        };
        
        $scope.loggedUser=undefined;
        
        $scope.showwelcomepage=true;
        $scope.showprojectpage=false;
        $scope.showattendancepage=false;
        $scope.showteampage=false;
        $scope.showprobationpage=false;
        $scope.showeducationalpage=false;
        $scope.showcontactspage=false;
        $scope.showloggedform=false;
        
        $scope.users=undefined;
        $scope.courses=undefined;
        $scope.tests=undefined;
        
        $scope.educational=undefined;
        $scope.educationalActivePage=0;
        
        $scope.test=null;
        $scope.clockmodel=null;
        $scope.testactive=false;
        $scope.alreadyinit=false;
        $scope.testpage=0;
        
        $scope.showdetailedresults=false;
        
        $scope.currentUser={
            id:undefined,
            login:undefined,
            name:undefined,
            surname:undefined,
            email:undefined,
            newpass:undefined,
            repeat:undefined,
            cur_students:[],
            cur_teachers:[],
            teach_courses:[],
            teach_students:[],
            is_admin:false,
            is_curator:false,
            is_teacher:false,
            is_student:false,
            results:[],
            learneds:[],
            need_learns:[],
            curator:undefined,
            teachers:[],
            courses:[],
            detailed_results:undefined
        };
        
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
            $scope.loggedUser.uteacher=u.uteacher;
            $scope.loggedUser.ustudent=u.ustudent;
            $scope.loggedUser.signed=u.usersigned;
            if($scope.loggedUser.uadmin==true){
                $scope.loggedUser.mark='admin';
            }
            else if($scope.loggedUser.ucurator==true){
                $scope.loggedUser.mark='curator';
            }
            else if($scope.loggedUser.uadmin==true){
                $scope.loggedUser.mark='teacher';
            }
            Users.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                $scope.users=us;
            });
            Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                $scope.courses=c;
                $scope.contentDownload.courses=true;
            });
            Tests.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
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
        
        Educational.get().then(function(data){
            $scope.educational=data;
        });
        console.log($scope.educational);
        
        
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
                            if($scope.loggedUser.uadmin==true){
                                $scope.loggedUser.mark='admin';
                            }
                            else if($scope.loggedUser.ucurator==true){
                                $scope.loggedUser.mark='curator';
                            }
                            else if($scope.loggedUser.uadmin==true){
                                $scope.loggedUser.mark='teacher';
                            }
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
        
        $scope.getVariantResultClass=function(variant){
            if(variant.isright==1){
                return 'answer-right';
            }
            else{
                if(variant.isright!==variant.answer){
                    return 'answer-false';
                }
            }
        };
        
        $scope.showLoggedForm=function(){
            $scope.showloggedform=true;
        };
        
        function erasePages(){
            console.log("erase");
            $scope.showwelcomepage=false;
            $scope.showprojectpage=false;
            $scope.showattendancepage=false;
            $scope.showteampage=false;
            $scope.showprobationpage=false;
            $scope.showeducationalpage=false;
            $scope.showcontactspage=false;
        }
        
        $scope.showWelcomePage=function(){
            erasePages();
            $scope.showwelcomepage=true;
        };
        
        $scope.showProjectPage=function(){
            erasePages();
            $scope.showprojectpage=true;
        };
        
        $scope.showAttendancePage=function(){
            erasePages();
            $scope.showattendancepage=true;
        };
        
        $scope.showTeamPage=function(){
            erasePages();
            $scope.showteampage=true;
        };
        
        $scope.showProbationPage=function(){
            erasePages();
            $scope.showprobationpage=true;
        };
        
        $scope.showEducationalPage=function(){
            erasePages();
            $scope.showeducationalpage=true;
        };
        
        $scope.showContactsPage=function(){
            erasePages();
            $scope.showcontactspage=true;
        };
        
        $scope.chooseEducationalPage=function(index){
            $scope.educationalActivePage=index;
        };
        
        $scope.educationalPageChangeShow=function(page){
            if(!page.downloadfile)
                page.show=!page.show;
        };
               
    }]
);


