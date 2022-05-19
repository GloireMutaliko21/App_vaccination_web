<?php 
    include "Connexion.php";

    $app=new App('id17494911_esantevacci');

    
    $query = "SELECT  dateVacc,SUM(nombre) as counte FROM stats GROUP BY dateVacc";
        echo json_encode($app->fetchPrepared($query));

?>