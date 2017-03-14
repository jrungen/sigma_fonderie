<?php
$cle = $_REQUEST['cle'];

//Connexion à la base de données
include 'cnx.php';

// Requête
$query = "SELECT * from salarie where cle = '$cle'";
$result = mysql_query( $query );

/* print out your own XML */
print "<salarieRead>\n";
while( $row = mysql_fetch_object( $result ) )
{
   print "<item>
	<nom>".$row->nom."</nom>
<nom01>".$row->nom01."</nom01>
<liendeparente01>".$row->liendeparente01."</liendeparente01>
<rip>".$row->rip."</rip>
<login>".$row->login."</login>
<datedembauche>".$row->datedembauche."</datedembauche>
<sexe>".$row->sexe."</sexe>
<situationfamiliale>".$row->situationfamiliale."</situationfamiliale>
<voiture>".$row->voiture."</voiture>
<nomjeunefille>".$row->nomjeunefille."</nomjeunefille>
<adresse01>".$row->adresse01."</adresse01>
<cpville01>".$row->cpville01."</cpville01>
<salairebrut>".$row->salairebrut."</salairebrut>
<domicile>".$row->domicile."</domicile>
<motdepasse>".$row->motdepasse."</motdepasse>
<prenom>".$row->prenom."</prenom>
<motifsortie>".$row->motifsortie."</motifsortie>
<echeance>".$row->echeance."</echeance>
<zone>".$row->zone."</zone>
<telephone01>".$row->telephone01."</telephone01>
<liendeparente02>".$row->liendeparente02."</liendeparente02>
<nombanque>".$row->nombanque."</nombanque>
<adresse>".$row->adresse."</adresse>
<statut>".$row->statut."</statut>
<pointpermis>".$row->pointpermis."</pointpermis>
<nom02>".$row->nom02."</nom02>
<cpville02>".$row->cpville02."</cpville02>
<codebanque>".$row->codebanque."</codebanque>
<datedefin>".$row->datedefin."</datedefin>
<adressesuite>".$row->adressesuite."</adressesuite>
<chevaux>".$row->chevaux."</chevaux>
<siteappartenance>".$row->siteappartenance."</siteappartenance>
<adresse02>".$row->adresse02."</adresse02>
<test01>".$row->test01."</test01>
<nocompte>".$row->nocompte."</nocompte>
<typecontrat>".$row->typecontrat."</typecontrat>
<echeancect>".$row->echeancect."</echeancect>
<telephone>".$row->telephone."</telephone>
<cpville>".$row->cpville."</cpville>
<portable>".$row->portable."</portable>
<telephone02>".$row->telephone02."</telephone02>
<cle_rib>".$row->cle_rib."</cle_rib>
<temps>".$row->temps."</temps>
<email>".$row->email."</email>
<age>".$row->age."</age>
<tempspartiel>".$row->tempspartiel."</tempspartiel>
<lieunaissance>".$row->lieunaissance."</lieunaissance>
<nationalite>".$row->nationalite."</nationalite>
<bulletindesalaire>".$row->bulletindesalaire."</bulletindesalaire>
<datenaissance>".$row->datenaissance."</datenaissance>
<dateexpiration01>".$row->dateexpiration01."</dateexpiration01>
<cartegrise>".$row->cartegrise."</cartegrise>
<pays>".$row->pays."</pays>
<dateexpiration02>".$row->dateexpiration02."</dateexpiration02>
<cartesejour>".$row->cartesejour."</cartesejour>
<nocartesejour>".$row->nocartesejour."</nocartesejour>
<nocarteidentite>".$row->nocarteidentite."</nocarteidentite>
<casier>".$row->casier."</casier>
<certificat>".$row->certificat."</certificat>
<diplome>".$row->diplome."</diplome>
<livretdefamille>".$row->livretdefamille."</livretdefamille>
<permis>".$row->permis."</permis>
<photo>".$row->photo."</photo>
<rib>".$row->rib."</rib>
<vaccins>".$row->vaccins."</vaccins>
<cartevital>".$row->cartevital."</cartevital>
<assuranceauto>".$row->assuranceauto."</assuranceauto>
<carteid>".$row->carteid."</carteid>
<cle>".$row->cle."</cle>
<idsalarie>".$row->idsalarie."</idsalarie>

	</item>\n";
}
print "</salarieRead>";

?>

