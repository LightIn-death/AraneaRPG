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
        $data = login($email, $password);
        generateSkills($data['id']);
        deleteTokenForUser($data['id']);
        $data['token'] = generateTokenForUser($data['id']);
        break;
    case "login":
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $data = login($email, $password);
      //  var_dump($data);
        if($data != 'fuck'){
        deleteTokenForUser($data['id']);
        $data['token'] = generateTokenForUser($data['id']);
    } break;
    case "del_account":
        $userToken = filter_input(INPUT_POST, "token");
        deleteAccount($userToken);
        $data = 'ok';
        break;
    case "get_random_account":
        $userId = filter_input(INPUT_POST, "id");
        $data = getRandomAccount($userId);
        break;
    case "launch_battle":
        $userId = filter_input(INPUT_POST, "user");
        $targetId = filter_input(INPUT_POST, "target");
        launchBattle($userId, $targetId);
        $data = 'ok';
        break;

        
            case "get_convs":
                $token = filter_input(INPUT_POST, "token");
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
