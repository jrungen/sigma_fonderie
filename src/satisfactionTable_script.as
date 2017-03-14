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
	restsatisfactionList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=satisfaction";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_satisfaction.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchsatisfaction();
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
text_ca_ht.text = numberFormat.format(text_ca_ht.text);
date_date_preparation.text = dateFormat.format(date_date_preparation.text);
date_date_realisation.text = dateFormat.format(date_date_realisation.text);


	onLoad_satisfaction();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_satisfaction();	
}

private function searchsatisfaction():void {
	restsatisfactionList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idsatisfaction:String):void {
	beforeCreate_satisfaction();	
	restsatisfactionUpdate.url = "satisfactionUpdate.php?id="+idsatisfaction;
	restsatisfactionUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridsatisfaction.dataProvider.refresh();
	restsatisfactionList.send();
}	

private function newItem():void{			
	var vsatisfactionItem:satisfactionItem = satisfactionItem(PopUpManager.createPopUp(this,satisfactionItem,true));
	vsatisfactionItem.mode = '1';
}   

private function openItem():void{			
	var vsatisfactionItem:satisfactionItem = satisfactionItem(PopUpManager.createPopUp(this,satisfactionItem,true));
	vsatisfactionItem.text_idsatisfaction.text = datagrid_satisfaction.selectedItem.idsatisfaction;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_satisfaction():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=satisfaction&group="+Application.application.gsGroup+"&id="+text_idsatisfaction.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_satisfaction_result);
	}
}

private function delete_satisfaction_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=satisfaction&id="+datagrid_satisfaction.selectedItem.idsatisfaction;
		restDelete.send();
		searchsatisfaction();
	}else{  

	}	
}

private function export_satisfaction():void {
	//restsatisfactionList_export.send();	
	navigateToURL( new URLRequest( 'satisfactionList_export.php?search='+textSearch.text+'&field='+combo_recherche.text), "_blank" );
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
	//	updateItem(text_idsatisfaction.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_satisfaction();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_satisfaction();
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



private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,true));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}

private function OpenConnexionprojet():void{
var vConnexion:projetConnexion = projetConnexion(PopUpManager.createPopUp(this,projetConnexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.targetComplement = connexion_projet_complement;
vConnexion.categorie = "projet";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "projet";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionprojetItem():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text =connexion_projet.text;
}

private function OpenConnexionutilisateur():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.targetComplement = connexion_utilisateur_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "utilisateur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateurItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur.text;
}

private function OpenConnexioneval_preparation():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_eval_preparation;
vConnexion.targetComplement = connexion_eval_preparation_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "eval_preparation";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexioneval_preparationItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_eval_preparation.text;
}

private function OpenConnexioneval_realisation():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_eval_realisation;
vConnexion.targetComplement = connexion_eval_realisation_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "eval_realisation";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexioneval_realisationItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_eval_realisation.text;
}





public function style_datagrid_satisfaction(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_satisfaction.height=150;
	advancedFilter_satisfaction.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_satisfaction.height=0;
	advancedFilter_satisfaction.visible = false;
}

