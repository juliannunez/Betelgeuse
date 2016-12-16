<?php 
$app->get('/session', function() {
    $db = new DbHandler();
    $session = $db->getSession();
    $response["uid"] = $session['uid'];
    $response["email"] = $session['email'];
    $response["name"] = $session['name'];
    echoResponse(200, $session);
});

$app->post('/login', function() use ($app) {
    require_once 'passwordHash.php';
    $r = json_decode($app->request->getBody());
    verifyRequiredParams(array('email', 'password'),$r->customer);
    $response = array();
    $db = new DbHandler();
    $password = $r->customer->password;
    $email = $r->customer->email;
    $user = $db->getOneRecord("select uid,name,password,email,created from customers_auth where phone='$email' or email='$email'");
    if ($user != NULL) {
        if(passwordHash::check_password($user['password'],$password)){
        $response['status'] = "success";
        $response['message'] = 'Logged in successfully.';
        $response['name'] = $user['name'];
        $response['uid'] = $user['uid'];
        $response['email'] = $user['email'];
        $response['createdAt'] = $user['created'];
        if (!isset($_SESSION)) {
            session_start();
        }
        $_SESSION['uid'] = $user['uid'];
        $_SESSION['email'] = $email;
        $_SESSION['name'] = $user['name'];
        } else {
            $response['status'] = "error";
            $response['message'] = 'Login failed. Incorrect credentials';
        }
    }else {
            $response['status'] = "error";
            $response['message'] = 'No such user is registered';
        }
    echoResponse(200, $response);
});

$app->post('/signUp', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $tipo_doc = $r->customer->tipo_doc;
    $nro_doc = $r->customer->nro_doc;
    $nombre = $r->customer->nombre;
    $link_cv = $r->customer->link_cv;
    $telefono = $r->customer->telefono;
    $email = $r->customer->email;
    $direccion = $r->customer->direccion;
    $isUserExists = $db->getOneRecord("select 1 from profesor where nro_doc='$nro_doc'");
    if(!$isUserExists){
        $tabble_name = "profesor";
        $column_names = array('tipo_doc', 'nro_doc', 'nombre', 'link_cv', 'telefono', 'direccion', 'email');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "An user with the provided phone or email exists!";
        echoResponse(201, $response);
    }
});

$app->post('/rooms', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $numero = $r->customer->numero;
    $capacidad = $r->customer->capacidad;
    $tipo_aula = $r->customer->tipo_aula;
     echo '<script>';
        echo 'console.log('. json_encode( $numero ) .')';
        echo '</script>';
    $isUserExists = $db->getOneRecord("select 1 from aula where numero='$numero'");
    if(!$isUserExists){
        $tabble_name = "aula";
        $column_names = array('numero', 'capacidad', 'tipo_aula');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "Ya existe esa aula";
        echoResponse(201, $response);
    }
});

$app->post('/courses', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $codigo = $r->customer->codigo;
    $nombre = $r->customer->nombre;
    $nro_creditos = $r->customer->nro_creditos;
    $intensidad_horaria = $r->customer->intensidad_horaria;
    $version_pensum = $r->customer->version_pensum;
    $isUserExists = $db->getOneRecord("select 1 from curso where codigo='$codigo'");
    if(!$isUserExists){
        $tabble_name = "curso";
        $column_names = array('codigo', 'nombre', 'nro_creditos', 'intensidad_horaria', 'version_pensum');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "Ya existe este curso";
        echoResponse(201, $response);
    }
});
$app->post('/microcurriculos', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $semestre = $r->customer->semestre;
    $cod_curso = $r->customer->cod_curso;
    $link = $r->customer->link;
    $isUserExists = $db->getOneRecord("select 1 from curso where codigo='$cod_curso'");
    if($isUserExists){
        $tabble_name = "microcurriculo";
        $column_names = array('semestre', 'cod_curso', 'link');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "No existe este curso";
        echoResponse(201, $response);

    }
});

$app->post('/vinculos', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $tipo_doc = $r->customer->tipo_doc;
    $nro_doc = $r->customer->nro_doc;
    $tipo = $r->customer->tipo;
    $isUserExists = $db->getOneRecord("select 1 from profesor where nro_doc='$nro_doc'");
    if($isUserExists){
        $tabble_name = "vinculo_profesor";
        $column_names = array('tipo_doc', 'nro_doc', 'tipo');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "No existe este profesor";
        echoResponse(201, $response);

    }
});

$app->post('/disponibilidades', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $tipo_doc = $r->customer->tipo_doc;
    $nro_doc = $r->customer->nro_doc;
    $dia = $r->customer->dia;
    $hora_desde = $r->customer->hora_desde;
    $hora_hasta = $r->customer->hora_hasta;
    $isUserExists = $db->getOneRecord("select 1 from profesor where nro_doc='$nro_doc'");
    if($isUserExists){
        $tabble_name = "disponibilidad";
        $column_names = array('tipo_doc', 'nro_doc', 'dia', 'hora_desde', 'hora_hasta');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "No existe este profesor";
        echoResponse(201, $response);

    }
});

$app->post('/programaciones', function() use ($app) {
    $response = array();
    $r = json_decode($app->request->getBody());
    $db = new DbHandler();
    $codigo = $r->customer->codigo;
    $grupo = $r->customer->grupo;
    $semestre = $r->customer->semestre;
    $est_matriculados = $r->customer->est_matriculados;
    $isUserExists = $db->getOneRecord("select 1 from curso where codigo='$codigo'");
    if($isUserExists){
        $tabble_name = "curso_programado";
        $column_names = array('codigo', 'grupo', 'semestre', 'est_matriculados');
        $result = $db->insertIntoTable($r->customer, $column_names, $tabble_name);
        if ($result != NULL) {
            $response["status"] = "success";
            $response["message"] = "User account created successfully";
            $response["uid"] = $result;
            echoResponse(200, $response);
        } else {
            $response["status"] = "error";
            $response["message"] = "Failed to create customer. Please try again";
            echoResponse(201, $response);
        }            
    }else{
        $response["status"] = "error";
        $response["message"] = "Este curso no existe";
        echoResponse(201, $response);
    }
});
$app->get('/logout', function() {
    $db = new DbHandler();
    $session = $db->destroySession();
    $response["status"] = "info";
    $response["message"] = "Logged out successfully";
    echoResponse(200, $response);
});
?>