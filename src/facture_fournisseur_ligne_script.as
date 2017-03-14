import flash.utils.Timer;
import mx.controls.Text;
import mx.controls.Button;
import mx.rpc.events.ResultEvent;

// Bouton dupliquer
private var convertButton:Button = new Button();

private function initButton():void {
	// Création du bouton dupliquer
	convertButton.x = 10;
	convertButton.y = 250;
	convertButton.id="btn_facture_fournisseur_ligne_convert";
	convertButton.label = "Convertisseur €";
	convertButton.addEventListener(MouseEvent.CLICK,btn_convert)
	tab_facture_fournisseur_ligne_principal.addChild(convertButton);
	
}

private function btn_convert(e:Event):void{
	// Redirection vers une URL
	navigateToURL( new URLRequest( 'http://www.oanda.com/lang/fr/currency/converter/'), "_blank" );
}

private function onLoad_facture_fournisseur_ligne():void {
	devise();
	reglement();
	// USER 
	if(Application.application.gsProfil =='user')
	{
		text_acompte_paye.enabled = false;
		date_date_paye.enabled = false;
		fichier_text_pj_paye.enabled = false;
		btn_parcourir_pj_paye.enabled = false;
		text_num_cheque.enabled = false;
		combo_statut.enabled = false;
		//combo_statut_compta.enabled = false;
		if (fichier_text_pj_reglement.text == ''){
			fichier_text_pj_reglement.enabled = true;
			btn_parcourir_pj_reglement.enabled = true;
		}else{
			fichier_text_pj_reglement.enabled = false;
			btn_parcourir_pj_reglement.enabled = false;
		}
	}
	// si user et modification pas d'accès à la partie demande de règlement
	if((Application.application.gsProfil =='user')&&(text_cle.text!='')){
		text_acompte_reglement_ht.enabled = false;
		text_acompte_reglement.enabled = false;
		date_date_reglement.enabled = false;
		combo_type_reglement.enabled = false;
	}

}

private function onCreate_facture_fournisseur_ligne():void {}
private function onUpdate_facture_fournisseur_ligne():void {}
private function beforeCreate_facture_fournisseur_ligne():void {
	cle_facture_fournisseur_ligne();
} 	
private function event_facture_fournisseur_ligne(e:Event):void {}
private function onPrint_facture_fournisseur_ligne():void {
    // Lancer une URL pour l'impression
	navigateToURL( new URLRequest( 'modele/word_facture_fournisseur_ligne.php?id='+text_idfacture_fournisseur_ligne.text+'&file=lettre_cheque.xml'), "_blank" );
}
private function imprimer2():void {
      // Lancer une URL pour l'impression
	navigateToURL( new URLRequest( 'modele/word_facture_fournisseur_ligne.php?id='+text_idfacture_fournisseur_ligne.text+'&file=lettre_cheque_hsbc.xml'), "_blank" );
}
private function beforeUpdate_facture_fournisseur_ligne():void {}
public function cle_facture_fournisseur_ligne():void {
	// si la clé est vide
	var temps:Date = new Date();
	if (text_cle.text==''){
		text_cle.text = connexion_facture_fournisseur.text+"/"+temps.getTime();
	}
}
public function devise():void {
	// dégrise le champs si différent de EUR ou USD
	if ((combo_devise.text=='EUR')||(combo_devise.text=='USD'))
	{
		text_autre_devise.enabled = false;
	}
	else if(combo_devise.text=='Autres')
	{
		text_autre_devise.enabled = true;
	}
}
public function reglement():void {
	// si règlement par chèque
	if (combo_autres.text=='CHEQUE')
	{
		text_nom_banque.enabled = false;
		text_domiciliation.enabled = false;
		text_code_banque.enabled = false;
		text_code_guichet.enabled = false;
		text_num_compte.enabled = false;
		text_cle_banque.enabled = false;
		text_iban.enabled = false;
		text_code_swift.enabled = false;
	}
	// si règlement par virement
	else if (combo_autres.text=='VIREMENT')
	{
		text_nom_banque.enabled = true;
		text_domiciliation.enabled = true;
		text_code_banque.enabled = true;
		text_code_guichet.enabled = true;
		text_num_compte.enabled = true;
		text_cle_banque.enabled = true;
		text_iban.enabled = true;
		text_code_swift.enabled = true;
	}
	// si règlement ni par chèque ni par virement
	else
	{
		text_nom_banque.enabled = false;
		text_domiciliation.enabled = false;
		text_code_banque.enabled = false;
		text_code_guichet.enabled = false;
		text_num_compte.enabled = false;
		text_cle_banque.enabled = false;
		text_iban.enabled = false;
		text_code_swift.enabled = false;
	}
}
public function justificatif():void{
	if((Number(text_acompte_paye.text)!=0)&&(Number(text_acompte_reglement.text)!=0)){
		if (Number(text_acompte_paye.text)-Number(text_acompte_reglement.text)==0){
			combo_statut.text = 'Réglée';
		}else{
			combo_statut.text = 'A régler';
		}
	}
}
private function rest_connexion_facture_fournisseur_result():void{}