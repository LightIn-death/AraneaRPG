<?php
$root = realpath($_SERVER["DOCUMENT_ROOT"]);
require_once "env.php";


$pdo = new PDO(DB_INFOS::servername, DB_INFOS::username, DB_INFOS::password, [
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
]);

