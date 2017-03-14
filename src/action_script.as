// ActionScript file
import flash.events.Event;
/* JR le 03/12/2013 > ces bouton ne sont plus utiles
private var attestation1Button:Button = new Button();
private var attestation2Button:Button = new Button();
*/

private function onLoad_action():void {
/* JR le 03/12/2013 > ces bouton ne sont plus utiles
	if(Application.application.gsProfil=="admin"){
	// Création du bouton 1ère relance attestation
      attestation1Button.x = 450;
      attestation1Button.y = 255;
      attestation1Button.id="btn_attestation1";
      attestation1Button.label = "Demande attestation 1ère relance";
      attestation1Button.addEventListener(MouseEvent.CLICK,btn_attestation1)
      tab_action_principal.addChild(attestation1Button);
      
	// Création du bouton 2ème relance attestation
      attestation2Button.x = 450;
      attestation2Button.y = 280;
      attestation2Button.id="btn_attestation2";
      attestation2Button.label = "Demande attestation 2ème relance";
      attestation2Button.addEventListener(MouseEvent.CLICK,btn_attestation2)
      tab_action_principal.addChild(attestation2Button);
	}
*/
}
/* JR le 03/12/2013 > ces bouton ne sont plus utiles
private function btn_attestation1(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = connexion_fournisseur.text;
	vactionItem.connexion_fournisseur_complement.text = connexion_fournisseur_complement.text;
	vactionItem.connexion_type_complement.text = "Demande attestation 1ère relance";
	vactionItem.connexion_type.text = "Demande attestation 1ère relance";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
}
private function btn_attestation2(e:Event):void{
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode= '1';
	vactionItem.text_idaction.text = '';
	vactionItem.connexion_fournisseur.text = connexion_fournisseur.text;
	vactionItem.connexion_fournisseur_complement.text = connexion_fournisseur_complement.text;
	vactionItem.connexion_type_complement.text = "Demande attestation 2ème relance";
	vactionItem.connexion_type.text = "Demande attestation 2ème relance";
	vactionItem.connexion_utilisateur.text = Application.application.gsUser;
	vactionItem.connexion_utilisateur_complement.text = Application.application.gsUser;
	vactionItem.combo_statut.data = "A faire";
}
*/
private function onCreate_action():void {
} 	

private function onUpdate_action():void {
} 	 			

private function beforeCreate_action():void {
	cle_action();
}	
private function beforeUpdate_action():void {

}

private function event_action(e:Event):void {
	
}

private function onPrint_action():void {
      // Ouvrir la fenêtre de modèle de lettre
      var vImprimer:_imprimer = _imprimer(PopUpManager.createPopUp(this,_imprimer,true));
      vImprimer.itemId = text_idaction.text;
      vImprimer.sCategorie = "action";

} 		

private function cle_action():void {
	// si la clé est vide
	if (mode=="1"){
		var temps:Date = new Date();
		text_cle.text = text_nom.text+'-'+temps.getDate()+temps.getTime();
	}
}

private function initButton():void{}
private function rest_connexion_type_result():void{}
private function rest_connexion_societe_result():void{}
private function rest_connexion_fournisseur_result():void{}
private function rest_connexion_utilisateur_result():void{}
private function rest_connexion_projet_result():void{}
private function rest_connexion_utilisateur_cc_result():void{}