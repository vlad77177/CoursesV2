App.controller('AdminTestPageController',['$scope','$http','$filter','$q','LoggedUserService','UsersService','CoursesService','TestsService',
    function AdminTestPageController($scope, $http,$filter,$q,LoggedUser,Users,Courses,Tests){
        
        $scope.getTestInfo=function(id){
            for(var i=0;i<$scope.tests.length;i++){
                if($scope.tests[i].id===id){
                    $scope.currentTest.data=$scope.tests[i];
                }
            }
        };
        
        $scope.addQuestion=function(tid){
            var data={
                user:$scope.loggedUser,
                data:tid
            };
            $http({method:'POST',data:data,url:'php/createnewquestion.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                    });
            });
        };
        
        $scope.addTest=function(){
            var data={
                user:$scope.loggedUser
            };
            $http({method:'POST',data:data,url:'php/createnewtest.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                    });
            });
        };
        
        $scope.changeTestSettings=function(){
            var data={
                user:$scope.loggedUser,
                data:$scope.currentTest.data
            };
            $http({method:'POST',data:data,url:'php/updatetestsettings.php'})
                .then(function(){
                    Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.courses=c;
                        $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.courses,'unids',$scope.currentUser.teach_courses);
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        $scope.getQuestionInfo=function(question,test_id){ 
            $scope.currentQuestion.data=question;
            if($scope.currentTest.data===undefined){
                $scope.getTestInfo(test_id);
            }
        };
        
        $scope.changeIsRight=function(variant){
            var qid=$scope.currentQuestion.data;
            var tid=$scope.currentTest.data.id;
            var data={
                user:$scope.loggedUser,
                id:variant
            };
            $http({method:'POST',data:data,url:'php/changevariantisright.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                        for(var i=0;i<$scope.tests.length;i++){
                            if($scope.tests[i].id===tid){
                                $scope.getTestInfo($scope.tests[i].data.id);
                            }
                        }
                        for(var i=0;i<$scope.currentTest.data.questions.length;i++){
                            if($scope.currentTest.data.questions[i].id===qid){
                                $scope.getQuestionInfo($scope.currentTest.data.questions[i],tid);                               
                            }
                        }
                    });
            });
        };
        
    }]
);


