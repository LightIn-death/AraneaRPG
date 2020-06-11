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
        return 'fuck';
    }
}

function register($pseudo, $email, $password, $age, $sex, $desc, $image)
{

    global $pdo;
    $password = password_hash($password, PASSWORD_BCRYPT);
    $query = $pdo->prepare("Insert into users (pseudo,email,password,age,sex) VALUES (:pseudo,:email,:pass,:age,:sex);");
    $query->execute(['pseudo' => $pseudo, 'email' => $email, 'pass' => $password, 'age' => $age, 'sex' => $sex]);

}

function generateSkills($userId){
    global $pdo;
    $query = $pdo->prepare("insert into skills (owner,strenght, intelligence,magie,speed,charisme) values (:id,5,5,5,5,5);");
    $query->execute(['id' => $userId]);
}

function getUserIdByToken($userToken){

    global $pdo;
    $query = $pdo->prepare("select * from tokens where token = :token;");
    $query->execute(['token' => $userToken]);
    $data = $query->fetch();
    return $data['owner'];

}

function deleteTokenForUser($userId){

    global $pdo;
    $query = $pdo->prepare("delete from tokens where owner = :userId;");
    $query->execute(['userId' => $userId]);

}

function generateTokenForUser($userId){

    global $pdo;
    $token = uniqid('', true);
    $query = $pdo->prepare("Insert into tokens (owner,token) VALUES (:userId,:token);");
    $query->execute(['userId' => $userId, 'token' => $token]);
    return $token;


}

function deleteAccount($userToken){

    global $pdo;
    $query = $pdo->prepare("  delete from users using tokens where users.id = tokens.owner and tokens.token = :token ;");
    $query->execute(['token' => $userToken]);



}

function getRandomAccount($userId){


    global $pdo;
    $query = $pdo->prepare("select u.id from convs c join users u on c.winner = u.id or
 c.looser = u.id where u.id != :id and looser != :id  and winner != :id order by random() limit 1; ");
    $query->execute(['id' => $userId]);
    return $query->fetch();



}

function launchBattle($userId,$targetId){

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



    $diff   = 5;
    $diff += comparePoint($userSTR , $targetSTR);
    $diff += comparePoint($userINT , $targetINT);
    $diff += comparePoint($userMAG , $targetMAG);
    $diff += comparePoint($userSPD , $targetSPD);
    $diff += comparePoint($userCHAR , $targetCHAR);
    $diff *=10;

    $randNumber = rand(1,100);
    if($randNumber<$diff){
        createConvs($userId,$targetId);
    }
    elseif($randNumber>$diff){
        createConvs($targetId,$userId);
    }elseif ($randNumber==$diff){
        createConvs($userId,$targetId);
    }


}

function comparePoint($p1,$p2){
    if($p1>$p2){
        return 1;
    }elseif ($p1 < $p2){
        return  -1;
    }else{
        return 0;
    }
}

function createConvs($winner,$looser){

    global $pdo;
    $id =     $token = uniqid('', true);
    $query = $pdo->prepare("Insert into convs (id,winner,looser,lastmessage,lastmessagedate,notreadby,score)
 VALUES (:id,:winner,:looser,'',null,null,0);");
    $query->execute(['id' => $id,'winner' => $winner,'looser' => $looser,]);





}

function getConvs($userToken){

    $id = getUserIdByToken($userToken);
    global $pdo;
    $query = $pdo->prepare("select * from convs where looser = :id or winner = :id;");
    $query->execute();
    //  $rq-> debugDumpParams();
    return $query->fetchAll(['id'=> $id]);
}

function updateConvs(){}

function getMessages($convId){}

function getUserProfile($userId){}

function updateProfile($userToken){}

function getPackForUser($userId){}

function openPackId($userToken,$packId){}

function getSkills($userId){


    global $pdo;
    $query = $pdo->prepare("select * from skills where owner = :id;");
    $query->execute(['id' => $userId]);
    return $query->fetch();


}

function addPointToSkills($userToken,$category){}

function getStoreItems(){}

function buyItem($itemId){}

































//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function getAllUsers()
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `users` ");
    $query->execute();
//    $rq-> debugDumpParams();
    $data = $query->fetchAll();
    return $data;
}


function getAllMessages()
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `messages` ");
    $query->execute();
//    $rq-> debugDumpParams();
    $data = $query->fetchAll();
    return $data;
}


