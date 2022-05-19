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
   $idEnfant = $data['idEnfant'];

   $query="UPDATE `enfant` SET `noms`='$name',`lieuNaiss`='$lieuNaiss',`dateNaissance`='$dateNaiss',`sexe`='$sexe',`poids`='$poids',`taille`='$taille',`numCarteVacc`='$numCarte',`idMere`='$idMere', `idHopital`='$idHopital' WHERE idEnfant = '$idEnfant'";
   
    echo json_encode($app->fetchPrepared($query));

?>