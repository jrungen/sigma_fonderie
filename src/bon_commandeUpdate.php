<?php

$search=" where idbon_commande = '".$_REQUEST['id']."'";

//Connexion � la base de donnees
include 'cnx.php';



// Requ�te
$query = "UPDATE bon_commande set  $search";


$result = mysql_query( $query );

?>