function userLogin($email, $password)
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `users` WHERE email=:email AND password=:password");
    $query->execute(['email' => $email, 'password' => $password]);
    $row = $query->fetchAll();

    if (empty($row)) {

    }
    foreach ($row as $r) {
        if ($r["email"] == $email and $r["password"] == $password) {
            /*Do everything as connected*/
            return $r;
        }
    }

    return "Wrong credentials";
}


function userInscription($nom, $prenom, $email, $tel, $password)
{

    global $pdo;
    $query = $pdo->prepare("INSERT INTO `personnes` (`id_personnes`, `nom`, `prenom`, `email`, `tel`, `password`, `admin`) VALUES (NULL, :nom, :prenom, :email, :tel, :password, '0')");
    $query->execute(['nom' => $nom, 'prenom' => $prenom, 'email' => $email, 'tel' => $tel, 'password' => $password]);
}


function EtudeAdd($nom, $reference)
{
    $date = date('Y/m/d', time());
    global $pdo;
    $query = $pdo->prepare("INSERT INTO `etudes` (`nom`, `dateDebut`,  `reference`) VALUES ( :nom, :date , :referen)");
    $query->execute(['nom' => $nom, 'date' => $date, 'referen' => $reference]);
}


function getEtude($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `etudes` where id_etudes=:id ");
    $rq->execute(['id' => $id]);
    $data = $rq->fetch();
    return $data;
}


function clotureEtude($id)
{

    $date = date('Y/m/d', time());
    global $pdo;
    $query = $pdo->prepare("    UPDATE `etudes` SET `dateFin` = :date WHERE `etudes`.`id_etudes` = :id ");
    $query->execute(['date' => $date, 'id' => $id]);

}


function supprimeEtude($id)
{
    global $pdo;
    $query = $pdo->prepare("DELETE FROM `etudes` WHERE `etudes`.`id_etudes` = :id");
    $query->execute(['id' => $id]);
}


function getPlageInstance($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT p.nom, p.commune,p.departement,i.id_instancePlages FROM instanceplages i JOIN etudes e on i.FK_id_etudes = e.id_etudes JOIN plage p on i.FK_id_plages = p.id_plages WHERE e.id_etudes=:id");
    $rq->execute(['id' => $id]);
    $data = $rq->fetchAll();
    return $data;
}


function getPlageInfo($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM plage join  instanceplages i on plage.id_plages = i.FK_id_plages join zones z on i.id_instancePlages = z.FK_instance_plages WHERE z.FK_instance_plages =:id");
    $rq->execute(['id' => $id]);
    $data = $rq->fetch();
    return $data;
}


function getPlagesNotInEtude($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM plage WHERE NOT id_plages IN (SELECT id_plages from plage JOIN instanceplages on instanceplages.FK_id_plages = plage.id_plages WHERE FK_id_etudes = :id ) ");
    $rq->execute(['id' => $id]);
    $data = $rq->fetchAll();
    return $data;
}


function CreatePlageInstance($id, $plage, $km)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `plage` where id_plages=:plage");
    $rq->execute(['plage' => $plage]);
    $plageresult = $rq->fetch();
    $rq = $pdo->prepare("INSERT INTO `instanceplages` ( `FK_id_etudes`, `FK_id_plages`, `superficieTotal`) VALUES ( :id, :plageid, :km)");
    $rq->execute(['id' => $id, 'plageid' => $plageresult["id_plages"], 'km' => $km]);
}


function SupprPlageInstance($id)
{
    global $pdo;
    $rq = $pdo->prepare(" DELETE FROM `instanceplages` WHERE `instanceplages`.`id_instancePlages` = :id");
    $rq->execute(['id' => $id]);
}


function addEspece($nom)
{
    global $pdo;
    $query = $pdo->prepare("INSERT INTO `especes` (`nom`) VALUES (:nom)");
    $query->execute(['nom' => $nom]);
}


function listeEspece()
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `especes`");
    $query->execute();
    $liste = $query->fetchAll();
    return $liste;
}

