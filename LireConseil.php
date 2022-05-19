<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    $data = json_decode(file_get_contents('php://input'),true);

        $loginAg = $data['loginAg'];
        $pwAg = $data['pwAg'];
        $loginA = $data['loginA'];
        $pwA = $data['pwA'];

        $querry = "SELECT * FROM agent, administrateur WHERE (agent.loginAg = '$loginAg' AND agent.pwAg = '$pwAg') OR (administrateur.loginA = '$loginA' AND administrateur.pwA = '$pwA')";


        // if($app->getValues($querry)){
        echo json_encode($app->fetchPrepared($querry));
        // }else{
        //     return null;
        // }

?>