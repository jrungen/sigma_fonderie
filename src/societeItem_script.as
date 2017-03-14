import mx.core.ContainerGlobals;
import mx.core.Application;
import mx.events.CollectionEvent;
import mx.controls.Alert;		  
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;
import mx.collections.ArrayCollection;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.events.CloseEvent; 
/* Validator */
import mx.validators.Validator;
import mx.utils.StringUtil;
import mx.events.ValidationResultEvent;
import mx.formatters.DateFormatter;

import flash.net.navigateToURL;
import flash.system.System;
System.useCodePage = true;

public var mode:String = '0';
public var refresh:String;
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";

private function createListenersociete(e:Event):void {
	event_societe(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restsocieteRead.url = "societeRead.php?cle="+text_cle.text;
			restsocieteRead.send();
			send_selection();
	if(Application.application.gsProfil=="user"){
		text_compte_tiers.enabled=false;
	}
}

private function onLoad(e:ResultEvent):void {
	// Si création de fiche
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
	var sDate:String = dateFormat.format(new Date());
	var sYear:String = sDate.substr(6,10);
	
	if(mode=='1'){
		date_date_creation.text = sDate;
		text_creation_par.text = Application.application.gsUser;
		combo_annee.text = sYear;
	}else{
		text_modification_par.text = Application.application.gsUser;
		date_date_modification.selectedDate = new Date();
	}
	onLoad_societe();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_societe();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_societe();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idsociete:String):void {
	beforeUpdate_societe();	
	restsocieteUpdate.url = "societeUpdate.php?id="+text_idsociete.text;
	restsocieteUpdate.send();
	//outerDocument.datagridsociete.dataProvider.refresh();
	//restsocieteList.send();
}	

private function createItem():void {
	beforeCreate_societe();	
	restsocieteCreate.url = "societeCreate.php";
	restsocieteCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_societe():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (text_idsociete.text==''){
		var validators:Array = Validator.validateAll([valid_nom, valid_ville, valid_pays]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idsociete.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (text_idsociete.text==''){
	var validators:Array = Validator.validateAll([valid_nom, valid_ville, valid_pays]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idsociete.text);
		Alert.show("Fiche modifiée");
	}
}

// Btn_fermer
private function fermer():void {
	Alert.show('Voulez-vous enregistrer cette fiche ?', 'Message de confirmation', 3, this, close_result);
}

private function close_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		enregistrer();
	}else{  
		close();
	}	
}

// Brn Imprimer
private function imprimer():void {
	onPrint_societe();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idsociete.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idsociete.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idsociete.text==''){
			createItem();
		}else{
			updateItem(text_idsociete.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
	restSocieteProjet.url = "SocieteProjet_Vue.php?cle="+text_cle.text;
	restSocieteProjet.send();
	restSocieteContact.url = "SocieteContact_Vue.php?cle="+text_cle.text;
	restSocieteContact.send();
	restSocieteAction.url = "SocieteAction_Vue.php?cle="+text_cle.text;
	restSocieteAction.send();
	restSocieteFacture.url = "SocieteFacture_Vue.php?cle="+text_cle.text+"&search="+text_search_SocieteFacture.text;
	restSocieteFacture.send();
} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function AddSocieteProjet():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_idprojet.text = '';
vprojetItem.connexion_societe.text = text_cle.text ;
refresh = 'REFRESH';
}

private function Delete_SocieteProjet(id:String):void{
restDelete.url = "delete.php?categorie=projet&id="+id;
restDelete.send();
send_selection();
}

private function UpdateSocieteProjet():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text = datagrid_SocieteProjet.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_SocieteProjet(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddSocieteContact():void{
var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
vcontactItem.text_idcontact.text = '';
vcontactItem.connexion_societe.text = text_cle.text ;

refresh = 'REFRESH';
}

private function Delete_SocieteContact(id:String):void{
restDelete.url = "delete.php?categorie=contact&id="+id;
restDelete.send();
send_selection();
}

private function UpdateSocieteContact():void{
var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
vcontactItem.text_cle.text = datagrid_SocieteContact.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_SocieteContact(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

//ajouté par Jonathan
private function AddSocieteAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.mode= '1';
vactionItem.text_idaction.text = '';
vactionItem.connexion_societe.text = text_cle.text;
vactionItem.connexion_societe_complement.text = text_cle.text;
refresh = 'REFRESH';
}

private function Delete_SocieteAction(id:String):void{
restDelete.url = "delete.php?categorie=action&id="+id;
restDelete.send();
send_selection();
}

private function UpdateSocieteAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.text_cle.text = datagrid_SocieteAction.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_SocieteAction(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

//ajouté par Jonathan
private function AddSocieteFacture():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.mode= '1';
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_societe.text = text_cle.text;
refresh = 'REFRESH';
}

private function Delete_SocieteFacture(id:String):void{
restDelete.url = "delete.php?categorie=action&id="+id;
restDelete.send();
send_selection();
}

private function UpdateSocieteFacture():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_SocieteFacture.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_SocieteFacture(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}




