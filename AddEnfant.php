<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $name=$data['noms'];
   $lieuNaiss=$data['lieuNaiss'];
   $dateNaiss=$data['dateNaissance'];
   $sexe=$data['sexe'];
   $poids = $data['poids'];
   $taille = $data['taille'];
   $numCarte = $data['numCarteVacc'];
   $idMere = $data['idMere'];
   $idHopital = $data['idHopital'];

$query="INSERT INTO `enfant`(`noms`, `lieuNaiss`, `dateNaissance`, `sexe`, `poids`, `taille`, `numCarteVacc`, `idMere`,`idHopital`) 
       VALUES (?,?,?,?,?,?,?,?,?)";
 //echo json_encode(array("data"=>"Enregistrement reussi avec succes"));

if($app->prepare($query,[$name,$lieuNaiss,$dateNaiss,$sexe,$poids,$taille,$numCarte,$idMere,$idHopital],1)){
   echo json_encode($app->fetchPrepared("select * from enfant"));
}else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));

}

?>