<?php

//Connexion a la base de donn�es
include 'cnx.php';


// Requete
$query = "SELECT * from depenses_annexes where 1 AND projet='".$_REQUEST['cle']."' AND objet <>'Prestation tourisme d\'affaires'";
$result = mysql_query( $query );

print "<depenses_annexesList>\n";
while( $row = mysql_fetch_object( $result ) )
{
	//---------------------------
	// Gestion des connexions
	//---------------------------
	$query_connexion = "SELECT nom,prenom from tiers where 1 AND cle='".$row->tiers."' ";
	$result_connexion = mysql_query( $query_connexion );
	$tiers = '';
	while( $row_connexion = mysql_fetch_object( $result_connexion ) )
	{
		$tiers = $row_connexion->nom.' '.$row_connexion->prenom;
	}
	
	$montantht = $row->montant_ht;
	
	if($montantht==0){
		$montantht = $row->montant_reglement_ttc;
	}

   print "<item>
		<iddepenses_annexes>".$row->iddepenses_annexes."</iddepenses_annexes>
		<cle>".$row->cle."</cle>
		<pays>".$row->pays."</pays>
		<date>".substr($row->date,-2)."/".substr($row->date,-5,2)."/".substr($row->date,-10,4)."</date>
		<type_depense>".$row->type_depense."</type_depense>
		<montant_reglement_ttc>".$row->montant_reglement_ttc."</montant_reglement_ttc>
		<montant_ttc>".$row->montant_ttc."</montant_ttc>
		<total_reglement>".$row->total_reglement."</total_reglement>
		<libelle>".$row->libelle."</libelle>
		<tiers>".$tiers."</tiers>
		<regle_le>".substr($row->regle_le,-2)."/".substr($row->regle_le,-5,2)."/".substr($row->regle_le,-10,4)."</regle_le>
		<montant_ht>".$montantht."</montant_ht>
	</item>\n";
}
print "</depenses_annexesList>"; 
?>