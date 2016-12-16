var app = angular.module('myApp', ['ngRoute', 'ngAnimate', 'toaster']);

app.config(['$routeProvider',
  function ($routeProvider) {
        $routeProvider.
        when('/login', {
            title: 'Login',
            templateUrl: 'partials/login.html',
            controller: 'authCtrl'
        })
            .when('/logout', {
                title: 'Logout',
                templateUrl: 'partials/login.html',
                controller: 'logoutCtrl'
            })
            .when('/signup', {
                title: 'Signup',
                templateUrl: 'partials/signup.html',
                controller: 'authCtrl'
            })
            .when('/dashboard', {
                title: 'Dashboard',
                templateUrl: 'partials/dashboard.html',
                controller: 'authCtrl'
                })
            .when('/rooms', {
                title: 'rooms',
                templateUrl: 'partials/rooms.html',
                controller: 'authCtrl'
            })
            .when('/courses', {
                title: 'courses',
                templateUrl: 'partials/courses.html',
                controller: 'authCtrl'
            })
            .when('/microcurriculos', {
                title: 'microcurriculos',
                templateUrl: 'partials/microcurriculos.html',
                controller: 'authCtrl'
            })
            .when('/vinculos', {
                title: 'vinculos',
                templateUrl: 'partials/vinculos.html',
                controller: 'authCtrl'
            })
            .when('/disponibilidades', {
                title: 'disponibilidades',
                templateUrl: 'partials/disponibilidades.html',
                controller: 'authCtrl'
            })
            .when('/programaciones', {
                title: 'programaciones',
                templateUrl: 'partials/programaciones.html',
                controller: 'authCtrl'
            })
            .when('/', {
                title: 'Login',
                templateUrl: 'partials/login.html',
                controller: 'authCtrl',
                role: '0'
            })
            .otherwise({
                redirectTo: '/login'
            });
  }])
    .run(function ($rootScope, $location, Data) {
        $rootScope.$on("$routeChangeStart", function (event, next, current) {
            $rootScope.authenticated = false;
            Data.get('session').then(function (results) {
                if (results.uid) {
                    $rootScope.authenticated = true;
                    $rootScope.uid = results.uid;
                    $rootScope.name = results.name;
                    $rootScope.email = results.email;
                    

                } else {
                    var nextUrl = next.$$route.originalPath;
                    if (nextUrl == '/signup' || nextUrl == '/login' || nextUrl == '/rooms' || nextUrl == '/courses' || nextUrl == '/microcurriculos' || nextUrl == '/vinculos' || nextUrl == '/disponibilidades' || nextUrl == '/programaciones') {

                    } else {
                        $location.path("/login");
                    }
                }
            });
        });
    });