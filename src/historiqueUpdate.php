<?php

$search=" where idhistorique = '".$_REQUEST['id']."'";

//Connexion � la base de donnees
include 'cnx.php';



// Requ�te
$query = "UPDATE historique set  $search";


$result = mysql_query( $query );

?>



