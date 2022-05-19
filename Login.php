<?php

    include "Connexion.php";

    $app = new App('id17494911_esantevacci');
    
    $data = json_decode(file_get_contents('php://input'),true);

        
        
        $loginAg = $data['loginAg'];
        $pwAg = $data['pwAg'];
        $querry = "SELECT * FROM agent WHERE loginAg = '$loginAg' AND pwAg = '$pwAg'";

        echo json_encode($app->fetchPrepared($querry));
        
        

?>

