<?php

class App
 {
    private $db_name, $db_user, $db_pass, $db_host, $pdo;
    public $status = 0;
  


    public function __construct( $db_name = "id17494911_esantevacci", $db_user = "root", $db_pass = "", $db_host = 'localhost' )
 {
        $this->db_name = $db_name;
        $this->db_user = $db_user;
        $this->db_pass = $db_pass;
        $this->db_host = $db_host;
    }

public function getPDO()
{
    try {
        if ( $this->pdo === null ) {
            $pdo_ = new PDO( 'mysql:host=' . $this->db_host . '; port=3306; dbname=' . $this->db_name . ';charset=utf8', $this->db_user, $this->db_pass );
            // $pdo->exec("SET time_zone='+02:00';");
            $pdo_->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING );
            $this->pdo = $pdo_;
        }
    } catch ( PDOException $ex ) {
     die( $ex->getMessage() );
    }
    return $this->pdo;
}

    public function query_exec( $statement )
 {
        $req = $this->getPDO()->query( $statement );
        $data = $req->fetchAll( PDO::FETCH_OBJ );
        return $data;
    }
    
public function prepare( $statement, $attribut = [], $test )
 {
 
        try {
            $req = $this->getPDO()->prepare( $statement );
            switch ( $test ) {
                case 1:
                     return $req->execute($attribut);
                       
                break;
                case 2:
                    $req->execute();
                return $req->fetchAll();
                break;
                default:
                     $req->execute( $attribut );
                return ( $req->fetchAll() );
            }
        } catch ( PDOException $exception ) {
             die( $exception->getMessage());
        }
    }

    public function fetchPrepared( $statement )
 {
        $req = $this->getPDO()->prepare( $statement );
        $req->execute();
        return $req->fetchAll();
    }
       public function getValues($rqt)
    {
        $querry = $this->getPDO()->prepare($rqt);
        $querry->execute();
        while ($row = $querry->fetch()) {
            return $row["value"];
        }
        return null;
    }
    public function getRandID($element)
    {
        return   substr($element, 0, 3) . date('YmdGis');
    }
    public function getCaracter( $valeur )
 {
        if ( preg_match( "/^[\p{L}0-9- ]*$/u", $valeur ) ) {
            return true;
        } else {
            return false;
        }
    }

    public function getMail( $valeur )
 {
        if ( preg_match( "/^[a-z0-9\-_.]+@[a-z]+\.[a-z]{2,3}$/i", $valeur ) ) {
            return true;
        } else {
            return false;
        }
    }    

    public function getApostrophe( $message )
    {
        return str_replace( "'", "''", $message );
    }
    
    public function getData($donne){
        $datab=str_replace("[",trim(''),$donne);   
        $datan=str_replace("]",'',$datab);
        return $data=explode(",", $datan); 
    }
     public function isValideTel($numero)
    {
        if (preg_match('#(0|\+33)[1-9]( *[0-9]{2}){4}#', $numero)) {
            return true;
        } else {
            return true;
        }
    }
    
 }




