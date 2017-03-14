<?php
//Connexion à la base de données
include '../cnx.php';

function money_format_win($format, $number)
{
    $regex  = '/%((?:[\^!\-]|\+|\(|\=.)*)([0-9]+)?'.
              '(?:#([0-9]+))?(?:\.([0-9]+))?([in%])/';
    if (setlocale(LC_MONETARY, 0) == 'C') {
        setlocale(LC_MONETARY, '');
    }
    $locale = localeconv();
    preg_match_all($regex, $format, $matches, PREG_SET_ORDER);
    foreach ($matches as $fmatch) {
        $value = floatval($number);
        $flags = array(
            'fillchar'  => preg_match('/\=(.)/', $fmatch[1], $match) ?
                           $match[1] : ' ',
            'nogroup'   => preg_match('/\^/', $fmatch[1]) > 0,
            'usesignal' => preg_match('/\+|\(/', $fmatch[1], $match) ?
                           $match[0] : '+',
            'nosimbol'  => preg_match('/\!/', $fmatch[1]) > 0,
            'isleft'    => preg_match('/\-/', $fmatch[1]) > 0
        );
        $width      = trim($fmatch[2]) ? (int)$fmatch[2] : 0;
        $left       = trim($fmatch[3]) ? (int)$fmatch[3] : 0;
        $right      = trim($fmatch[4]) ? (int)$fmatch[4] : $locale['int_frac_digits'];
        $conversion = $fmatch[5];
 
        $positive = true;
        if ($value < 0) {
            $positive = false;
            $value  *= -1;
        }
        $letter = $positive ? 'p' : 'n';
 
        $prefix = $suffix = $cprefix = $csuffix = $signal = '';
 
        $signal = $positive ? $locale['positive_sign'] : $locale['negative_sign'];
        switch (true) {
            case $locale["{$letter}_sign_posn"] == 1 && $flags['usesignal'] == '+':
                $prefix = $signal;
                break;
            case $locale["{$letter}_sign_posn"] == 2 && $flags['usesignal'] == '+':
                $suffix = $signal;
                break;
            case $locale["{$letter}_sign_posn"] == 3 && $flags['usesignal'] == '+':
                $cprefix = $signal;
                break;
            case $locale["{$letter}_sign_posn"] == 4 && $flags['usesignal'] == '+':
                $csuffix = $signal;
                break;
            case $flags['usesignal'] == '(':
            case $locale["{$letter}_sign_posn"] == 0:
                $prefix = '(';
                $suffix = ')';
                break;
        }
        if (!$flags['nosimbol']) {
            $currency = $cprefix .
                        ($conversion == 'i' ? $locale['int_curr_symbol'] : $locale['currency_symbol']) .
                        $csuffix;
        } else {
            $currency = '';
        }
        $space  = $locale["{$letter}_sep_by_space"] ? ' ' : '';
 
        $value = number_format($value, $right, $locale['mon_decimal_point'],
                 $flags['nogroup'] ? '' : $locale['mon_thousands_sep']);
        $value = @explode($locale['mon_decimal_point'], $value);
 
        $n = strlen($prefix) + strlen($currency) + strlen($value[0]);
        if ($left > 0 && $left > $n) {
            $value[0] = str_repeat($flags['fillchar'], $left - $n) . $value[0];
        }
        $value = implode($locale['mon_decimal_point'], $value);
        if ($locale["{$letter}_cs_precedes"]) {
            $value = $prefix . $currency . $space . $value . $suffix;
        } else {
            $value = $prefix . $value . $space . $currency . $suffix;
        }
        if ($width > 0) {
            $value = str_pad($value, $width, $flags['fillchar'], $flags['isleft'] ?
                     STR_PAD_RIGHT : STR_PAD_LEFT);
        }
 
        $format = str_replace($fmatch[0], $value, $format);
    }
    return $format;
}

setlocale(LC_MONETARY, 'fr_FR');

// Cle du document
$cle = $_REQUEST['cle'];

// Valeur de l'entête
$query = "SELECT * from facture_client where cle = '$cle'";
$result = mysql_query( $query );

// En-tête
while( $row = mysql_fetch_object( $result ) )
{
	$document_cle = $row->cle;
	$document_num = $row->numero;
	$document_date = substr($row->date_facture,-2)."/".substr($row->date_facture,-5,2)."/".substr($row->date_facture,-10,4);
	$document_reference = $row->clt_reference;
	$document_objet = $row->libelle;
	$document_projet = $row->projet;
	$document_montant_ht = money_format_win('%!n &euro;', $row->montant_ht);
	$document_montant_ttc = money_format_win('%!n &euro;', $row->montant_ttc);
	$document_montant_tva = money_format_win('%!n &euro;', $row->montant_tva);
	$document_compte = $row->societe;
	$document_contact = $row->contact;
	$document_cas = $row->cas;
}

