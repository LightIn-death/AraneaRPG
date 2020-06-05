<?php
require_once "Functions.php";


$action = filter_input(INPUT_POST, "action");


//  set_ pour ajouter
//  get_ pour recup
//  update_ pour modifier
//  delete_ pour suppr
//  return "ok" si success
//  return "fuck" si fail




switch($action){
    case "register":
        $pseudo = filter_input(INPUT_POST, "pseudo");
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $age = filter_input(INPUT_POST, "age");
        $sex = filter_input(INPUT_POST, "sex");
        createUser("LightIn","breval2000@live.fr","123",19,true,"","");
        $data = "ok";
    break;
    case "login":
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");

        $data = loginUser($email,$password);

    break;
    case "lo ":
        $email= filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
       $data = userLogin($email,$password);
    break;


    case "efefefefef ":
        $data = getAllMessages();
    break;

    case "":
        $data = "fuck";
    break;
}
if (is_null($action)) {
    $data = "fuck";
}


echo json_encode($data);