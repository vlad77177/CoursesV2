App.controller('StudentPageController',['$scope','$http','$filter','$interval','LoggedUserService','UsersService','CoursesService',
    function StudentPageController($scope, $http,$filter,$interval,LoggedUser,Courses){
       
        $scope.textOpen=undefined;
               
        $scope.showresult=false;        
        $scope.result=null;       
        
        $scope.currentLessonIndex=undefined;
        $scope.currentCourseId=undefined;
        
        $scope.timer=undefined;
        
        $scope.tick=function(){
            if($scope.$parent.test!==undefined){
                $scope.$parent.test.seconds=$scope.$parent.test.seconds-1;
                if($scope.$parent.test.seconds<=0){
                    var data1={
                        user:$scope.loggedUser,
                        sid:$scope.$parent.test.session_id
                    };
                    $http({method:'POST',data:data1,url:'php/finishtest.php'})
                        .then(function(data){
                            $scope.result=data.data;
                            $scope.$parent.testactive=false;
                            $scope.showresult=true;
                            $interval.cancel($scope.timer);
                        });
                }
                var hour=Math.floor($scope.$parent.test.seconds/(60*60));
                var minute=Math.floor($scope.$parent.test.seconds/60)-hour*60;
                var second=$scope.$parent.test.seconds-(hour*(60*60))-minute*60;
                $scope.$parent.clockmodel=""+hour+":"+minute+":"+second;
            }
        };
        
        $scope.getActiveTest=function(course){
            var data1={
                user:$scope.loggedUser,
                uid:$scope.loggedUser.id,
                cid:course.id
            };
            
            $http({method:'POST',data:data1,url:'php/getactivetest.php'})
                .then(function(data){
                    if(data.data!=false){
                        $scope.$parent.alreadyinit=true;
                        $scope.$parent.testactive=true;
                        $scope.$parent.test=data.data;
                        if($scope.$parent.test.seconds<=0){
                            var data1={
                                user:$scope.loggedUser,
                                sid:$scope.$parent.test.session_id
                            };
                            $http({method:'POST',data:data1,url:'php/finishtest.php'})
                                .then(function(data){
                                    $scope.result=data.data;
                                    $scope.$parent.testactive=false;
                                    $scope.$parent.showresult=true;
                                    $interval.cancel($scope.timer);
                                });
                        }
                        else{
                            $scope.timer=$interval(function(){$scope.tick();},1000);
                            $scope.continueTest();
                        }
                    }
                    else{
                        $scope.initTest(course);
                    }
                });
        };
        
        $scope.initTest=function(course){
            var data={
                user:$scope.loggedUser,
                cid:course.id,
                uid:$scope.loggedUser.id
            };
            $http({method:'POST',data:data,url:'php/testinit.php'})
                    .then(function(data){
                        var data1={
                            user:$scope.loggedUser,
                            uid:$scope.loggedUser.id,
                            cid:course.id
                        };
                        $http({method:'POST',data:data1,url:'php/getactivetest.php'})
                                .then(function(data){
                                    if(data.data!=false){
                                        $scope.$parent.alreadyinit=true;
                                        $scope.$parent.testactive=true;
                                        $scope.$parent.test=data.data;
                                        if($scope.$parent.test.seconds<=0){
                                            var data1={
                                                user:$scope.loggedUser,
                                                sid:$scope.$parent.test.session_id
                                            };
                                            $http({method:'POST',data:data1,url:'php/finishtest.php'})
                                                .then(function(data){
                                                    $scope.result=data.data;
                                                    $scope.$parent.testactive=false;
                                                    $scope.$parent.showresult=true;
                                                });
                                        }
                                        else{
                                            $scope.timer=$interval(function(){$scope.tick();},1000);
                                            $scope.continueTest();
                                        }
                                    }
                                });
                    });
        };
        
        $scope.ansver=function(index){
            var data={
                user:$scope.loggedUser,
                qsid:$scope.$parent.test.questions[$scope.$parent.testpage].id_session,
                ansver:index+1,
                number:$scope.$parent.testpage+1
            };
            $http({method:'POST',data:data,url:'php/ansver.php'})
                    .then(function(){
                    });
            if($scope.$parent.test.questions[$scope.$parent.testpage].ansvers.indexOf((index+1).toString())===-1)
                $scope.$parent.test.questions[$scope.$parent.testpage].ansvers[$scope.$parent.test.questions[$scope.$parent.testpage].ansvers.length]=(index+1).toString();
            else{
                $scope.$parent.test.questions[$scope.$parent.testpage].ansvers.splice(
                    $scope.$parent.test.questions[$scope.$parent.testpage].ansvers.indexOf((index+1).toString()),
                    1
                );
            }
        };
        
        $scope.currentLesson={
            data:undefined,
            id:undefined
        };
        
        $scope.getCourseInfo=function(id,openflag){
            $scope.showresult=false;
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data,url:'php/getcoursedescription.php'})
                .then(function(data){
                    console.log(data);
                    $scope.currentCourse.data=data.data;
                    $scope.currentCourse.curator=data.data.curator;
                    if(openflag===true)
                        $scope.textOpen='Course';
            });
            //$scope.getActiveTest(id);
        };
        
        $scope.getLessonInfo=function(cid,lid,index){
            //if(index<$scope.currentStudent.data.lessons_learned+1){       
            $scope.showresult=false;
                var data={
                    user:$scope.loggedUser,
                    cid:cid,
                    lid:lid
                };
                $http({method:'POST',data:data,url:'php/getlessoncontent.php'})
                    .then(function(data){
                        $scope.currentLesson.data=data.data;
                        $scope.currentLesson.id=lid;
                        if($scope.currentCourse.data===undefined){
                            $scope.getCourseInfo(cid,false);
                        }
                        $scope.textOpen='Lesson';
                        $scope.currentLessonIndex=index;
                        $scope.currentCourseId=cid;
                });
            //}
        };
        
        $scope.lastQuestion=function(){
            if($scope.$parent.testpage>0){
                $scope.$parent.testpage--;
            }
        };
        $scope.nextQuestion=function(){
            if($scope.$parent.testpage<$scope.$parent.test.questions.length-1){
                $scope.$parent.testpage++;
            }
            else{
                var data1={
                    user:$scope.loggedUser,
                    sid:$scope.$parent.test.session_id
                };
                $http({method:'POST',data:data1,url:'php/finishtest.php'})
                    .then(function(data){
                        $scope.result=data.data;
                        $scope.$parent.testactive=false;
                        $scope.showresult=true;
                        $interval.cancel($scope.timer);
                    });
            }
        };
        
        $scope.nextLesson=function(){
            $scope.showresult=false;
            if($scope.currentLessonIndex>=0){
                var course=$filter('CourseFilter')($scope.courses,'ids',$scope.currentCourseId);
                if(course.length>0){
                    $scope.getLessonInfo($scope.currentCourseId,course[0].lessons[$scope.currentLessonIndex+1].id,$scope.currentLessonIndex+1);
                    $scope.currentStudent.data.lessons_learned++;
                }
            }
        };
        
        $scope.lastLesson=function(){
            $scope.showresult=false;
            if($scope.currentLessonIndex>=0){
                var course=$filter('CourseFilter')($scope.courses,'ids',$scope.currentCourseId);
                if(course.length>0){
                    $scope.getLessonInfo($scope.currentCourseId,course[0].lessons[$scope.currentLessonIndex-1].id,$scope.currentLessonIndex-1);
                }
            }
        };
        
        $scope.isDisabled=function(course){
            var test=$filter('FindTestForCourseFilter')($scope.$parent.tests,course.id);
            if(test!==undefined){
                if(test.active==true)
                    return false;
                else
                    return true;
            }
        };
        
    }]
);


