App.controller('AdminTextPageController',['$scope','$http','$filter','$q','LoggedUserService','UsersService',
    function AdminTextPageController($scope, $http,$filter,$q,LoggedUser,Users){
        
        $scope.textOpen='Course';
        
        $scope.currentLesson={
            data:undefined,
            id:undefined
        };
        
        $scope.editableTextArea={
            value:false
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


