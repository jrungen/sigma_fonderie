// ActionScript file
import flash.events.Event;
import mx.controls.Alert;

private function onLoad_fournisseur_attestation():void {
}

private function onCreate_fournisseur_attestation():void {
} 	

private function onUpdate_fournisseur_attestation():void {
} 	 			

private function beforeCreate_fournisseur_attestation():void {
	cle_fournisseur_attestation();
}	
private function beforeUpdate_fournisseur_attestation():void {

}

private function event_fournisseur_attestation(e:Event):void {
	
}

private function onPrint_fournisseur_attestation():void {
} 		

private function cle_fournisseur_attestation():void {
	// si la clé est vide
	if (mode=="1"){
		var txt:Number = Math.random();
		text_cle.text = date_date_attestation.text+"-"+txt.toString().substr(10,5);
	}
}
private function cree_renouvellement():void {
	
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = connexion_fournisseur.text;
	vactionItem.connexion_fournisseur_complement.text = connexion_fournisseur_complement.text;
	vactionItem.connexion_type_complement.text = "Demande attestation renouvellement";
	vactionItem.connexion_type.text = "Demande attestation renouvellement";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
	vactionItem.text_nom.text = "Demande attestation renouvellement";
	vactionItem.date_date_debut.text = ''
}
private function rest_connexion_fournisseur_result():void {}
private function initButton():void {}
private function send_selection_script():void {}