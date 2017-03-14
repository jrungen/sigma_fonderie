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
	restpaysList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=pays";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_pays.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchpays();
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


	onLoad_pays();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_pays();	
}

private function searchpays():void {
	restpaysList.send();	
}

private function send_selection(e:ListEvent):void {
	restpaysRead.url = "paysRead.php?idpays="+encodeURIComponent(e.currentTarget.selectedItem.idpays);
restpaysRead.send();

	
} 			

private function updateItem(idpays:String):void {
	beforeCreate_pays();	
	restpaysUpdate.url = "paysUpdate.php?id="+idpays;
	restpaysUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridpays.dataProvider.refresh();
	restpaysList.send();
}	

private function newItem():void{			
	var vpaysItem:paysItem = paysItem(PopUpManager.createPopUp(this,paysItem,true));
	vpaysItem.mode = '1';
}   

private function openItem():void{			
	var vpaysItem:paysItem = paysItem(PopUpManager.createPopUp(this,paysItem,true));
	vpaysItem.text_idpays.text = datagrid_pays.selectedItem.idpays;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_pays():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=pays&group="+Application.application.gsGroup+"&id="+text_idpays.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_pays_result);
	}
}

private function delete_pays_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=pays&id="+datagrid_pays.selectedItem.idpays;
		restDelete.send();
		searchpays();
	}else{  

	}	
}

private function export_pays():void {
	restpaysList_export.send();	
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
	//	updateItem(text_idpays.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_pays();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_pays();
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







public function style_datagrid_pays(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_pays.height=150;
	advancedFilter_pays.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_pays.height=0;
	advancedFilter_pays.visible = false;
}

