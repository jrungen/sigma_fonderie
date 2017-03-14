<?php

$search=" where idbon_commande = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';



// Requête
$query = "UPDATE bon_commande set  $search";


$result = mysql_query( $query );

?>



