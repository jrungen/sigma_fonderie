<?php

$search=" where idsalarie = '".$_REQUEST['id']."'";

//Connexion ˆ la base de donnees
include 'cnx.php';

if ($_REQUEST['nom']=='') $s_nom = ''; else $s_nom= addslashes($_REQUEST['nom']);
if ($_REQUEST['nom01']=='') $s_nom01 = ''; else $s_nom01= addslashes($_REQUEST['nom01']);
if ($_REQUEST['liendeparente01']=='') $s_liendeparente01 = ''; else $s_liendeparente01= addslashes($_REQUEST['liendeparente01']);
if ($_REQUEST['rip']=='') $s_rip = ''; else $s_rip= addslashes($_REQUEST['rip']);
if ($_REQUEST['login']=='') $s_login = ''; else $s_login= addslashes($_REQUEST['login']);
if ($_REQUEST['datedembauche']=='') $s_datedembauche = '0000-00-00'; else $s_datedembauche= addslashes($_REQUEST['datedembauche']);
if ($_REQUEST['sexe']=='') $s_sexe = ''; else $s_sexe= addslashes($_REQUEST['sexe']);
if ($_REQUEST['situationfamiliale']=='') $s_situationfamiliale = ''; else $s_situationfamiliale= addslashes($_REQUEST['situationfamiliale']);
if ($_REQUEST['voiture']=='') $s_voiture = ''; else $s_voiture= addslashes($_REQUEST['voiture']);
if ($_REQUEST['nomjeunefille']=='') $s_nomjeunefille = ''; else $s_nomjeunefille= addslashes($_REQUEST['nomjeunefille']);
if ($_REQUEST['adresse01']=='') $s_adresse01 = ''; else $s_adresse01= addslashes($_REQUEST['adresse01']);
if ($_REQUEST['cpville01']=='') $s_cpville01 = ''; else $s_cpville01= addslashes($_REQUEST['cpville01']);
if ($_REQUEST['salairebrut']=='') $s_salairebrut = ''; else $s_salairebrut= addslashes($_REQUEST['salairebrut']);
if ($_REQUEST['domicile']=='') $s_domicile = ''; else $s_domicile= addslashes($_REQUEST['domicile']);
if ($_REQUEST['motdepasse']=='') $s_motdepasse = ''; else $s_motdepasse= addslashes($_REQUEST['motdepasse']);
if ($_REQUEST['prenom']=='') $s_prenom = ''; else $s_prenom= addslashes($_REQUEST['prenom']);
if ($_REQUEST['motifsortie']=='') $s_motifsortie = ''; else $s_motifsortie= addslashes($_REQUEST['motifsortie']);
if ($_REQUEST['echeance']=='') $s_echeance = '0000-00-00'; else $s_echeance= addslashes($_REQUEST['echeance']);
if ($_REQUEST['zone']=='') $s_zone = ''; else $s_zone= addslashes($_REQUEST['zone']);
if ($_REQUEST['telephone01']=='') $s_telephone01 = ''; else $s_telephone01= addslashes($_REQUEST['telephone01']);
if ($_REQUEST['liendeparente02']=='') $s_liendeparente02 = ''; else $s_liendeparente02= addslashes($_REQUEST['liendeparente02']);
if ($_REQUEST['nombanque']=='') $s_nombanque = ''; else $s_nombanque= addslashes($_REQUEST['nombanque']);
if ($_REQUEST['adresse']=='') $s_adresse = ''; else $s_adresse= addslashes($_REQUEST['adresse']);
if ($_REQUEST['statut']=='') $s_statut = ''; else $s_statut= addslashes($_REQUEST['statut']);
if ($_REQUEST['pointpermis']=='') $s_pointpermis = ''; else $s_pointpermis= addslashes($_REQUEST['pointpermis']);
if ($_REQUEST['nom02']=='') $s_nom02 = ''; else $s_nom02= addslashes($_REQUEST['nom02']);
if ($_REQUEST['cpville02']=='') $s_cpville02 = ''; else $s_cpville02= addslashes($_REQUEST['cpville02']);
if ($_REQUEST['codebanque']=='') $s_codebanque = ''; else $s_codebanque= addslashes($_REQUEST['codebanque']);
if ($_REQUEST['datedefin']=='') $s_datedefin = '0000-00-00'; else $s_datedefin= addslashes($_REQUEST['datedefin']);
if ($_REQUEST['adressesuite']=='') $s_adressesuite = ''; else $s_adressesuite= addslashes($_REQUEST['adressesuite']);
if ($_REQUEST['chevaux']=='') $s_chevaux = ''; else $s_chevaux= addslashes($_REQUEST['chevaux']);
if ($_REQUEST['siteappartenance']=='') $s_siteappartenance = ''; else $s_siteappartenance= addslashes($_REQUEST['siteappartenance']);
if ($_REQUEST['adresse02']=='') $s_adresse02 = ''; else $s_adresse02= addslashes($_REQUEST['adresse02']);
if ($_REQUEST['test01']=='') $s_test01 = ''; else $s_test01= addslashes($_REQUEST['test01']);
if ($_REQUEST['nocompte']=='') $s_nocompte = ''; else $s_nocompte= addslashes($_REQUEST['nocompte']);
if ($_REQUEST['typecontrat']=='') $s_typecontrat = ''; else $s_typecontrat= addslashes($_REQUEST['typecontrat']);
if ($_REQUEST['echeancect']=='') $s_echeancect = '0000-00-00'; else $s_echeancect= addslashes($_REQUEST['echeancect']);
if ($_REQUEST['telephone']=='') $s_telephone = ''; else $s_telephone= addslashes($_REQUEST['telephone']);
if ($_REQUEST['cpville']=='') $s_cpville = ''; else $s_cpville= addslashes($_REQUEST['cpville']);
if ($_REQUEST['portable']=='') $s_portable = ''; else $s_portable= addslashes($_REQUEST['portable']);
if ($_REQUEST['telephone02']=='') $s_telephone02 = ''; else $s_telephone02= addslashes($_REQUEST['telephone02']);
if ($_REQUEST['cle_rib']=='') $s_cle_rib = ''; else $s_cle_rib= addslashes($_REQUEST['cle_rib']);
if ($_REQUEST['temps']=='') $s_temps = ''; else $s_temps= addslashes($_REQUEST['temps']);
if ($_REQUEST['email']=='') $s_email = ''; else $s_email= addslashes($_REQUEST['email']);
if ($_REQUEST['age']=='') $s_age = ''; else $s_age= addslashes($_REQUEST['age']);
if ($_REQUEST['tempspartiel']=='') $s_tempspartiel = ''; else $s_tempspartiel= addslashes($_REQUEST['tempspartiel']);
if ($_REQUEST['lieunaissance']=='') $s_lieunaissance = ''; else $s_lieunaissance= addslashes($_REQUEST['lieunaissance']);
if ($_REQUEST['nationalite']=='') $s_nationalite = ''; else $s_nationalite= addslashes($_REQUEST['nationalite']);
if ($_REQUEST['bulletindesalaire']=='') $s_bulletindesalaire = ''; else $s_bulletindesalaire= addslashes($_REQUEST['bulletindesalaire']);
if ($_REQUEST['datenaissance']=='') $s_datenaissance = '0000-00-00'; else $s_datenaissance= addslashes($_REQUEST['datenaissance']);
if ($_REQUEST['dateexpiration01']=='') $s_dateexpiration01 = '0000-00-00'; else $s_dateexpiration01= addslashes($_REQUEST['dateexpiration01']);
if ($_REQUEST['cartegrise']=='') $s_cartegrise = ''; else $s_cartegrise= addslashes($_REQUEST['cartegrise']);
if ($_REQUEST['pays']=='') $s_pays = ''; else $s_pays= addslashes($_REQUEST['pays']);
if ($_REQUEST['dateexpiration02']=='') $s_dateexpiration02 = '0000-00-00'; else $s_dateexpiration02= addslashes($_REQUEST['dateexpiration02']);
if ($_REQUEST['cartesejour']=='') $s_cartesejour = ''; else $s_cartesejour= addslashes($_REQUEST['cartesejour']);
if ($_REQUEST['nocartesejour']=='') $s_nocartesejour = ''; else $s_nocartesejour= addslashes($_REQUEST['nocartesejour']);
if ($_REQUEST['nocarteidentite']=='') $s_nocarteidentite = ''; else $s_nocarteidentite= addslashes($_REQUEST['nocarteidentite']);
if ($_REQUEST['casier']=='') $s_casier = ''; else $s_casier= addslashes($_REQUEST['casier']);
if ($_REQUEST['certificat']=='') $s_certificat = ''; else $s_certificat= addslashes($_REQUEST['certificat']);
if ($_REQUEST['diplome']=='') $s_diplome = ''; else $s_diplome= addslashes($_REQUEST['diplome']);
if ($_REQUEST['livretdefamille']=='') $s_livretdefamille = ''; else $s_livretdefamille= addslashes($_REQUEST['livretdefamille']);
if ($_REQUEST['permis']=='') $s_permis = ''; else $s_permis= addslashes($_REQUEST['permis']);
if ($_REQUEST['photo']=='') $s_photo = ''; else $s_photo= addslashes($_REQUEST['photo']);
if ($_REQUEST['rib']=='') $s_rib = ''; else $s_rib= addslashes($_REQUEST['rib']);
if ($_REQUEST['vaccins']=='') $s_vaccins = ''; else $s_vaccins= addslashes($_REQUEST['vaccins']);
if ($_REQUEST['cartevital']=='') $s_cartevital = ''; else $s_cartevital= addslashes($_REQUEST['cartevital']);
if ($_REQUEST['assuranceauto']=='') $s_assuranceauto = ''; else $s_assuranceauto= addslashes($_REQUEST['assuranceauto']);
if ($_REQUEST['carteid']=='') $s_carteid = ''; else $s_carteid= addslashes($_REQUEST['carteid']);
if ($_REQUEST['cle']=='') $s_cle = ''; else $s_cle= addslashes($_REQUEST['cle']);


