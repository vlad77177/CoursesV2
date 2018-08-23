App.controller('TestPageController',['$scope','$http','$filter','$q','LoggedUserService','UsersService','CoursesService','TestsService',
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
                if($scope.$parent.tests[i].id===id){
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
                        $scope.$parent.tests=t;//обновленный
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        }
                        $scope.isTestCorrect();
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
                        $scope.$parent.tests=t;
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        }
                        $scope.isTestCorrect();
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
                        $scope.$parent.tests=t;//обновленный                            
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
                        $scope.$parent.tests=t;//обновленный                            
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
                        $scope.$parent.tests=t;//обновленный   
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        }
                        $scope.isTestCorrect();
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
                        $scope.$parent.tests=t;//обновленный
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        }
                        $scope.isTestCorrect();
                    });
            });
        };
        
        $scope.changeTestSettings=function(){
            if($scope.isTestCorrect()===false){
                $scope.currentTest.data.active=0;
            }
            var data={
                user:$scope.loggedUser,
                data:$scope.currentTest.data
            };
            $http({method:'POST',data:data,url:'php/updatetestsettings.php'})
                .then(function(){
                    Tests.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(t){
                        $scope.$parent.tests=t;//обновленный                            
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        }     
                        $scope.isTestCorrect();
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
                        $scope.$parent.tests=t;//обновленный                            
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===$scope.currentTest.data.id){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
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
                $scope.$parent.tests=t;//обновленный
                $scope.getTestInfo($scope.currentTest.data.id);
                $scope.getQuestionInfo($scope.currentQuestion.data,$scope.currentTest.data.id);
                $scope.isTestCorrect();
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
                        $scope.$parent.tests=t;//обновленный                            
                        for(var i=0;i<$scope.$parent.tests.length;i++){
                            if($scope.$parent.tests[i].id===tid){
                                $scope.getTestInfo($scope.$parent.tests[i].id);
                            }
                        } 
                        $scope.getQuestionInfo($scope.currentQuestion.data,tid);
                        $scope.isTestCorrect();
                    });
            });
        };
        
        $scope.isTestCorrect=function(){
            if($scope.currentTest.data===undefined){
                return false;
            }
            var test=$scope.currentTest.data;
            if(test.threshold>test.display_q || test.minute_on_pass<1 || test.display_q>test.questions.length){
                return false;
            }
            for(var i=0;i<test.questions.length;i++){
                if(test.questions[i].variants===undefined){
                    return false;
                }
                if(test.questions[i].variants.length<2){
                    return false;
                }
                var answers_count=0;
                for(var j=0;j<test.questions[i].variants.length;j++){
                    if(test.questions[i].variants[j].isright==true)
                        answers_count++;
                }
                if(answers_count===0){
                    return false;
                }
            }
            return true;
        };
        
    }]
);


