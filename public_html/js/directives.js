App.directive('loginForm',function(){
    return{
        restrict:'E',
        templateUrl:'templates/loginform.html',
        replace:true
    };
});
App.directive('mainPage',function(){
    return{
        restrict:'E',
        templateUrl:'templates/mainpage.html',
        replace:true
    };
});

App.directive('studentPage',function(){
    return{
        restrict:'E',
        templateUrl:'templates/studentpage.html',
        replace:true
    };
});

App.directive('curatorExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/curatorextended.html',
        replace:true
    };
});

App.directive('courseExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/coursextended.html',
        replace:true
    };
});

App.directive('teacherExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/teacherextended.html',
        replace:true
    };
});

App.directive('studentExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/studentextended.html',
        replace:true
    };
});

App.directive('testExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/testextended.html',
        replace:true
    };
});

App.directive('questionExtended',function(){
    return{
        restrict:'E',
        templateUrl:'templates/questionextended.html',
        replace:true
    };
});

App.directive('testingPage',function(){
    return{
        restrict:'E',
        templateUrl:'templates/testingpage.html',
        replace:true
    };
});

App.directive('detailedResult',function(){
    return{
        restrict:'E',
        templateUrl:'templates/detailedresult.html',
        replace:true
    };
});

App.directive('welcomePage',function(){
    return{
        restrict:'E',
        templateUrl:'templates/welcome.html',
        replace:true
    };
});

 App.directive('inDevelopingPage',function(){
    return{
        restrict:'E',
        templateUrl:'templates/indeveloping.html',
        replace:true
    };
});

App.directive('menuBlock',function(){
    return{
        restrict:'E',
        templateUrl:'templates/menublock.html',
        replace:true
    };
});

App.directive('educational',function(){
    return{
        restrict:'E',
        templateUrl:'templates/educational.html',
        replace:true
    };
});

//обработка модели чекбоксов, корректная связь boolean и int 
App.directive('intbooleanvalidation',function(){
    return{
        require:'ngModel',
        restrict:'A',
        link: function($scope, $element, $attrs, modelCtrl) {
            modelCtrl.$formatters.push(function (modelValue) {
                if(modelValue==1)
                    return true;
                else
                    return false;
            });

            modelCtrl.$parsers.push(function (viewValue) {
                if(viewValue==true)
                    return 1;
                else
                    return 0;
            });               
        }
    };
});
/*
App.directive('educationalContent',function(){
    return{
        require:'ngBindHtml',
        restrict:'A',
        
    };
});*/
