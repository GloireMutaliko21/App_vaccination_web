<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $name=$data['noms'];
   $dateNaiss=$data['dateNaiss'];
   $tel=$data['tel'];
   $adresse = $data['adresse'];
   $loginM = $data['loginM'];
   $pwM = $data['pwM'];
   $idHopital = $data['idHopital']; 
   $idMere = $data['idMere'];

   $query="UPDATE `mere` SET `noms`='$name',`dateNaiss`='$dateNaiss',`tel`='$tel',`adresse`='$adresse',`loginM`='$loginM',`pwM`='$pwM', `idHopital`='$idHopital' WHERE `idMere`='$idMere'";
   
    echo json_encode($app->fetchPrepared($query));


?>