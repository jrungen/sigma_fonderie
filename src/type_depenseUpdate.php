<?php

$search=" where idtype_depense = '".$_REQUEST['id']."'";

//Connexion � la base de donnees
include 'cnx.php';



// Requ�te
$query = "UPDATE type_depense set  $search";


$result = mysql_query( $query );

?>



