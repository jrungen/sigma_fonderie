// ActionScript file
import flash.events.Event;

import mx.core.Application;
private var attestationButton:Button = new Button();
private var relance1Button:Button = new Button();
private var relance2Button:Button = new Button();
private var renouvellementButton:Button = new Button();

private function onLoad_fournisseur():void {

	if(Application.application.gsProfil=="user"){
		text_compte_tiers.enabled=false;
	}

	if(Application.application.gsProfil=="admin"){
	  // Création des boutons attestation
	  attestationButton.x = 160;
	  attestationButton.y = 25;
	  attestationButton.id="btn_attestation";
	  attestationButton.label = "Demande attestation";
	  attestationButton.addEventListener(MouseEvent.CLICK,btn_attestation)
	  tab_fournisseur_action.addChild(attestationButton);
	
	  renouvellementButton.x = 160;
	  renouvellementButton.y = 50;
	  renouvellementButton.id="btn_renouvellement";
	  renouvellementButton.label = "Demande attestation renouvellement";
	  renouvellementButton.addEventListener(MouseEvent.CLICK,btn_renouvellement)
	  tab_fournisseur_action.addChild(renouvellementButton);
	
	  relance1Button.x = 420;
	  relance1Button.y = 25;
	  relance1Button.id="btn_relance1";
	  relance1Button.label = "Demande attestation 1ère relance";
	  relance1Button.addEventListener(MouseEvent.CLICK,btn_relance1)
	  tab_fournisseur_action.addChild(relance1Button);
	
	  relance2Button.x = 420;
	  relance2Button.y = 50;
	  relance2Button.id="btn_relance2";
	  relance2Button.label = "Demande attestation 2ème relance";
	  relance2Button.addEventListener(MouseEvent.CLICK,btn_relance2)
	  tab_fournisseur_action.addChild(relance2Button);
	}
}

private function btn_attestation(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = text_cle.text;
	vactionItem.connexion_fournisseur_complement.text = text_cle.text;
	vactionItem.connexion_type_complement.text = "Demande attestation";
	vactionItem.connexion_type.text = "Demande attestation";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
	vactionItem.text_nom.text = "Demande attestation";
}

private function btn_relance1(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = text_cle.text;
	vactionItem.connexion_fournisseur_complement.text = text_cle.text;
	vactionItem.connexion_type_complement.text = "Demande attestation 1ère relance";
	vactionItem.connexion_type.text = "Demande attestation 1ère relance";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
	vactionItem.text_nom.text = "Demande attestation 1ère relance";
}

private function btn_relance2(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = text_cle.text;
	vactionItem.connexion_fournisseur_complement.text = text_cle.text;
	vactionItem.connexion_type_complement.text = "Demande attestation 2ème relance";
	vactionItem.connexion_type.text = "Demande attestation 2ème relance";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
	vactionItem.text_nom.text = "Demande attestation 2ème relance";
}

private function btn_renouvellement(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = text_cle.text;
	vactionItem.connexion_fournisseur_complement.text = text_cle.text;
	vactionItem.connexion_type_complement.text = "Demande attestation renouvellement";
	vactionItem.connexion_type.text = "Demande attestation renouvellement";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
	vactionItem.text_nom.text = "Demande attestation renouvellement";
}

private function onCreate_fournisseur():void {
} 	

private function onUpdate_fournisseur():void {
} 	 			

private function beforeCreate_fournisseur():void {
	cle_fournisseur();
}	

private function beforeUpdate_fournisseur():void {
}

private function event_fournisseur(e:Event):void {
	
}

private function onPrint_fournisseur():void {
	
} 		

private function cle_fournisseur():void {
	// si la clé est vide
	if (mode=="1"){
		text_cle.text = text_nom.text+"/"+text_ville.text;
	}
}

private function initButton():void {}
private function rest_connexion_pays_result():void{}