function listeEspeceNotUse($id)
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `especes` WHERE NOT id_especes IN (SELECT id_especes FROM `especes` join instanceespeces on FK_id_especes=id_especes join zones on FK_zone=id_zones WHERE id_zones = :id ) ");
    $query->execute(['id' => $id]);
    $liste = $query->fetchAll();
    return $liste;
}


function deleteEspece($id_especes)
{
    global $pdo;
    $query = $pdo->prepare("DELETE FROM `especes` WHERE `id_especes`=:id_especes");
    $query->execute(['id_especes' => $id_especes]);
}


function modifyEspeces($id_especes, $nom)
{
    global $pdo;
    $query = $pdo->prepare("UPDATE `especes` SET `nom`=:nom WHERE id_especes=:id_especes");
    $query->execute(['id_especes' => $id_especes, 'nom' => $nom]);
}


function addPlage($nom, $commune, $departement)
{
    global $pdo;
    $query = $pdo->prepare("INSERT INTO `plage`(`nom`, `commune`, `departement`) VALUES (:nom, :commune, :departement)");
    $query->execute(['nom' => $nom, 'commune' => $commune, 'departement' => $departement]);
}


function listePlage()
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `plage`");
    $query->execute();
    $row = $query->fetchAll();
    return $row;
}


function deletePlage($id_plages)
{
    global $pdo;
    $query = $pdo->prepare("DELETE FROM `plage` WHERE `id_plages`=:id_plages");
    $query->execute(['id_plages' => $id_plages]);
}


function modifyPlage($id_plages, $nom, $commune, $departement)
{
    global $pdo;
    $query = $pdo->prepare("UPDATE `plage` SET `nom`=:nom, `commune`=:commune, `departement`=:departement WHERE id_plages=:id_plages");
    $query->execute(['id_plages' => $id_plages, 'nom' => $nom, 'commune' => $commune, 'departement' => $departement]);
}


function selectModifyPlage($id_plages)
{
    global $pdo;
    $query = $pdo->prepare("SELECT `id_plages`, `nom`, `commune`, `departement` FROM `plage` WHERE id_plages=:id_plages");
    $query->execute(['id_plages' => $id_plages]);
    $onePlage = $query->fetchAll();
    return $onePlage;
}


function selectModifyEspeces($id_especes)
{
    global $pdo;
    $query = $pdo->prepare("SELECT `id_especes`, `nom` FROM `especes` WHERE id_especes=:id_especes");
    $query->execute(['id_especes' => $id_especes]);
    $oneEspeces = $query->fetchAll();
    return $oneEspeces;
}


function getOpenEtudes()
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `etudes` where dateFin is null ");
    $rq->execute();
    $data = $rq->fetchAll();
    return $data;

}


function getZones($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `zones` WHERE `FK_instance_plages` = :id");
    $rq->execute(["id" => $id]);
    $data = $rq->fetchAll();
    return $data;

}


function getZonedetails($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `zones` WHERE `id_zones`= :id");
    $rq->execute(["id" => $id]);
    $data = $rq->fetch();
    return $data;

}


function getInstEspece($id)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT * FROM `instanceespeces` i JOIN especes e ON e.id_especes=i.FK_id_especes WHERE `FK_zone`=:id");
    $rq->execute(['id' => $id]);
    $data = $rq->fetchAll();
    return $data;
}


function deleteInstEspece($id_espece, $id_zone)
{
    global $pdo;
    $rq = $pdo->prepare("DELETE FROM instanceespeces WHERE FK_id_especes = :espece AND FK_zone = :zone");
    $rq->execute(['espece' => $id_espece, 'zone' => $id_zone]);
}


function addInstEspece($id_espece, $id_zone, $nombre)
{
    global $pdo;
    $rq = $pdo->prepare("INSERT INTO `instanceespeces` (`FK_id_especes`, `FK_zone`, `nombre`) VALUES (:espece, :zone, :nombre)");
    $rq->execute(['espece' => $id_espece, 'zone' => $id_zone, 'nombre' => $nombre]);
}


function updateZone($number, $Point1, $Point2, $Point3, $Point4, $id)
{
    global $pdo;
    $rq = $pdo->prepare("UPDATE `zones` SET  	nombrePersonne=:numbe ,point1=:point1,point2=:point2,point3=:point3,point4=:point4 WHERE id_zones=:id");
    $rq->execute(['numbe' => $number, 'point1' => $Point1, 'point2' => $Point2, 'point3' => $Point3, 'point4' => $Point4, 'id' => $id]);
}