// Requête
$query = "UPDATE salarie set nom='". $s_nom."',
nom01='". $s_nom01."',
liendeparente01='". $s_liendeparente01."',
rip='". $s_rip."',
login='". $s_login."',
datedembauche='". $s_datedembauche."',
sexe='". $s_sexe."',
situationfamiliale='". $s_situationfamiliale."',
voiture='". $s_voiture."',
nomjeunefille='". $s_nomjeunefille."',
adresse01='". $s_adresse01."',
cpville01='". $s_cpville01."',
salairebrut='". $s_salairebrut."',
domicile='". $s_domicile."',
motdepasse='". $s_motdepasse."',
prenom='". $s_prenom."',
motifsortie='". $s_motifsortie."',
echeance='". $s_echeance."',
zone='". $s_zone."',
telephone01='". $s_telephone01."',
liendeparente02='". $s_liendeparente02."',
nombanque='". $s_nombanque."',
adresse='". $s_adresse."',
statut='". $s_statut."',
pointpermis='". $s_pointpermis."',
nom02='". $s_nom02."',
cpville02='". $s_cpville02."',
codebanque='". $s_codebanque."',
datedefin='". $s_datedefin."',
adressesuite='". $s_adressesuite."',
chevaux='". $s_chevaux."',
siteappartenance='". $s_siteappartenance."',
adresse02='". $s_adresse02."',
test01='". $s_test01."',
nocompte='". $s_nocompte."',
typecontrat='". $s_typecontrat."',
echeancect='". $s_echeancect."',
telephone='". $s_telephone."',
cpville='". $s_cpville."',
portable='". $s_portable."',
telephone02='". $s_telephone02."',
cle_rib='". $s_cle_rib."',
temps='". $s_temps."',
email='". $s_email."',
age='". $s_age."',
tempspartiel='". $s_tempspartiel."',
lieunaissance='". $s_lieunaissance."',
nationalite='". $s_nationalite."',
bulletindesalaire='". $s_bulletindesalaire."',
datenaissance='". $s_datenaissance."',
dateexpiration01='". $s_dateexpiration01."',
cartegrise='". $s_cartegrise."',
pays='". $s_pays."',
dateexpiration02='". $s_dateexpiration02."',
cartesejour='". $s_cartesejour."',
nocartesejour='". $s_nocartesejour."',
nocarteidentite='". $s_nocarteidentite."',
casier='". $s_casier."',
certificat='". $s_certificat."',
diplome='". $s_diplome."',
livretdefamille='". $s_livretdefamille."',
permis='". $s_permis."',
photo='". $s_photo."',
rib='". $s_rib."',
vaccins='". $s_vaccins."',
cartevital='". $s_cartevital."',
assuranceauto='". $s_assuranceauto."',
carteid='". $s_carteid."',
cle='". $s_cle."' $search";


$result = mysql_query( $query );

?>



