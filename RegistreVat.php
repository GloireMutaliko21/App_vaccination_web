<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $dateRecue=$data['dateRecue'];
   $idMere=$data['idMere'];
   $idVat=$data['idVat'];
   $obs = $data['obs'];
   $idAgent = $data['idAgent'];
   $idHopital = $data['idHopital'];

$query="INSERT INTO `registrevat`(`dateRecue`, `idMere`, `idVat`, `obs`, `idAgent`, `idHopital`) 
       VALUES (?,?,?,?,?,?)";
 //echo json_encode(array("data"=>"Enregistrement reussi avec succes"));

if($app->prepare($query,[$dateRecue,$idMere,$idVat,$obs,$idAgent,$idHopital],1)){
   echo json_encode($app->fetchPrepared("select * from registrevat"));
}else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));

}

?>