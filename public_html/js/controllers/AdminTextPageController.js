App.controller('AdminTextPageController',['$scope','$http','$filter','$q','LoggedUserService','UsersService','CoursesService',
    function AdminTextPageController($scope, $http,$filter,$q,LoggedUser,Users,Courses){
        
        $scope.textOpen='Course';
        
        $scope.currentLesson={
            data:undefined,
            id:undefined,
            name:undefined,
        };
        
        $scope.editableTextArea={
            value:false
        };
        
        $scope.saveCourseName=function(id,name){
            
            $scope.data={
                user:$scope.loggedUser,
                id:id,
                name:name
            };
            
            $http({method:'POST',data:$scope.data,url:'php/updatecoursename.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.saveLessonName=function(id,name){
            
            var data={
                user:$scope.loggedUser,
                id:id,
                name:name
            };
            
            $http({method:'POST',data:data,url:'php/updatelessonname.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.createNewCourse=function(){
            var data={
                user:$scope.loggedUser
            };
            $http({method:'POST',data:data,url:'php/createnewcourse.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.createNewLesson=function(id){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data,url:'php/createnewlesson.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.deleteCourse=function(id){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data, url:'php/deletecourse.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.deleteLesson=function(id){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data, url:'php/deletelesson.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.getCourseInfo=function(id,openflag){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data,url:'php/getcoursedescription.php'})
                .then(function(data){
                    $scope.currentCourse.data=data.data;
                    $scope.currentCourse.curator=data.data.curator;
                    if(openflag===true)
                        $scope.textOpen='Course';
            });
        };
        
        $scope.getLessonInfo=function(cid,lid){
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
            });
        };
        
    }]
);


