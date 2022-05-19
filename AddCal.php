<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $idVaccin=$data['idVaccin'];
    $datePrev=$data['datePrev'];

    $query = "SELECT MAX(idEnfant) as value FROM enfant";
    $idEnfant=$app->getValues($query);

    $querry = "INSERT INTO `calendriervaccenf`(`datePrev`, `idVaccin`, `idEnfant`) VALUES (?,?,?)";

    if($app->prepare($querry,[$datePrev,$idVaccin,$idEnfant],1)){
        echo json_encode($app->fetchPrepared("select * from calendriervaccenf where idEnfant ='$idEnfant'"));
     }else{
            echo json_encode(array("data"=>"Calendrier non ajouté, contacter l'admin"));
     }

?>