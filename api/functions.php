<?php
require_once "connect.php";

function login($email, $password)
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM public.users where email = :email");
    $query->execute(['email' => $email]);
    $data = $query->fetch();
    if (password_verify($password, $data['password'])) {
        return $data;
    } else {
        $data = [];
        $data["fail"] = 'mauvais email ou mot de passe';
        return $data;
    }
}

function register($pseudo, $email, $password, $age, $sex, $desc, $image)
{
    global $pdo;
    $password = password_hash($password, PASSWORD_DEFAULT);
    $query = $pdo->prepare("Insert into users (pseudo,email,password,age,sex,image) VALUES (:pseudo,:email,:pass,:age,:sex,:image);");
    $query->execute(['pseudo' => $pseudo, 'email' => $email, 'pass' => $password, 'age' => $age, 'sex' => $sex, "image" => $image]);

    // var_dump($password);
}

function generateSkills($userId)
{
    global $pdo;
    $query = $pdo->prepare("insert into skills (owner,strenght, intelligence,magie,speed,charisme) values (:id,5,5,5,5,5);");
    $query->execute(['id' => $userId]);
}

function getUserIdByToken($userToken)
{
    global $pdo;
    $query = $pdo->prepare("select * from tokens where token = :token;");
    $query->execute(['token' => $userToken]);
    $data = $query->fetch();
    return $data['owner'];
}

function deleteTokenForUser($userId)
{
    global $pdo;
    $query = $pdo->prepare("delete from tokens where owner = :userId;");
    $query->execute(['userId' => $userId]);
}

function generateTokenForUser($userId)
{
    global $pdo;
    $token = uniqid('', true);
    $query = $pdo->prepare("Insert into tokens (owner,token) VALUES (:userId,:token);");
    $query->execute(['userId' => $userId, 'token' => $token]);
    return $token;
}

function deleteAccount($userToken)
{

    global $pdo;
    $query = $pdo->prepare("  delete from users using tokens where users.id = tokens.owner and tokens.token = :token ;");
    $query->execute(['token' => $userToken]);
}

