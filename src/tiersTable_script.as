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
	resttiersList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=tiers";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_tiers.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchtiers();
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


	onLoad_tiers();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_tiers();	
}

private function searchtiers():void {
	resttiersList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idtiers:String):void {
	beforeCreate_tiers();	
	resttiersUpdate.url = "tiersUpdate.php?id="+idtiers;
	resttiersUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridtiers.dataProvider.refresh();
	resttiersList.send();
}	

private function newItem():void{			
	var vtiersItem:tiersItem = tiersItem(PopUpManager.createPopUp(this,tiersItem,true));
	vtiersItem.mode = '1';
}   

private function openItem():void{			
	var vtiersItem:tiersItem = tiersItem(PopUpManager.createPopUp(this,tiersItem,true));
	vtiersItem.text_idtiers.text = datagrid_tiers.selectedItem.idtiers;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_tiers():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=tiers&group="+Application.application.gsGroup+"&id="+text_idtiers.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_tiers_result);
	}
}

private function delete_tiers_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=tiers&id="+datagrid_tiers.selectedItem.idtiers;
		restDelete.send();
		searchtiers();
	}else{  

	}	
}

private function export_tiers():void {
	resttiersList_export.send();	
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
	//	updateItem(text_idtiers.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_tiers();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_tiers();
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



private function OpenConnexionpays():void{
var vConnexion:paysConnexion = paysConnexion(PopUpManager.createPopUp(this,paysConnexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.targetComplement = connexion_pays_complement;
vConnexion.categorie = "pays";
vConnexion.categorie_source = "tiers";
vConnexion.connexion_source = "pays";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionpaysItem():void{
var vpaysItem:paysItem = paysItem(PopUpManager.createPopUp(this,paysItem,true));
vpaysItem.text_cle.text =connexion_pays.text;
}





public function style_datagrid_tiers(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_tiers.height=150;
	advancedFilter_tiers.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_tiers.height=0;
	advancedFilter_tiers.visible = false;
}

