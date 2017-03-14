<?php
$table = $_REQUEST['table'];
$annee = $_REQUEST['annee'];

//Connexion à la base de données
include 'cnx.php';

switch ($table) {
	case 'projet':
	// Requête
	$query = "SELECT numero_projet as numero from configuration where idconfiguration='1'";
	$result = mysql_query( $query );
	print "<autoincrement>\n";
	while( $row = mysql_fetch_object( $result ) )
	{
		$num = $row->numero;
		echo $num;
		$new =$num + 1;
	   print "<nouveau>
		<numero>".$num."</numero>
	   </nouveau>\n";
	}
	
	print "</autoincrement>"; 

	// Mettre à jour la fiche configuration
	$query = "update configuration set numero_projet='$new' where idconfiguration='1'";
	$result = mysql_query( $query );	
	break;
	
	case "facture_client":
	// Requête
	/*
	$query = "SELECT numero_facture_client as numero from configuration where idconfiguration='1'";
	$result = mysql_query( $query );
	print "<autoincrement>\n";
	while( $row = mysql_fetch_object( $result ) )
	{
		$num = $row->numero;
		echo $num;
		$new =$num + 1;
		// num=YYYYMM001
		// Il faut enlever le 1 du numéro
		$num=date('Ym').substr($num, 1, 3);
	   print "<nouveau>
		<numero>".$num."</numero>
	   </nouveau>\n";
	}
	
	print "</autoincrement>"; 
	// Mettre à jour la fiche configuration
	$query = "update configuration set numero_facture_client='$new' where idconfiguration='1'";
	$result = mysql_query( $query );	
	*/
	if($annee=='2011'){
		$query = "SELECT numero as numero FROM facture_client where numero like '2011%' order by numero desc limit 0,1;";
	}
	if($annee=='2012'){
		$query = "SELECT numero as numero FROM facture_client where numero like '2012%' order by round(numero) desc limit 0,1;";
	}

	$result = mysql_query( $query );
	print "<autoincrement>\n";
	while( $row = mysql_fetch_object( $result ) )
	{
		$num = $row->numero;
		$new =$num + 1;
		if($annee=='2011'){
			$new = '201110'.substr($new, 6, 3);
		}else{
			$new = date('Ym').substr($new, 6, 4);
		}
	   print "<nouveau>
		<numero>".$new."</numero>
	   </nouveau>\n";
	}
	
	print "</autoincrement>"; 

	break;
}

 
?>