function createNewZone($id_plage, $nombrePersonne)
{
    global $pdo;
    $rq = $pdo->prepare("INSERT INTO zones(FK_instance_plages,nombrePersonne) VALUES (:FK_instance_plages,:nombrePersonne)");
    $rq->execute(['FK_instance_plages' => $id_plage, 'nombrePersonne' => $nombrePersonne,]);
    $rq = $pdo->prepare("SELECT id_zones FROM `zones` ORDER BY id_zones DESC LIMIT 1 ");
    $rq->execute();
    $data = $rq->fetch();
    return intval($data["id_zones"]);

}


function getSumZoneReshe($plageInstance)
{
    $zones = getZones($plageInstance);
    $zoneRecherche = 0;
    foreach ($zones as $zone) {
        $p1 = $zone["point1"];
        $p2 = $zone["point2"];
        $p3 = $zone["point3"];
        $p4 = $zone["point4"];
        if (GPScheck($p1, $p2, $p3, $p4)) {
            $zoneRecherche += GPScalculate($p1, $p2, $p3, $p4);
        }
    }
    return $zoneRecherche;
}

function getTotalWorms($plageId)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT SUM(nombre) FROM `instanceespeces` JOIN zones on FK_zone=zones.id_zones WHERE zones.FK_instance_plages=:id");
    $rq->execute(['id' => $plageId]);
    $data = $rq->fetch();
    return intval($data["SUM(nombre)"]);

}


function getDensite($plageId)
{
    if (getSumZoneReshe($plageId) == 0) {
        $tempSumZoneRe = 1;
    } else {
        $tempSumZoneRe = getSumZoneReshe($plageId);
    }

    $dens = getTotalWorms($plageId) / $tempSumZoneRe;
    return $dens;
}


function getPlageSurface($plageId)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT superficieTotal FROM `instanceplages` WHERE id_instancePlages=:id");
    $rq->execute(['id' => $plageId]);
    $data = $rq->fetch();
    return intval($data["superficieTotal"]);
}


function getEstim($plageId)
{
    $estim = getDensite($plageId) * getPlageSurface($plageId);
    return $estim;
}


function getIdPlageInEtude($etudeId)
{
    global $pdo;

    $rq = $pdo->prepare("SELECT id_instancePlages FROM `instanceplages` WHERE FK_id_etudes=:id");
    $rq->execute(['id' => $etudeId]);
    $data = $rq->fetch();
    return $data;
}


function getGlobalDensite($etudeId)
{
    $recheZone = 1;
    $WormsZone = 0;
    foreach (getIdPlageInEtude($etudeId) as $id) {
        $TEMPrecheZone = getSumZoneReshe($id);
        $TEMPWormsZone = getTotalWorms($id);
        $recheZone += $TEMPrecheZone;
        $WormsZone += $TEMPWormsZone;
    }
    $totalDens = $WormsZone / $recheZone;
    return $totalDens;

}

function getGlobalEstim($etudeId)
{
    $surf = 0;
    foreach (getIdPlageInEtude($etudeId) as $id) {
        $surf += getPlageSurface($id);
    }
    $Tdens = getGlobalDensite($etudeId);
    $totalEstim = $Tdens * $surf;
    return $totalEstim;
}


function getNombrePartitip($etudeId)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT SUM(nombrePersonne) FROM etudes e JOIN instanceplages i on i.FK_id_etudes=e.id_etudes JOIN `zones` z on i.id_instancePlages=z.FK_instance_plages WHERE e.id_etudes=:id");
    $rq->execute(['id' => $etudeId]);
    $data = $rq->fetch();
    return intval($data["SUM(nombrePersonne)"]);
}


function userList()
{
    global $pdo;
    $query = $pdo->prepare("SELECT * FROM `personnes` where `admin`=0");
    $query->execute();
    $row = $query->fetchAll();
    return $row;
}


function userUprankAdmin($id_personnes)
{
    global $pdo;
    $rq = $pdo->prepare("UPDATE `personnes` SET `admin`=1 WHERE `id_personnes`=:id_personnes ");
    $rq->execute(['id_personnes' => $id_personnes]);
}