function getRandomAccount($userId)
{


    global $pdo;
    $query = $pdo->prepare("select u.id from convs c Full join users u on c.winner = u.id or
 c.looser = u.id where u.id != :id  and ((c.looser is null  and c.winner is null ) OR (c.looser !=u.id  and c.winner  !=u.id)) order by random() limit 1; ");
    $query->execute(['id' => $userId]);
    return $query->fetch();
}

function launchBattle($userId, $targetId)
{

    $skillsUser = getSkills($userId);
    $skillsTarget = getSkills($targetId);

    $userSTR = $skillsUser['strenght'];
    $targetSTR = $skillsTarget['strenght'];
    $userINT = $skillsUser['strenght'];
    $targetINT = $skillsTarget['strenght'];
    $userMAG = $skillsUser['strenght'];
    $targetMAG = $skillsTarget['strenght'];
    $userSPD = $skillsUser['strenght'];
    $targetSPD = $skillsTarget['strenght'];
    $userCHAR = $skillsUser['strenght'];
    $targetCHAR = $skillsTarget['strenght'];


    $diff = 5;
    $diff += comparePoint($userSTR, $targetSTR);
    $diff += comparePoint($userINT, $targetINT);
    $diff += comparePoint($userMAG, $targetMAG);
    $diff += comparePoint($userSPD, $targetSPD);
    $diff += comparePoint($userCHAR, $targetCHAR);
    $diff *= 10;

    $randNumber = rand(1, 100);
    if ($randNumber < $diff) {
        createConvs($userId, $targetId);
        $data["winner"] = $userId;
        return $data;
    } elseif ($randNumber > $diff) {
        createConvs($targetId, $userId);
        $data["winner"] = $targetId;
        return $data;
    } elseif ($randNumber == $diff) {
        createConvs($userId, $targetId);
        $data["winner"] = $userId;
        return $data;
    }
    $data["fail"] = "fail";
    return $data;
}

function comparePoint($p1, $p2)
{
    if ($p1 > $p2) {
        return 1;
    } elseif ($p1 < $p2) {
        return -1;
    } else {
        return 0;
    }
}

function createConvs($winner, $looser)
{

    global $pdo;
    $id = uniqid('', true);
    $query = $pdo->prepare("Insert into convs (id,winner,looser,lastmessage,lastmessagedate,notreadby,score)
 VALUES (:id,:winner,:looser,'',null,null,0);");
    $query->execute(['id' => $id, 'winner' => $winner, 'looser' => $looser,]);
}

function getConvs($userToken)
{

    $id = getUserIdByToken($userToken);
    global $pdo;
    $query = $pdo->prepare("select * from convs where looser = :id or winner = :id;");
    $query->execute(['id' => $id]);
    //  $rq-> debugDumpParams();
    return $query->fetchAll();
}

function updateConvs()
{
}

function getMessages($convId)
{

    global $pdo;
    $query = $pdo->prepare("select * from messages where conv_id = :id Order by date desc;");
    $query->execute(['id' => $convId]);
    //  $rq-> debugDumpParams();
    return $query->fetchAll();
}

function sendMessage($convId, $content, $owner)
{
    global $pdo;

    $id = uniqid('', true);
    $query = $pdo->prepare("Insert INTO messages (id,conv_id,content,owner,date) VALUES (:id,:conv,:content,:owner,current_timestamp);");
    $query->execute(['id' => $id, 'conv' => $convId, 'content' => $content, 'owner' => $owner]);
    //  $rq-> debugDumpParams();
}

function getUserProfile($userId)
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM public.users where id = :id ;");
    $query->execute(['id' => $userId]);
    $data = $query->fetch();
    return $data;
}

function updateProfile($userToken, $pseudo, $age, $descr)
{
    global $pdo;
    $userId = getUserIdByToken($userToken);
    $query = $pdo->prepare("update users set pseudo = :pseudo, age = :age, sex = :sexe, description= :descr where id = :id ;");
    $query->execute(['id' => $userId, 'pseudo' => $pseudo, 'age' => $age, 'descr' => $descr]);
}

function getPackForUser($userId)
{
}

function openPackId($userToken, $packId)
{
}

function getSkills($userId)
{
    global $pdo;
    $query = $pdo->prepare("select * from skills where owner = :id;");
    $query->execute(['id' => $userId]);
    return $query->fetch();
}

function addPointToSkills($userToken, $category)
{
    global $pdo;

    $id = getUserIdByToken($userToken);


    $query = $pdo->prepare("SELECT free FROM skills where owner = :id ;");
    $query->execute(['id' => $id]);
    $data = $query->fetch();
    $free = $data["free"];
    echo $free;

    if ($free > 0) { // Peut improve coter serveur
        switch ($category) {
            case "str":
                $query = $pdo->prepare("UPDATE skills SET strenght = (select strenght  from skills where owner = :id ) + 1  where owner = :id ;");
                break;

            case "int":
                $query = $pdo->prepare("UPDATE skills SET intelligence = (select intelligence from skills where owner = :id ) + 1  where owner = :id ;");
                break;

            case "mag":
                $query = $pdo->prepare("UPDATE skills SET magie = (select magie from skills where owner = :id ) + 1  where owner = :id ;");
                break;

            case "spd":
                $query = $pdo->prepare("UPDATE skills SET  speed = (select speed  from skills where owner = :id ) + 1  where owner = :id ;");
                break;

            case "char":
                $query = $pdo->prepare("UPDATE skills SET charisme = (select charisme from skills where owner = :id ) + 1  where owner = :id ;");
                break;
        }

        $query->execute(['id' => $id]);
        $query = $pdo->prepare("UPDATE skills SET free = (select free from skills where owner = :id ) - 1  where owner = :id ;");
        $query->execute(['id' => $id]);
    }
}

function getStoreItems()
{
}

function buyItem($itemId)
{
}

function uploadProfilePicture($token, $image)
{
    global $pdo;

    $array = explode(".", $image["name"]);
    $extension = "." . strtolower(end($array));
    $uuid =  uniqid('', true) . $extension;
    $target = "images/profile/" . $uuid;
    //    if($image[""])




    $userId = getUserIdByToken($token);

    $query = $pdo->prepare("update users set image = :target where id= :id;");


    if (move_uploaded_file($_FILES['image']["tmp_name"], $target)) {
        $query->execute(['id' => $userId, "target" => $target]);
        return $uuid;
    }
    return "image no send";
}
