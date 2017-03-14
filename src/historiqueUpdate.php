<?php

$search=" where idhistorique = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';



// Requête
$query = "UPDATE historique set  $search";


$result = mysql_query( $query );

?>



