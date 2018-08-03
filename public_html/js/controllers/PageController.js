App.controller('PageController',['$scope','$http','LoggedUserService','UsersService',
    function AdminPageController($scope, $http,LoggedUser,Users){
        $scope.openedPage='Users';
               
        $scope.currentCourse={
            data:undefined,
            curator:undefined
        };
        
        $scope.currentTest={
            data:undefined
        };
        
        $scope.currentQuestion={
            data:undefined
        };
        
        $scope.openPage=function(flag){
            $scope.openedPage=flag;
        };
    }]
);


