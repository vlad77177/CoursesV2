App.controller('CuratorUserPageController',['$scope','$http','$filter','LoggedUserService','UsersService',
    function CuratorUserPageController($scope, $http,$filter,LoggedUser,Users){
        /*
        $scope.selectedUserID=undefined;
        
        $scope.currentUser={
            id:undefined,
            login:undefined,
            email:undefined,
            newpass:undefined,
            repeat:undefined,
            is_admin:false,
            is_curator:false,
            is_teacher:false,
            is_student:false
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
            if(user[0].admin===true)
                $scope.currentUser.is_admin=true;
            if(user[0].curator===true)
                $scope.currentUser.is_curator=true;
            if(user[0].teacher===true)
                $scope.currentUser.is_teacher=true;
            if(user[0].admin===true)
                $scope.currentUser.is_student=true;
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
        };*/
    }]
);