// Coordonnées
$query_compte = "SELECT * from societe where cle = '$document_compte'";
$result_compte = mysql_query( $query_compte );
while( $row = mysql_fetch_object( $result_compte ) )
{
	$compte_nom = $row->nom;
	$compte_adresse = $row->adresse;
	$compte_adresse2 = $row->adressesuite;
	$compte_cp = $row->cp;
	$compte_ville = $row->ville;
	$tva_intra = $row->tva_intra;
}

// Projet
$query_projet = "SELECT comptable from projet where cle = '$document_projet'";
$result_projet = mysql_query( $query_projet );
while( $row_projet = mysql_fetch_object( $result_projet ) )
{
	$projet_comptable = $row_projet->comptable;
}

?>

<!-- DEBUT PREMIERE PAGE -->
<page backtop="90mm" backbottom="10mm" backleft="2m" backright="2mm">

<page_header> 
<style type="text/Css">
<!--
.entete{font:10pt Arial;padding-top:100px 2px;border:0px solid #000;width:100%;height:500px;}
-->
</style>
<!-- DEBUT ENTETE -->
<TABLE class="entete">
<TR>
	<!-- LOGO -->
	<TD style="width: 60%;font-size:10pt; padding-top:30px;">
		<IMG src="logo.jpg" /><br />
	</TD>
    <td>&nbsp;</td>
</tr>
	<!-- COORDONNEES -->
<tr>
    <td>&nbsp;</td>
	<TD style="width: 40%;">
		<TABLE>
			<TR>
				<TD><b><?php echo $compte_nom;?></b></TD>
			</TR>
            <?php
				if ($document_contact != ''){
					echo "
					<TR>
					<TD>$document_contact</TD>
					</TR>
					";
				}
			?>
			<TR>
				<TD><?php echo $compte_adresse;?></TD>
			</TR>
            <?php
				if ($compte_adresse2 != ''){
					echo "
					<TR>
					<TD>$compte_adresse2</TD>
					</TR>
					";
				}
			?>  
			<TR>
				<TD><?php echo $compte_cp;?> <?php echo $compte_ville;?></TD>
			</TR>
		</TABLE>
	</TD>
</TR>
</TABLE>

<div style="width:50%;height:50px;padding-top:30px;font-size:14px;text-align:left;vertical-align:top;color:#000;">
<b>FACTURE N° <?php echo $document_num." / ".$document_projet;?></b>
</div>
<div style="width:50%;color:#000040;text-align:left;">
Pantin, le  <?php echo $document_date;?>
<br /><br />
<b>Réf : </b><?php echo $document_reference;?> <br />
<b>N° TVA intracommunautaire : </b><?php echo $tva_intra;?><br />
</div>

<!-- FIN ENTETE -->

</page_header> 



<!-- DETAILS -->
<table style="width: 100%;" cellspacing="0" cellpadding="0">
<TR style="width: 100%;height:30px;background-color:#FFF;color:#000;font-size:12pt;border:1px solid #000000;">
	<TD style="width: 80%;height:30px;font-size:10pt;text-align:center;font-weight:bold;border-left:1px solid #000000;border-right:0px solid #000000;border-top:2px solid #000000;border-bottom:1px solid #000000;">Désignation</TD>
	<TD style="width: 20%;height:30px;font-size:10pt;text-align:center;font-weight:bold;border:1px solid #000000;border-top:2px solid #000000;">Montant HT</TD>
</TR>

<?php

// Valeur du compte
$query = "SELECT * from facture_client_ligne where facture_client = '$document_cle'";
$result = mysql_query( $query );
while( $row = mysql_fetch_object( $result ) )
{
	echo "<TR style='width: 100%;height:30px;background-color:#FFFFFF;font-size:10pt;'>
		<TD style='height:25px;margin-top:5px;font-size:10pt;;border-left:1px solid #000000;border-right:0px solid #000000; padding-left:5px;'><div style='width:530px;'><b>".nl2br($row->designation)."</b></div></TD>
		<TD style=';height:25px;margin-top:5px;font-size:10pt;text-align:right;border-left:1px solid #000000;border-right:1px solid #000000; padding-right:5px;'>".money_format_win('%!n &euro;', $row->total_montant_ht)."</TD>
	</TR>";
	
}
?>
<TR style="width: 100%;height:30px;background-color:#FFF;color:#000;font-size:12pt;border:1px solid #000000;">
	<TD style="width: 80%;height:30px;font-size:10pt;text-align:right;font-weight:bold;border-top:1px solid #000000;">Montant Total HT&nbsp;</TD>
	<TD style="width: 20%;height:30px;font-size:10pt;text-align:right;font-weight:bold;border-left:1px solid #000000;border-right:1px solid #000000;border-top:1px solid #000000; padding-right:5px;"><?php echo $document_montant_ht; ?></TD>
</TR>
<TR style="width: 100%;height:30px;background-color:#FFF;color:#000;font-size:12pt;border:1px solid #000000;">
	<TD style="width: 80%;height:30px;font-size:10pt;text-align:right;font-weight:bold;">
    <?php
	switch ($document_cas) {
	case "A":
		echo "T.V.A applicable au taux de <b>[19,6%]</b>&nbsp;";
		break;
	case "B":
		echo "Tva non applicable en vertu de l'article 44 de la directive européenne n°2006/112/CE<br>
		Autoliquidation";
		break;
	case "C":
		echo "T.V.A applicable au taux de <b>[19,6%]</b>&nbsp;";
		break;
	case "D":
		echo "Tva non applicable en vertu de l'article 196 de la directive européenne n°2006/112/CE<br>
		Autoliquidation";
		break;
	case "E":
		echo "Tva non applicable en vertu de l'article 196 de la directive européenne n°2006/112/CE<br>
		Autoliquidation";
		break;
	case "F":
		echo "T.V.A applicable au taux de <b>[19,6%]</b>&nbsp;";
		break;
	case "G":
		echo "Autoliquidation&nbsp;";
		break;
	case "H":
		echo "Autoliquidation&nbsp;";
		break;
	default:
		echo "T.V.A applicable au taux de <b>[19,6%]</b>&nbsp;";
		break;
	}
	?>
    </TD>
	<TD style="width: 20%;height:30px;font-size:10pt;text-align:right;font-weight:bold;border-left:1px solid #000000;border-right:1px solid #000000;border-top:1px solid #000000; padding-right:5px;"><?php echo $document_montant_tva; ?></TD>
</TR>
<TR style="width: 100%;height:30px;background-color:#FFF;color:#000;font-size:12pt;border:1px solid #000000;">
	<TD style="width: 80%;height:30px;font-size:10pt;text-align:right;font-weight:bold;">Montant Total TTC&nbsp;</TD>
	<TD style="width: 20%;height:30px;font-size:10pt;text-align:right;font-weight:bold;border:1px solid #000000; padding-right:5px;"><?php echo $document_montant_ttc;?></TD>
</TR>

</table>
<!-- FIN DETAILS -->
<br /><br />
<!-- modalité de règlement -->
<table style="width: 100%; border:2px solid #000;" cellspacing="0" cellpadding="0">
<TR style="width: 100%;height:30px;background-color:#FFF;color:#000">
	<TD style="width: 100%;height:30px;font-size:12px;text-align:center;font-weight:bold;">MODALITÉS DE RÈGLEMENT</TD>
</TR>
</table>
<br /><br />
<?php
	echo "
<table style='width: 100%; border:2px solid #000;' cellspacing='0' cellpadding='0'>
	<TR style='width: 100%;height:30px;background-color:#FFF;color:#000'>
		<TD style='width: 40%;height:30px;font-size:12px;text-align:center;font-weight:bold; border-right:1px solid #000;'>Conditions de règlements</TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:bold; border-right:1px solid #000;'>Prix à l'unité</TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:bold; border-right:1px solid #000;'>Quantité</TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:bold;'>Total</TD>
	</TR>
	<TR style='width: 100%;height:30px;background-color:#FFF;color:red;'>
		<TD style='width: 40%;height:30px;font-size:12px;text-align:center;font-weight:normal; border-right:1px solid #000; border-top:1px solid #000;'><b>À régler à réception de facture</b></TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:normal; border-right:1px solid #000; border-top:1px solid #000;'>".$document_montant_ttc."</TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:normal; border-right:1px solid #000; border-top:1px solid #000;'>100 %</TD>
		<TD style='width: 20%;height:30px;font-size:12px;text-align:center;font-weight:normal; border-top:1px solid #000;'>".$document_montant_ttc."</TD>		
	</TR>";
	
?>
</table>

<!-- BANQUE -->
<?php
if(($compte_nom != 'MSD FRANCE')&&($compte_nom !='Laboratoires MSD-FRANCE')){
	if($projet_comptable=='Benjamin'){
?>
<div style="width:100%;text-align:center; font-weight:bold;">
	Valeur en votre aimable règlement par chèque ou par virement bancaire à reception de la facture : <br/>
	Titulaire du compte : La Fonderie<br/>
	Domiciliation : BNP PARIBAS ETOILE - ENTREP<br/>
	IBAN : FR76 3000 4008 9200 0105 2218 521<br/>
	BIC :   BNPAFRPPPKL<br/><br/>

	<table align="center" style="font-size:10pt;text-align:center;font-weight:bold;border:1px solid #000000;" cellspacing="0" cellpadding="0">
		<tr>
			<td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE BANQUE</td><td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE AGENCE </td><td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">NUMERO DE COMPTE</td><td style="border-bottom:1px solid #000000;padding:5px;">CLE RIB</td>
		</tr>
		<tr>
			<td style="border-right:1px solid #000000;padding:5px;">30004</td><td style="border-right:1px solid #000000;padding:5px;">00892</td><td style="border-right:1px solid #000000;padding:5px;">000105 221 85</td><td style="border:0px solid #000000;padding:5px;">21</td>
		</tr>
	</table>
<br /> <br />
</div>
<?php
	}else{
?>
<div style="width:100%;text-align:center; font-weight:bold;">
	Titulaire du compte : La Fonderie<br/>
    Banque BNP PARIBAS<br />
	Domiciliation : BNP PARIBAS ETOILE - ENTREP<br/>
	IBAN : FR76 3000 4008 0100 0215 2227 531<br/>
	BIC :   BNPAFRPPPKL<br/><br/>

	<table align="center" style="font-size:10pt;text-align:center;font-weight:bold;border:1px solid #000000;" cellspacing="0" cellpadding="0">
		<tr>
			<td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE BANQUE</td>
            <td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE AGENCE </td>
            <td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">NUMERO DE COMPTE</td>
            <td style="border-bottom:1px solid #000000;padding:5px;">CLE RIB</td>
		</tr>
		<tr>
			<td style="border-right:1px solid #000000;padding:5px;">30004</td>
            <td style="border-right:1px solid #000000;padding:5px;">00801</td>
            <td style="border-right:1px solid #000000;padding:5px;">000 215 222 75</td>
            <td style="border:0px solid #000000;padding:5px;">31</td>
		</tr>
	</table>
<br /> <br />
</div>
<?php
	}
}else{
?>
<!-- RIB MSD -->
<div style="width:100%;text-align:center; font-weight:bold;">
	Valeur en votre aimable règlement par chèque ou par virement bancaire à reception de la facture : <br/>
	Titulaire du compte : La Fonderie<br/>
	Domiciliation : BNP PARIBAS ETOILE - ENTREP<br/>
	IBAN : FR76 3000 4008 9200 0105 2257 321<br/>
	BIC :   BNPAFRPPPKL<br/><br/>

	<table align="center" style="font-size:10pt;text-align:center;font-weight:bold;border:1px solid #000000;" cellspacing="0" cellpadding="0">
		<tr>
			<td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE BANQUE</td><td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">CODE AGENCE </td><td style="border-right:1px solid #000000;border-bottom:1px solid #000000;padding:5px;">NUMERO DE COMPTE</td><td style="border-bottom:1px solid #000000;padding:5px;">CLE RIB</td>
		</tr>
		<tr>
			<td style="border-right:1px solid #000000;padding:5px;">30004</td><td style="border-right:1px solid #000000;padding:5px;">00892</td><td style="border-right:1px solid #000000;padding:5px;">000105 225 73</td><td style="border:0px solid #000000;padding:5px;">21</td>
		</tr>
	</table>
<br /> <br />
</div>
<div style="width:100%;text-align:center; font-weight:bold;">
"Escompte pour paiement anticipé : Néant"<br />
Le defaut de paiement à l'échéance donnera lieu à l'application d'une pénalité de retard calculée sur l'integarlié du prix au taux defini à 1,5% par mois. Indemnité forfaitaire de 40 € pour frais de recouvrement.
<br />
</div>
<?php
}
?>
<!-- FIN BANQUE -->

</page>

<!-- DEBUT FOOTER -->
<page_footer> 

<div style="width:100%;text-align:center;font-size:8pt;">
<hr color="#000" size="1"/>
<!--La Fonderie Com'Santé <br />
61, rue Jules Auffret . 93500 PANTIN . Tél. : 01 49 42 45 40 . www.la-fonderie.fr <br />
SAS au capital de 10 000 euros – RCS Bobigny 495 120 628 – SIRET 49512062800021 APE 7021Z <br />
TVA intracommunautaire : FR 23495120628-->
La Fonderie - 61, rue Jules Auffret - 93500 Pantin - France - +33 (0)1 49 42 70 70<br />
Société par actions simplifiée au capital de 1 000 000 € - RCS Bobigny 495120628 - TVA FR23495120628<br />
Immatriculation au Registre des opérateurs de voyage et de séjour IM 093110025 - Agrément IATA<br />
www.la-fonderie.fr<br />
www.facebook.com/lafonderiefb<br />
www.twitter.com/lafonderietwitt
<br /><br />
page [[page_cu]]/[[page_nb]]
</div>

</page_footer> 
<!-- FIN FOOTER -->

<!-- FIN PREMIERE PAGE -->