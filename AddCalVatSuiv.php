<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

    $idVat=$data['idVat'];
    $datePrevue=$data['datePrevue'];
    $idMere=$data['idMere'];

    $querry = "INSERT INTO `calendriervat`(`datePrevue`, `idVat`, `idMere`) VALUES (?,?,?)";

    if($app->prepare($querry,[$datePrevue,$idVat,$idMere],1)){
        echo json_encode($app->fetchPrepared("select * from calendriervat where idMere ='$idMere'"));
     }else{
            echo json_encode(array("data"=>"Calendrier non ajouté, contacter l'admin"));
     }

?>