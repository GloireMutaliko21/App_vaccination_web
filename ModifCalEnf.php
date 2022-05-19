<?php

    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

        $idEnfant = $data['idEnfant'];
        $idVaccin = $data['idVaccin'];

        $querry = "UPDATE calendriervaccenf SET etat = 'Non actif' WHERE idEnfant = '$idEnfant' AND idVaccin = '$idVaccin'";

        echo json_encode($app->fetchPrepared($querry));
        

// }

?>