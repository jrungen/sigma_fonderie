<?php
$table = $_REQUEST['categorie'];
$id = $_REQUEST['id'];

//Connexion � la base de donn�es
include 'cnx.php';


// Requ�te
$query = "delete from $table where id$table = '$id'";
$result = mysql_query( $query );



?>


