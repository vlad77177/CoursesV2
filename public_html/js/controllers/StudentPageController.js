App.controller('StudentPageController',['$scope','$http','$filter','LoggedUserService','UsersService','CoursesService',
    function StudentPageController($scope, $http,$filter,LoggedUser,Courses){
       
        $scope.textOpen=undefined;
       
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
                });
            }
        };
        
    }]
);


