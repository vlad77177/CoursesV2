App.controller('StudentPageController',['$scope','$http','$filter','$interval','LoggedUserService','UsersService','CoursesService',
    function StudentPageController($scope, $http,$filter,$interval,LoggedUser,Courses){
       
        $scope.textOpen=undefined;
               
        $scope.showresult=false;        
        $scope.result=null;       
        
        $scope.currentLessonIndex=undefined;
        $scope.currentCourseId=undefined;
        
        $scope.tick=function(){
            if($scope.test!=undefined){
                $scope.test.seconds=$scope.test.seconds-1;
                var hour=Math.floor($scope.test.seconds/(60*60));
                var minute=Math.floor($scope.test.seconds/60)-hour*60;
                var second=$scope.test.seconds-(hour*(60*60))-minute*60;
                $scope.clockmodel=""+hour+":"+minute+":"+second;
            }
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
                                        $scope.alreadyinit=true;
                                        $scope.testactive=true;
                                        $scope.test=data.data;
                                        $interval(function(){$scope.tick();},1000);
                                        $scope.continueTest();
                                    }
                                });
                    });
        };
        
        $scope.ansver=function(index){
            var data={
                user:$scope.loggedUser,
                qsid:$scope.test.questions[$scope.testpage].id_session,
                ansver:index+1,
                number:$scope.testpage+1
            };
            $http({method:'POST',data:data,url:'php/ansver.php'})
                    .then(function(data){
                        if($scope.test.questions.length==$scope.testpage+1){
                            var data1={
                                user:$scope.loggedUser,
                                sid:$scope.test.session_id
                            };
                            $http({method:'POST',data:data1,url:'php/finishtest.php'})
                                .then(function(data){
                                    $scope.result=data.data;
                                    $scope.testactive=false;
                                    $scope.showresult=true;
                                });
                        }
                        $scope.testpage=$scope.testpage+1;
                    });
            $scope.test.questions[$scope.testpage].ansvers[$scope.test.questions[$scope.testpage].ansvers.length]=index+1;
        };
        
        $scope.currentLesson={
            data:undefined,
            id:undefined
        };
        
        $scope.getCourseInfo=function(id,openflag){
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
        };
        
        $scope.getLessonInfo=function(cid,lid,index){
            if(index<$scope.currentStudent.data.lessons_learned+1){                
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
            }
        };
        
        $scope.nextLesson=function(){
            if($scope.currentLessonIndex>=0){
                var course=$filter('CourseFilter')($scope.courses,'ids',$scope.currentCourseId);
                if(course.length>0){
                    $scope.getLessonInfo($scope.currentCourseId,course[0].lessons[$scope.currentLessonIndex+1].id,0);
                    $scope.currentStudent.data.lessons_learned++;
                }
            }
        };
        
        $scope.lastLesson=function(){
            if($scope.currentLessonIndex>=0){
                var course=$filter('CourseFilter')($scope.courses,'ids',$scope.currentCourseId);
                if(course.length>0){
                    $scope.getLessonInfo($scope.currentCourseId,course[0].lessons[$scope.currentLessonIndex-1].id,0);
                }
            }
        };
        
    }]
);


