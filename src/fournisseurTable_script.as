// ActionScript file

import flash.system.System;

import mx.controls.Alert;
import mx.core.Application;
import mx.events.CloseEvent;
import mx.events.ListEvent;
import mx.formatters.DateFormatter;
import mx.formatters.NumberFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.ResultEvent;

System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

private function load():void {
	restfournisseurList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=fournisseur";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_fournisseur.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchfournisseur();
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


	onLoad_fournisseur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_fournisseur();	
}

private function searchfournisseur():void {
	restfournisseurList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idfournisseur:String):void {
	beforeCreate_fournisseur();	
	restfournisseurUpdate.url = "fournisseurUpdate.php?id="+idfournisseur;
	restfournisseurUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfournisseur.dataProvider.refresh();
	restfournisseurList.send();
}	

private function newItem():void{			
	var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
	vfournisseurItem.mode = '1';
}   

private function openItem():void{			
	var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
	vfournisseurItem.text_idfournisseur.text = datagrid_fournisseur.selectedItem.idfournisseur;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_fournisseur():void {
	// Vérif permission
	//restPermission.url = "script/permission.php?permission=delete&table=fournisseur&group="+Application.application.gsGroup+"&id="+text_idfournisseur.text;
	//restPermission.send();
	//Alert.show(gsProfil);
	if(Application.application.gsProfil !='user'){
		restDelete.url = "delete.php?categorie=fournisseur&id="+datagrid_fournisseur.selectedItem.idfournisseur;
		restDelete.send();
		searchfournisseur();
	}else{
		Alert.show('Vous n\'avez pas les droits pour supprimer la fiche');
	}
}

private function export_fournisseur():void {
	//restfournisseurList_export.send();
	navigateToURL( new URLRequest( 'fournisseurList_export.php?search='+textSearch.text+'&field='+combo_recherche.text), "_blank" );
}
private function attestation_fournisseur():void {
	//restfournisseurList_export.send();
	navigateToURL( new URLRequest( 'csv/attestation_fournisseur.php'), "_blank" );
}

//Gestion du menu prinipale 

//les menus
public function menu(event:MouseEvent):void {
	//Menu Nouveau
	if(myMenuBar.selectedIndex == 0){
		newItem();
	}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_fournisseur();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_fournisseur();
	}	
	
	//Menu Attestation Fournisseur
	else if(myMenuBar.selectedIndex == 3){
		attestation_fournisseur();
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
vConnexion.categorie_source = "fournisseur";
vConnexion.connexion_source = "pays";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionpaysItem():void{
var vpaysItem:paysItem = paysItem(PopUpManager.createPopUp(this,paysItem,true));
vpaysItem.text_cle.text =connexion_pays.text;
}

public function style_datagrid_fournisseur(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_fournisseur.height=150;
	advancedFilter_fournisseur.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_fournisseur.height=0;
	advancedFilter_fournisseur.visible = false;
}

