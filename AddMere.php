<?php
    include "Connexion.php";
    $app=new App('id17494911_esantevacci');
    $data=json_decode(file_get_contents('php://input'),true);

   $name=$data['noms'];
   $dateNaiss=$data['dateNaiss'];
   $tel=$data['tel'];
   $adresse = $data['adresse'];
   $loginM = $data['loginM'];
   $pwM = $data['pwM'];
   $idHopital = $data['idHopital']; 

   $datePrevue = $data['datePrevue'];
   $idVAT = $data['idVAT'];

$query="INSERT INTO `mere`(`noms`, `dateNaiss`, `tel`, `adresse`, `loginM`, `pwM`, `idHopital`) 
       VALUES (?,?,?,?,?,?,?)";

$query2 = "SELECT LAST_INSERT_ID() as value";
//$idMere=$app->getValues($query2);

$query3="INSERT INTO `calendriervat`(`datePrevue`, `idVAT`, `idMere`) VALUES (?,?,?)";

if($app->prepare($query,[$name,$dateNaiss,$tel,$adresse,$loginM,$pwM,$idHopital],1)){
   $idMere=$app->getValues($query2);
   //echo json_encode($app->fetchPrepared("select * from mere"));
}else{
       echo json_encode(array("data"=>"Echec de l'enregistrement"));
}
if ($app->prepare($query3,[$datePrevue,$idVAT,$idMere],1)) {
       echo json_encode($app->fetchPrepared("select * from calendriervat"));
} else {
       echo json_encode(array("data"=>"Echec calendrier VAT"));
}


?>