<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $contenu=$data['contenu'];
    $datePub=$data['datePub'];
    $idAgent=$data['idAgent'];

    $query="INSERT INTO `conseil`(`contenu`, `datePub`, `idAgent`) VALUES (?,?,?)";

    if($app->prepare($query,[$contenu,$datePub,$idAgent],1)){
        echo json_encode($app->fetchPrepared("select * from conseil"));
    }else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));
    }
?>