App.controller('CoursesPageController',['$scope','$http','$filter','LoggedUserService','UsersService','CoursesService',
    function AdminCoursesPageController($scope, $http,$filter,LoggedUser,Users,Courses){

        $scope.openedCourseExPage='Users';
        
        $scope.unlinkCuratorCourse={
            value:undefined,
            curators:[]
        };
        
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
                    
                    $scope.unlinkCuratorCourse.curators=$filter('UserFilter')($scope.users,'curator');
                    $scope.unlinkCuratorCourse.value=$scope.currentCourse.curator;
                    
                    var cur=$filter('UserFilter')($scope.$parent.users,'id',$scope.currentCourse.curator);//куратор, который привязан к курсу
                    
                    if(cur[0]!==undefined){
                        var u=$filter('UserInIDArrayFilter')($scope.users,cur[0].cur_teachers);    //список пользователей, прин куратору                
                        if($scope.currentCourse.data.teachers!==undefined){                        
                            $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')(u,'unids',$scope.currentCourse.data.teachers)),'teacher');
                        }
                        else{
                            $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(u,'teacher');
                        }

                        var stud=$filter('UserInIDArrayFilter')($scope.users,cur[0].cur_students); //список студентов                    
                        if($scope.currentCourse.data.users!==undefined){
                            $scope.unlinkStudentsCourse.students=$filter('UserFilter')(($filter('UserFilter')(stud,'unids',$scope.currentCourse.data.users)),'student');
                        }
                        else{
                            $scope.unlinkStudentsCourse.students=$filter('UserFilter')(stud,'student');
                        }
                    }
            });
        };
        
        $scope.createNewCourse=function(){
            var data={
                user:$scope.loggedUser
            };
            $http({method:'POST',data:data,url:'php/createnewcourse.php'})
                    .then(function(){
                        Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                            $scope.$parent.courses=c;
                            $scope.contentDownload.courses=true;
                        });
            });
        };
        
        $scope.openCourseExPage=function(flag){
            $scope.openedCourseExPage=flag;
        };
        
        $scope.setCurator=function(){
            var data={
                user:$scope.loggedUser,
                curator_id:$scope.unlinkCuratorCourse.value,
                course_id:$scope.currentCourse.data.description.id_course,
                mode:5
            };
            console.log(data);
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    Courses.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.$parent.courses=c;
                    });
                    $scope.getCourseInfo($scope.currentCourse.data.description.id_course);
            });
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
                        $scope.$parent.users=us;
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.currentCourse.data.teachers)),'teacher');
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
                        $scope.$parent.users=us;
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
                        $scope.$parent.users=us;
                        $scope.unlinkTeachersCourse.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.currentCourse.data.teachers)),'teacher');
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
                        $scope.$parent.users=us;
                    });
            });
        };
        
        
    }]
);


