<?php

    
    include "Connexion.php";

    $app=new App('id17494911_esantevacci');
    $event=$_POST['event'];
   
    
    if($event=='FIND_HOPITAL'){
        $query = "SELECT concat(idHopital,'-',denomination) hopital FROM hopital";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_HOPITAL_TOUT'){
        $query = "SELECT * FROM hopital";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_CONSEIL_TOUT'){
        $query = "SELECT * FROM conseil";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_HOPITAL_KADUTU'){
        $query = "SELECT * FROM hopital WHERE zoneSante = 'Kadutu'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_HOPITAL_IBANDA'){
        $query = "SELECT * FROM hopital WHERE zoneSante = 'Ibanda'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_HOPITAL_BAGIRA'){
        $query = "SELECT * FROM hopital WHERE zoneSante = 'Bagira'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_MERE'){
        $idHopital = $_POST["idHopital"];
        $query = "SELECT concat(idMere,'-',noms) mere FROM mere WHERE idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_MERE_TOUT'){
        $idHopital = $_POST["idHopital"];
        $query = "SELECT * FROM mere WHERE idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_MERE_ADMIN'){
        $query = "SELECT * FROM mere";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='REGISTRE_VACC'){
        $query = "SELECT * FROM registrevaccenf";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='REGISTRE_VAT'){
        $query = "SELECT * FROM registrevat";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='VACCINS'){
        $query = "SELECT * FROM vaccin";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='VAT'){
        $query = "SELECT * FROM vat";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_ENFANT_TOUT'){
        $idHopital = $_POST["idHopital"];
        $query = "SELECT * FROM enfant WHERE idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_ENFANT_ADMIN'){
        $query = "SELECT * FROM enfant";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_AGENT'){
        $query = "SELECT * FROM agent, hopital WHERE agent.idHopital=hopital.idHopital";
        echo json_encode($app->fetchPrepared($query));
    }
     
    if ($event=='FIND_ENFANT') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT dateNaissance,noms,sexe,poids,taille,idMere,datePrev,DATEDIFF(`datePrev`,DATE(NOW())) FROM enfant, calendriervaccenf WHERE idMere ='$idMere' AND enfant.idEnfant = calendriervaccenf.idEnfant ORDER BY datePrev ASC";
        echo json_encode($app->fetchPrepared($querry));
        //SELECT DATEDIFF(DATE(NOW()),`datePrev`) FROM `calendriervaccenf`;
    }
    if ($event=='FIND_ENFANT_ONLY') {

        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM enfant WHERE idMere ='$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='FIND_NOTIF') {
        $idMere =$_POST['idMere'];
        $querry = "SELECT * FROM calendriervaccenf, enfant, vaccin WHERE datePrev<=DATE(NOW()) AND calendriervaccenf.idEnfant = enfant.idEnfant AND calendriervaccenf.idVaccin = vaccin.idVaccin AND enfant.idMere = '$idMere'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANTS_ATTENDUS') {
         $idHopital = $_POST["idHopital"];
            $querry = "SELECT DISTINCT enfant.idEnfant, enfant.idHopital, enfant.noms,enfant.sexe,v_calendriervaccenf.idEnfant,calendriervaccenf.idEnfant,v_calendriervaccenf.jour, calendriervaccenf.idVaccin FROM v_calendriervaccenf,enfant,calendriervaccenf WHERE v_calendriervaccenf.jour<=0 AND enfant.idEnfant=calendriervaccenf.idEnfant AND enfant.idEnfant = v_calendriervaccenf.idEnfant AND calendriervaccenf.idEnfant=v_calendriervaccenf.idEnfant AND enfant.idHopital = '$idHopital'";
            
        echo json_encode($app->fetchPrepared($querry));
        
    }
    if ($event=='MERES_ATTENDUES') {
         $idHopital = $_POST["idHopital"];
            $querry = "SELECT mere.idMere, mere.noms, mere.idHopital, mere.tel, mere.adresse, v_calendriervat.idMere, calendriervat.idMere, v_calendriervat.jour, calendriervat.idVat FROM v_calendriervat, mere, calendriervat WHERE v_calendriervat.jour<=0 AND mere.idMere = calendriervat.idMere AND mere.idMere = v_calendriervat.idMere AND calendriervat.idMere = v_calendriervat.idMere AND mere.idHopital = '$idHopital'";
        
        echo json_encode($app->fetchPrepared($querry));
        
    }
    if ($event=='VACCINES_TODAY') {
        $querry = "SELECT num, dateRecue FROM registrevaccenf WHERE dateRecue LIKE DATE(NOW()) UNION ALL SELECT  num, dateRecue FROM registrevat WHERE dateRecue LIKE DATE(NOW())";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='VACCINES_MONTH') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT num, dateRecue,idHopital FROM registrevaccenf WHERE MONTH(dateRecue) = MONTH(NOW()) AND idHopital = '$idHopital' UNION ALL SELECT  num, dateRecue,idHopital FROM registrevat WHERE MONTH(dateRecue) = MONTH(NOW()) AND idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANTS_VACCINES_LAST_MONTH') {
         $idHopital = $_POST["idHopital"];
        $querry = "SELECT num, dateRecue, idHopital FROM registrevaccenf WHERE MONTH(dateRecue) = (MONTH(NOW())-1) AND idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERES_VACCINES_LAST_MONTH') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT num, dateRecue, idHopital FROM registrevat WHERE MONTH(dateRecue) = (MONTH(NOW())-1) AND idHopital = '$idHopital' ";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANT_N0N_VACCINES') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT * FROM enfant WHERE idEnfant NOT IN (SELECT idEnfant FROM registrevaccenf) AND idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERE_N0N_VACCINES') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT * FROM mere WHERE idMere NOT IN (SELECT idMere FROM registrevat) AND idHopital = '$idHopital'";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANTS_VACCINES_LAST_MONTH_ADMIN') {
        $querry = "SELECT num, dateRecue, idHopital FROM registrevaccenf WHERE MONTH(dateRecue) = (MONTH(NOW())-1)";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERES_VACCINES_LAST_MONTH_ADMIN') {
        $querry = "SELECT num, dateRecue, idHopital FROM registrevat WHERE MONTH(dateRecue) = (MONTH(NOW())-1)";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANT_N0N_VACCINES_ADMIN') {
        $querry = "SELECT * FROM enfant WHERE idEnfant NOT IN (SELECT idEnfant FROM registrevaccenf)";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERE_N0N_VACCINES_ADMIN') {
        $querry = "SELECT * FROM mere WHERE idMere NOT IN (SELECT idMere FROM registrevat)";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='COUNT_ENFANTS_ATTENDUS') {
        $querry = "SELECT COUNT(*) FROM v_calendriervaccenf WHERE jour<=0 ";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ABANDONS_PEV') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT DISTINCT v_calendriervaccenf.idEnfant, v_calendriervaccenf.jour,enfant.idEnfant, v_calendriervaccenf.noms, registrevaccenf.idHopital, enfant.idHopital FROM enfant, v_calendriervaccenf, registrevaccenf WHERE v_calendriervaccenf.idEnfant = enfant.idEnfant AND enfant.idHopital = '$idHopital' AND v_calendriervaccenf.jour<-20 ORDER BY enfant.idEnfant ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANTS_MONTH') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT enfant.idEnfant,enfant.noms,enfant.lieuNaiss,enfant.dateNaissance,enfant.sexe,registrevaccenf.idEnfant, registrevaccenf.idHopital, MONTH(registrevaccenf.dateRecue) FROM enfant, registrevaccenf WHERE enfant.idEnfant=registrevaccenf.idEnfant AND MONTH(registrevaccenf.dateRecue) = MONTH(NOW()) AND registrevaccenf.idHopital = '$idHopital' ORDER BY enfant.idEnfant ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERES_MONTH') {
        $idHopital = $_POST["idHopital"];
        $querry = "SELECT mere.idMere,mere.noms,mere.dateNaiss,registrevat.idMere, registrevat.idHopital, MONTH(registrevat.dateRecue) FROM mere, registrevat WHERE mere.idMere=registrevat.idMere AND MONTH(registrevat.dateRecue) = MONTH(NOW()) AND registrevat.idHopital = '$idHopital' ORDER BY mere.idMere ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='ENFANTS_2_DATES') {
        $idHopital = $_POST["idHopital"];
        $date1=$_POST['date1'];
        $date2=$_POST['date2'];
        $querry = "SELECT enfant.idEnfant,enfant.noms,enfant.lieuNaiss,enfant.dateNaissance,enfant.sexe,registrevaccenf.idEnfant, registrevaccenf.dateRecue FROM enfant, registrevaccenf WHERE enfant.idEnfant=registrevaccenf.idEnfant AND registrevaccenf.dateRecue BETWEEN '$date1' AND '$date2' AND registrevaccenf.idHopital = '$idHopital' ORDER BY enfant.idEnfant ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    if ($event=='MERES_2_DATES') {
        $idHopital = $_POST["idHopital"];
        $date1=$_POST['date1'];
        $date2=$_POST['date2'];
        $querry = "SELECT mere.idMere,mere.noms,mere.dateNaiss,registrevat.idMere, registrevat.dateRecue FROM mere, registrevat WHERE mere.idMere=registrevat.idMere AND registrevat.dateRecue BETWEEN '$date1' AND '$date2' AND registrevat.idHopital = '$idHopital' ORDER BY mere.idMere ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    if($event=='FIND_VACCIN_FORMAL'){
        $query = "SELECT concat(idVaccin,'-',nomVaccin) vacc FROM formal_vaccins";
        echo json_encode($app->fetchPrepared($query));
    }
    if ($event=='ENFANTS_VACCIN') {
        $idVaccin=$_POST['idVaccin'];
        $querry = "SELECT enfant.idEnfant,enfant.noms,enfant.lieuNaiss,enfant.dateNaissance,enfant.sexe,registrevaccenf.idEnfant, registrevaccenf.idVaccin,formal_vaccins.idVaccin FROM enfant, registrevaccenf,formal_vaccins WHERE enfant.idEnfant=registrevaccenf.idEnfant AND formal_vaccins.idVaccin=registrevaccenf.idVaccin AND registrevaccenf.idVaccin='$idVaccin' ORDER BY enfant.idEnfant ASC";
        echo json_encode($app->fetchPrepared($querry));
    }
    
    //, registrevat WHERE MONTH(datePrev)=MONTH(DATE(NOW())) AND MONTH(datePrevue)
    
    if($event=='FIND_STAT'){
        $query = "SELECT * FROM registrevaccenf WHERE num < 6";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_ECV'){
        $idHopital = $_POST["idHopital"];
        $query = "SELECT * FROM registrevaccenf WHERE idHopital =' $idHopital'GROUP BY idEnfant HAVING COUNT(idEnfant) >=5";
        echo json_encode($app->fetchPrepared($query));
    }
    if($event=='FIND_MCV'){
        $idHopital = $_POST["idHopital"];
        $query = "SELECT * FROM registrevat WHERE idHopital =' $idHopital'GROUP BY idMere HAVING COUNT(idMere) >=5";
        echo json_encode($app->fetchPrepared($query));
    }
    if ($event=='CALENDARS') {
        $idHopital = $_POST["idHopital"];
        $query = "SELECT enfant.noms as nom,enfant.idEnfant,enfant.idHopital,hopital.idHopital,calendriervaccenf.datePrev,calendriervaccenf.idVaccin,calendriervaccenf.idEnfant,nomVaccin FROM calendriervaccenf,enfant,hopital,vaccin WHERE calendriervaccenf.idEnfant=enfant.idEnfant AND enfant.idHopital = hopital.idHopital AND hopital.idHopital = ' $idHopital' AND calendriervaccenf.idVaccin = vaccin.idVaccin";
        echo json_encode($app->fetchPrepared($query));
    }

?>