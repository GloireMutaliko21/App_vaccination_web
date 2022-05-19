<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $denomination=$data['denomination'];
    $mail=$data['mail'];
    $zoneSante=$data['zoneSante'];
    $adresse = $data['adresse']; 

    $query="INSERT INTO `hopital`(`denomination`, `mail`, `zoneSante`, `adresse`, `idAdmin`) 
       VALUES (?,?,?,?,?)";

    if($app->prepare($query,[$denomination,$mail,$zoneSante,$adresse,1],1)){
        echo json_encode($app->fetchPrepared("select * from hopital"));
    }else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));
    }
?>