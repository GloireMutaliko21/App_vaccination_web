<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $denomination=$data['denomination'];
    $mail=$data['mail'];
    $zoneSante=$data['zoneSante'];
    $adresse = $data['adresse']; 
    $idHopital = $data['idHopital']; 

    $query="UPDATE `hopital` SET `denomination`='$denomination',`mail`='$mail',`zoneSante`='$zoneSante',`adresse`='$adresse' WHERE `idHopital`='$idHopital'";
   
    echo json_encode($app->fetchPrepared($query));
?>