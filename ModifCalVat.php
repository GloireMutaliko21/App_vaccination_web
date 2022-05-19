<?php

    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

        $idMere = $data['idMere'];
        $idVat = $data['idVat'];

        $querry = "UPDATE calendriervat SET etat = 'Non actif' WHERE idMere = '$idMere' AND idVat = '$idVat'";

        echo json_encode($app->fetchPrepared($querry));

?>