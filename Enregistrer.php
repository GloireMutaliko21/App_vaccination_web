<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $name=$data['nomsAgent'];
    $numTel=$data['numTel'];
    $adresse=$data['adresse'];
    $idHopital = $data['idHopital']; 

    $query="INSERT INTO `agent`(`nomsAgent`, `numTel`, `adresse`,`loginAg`, `pwAg`, `idHopital`) 
       VALUES (?,?,?,?,?,?)";

    if($app->prepare($query,[$name,$numTel,$adresse,$name,$numTel,$idHopital],1)){
        echo json_encode($app->fetchPrepared("select * from agent"));
    }else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));
    }
?>