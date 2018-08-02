/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
App.controller('AdminUserPageController',['$scope','$http','$filter','LoggedUserService','UsersService','CoursesService',
    function AdminUserPageController($scope, $http,$filter,LoggedUser,Users,Courses){
        
        $scope.selectedUserID=undefined;
        
        $scope.currentUser={
            id:undefined,
            login:undefined,
            email:undefined,
            newpass:undefined,
            repeat:undefined,
            cur_students:[],
            cur_teachers:[],
            teach_courses:[],
            teach_students:[],
            is_admin:false,
            is_curator:false,
            is_teacher:false,
            is_student:false
        };
        
        $scope.unlinkStudents={
            value:undefined,
            students:[]
        };
        $scope.unlinkTeachers={
            value:undefined,
            teachers:[]
        };
        
        $scope.unlinkCourses={
            value:undefined,
            courses:[]
        };
        
        $scope.newUser={
            login:undefined,
            email:undefined,
            password:undefined,
            repeat:undefined,
            user_type:1,
            type_variants:[
                {id:1,name:'Куратор'},
                {id:2,name:'Преподаватель'},
                {id:3,name:'Студент'}
            ]
        };
        
        $scope.selectUser=function(id){
            $scope.selectedUserID=id;
            $scope.currentUser.id=id;
            var user=$filter('UserFilter')($scope.users,'id',id);
            $scope.currentUser.login=user[0].login;
            $scope.currentUser.email=user[0].email;
            $scope.currentUser.cur_students=user[0]['cur_students'];
            $scope.currentUser.cur_teachers=user[0]['cur_teachers'];
            $scope.currentUser.teach_courses=user[0]['teach_courses'];
            $scope.currentUser.teach_students=user[0]['teach_students'];
            if(user[0].administrator==true)
                $scope.currentUser.is_admin=true;
            else
                $scope.currentUser.is_admin=false;
            if(user[0].curator==true){
                $scope.currentUser.is_curator=true;
                //фильтрую сначала неподписанных, потом ищу среди них студентов
                $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_students)),'student');
                //по аналогии
                $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_teachers)),'teacher');
            }
            else
                $scope.currentUser.is_curator=false;
            if(user[0].teacher==true){
                $scope.currentUser.is_teacher=true;
                $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.courses,'unids',$scope.currentUser.teach_courses);
            }
            else
                $scope.currentUser.is_teacher=false;
            if(user[0].student==true){
                $scope.currentUser.is_student=true;
            }
            else
                $scope.currentUser.is_student=false;
        };
        
        $scope.saveUserData=function(){
            var data={
                user:$scope.loggedUser,
                currentUser:$scope.currentUser
            };
            if($scope.currentUser.newpass===$scope.currentUser.repeat){
                $http({method:'POST',data:data,url:'php/saveuserdata.php'})
                    .then(function(data){
                        alert(JSON.stringify(data));
                });
            }
            else{
                alert('Пароли не совпадают! Проверьте корректноть введенных данных!');
            }
        };
        
        $scope.createNewUser=function(){
            if($scope.newUser.login!==undefined && $scope.newUser.email!==undefined && $scope.newUser.password!==undefined){
                if($scope.newUser.password===$scope.newUser.repeat){
                    var data={
                        user:$scope.loggedUser,
                        newUser:$scope.newUser
                    };
                    $http({method:'POST',data:data,url:'php/createnewuser.php'})
                        .then(function(){
                            Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                                $scope.users=us;
                            });
                    });
                }
                else{
                    alert('Пароли не совпадают!');
                }
            }
            else{
                alert('Введите все данные!');
            }
        };
        
        $scope.linkStudent=function(){
            var data={
                user:$scope.loggedUser,
                student_id:$scope.unlinkStudents.value,
                curator_id:$scope.currentUser.id,
                mode:1
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_students)),'student');
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        $scope.linkTeacher=function(){
            var data={
                user:$scope.loggedUser,
                teacher_id:$scope.unlinkTeachers.value,
                curator_id:$scope.currentUser.id,
                mode:2
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        $scope.unlinkStudent=function(sid,cid){
            var data={
                user:$scope.loggedUser,
                student_id:sid,
                curator_id:cid,
                mode:1
            };
            $http({method:'POST',data:data,url:'php/unlinkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_students)),'student');
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        $scope.unlinkTeacher=function(tid,cid){
            var data={
                user:$scope.loggedUser,
                teacher_id:tid,
                curator_id:cid,
                mode:2
            };
            $http({method:'POST',data:data,url:'php/unlinkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
            
        };
        
        $scope.linkCourse=function(){
            var data={
                user:$scope.loggedUser,
                teacher_id:$scope.currentUser.id,
                course_id:$scope.unlinkCourses.value
            };
            $http({method:'POST',data:data,url:'php/linkcourse.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.currentUser.id);
                    });
                    Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.courses=c;
                        $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.courses,'unids',$scope.currentUser.teach_courses);
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
        };
        
        $scope.unlinkCourse=function(cid,tid){
            var data={
                user:$scope.loggedUser,
                teacher_id:tid,
                course_id:cid
            };
            $http({method:'POST',data:data,url:'php/unlinkcourse.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.users,'unids',$scope.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.currentUser.id);
                    });
                    Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.courses=c;
                        $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.courses,'unids',$scope.currentUser.teach_courses);
                        $scope.selectUser($scope.currentUser.id);
                    });
            });
            
        };
    }]
);
