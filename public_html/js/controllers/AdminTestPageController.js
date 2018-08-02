App.controller('AdminTestPageController',['$scope','$http','$filter','$q','LoggedUserService','UsersService','CoursesService','TestsService',
    function AdminTestPageController($scope, $http,$filter,$q,LoggedUser,Users,Courses,Tests){
        
        $scope.editTestName=false;
        
        $scope.editableTextAreaQ={
            value:false
        };
        
        $scope.editableTextAreaV={
            value:false
        };
        
        $scope.savedVariant={
            id_text:undefined,
            text:undefined
        };
        
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
        
        $scope.deleteQuestion=function(question){
            var data={
                user:$scope.loggedUser,
                id:question.id
            };
            $http({method:'POST',data:data,url:'php/deletequestion.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;                         
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
        
        $scope.deleteTest=function(){
            var data={
                user:$scope.loggedUser,
                id:$scope.currentTest.data.id
            };
            $http({method:'POST',data:data,url:'php/deletetest.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                    });
            });
        };
        
        $scope.addVariant=function(){
            var data={
                user:$scope.loggedUser,
                question:$scope.currentQuestion.data.id
            };
            $http({method:'POST',data:data,url:'php/createnewvariant.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                    });
            });
        };
        
        $scope.deleteVariant=function(id){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data,url:'php/deletevariant.php'})
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
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                        for(var i=0;i<$scope.tests.length;i++){
                            if($scope.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.tests[i].id);
                            }
                        }                              
                    });
            });
        };
        
        $scope.changeTestName=function(){
            var data={
                user:$scope.loggedUser,
                id:$scope.currentTest.data.id,
                name:$scope.currentTest.data.name
            };
            $http({method:'POST',data:data,url:'php/updatetestname.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.tests=t;//обновленный                            
                        for(var i=0;i<$scope.tests.length;i++){
                            if($scope.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.tests[i].id);
                            }
                        }                              
                    });
            });
        };
        
        $scope.getQuestionInfo=function(question,test_id){
            if($scope.currentTest.data===undefined){
                $scope.getTestInfo(test_id);
            }
            for(var i=0;i<$scope.currentTest.data.questions.length;i++){
                if(question.id===$scope.currentTest.data.questions[i].id){
                    $scope.currentQuestion.data=$scope.currentTest.data.questions[i];
                }
            }           
        };
        
        $scope.reloadTest=function(){
            Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                $scope.tests=t;//обновленный
                $scope.getTestInfo($scope.currentTest.data.id);
                $scope.getQuestionInfo($scope.currentQuestion.data,$scope.currentTest.data.id);
            });
        };
        
        $scope.saveVariantTmpData=function(id_text,text){
            $scope.savedVariant.id_text=id_text;
            $scope.savedVariant.text=text;
        };
        
        $scope.changeIsRight=function(variant){
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
                                $scope.getTestInfo($scope.tests[i].id);
                            }
                        } 
                        $scope.getQuestionInfo($scope.currentQuestion.data,tid);                               
                    });
            });
        };
        
    }]
);


