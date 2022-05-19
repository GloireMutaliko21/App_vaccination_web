<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    
    $data = json_decode(file_get_contents('php://input'),true);

        
        
        $loginA = $data['loginA'];
        // 'Salva21';
        $pwA = $data['pwA'];
        // 'salva';
        $querry = "SELECT * FROM administrateur WHERE loginA = '$loginA' AND pwA = '$pwA'";

        echo json_encode($app->fetchPrepared($querry));
        
        

?>

