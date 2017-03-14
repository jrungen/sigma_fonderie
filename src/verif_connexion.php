<?php
$table = $_REQUEST['table'];
$login = $_REQUEST['login'];
$password = $_REQUEST['password'];


//Connexion à la base de données
include 'cnx.php';


// Requête
$query = "SELECT * from $table where login='$login' and password='$password'";
$result = mysql_query( $query );
$num_rows = mysql_num_rows($result);
if($num_rows>0){
print "<utilisateurList>\n";
while( $row = mysql_fetch_object( $result ) )
{
	// Créer un cookie
	$utilisateur_cle = $row->cle;
	$utilisateur_profil = $row->profil;
	$utilisateur_subordonnes = $row->subordonnes;
	setcookie('cookie_flex_sigma_cle', $utilisateur_cle);
	setcookie('cookie_flex_sigma_profil', $utilisateur_profil);
	setcookie('cookie_flex_sigma_subordonnes', $utilisateur_subordonnes);
	
   print "<item>
	<idutilisateur>".$row->idutilisateur."</idutilisateur>
	<login>".$row->login."</login>
	<password>".$row->password."</password>
	<cle>".$row->cle."</cle>
	<profil>".$row->profil."</profil>
	<societe>".$row->societe."</societe>
	   </item>\n";
}
print "</utilisateurList>"; 
}else{
	print "<utilisateurList>\n
	<item>
	<idutilisateur></idutilisateur>
	<login></login>
	<password></password>
	<cle></cle>
	<profil></profil></item>
	<societe></societe>\n
	</utilisateurList>"; 
}
?>

