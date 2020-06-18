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
        //var_dump($data);
        if (!array_key_exists("fail", $data)) {
            deleteTokenForUser($data['id']);
            $data['token'] = generateTokenForUser($data['id']);
        }
        break;

    case "del_account":
        $userToken = filter_input(INPUT_POST, "token");
        deleteAccount($userToken);
        $data = 'ok';
        break;

    case "get_random_account":
        $userId = filter_input(INPUT_POST, "id");
        $targetId = getRandomAccount($userId);
        $data = getUserProfile($targetId["id"]);
        break;

    case "launch_battle":
        $userId = filter_input(INPUT_POST, "user");
        $targetId = filter_input(INPUT_POST, "target");
        $data = launchBattle($userId, $targetId);
        break;

    case "get_convs":
        $token = filter_input(INPUT_POST, "token");
        $data = getConvs($token);
        break;

    case "get_skills":
        $id = filter_input(INPUT_POST, "id");
        $data = getSkills($id);
        break;

    case "add_skill_point":
        $userToken = filter_input(INPUT_POST, "token");
        $categ = filter_input(INPUT_POST, "categ");
        addPointToSkills($userToken, $categ);
        $data = "ok";
        break;

    case "get_profile":
        $id = filter_input(INPUT_POST, "id");
        $data = getUserProfile($id);
        break;

    case "send_message":
        $convId = filter_input(INPUT_POST, "convId");
        $content = filter_input(INPUT_POST, "content");
        $owner = filter_input(INPUT_POST, "owner");
        sendMessage($convId, $content, $owner);
        $data = "ok";
        break;

    case "get_messages":
        $convId = filter_input(INPUT_POST, "convId");
        $data = getMessages($convId);
        break;

    case "upload_profile_pic":

        $image = $_FILES["image"];
        $userToken = filter_input(INPUT_POST, "token");
        $data = uploadProfilePicture($userToken, $image);
        break;

    case "update_profile":
        $userToken = filter_input(INPUT_POST, "token");
        $pseudo = filter_input(INPUT_POST, "pseudo");
        $age = filter_input(INPUT_POST, "age");
        $descr = filter_input(INPUT_POST, "descr");
        updateProfile($userToken, $pseudo, $age, $descr);
        $data = "ok";
        break;


    case "lo  ":
        $email = filter_input(INPUT_POST, "email");
        $password = filter_input(INPUT_POST, "password");
        $data = userLogin($email, $password);
        break;

    case "3":
        $data = "fuck";
        break;
}
if (is_null($action)) {
    $data = "fuck";
}


echo json_encode($data);
