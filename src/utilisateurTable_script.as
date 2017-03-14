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
	restutilisateurList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=utilisateur";
	restVue.send();
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


	onLoad_utilisateur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_utilisateur();	
}

private function searchutilisateur():void {
	restutilisateurList.send();	
}

private function send_selection(e:ListEvent):void {
	restutilisateurRead.url = "utilisateurRead.php?idutilisateur="+encodeURIComponent(e.currentTarget.selectedItem.idutilisateur);
restutilisateurRead.send();

	
} 			

private function updateItem(idutilisateur:String):void {
	beforeCreate_utilisateur();	
	restutilisateurUpdate.url = "utilisateurUpdate.php?id="+idutilisateur;
	restutilisateurUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridutilisateur.dataProvider.refresh();
	restutilisateurList.send();
}	

private function newItem():void{			
	var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
	vutilisateurItem.mode = '1';
}   

private function openItem():void{			
	var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
	vutilisateurItem.text_idutilisateur.text = datagrid_utilisateur.selectedItem.idutilisateur;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_utilisateur():void {
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message', 3, this, delete_utilisateur_result);
}

private function delete_utilisateur_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=utilisateur&id="+datagrid_utilisateur.selectedItem.idutilisateur;
		restDelete.send();
		searchutilisateur();
	}else{  

	}	
}

private function export_utilisateur():void {
	restutilisateurList_export.send();	
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
	//	updateItem(text_idutilisateur.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_utilisateur();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_utilisateur();
	}	
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}







public function style_datagrid_utilisateur(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}



