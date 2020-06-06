<?php
require_once "Functions.php";


$action = filter_input(INPUT_POST, "action");


//  set_ pour ajouter
//  get_ pour recup
//  update_ pour modifier
//  delete_ pour suppr
//  return "ok" si success
//  return "fuck" si fail


switch ($action) {
    case "register":
        $pseudo = filter_input(INPUT_POST, "pseudo");
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $age = filter_input(INPUT_POST, "age");
        $sex = filter_input(INPUT_POST, "sex");
        register($pseudo, $email, $password, $age, $sex, "", "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png");
        $data = "ok";
        break;
    case "login":
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $data = login($email, $password);

        break;
    case "del_account":

        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $data = userLogin($email, $password);
        break;









        case "lo ":
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $data = userLogin($email, $password);
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
