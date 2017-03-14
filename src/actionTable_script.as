// ActionScript file

import mx.validators.EmailValidator;
import mx.containers.ViewStack;
import mx.controls.Alert;
import mx.events.CloseEvent; 
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.core.Application;
import mx.formatters.DateFormatter;
import mx.formatters.NumberFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import flash.net.navigateToURL;
import flash.system.System;


import mx.collections.Grouping;
import mx.collections.GroupingCollection;
import mx.collections.GroupingField;
import mx.collections.SummaryField;
import mx.collections.SummaryRow;

System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

private function load():void {
	restactionList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=action";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_action.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchaction();
	}
}

private function onLoad(e:ResultEvent):void {
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
	var sDate:String = dateFormat.format(new Date());
	var sYear:String = sDate.substr(6,10);

	var numberFormat:NumberFormatter = new NumberFormatter();
	numberFormat.decimalSeparatorFrom = ".";
	numberFormat.decimalSeparatorTo = ".";
	numberFormat.precision="-1";
	numberFormat.thousandsSeparatorFrom=" ";
	numberFormat.thousandsSeparatorTo=" ";
	numberFormat.useNegativeSign="true";
	numberFormat.useThousandsSeparator="true";
	
	date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);
date_date_fin.text = dateFormat.format(date_date_fin.text);
date_date_debut.text = dateFormat.format(date_date_debut.text);
text_duree.text = numberFormat.format(text_duree.text);


	onLoad_action();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_action();	
}

private function searchaction():void {
	restactionList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idaction:String):void {
	beforeCreate_action();	
	restactionUpdate.url = "actionUpdate.php?id="+idaction;
	restactionUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridaction.dataProvider.refresh();
	restactionList.send();
}	

private function newItem():void{			
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.mode = '1';
}   

private function openItem():void{			
	var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
	vactionItem.text_idaction.text = datagrid_action.selectedItem.idaction;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_action():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=action&group="+Application.application.gsGroup+"&id="+text_idaction.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_action_result);
	}
}

private function delete_action_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=action&id="+datagrid_action.selectedItem.idaction;
		restDelete.send();
		searchaction();
	}else{  

	}	
}

private function export_action():void {
	restactionList_export.send();	
}

//Gestion du menu prinipale 

//les menus
public function menu(event:MouseEvent):void {
	//Menu Nouveau
	if(myMenuBar.selectedIndex == 0){
		newItem();
	}

	//Menu Enregistrer
	//else if(myMenuBar.selectedIndex == 1){
	//	updateItem(text_idaction.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_action();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_action();
	}	
	
	//Menu Filtre avancé
	else if(myMenuBar.selectedIndex == 3){
		advancedFilter();
	}	
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_fichier_joint():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_fichier_joint);
fileReferenceList.browse();
}
private function fileSelectedHandler_fichier_joint(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_fichier_joint);
fileReference.upload(urlRequest);
fichier_text_fichier_joint.text = "Uploading...";
}
private function uploadCompleteHandler_fichier_joint(event:Event):void {
fichier_text_fichier_joint.text = event.target.name;
}
public function openNewWindow_fichier_joint(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/action/"+fichier_text_fichier_joint.text);
navigateToURL(u,"_blank");
}


private function OpenConnexiontype():void{
var vConnexion:action_typeConnexion = action_typeConnexion(PopUpManager.createPopUp(this,action_typeConnexion,true));
vConnexion.targetComponent = connexion_type;
vConnexion.targetComplement = connexion_type_complement;
vConnexion.categorie = "action_type";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "type";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexiontypeItem():void{
var vaction_typeItem:action_typeItem = action_typeItem(PopUpManager.createPopUp(this,action_typeItem,true));
vaction_typeItem.text_cle.text =connexion_type.text;
}

private function OpenConnexionsociete():void{
var vConnexion:societeConnexion = societeConnexion(PopUpManager.createPopUp(this,societeConnexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.targetComplement = connexion_societe_complement;
vConnexion.categorie = "societe";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "societe";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionsocieteItem():void{
var vsocieteItem:societeItem = societeItem(PopUpManager.createPopUp(this,societeItem,true));
vsocieteItem.text_cle.text =connexion_societe.text;
}

private function OpenConnexionprojet():void{
var vConnexion:projetConnexion = projetConnexion(PopUpManager.createPopUp(this,projetConnexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.targetComplement = connexion_projet_complement;
vConnexion.categorie = "projet";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "projet";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionprojetItem():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text =connexion_projet.text;
}

private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,true));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}

private function OpenConnexionutilisateur():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.targetComplement = connexion_utilisateur_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "utilisateur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateurItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur.text;
}

private function OpenConnexionutilisateur_cc():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur_cc;
vConnexion.targetComplement = connexion_utilisateur_cc_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "utilisateur_cc";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateur_ccItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur_cc.text;
}





public function style_datagrid_action(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_action.height=150;
	advancedFilter_action.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_action.height=0;
	advancedFilter_action.visible = false;
}

