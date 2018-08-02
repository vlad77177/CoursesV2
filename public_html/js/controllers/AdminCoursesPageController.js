App.controller('AdminCoursesPageController',['$scope','$http','$filter','LoggedUserService','UsersService','CoursesService',
    function AdminCoursesPageController($scope, $http,$filter,LoggedUser,Users,Courses){

        $scope.openedCourseExPage='Users';
        
        $scope.unlinkTeachersCourse={
            value:undefined,
            teachers:[]
        };
        $scope.unlinkStudentsCourse={
            value:undefined,
            students:[]
        };
        
        $scope.getCourseInfo=function(id){
            var data={
                user:$scope.loggedUser,
                id:id
            };
            $http({method:'POST',data:data,url:'php/getcoursedescription.php'})
                .then(function(data){
                    $scope.currentCourse.data=data.data;
                    $scope.currentCourse.curator=data.data.curator;
                    
                    if($scope.currentCourse.data.teachers!==undefined){
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.teachers)),'teacher');
                    }
                    else{
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')($scope.users,'teacher');
                    }
                    if($scope.currentCourse.data.users!==undefined){
                        $scope.unlinkStudentsCourse.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.users)),'student');
                    }
                    else{
                        $scope.unlinkStudentsCourse.students=$filter('UserFilter')($scope.users,'student');
                    }
            });
        };
        
        $scope.openCourseExPage=function(flag){
            $scope.openedCourseExPage=flag;
        };
        
        $scope.linkTeacher=function(){
            var data={
                user:$scope.loggedUser,
                teacher_id:$scope.unlinkTeachersCourse.value,
                course_id:$scope.currentCourse.data.description.id_course,
                mode:3
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    $scope.getCourseInfo($scope.currentCourse.data.description.id_course);
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.teachers)),'teacher');
                        //$scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        $scope.linkStudent=function(){
            var data={
                user:$scope.loggedUser,
                student_id:$scope.unlinkStudentsCourse.value,
                course_id:$scope.currentCourse.data.description.id_course,
                mode:4
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    $scope.getCourseInfo($scope.currentCourse.data.description.id_course);
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkStudentsCourse.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.users)),'student');
                        //$scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        $scope.unlinkTeacher=function(tid,cid){
            var data={
                user:$scope.loggedUser,
                teacher_id:tid,
                course_id:cid,
                mode:3
            };
            $http({method:'POST',data:data,url:'php/unlinkuser.php'})
                .then(function(){
                    $scope.getCourseInfo($scope.currentCourse.data.description.id_course);
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.teachers)),'teacher');
                        //$scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        $scope.unlinkStudent=function(sid,cid){
            var data={
                user:$scope.loggedUser,
                student_id:sid,
                course_id:cid,
                mode:4
            };
            $http({method:'POST',data:data,url:'php/unlinkuser.php'})
                .then(function(){
                    $scope.getCourseInfo($scope.currentCourse.data.description.id_course);
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkStudentsCourse.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentCourse.data.users)),'student');
                        //$scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        
    }]
);


