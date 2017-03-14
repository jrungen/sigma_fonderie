<?php
$textsearch = $_REQUEST['search'];
$field = $_REQUEST['field'];
$view = $_REQUEST['view'];
$s_statut = $_REQUEST['statut'];
$s_annee = $_REQUEST['annee'];


$search="";
switch ($view) {
	case 'Par défaut':
	$search="";
	break;
	
	case 'Corinne':
	$search="AND comptable = 'Corinne' ";
	break;

	case 'Benjamin':
	$search="AND comptable = 'Benjamin'  ";
	break;

	case 'Kevin':
	$search="AND comptable in ('Benjamin','Kevin') ";
	break;

	case 'Dpt Sante':
	$search="AND departement like 'Dpt Sant%'  ";
	break;

	case 'Dpt Corpo':
	$search="AND departement = 'Dpt Corpo'  ";
	break;
	
	case 'Dpt Externalisation':
	$search="AND departement = 'Dpt Externalisation'  ";
	break;
}

// USER
$user = "'".$_COOKIE['cookie_flex_sigma_cle']."'";
if($_COOKIE['cookie_flex_sigma_subordonnes']!='') $user.= ', '.$_COOKIE['cookie_flex_sigma_subordonnes'];
//echo $user;
//echo $_COOKIE['cookie_flex_sigma_profil'];

if($_COOKIE['cookie_flex_sigma_profil']!=''){
	if($_COOKIE['cookie_flex_sigma_profil']=='admin'){
		if ($s_statut!='') $search.="and statut = '".$s_statut."' ";if ($s_annee!='') $search.="and annee = '".$s_annee."' ";
	}else{
		if ($s_statut!='') $search.="and statut = '".$s_statut."' ";if ($s_annee!='') $search.="and annee = '".$s_annee."' ";
		$search.= " and utilisateur in(".$user.")";
	}
}else{
	$search.="and statut = 'rien' ";
}

if ($field=='Tous'){
	if ($textsearch!='') $search.=" and (societe like '%$textsearch%' OR cle like '%$textsearch%' OR idprojet like '%$textsearch%' OR apporteur_affaire like '%$textsearch%' OR lieu like '%$textsearch%' OR nom like '%$textsearch%' OR datedebut like '%$textsearch%' OR datefin like '%$textsearch%' OR numero like '%$textsearch%' OR numero_code like '%$textsearch%' OR utilisateur like '%$textsearch%' OR ca_ht like '%$textsearch%' OR total_marge like '%$textsearch%' OR taux_marge like '%$textsearch%' OR libelle like '%$textsearch%' ) ";
}else{
	if ($textsearch!='') $search.=" and $field like '%$textsearch%' ";
}

//Connexion � la base de donn�es
include 'cnx.php';
//echo $search;

// Requ�te
$query = "SELECT * from projet where 1 ".$search." order by projet.idprojet desc";
//echo $query;

$result = mysql_query( $query );

print "<projetList>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<societe>".$row->societe."</societe>
<cle>".$row->cle."</cle>
<idprojet>".$row->idprojet."</idprojet>
<lieu>".$row->lieu."</lieu>
<nom>".$row->nom."</nom>
<datedebut>".substr($row->datedebut,-2)."/".substr($row->datedebut,-5,2)."/".substr($row->datedebut,-10,4)."</datedebut>
<datefin>".substr($row->datefin,-2)."/".substr($row->datefin,-5,2)."/".substr($row->datefin,-10,4)."</datefin>
<numero>".$row->numero."</numero>
<numero_code>".$row->numero_code."</numero_code>
<utilisateur>".$row->utilisateur."</utilisateur>
<ca_ht>".$row->ca_ht."</ca_ht>
<total_marge>".$row->total_marge."</total_marge>
<total_balance>".$row->st_total_balance."</total_balance>
<taux_marge>".$row->taux_marge."</taux_marge>
<libelle>".$row->libelle."</libelle>

   </item>\n";
}
print "</projetList>"; 
//echo $_COOKIE['cookie_flex_sigma_profil'];
//echo $query;
?>