function userDeleteAccount($id_personnes)
{
    global $pdo;
    $rq = $pdo->prepare("DELETE FROM `personnes` WHERE id_personnes=:id_personnes ");
    $rq->execute(['id_personnes' => $id_personnes]);
}


function userSelectAccount($id_personnes)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT `id_personnes`, `nom`, `prenom`, `email`, `tel`, `password`, `admin` FROM `personnes` WHERE `id_personnes`=:id_personnes ");
    $rq->execute(['id_personnes' => $id_personnes]);
}


function getKml($id_etude)
{
    global $pdo;
    $rq = $pdo->prepare("SELECT point1,point2,point3,point4,nombrePersonne FROM `zones` join instanceplages on FK_instance_plages=id_instancePlages join etudes on FK_id_etudes=id_etudes WHERE id_etudes = :id");
    $rq->execute(['id' => $id_etude]);
    $row = $rq->fetchAll();
    return $row;
}


function getStatEspPlage($id_plages)
{
    global $pdo;
    $query = $pdo->prepare("SELECT nom, SUM(nombre) FROM zones join instanceespeces on FK_zone=id_zones join especes on id_especes=FK_id_especes WHERE FK_instance_plages= :id GROUP by id_especes");
    $query->execute(['id' => $id_plages]);
    $WormsZone = $query->fetchAll();
//    return $WormsZone;
    if (empty($WormsZone)) {

        $data[0]["nom"] = "Donnee Corompu ou imcoplete";
        $data[0]["nombre"] = "\"Donnee Corompu ou imcoplete\"";
        $data[0]["dens"] = "\"Donnee Corompu ou imcoplete\"";
        $data[0]["est"] = "\"Donnee Corompu ou imcoplete\"";


    } else {


        if (getSumZoneReshe($id_plages) != 0) {
            $recheZone = getSumZoneReshe($id_plages);
        } else {
            $recheZone = 1;
        }

        $i = 0;


        foreach ($WormsZone as $wr) {
            $data[$i]["nom"] = $wr["nom"];
            $data[$i]["nombre"] = intval($wr["SUM(nombre)"]);
            $data[$i]["dens"] = intval($wr["SUM(nombre)"]) / $recheZone;
            $data[$i]["est"] = (intval($wr["SUM(nombre)"]) / $recheZone) * getPlageSurface($id_plages);
            $i++;
        }

    }
    return $data;
}


function getStatPerEspeceGlob($etudeId)
{

    // Get toute les espece de toute les plages de l'etudes et leurs nombres
    // get les surface garce a l'id des plage + surface ZONE
    // get densiter  = nombre / surface ZONE
    // get nombre estime =   densité * surface GLOBALE

    //GET NOM + NOMBRE + ID PLAGE
    global $pdo;
    $rq = $pdo->prepare("SELECT nom, SUM(nombre),id_especes, FK_id_especes,FK_zone,id_zones,FK_instance_plages,id_instancePlages,FK_id_etudes FROM `instanceespeces` join zones on FK_zone = id_zones join instanceplages on FK_instance_plages= id_instancePlages join especes on FK_id_especes=id_especes WHERE FK_id_etudes = :id GROUP BY id_especes");
    $rq->execute(['id' => $etudeId]);
    $row = $rq->fetchAll();
//    return $row;

// Calculer
    // SURFRECHERCHE

    $recheZone = 1;
    foreach (getIdPlageInEtude($etudeId) as $id) {
        $TEMPrecheZone = getSumZoneReshe($id);
        $recheZone += $TEMPrecheZone;
    }


    $surf = 0;

    foreach (getIdPlageInEtude($etudeId) as $id) {
        $surf += getPlageSurface($id);
    }


//
    $i = 0;
    foreach ($row as $ro) {
        $data[$i]["nom"] = $ro["nom"];
        $data[$i]["nombre"] = $ro["SUM(nombre)"];
        $densite = $ro["SUM(nombre)"] / $recheZone;
        $data[$i]["dens"] = $densite;
        $data[$i]["est"] = $densite * $surf;
        $i++;
    }


    // Return : Espece + Nombre + Densité + estimé
    return $data;

}



















