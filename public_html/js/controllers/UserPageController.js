/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
App.controller('UserPageController',['$scope','$http','$filter','LoggedUserService','UsersService','CoursesService',
    function AdminUserPageController($scope, $http,$filter,LoggedUser,Users,Courses){
        
        $scope.selectedUserID=undefined;
        
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
            name:undefined,
            surname:undefined,
            email:undefined,
            password:undefined,
            repeat:undefined,
            user_type:1,
            type_variants_admin:[
                {id:1,name:'Куратор'},
                {id:2,name:'Преподаватель'},
                {id:3,name:'Студент'}
            ],
            type_variants_curator:[
                {id:2,name:'Преподаватель'},
                {id:3,name:'Студент'}
            ]
        };
        
        $scope.searchType={
            types:[
                {id:1,type:'ID'},
                {id:2,type:'Логин'},
                {id:3,type:'Имя'},
                {id:4,type:'Фамилия'}
            ],
            model:1
        };
        
        $scope.searchString=undefined;
        
        $scope.selectUser=function(id){
            $scope.selectedUserID=id;
            $scope.$parent.currentUser.id=id;
            var user=$filter('UserFilter')($scope.$parent.users,'id',id);
            $scope.$parent.currentUser.login=user[0].login;
            $scope.$parent.currentUser.name=user[0].name;
            $scope.$parent.currentUser.surname=user[0].surname;
            $scope.$parent.currentUser.email=user[0].email;
            $scope.$parent.currentUser.cur_students=user[0]['cur_students'];
            $scope.$parent.currentUser.cur_teachers=user[0]['cur_teachers'];
            $scope.$parent.currentUser.teach_courses=user[0]['teach_courses'];
            $scope.$parent.currentUser.teach_students=user[0]['teach_students'];
            $scope.$parent.currentUser.courses=user[0]['courses'];
            $scope.$parent.currentUser.curator=user[0]['curator'];
            $scope.$parent.currentUser.learneds=user[0]['learneds'];
            $scope.$parent.currentUser.need_learns=user[0]['need_learns'];
            $scope.$parent.currentUser.results=user[0]['results'];
            $scope.$parent.currentUser.teachers=user[0]['teachers'];
            if(user[0].administrator==true)
                $scope.$parent.currentUser.is_admin=true;
            else
                $scope.$parent.currentUser.is_admin=false;
            if(user[0].curator==true){
                $scope.$parent.currentUser.is_curator=true;
                
                //фильтрую сначала неподписанных, потом ищу среди них студентов               
                var stud=new Array();
                var curators=$filter('UserFilter')($scope.$parent.users,'curator');
                /*
                 * Надо выбрать только тех студентов, которые не принадлежат другим кураторам
                 */
                var used_students_ids=new Array();
                for(var i=0;i<curators.length;i++){
                    used_students_ids=used_students_ids.concat(curators[i].cur_students);
                }
                stud=$filter('UserFilter')($scope.$parent.users,'unids',used_students_ids);
                
                if($scope.$parent.currentUser.cur_students!==undefined){
                    $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')(stud,'unids',$scope.$parent.currentUser.cur_students)),'student');
                }
                else{
                    $scope.unlinkStudents.students=$filter('UserFilter')(stud,'student');
                }
                
                //по аналогии
                var teach=new Array();
                var curators=$filter('UserFilter')($scope.$parent.users,'curator');
                /*
                 * Надо выбрать только тех учителей, которые не принадлежат другим кураторам
                 */
                var used_teachers_ids=new Array();
                for(var i=0;i<curators.length;i++){
                    used_teachers_ids=used_teachers_ids.concat(curators[i].cur_teachers);
                }
                teach=$filter('UserFilter')($scope.$parent.users,'unids',used_teachers_ids);
                
                if($scope.currentUser.cur_teachers!==undefined){
                    $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')(teach,'unids',$scope.$parent.currentUser.cur_teachers)),'teacher');
                }
                else{
                    $scope.unlinkteachers.teachers=$filter('UserFilter')(teach,'teacher');
                }
            }
            else
                $scope.$parent.currentUser.is_curator=false;
            if(user[0].teacher==true){
                $scope.$parent.currentUser.is_teacher=true;
                $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.$parent.courses,'unids',$scope.$parent.currentUser.teach_courses);
            }
            else
                $scope.$parent.currentUser.is_teacher=false;
            if(user[0].student==true){
                $scope.$parent.currentUser.is_student=true;
                
                var data={
                    user:$scope.loggedUser,
                    id:$scope.$parent.currentUser.id
                };
                
                $http({method:'POST',data:data,url:'php/getuserresults.php'})
                    .then(function(data){
                        $scope.$parent.currentUser.detailed_results=data;
                });
            }
            else
                $scope.$parent.currentUser.is_student=false;
            console.log($scope.$parent.currentUser);
        };
        
        $scope.saveUserData=function(){
            var data={
                user:$scope.loggedUser,
                currentUser:$scope.$parent.currentUser
            };
            if($scope.$parent.currentUser.newpass===$scope.$parent.currentUser.repeat){
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
                                $scope.$parent.users=us;
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
                curator_id:$scope.$parent.currentUser.id,
                mode:1
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.$parent.users=us;
                        $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_students)),'student');
                        $scope.selectUser($scope.$parent.currentUser.id);
                    });
            });
        };
        $scope.linkTeacher=function(){
            var data={
                user:$scope.loggedUser,
                teacher_id:$scope.unlinkTeachers.value,
                curator_id:$scope.$parent.currentUser.id,
                mode:2
            };
            $http({method:'POST',data:data,url:'php/linkuser.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.$parent.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.$parent.currentUser.id);
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
                        $scope.$parent.users=us;
                        $scope.unlinkStudents.students=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_students)),'student');
                        $scope.selectUser($scope.$parent.currentUser.id);
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
                        $scope.$parent.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.$parent.currentUser.id);
                    });
            });
            
        };
        
        $scope.linkCourse=function(){
            var data={
                user:$scope.loggedUser,
                teacher_id:$scope.$parent.currentUser.id,
                course_id:$scope.unlinkCourses.value
            };
            $http({method:'POST',data:data,url:'php/linkcourse.php'})
                .then(function(){
                    Users.reset($scope.loggedUser.login,$scope.loggedUser.password).then(function(us){
                        $scope.$parent.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.$parent.currentUser.id);
                    });
                    Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.$parent.courses=c;
                        $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.$parent.courses,'unids',$scope.$parent.currentUser.teach_courses);
                        $scope.selectUser($scope.$parent.currentUser.id);
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
                        $scope.$parent.users=us;
                        $scope.unlinkTeachers.teachers=$filter('UserFilter')(($filter('UserFilter')($scope.$parent.users,'unids',$scope.$parent.currentUser.cur_teachers)),'teacher');
                        $scope.selectUser($scope.$parent.currentUser.id);
                    });
                    Courses.get($scope.loggedUser.login,$scope.loggedUser.password).then(function(c){
                        $scope.$parent.courses=c;
                        $scope.unlinkCourses.courses=$filter('CourseFilter')($scope.$parent.courses,'unids',$scope.$parent.currentUser.teach_courses);
                        $scope.selectUser($scope.$parent.currentUser.id);
                    });
            });
            
        };
        
        $scope.showDetailedResults=function(user,course){
            $scope.$parent.showdetailedresults=true;
            console.log('showResults');
        };
               
    }]
);
