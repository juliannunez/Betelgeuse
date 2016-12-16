app.controller('authCtrl', function ($scope, $rootScope, $routeParams, $location, $http, Data) {
    //initially set those objects to null to avoid undefined error
    $scope.login = {};
    $scope.signup = {};
    $scope.rooms = {};
    $scope.courses = {};
    $scope.microcurriculos = {};
    $scope.vinculos = {};
    $scope.programaciones = {};

    $scope.doLogin = function (customer) {
        Data.post('login', {
            customer: customer
        }).then(function (results) {
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };
    $scope.signup = {tipo_doc:'',nro_doc:'',nombre:'',link_cv:'',telefono:'',email:'',direccion:''};
    $scope.signUp = function (customer) {
        Data.post('signUp', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.rooms = {numero:'',capacidad:'',tipo_aula:''};
    $scope.rooms = function (customer) {
        Data.post('rooms', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.courses = {codigo:'',nombre:'',nro_creditos:'',intensidad_horaria:'',version_pensum:''};
    $scope.courses = function (customer) {
        Data.post('courses', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.microcurriculos = {semestre:'',cod_curso:'',link:''};
    $scope.microcurriculos = function (customer) {
        Data.post('microcurriculos', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.vinculos = {tipo_doc:'',nro_doc:'',tipo:''};
    $scope.vinculos = function (customer) {
        Data.post('vinculos', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.disponibilidades = {tipo_doc:'',nro_doc:'',dia:'',hora_desde:'',hora_hasta:''};
    $scope.disponibilidades = function (customer) {
        Data.post('disponibilidades', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };

    $scope.programaciones = {codigo:'',grupo:'',semestre:'',est_matriculados:''};
    $scope.programaciones = function (customer) {
        Data.post('programaciones', {
            customer: customer
        }).then(function (results) {
            console.log(results);
            Data.toast(results);
            if (results.status == "success") {
                $location.path('dashboard');
            }
        });
    };


    $scope.logout = function () {
        Data.get('logout').then(function (results) {
            Data.toast(results);
            $location.path('login');
        });
    }
});