<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $nomsAgent=$data['nomsAgent'];
   $numTel=$data['numTel'];
   $adresse = $data['adresse'];
   $loginAg = $data['loginAg'];
   $pwAg = $data['pwAg'];
   $idAgent = $data['idAgent'];

   $query="UPDATE `agent` SET `nomsAgent`='$nomsAgent',`numTel`='$numTel' ,`adresse`='$adresse',`loginAg`='$loginAg',`pwAg`='$pwAg' WHERE `idAgent`='$idAgent'";
   
    echo json_encode($app->fetchPrepared($query));


?>