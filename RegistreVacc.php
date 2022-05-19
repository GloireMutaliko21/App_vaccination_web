<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $dateRecue=$data['dateRecue'];
   $idEnfant=$data['idEnfant'];
   $idVaccin=$data['idVaccin'];
   $asHasHz=$data['asHasHz'];
   $observation = $data['observation'];
   $idAgent = $data['idAgent'];
   $idHopital = $data['idHopital'];

$query="INSERT INTO `registrevaccenf`(`dateRecue`, `idEnfant`, `idVaccin`, `asHasHz`, `observation`, `idAgent`, `idHopital`) 
       VALUES (?,?,?,?,?,?,?)";
 //echo json_encode(array("data"=>"Enregistrement reussi avec succes"));

if($app->prepare($query,[$dateRecue,$idEnfant,$idVaccin,$asHasHz,$observation,$idAgent,$idHopital],1)){
   echo json_encode($app->fetchPrepared("select * from registrevaccenf"));
}else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));

}

?>