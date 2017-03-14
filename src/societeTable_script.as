// ActionScript file

import mx.validators.EmailValidator;
import mx.containers.ViewStack;
import mx.controls.Alert;
import mx.events.CloseEvent; 
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.core.Application;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import flash.net.navigateToURL;
import flash.system.System;
System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

private function load():void {
	restsocieteList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_societe();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_societe();	
}

private function searchsociete():void {
	restsocieteList.send();	
}

private function send_selection(e:ListEvent):void {} 			

private function updateItem(idsociete:String):void {
	beforeCreate_societe();	
	restsocieteUpdate.url = "societeUpdate.php?id="+idsociete;
	restsocieteUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridsociete.dataProvider.refresh();
	restsocieteList.send();
}	

private function newItem():void{			
	var vsocieteItem:societeItem = societeItem(PopUpManager.createPopUp(this,societeItem,true));
	vsocieteItem.mode = '1';
}   

private function openItem():void{			
	var vsocieteItem:societeItem = societeItem(PopUpManager.createPopUp(this,societeItem,true));
	vsocieteItem.text_cle.text = datagrid.selectedItem.cle;			
}  

private function AddSocieteProjet():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_idprojet.text = '';
vprojetItem.connexion_societe.text = text_cle.text ;
vprojetItem.mode ='1' ;
}

private function UpdateSocieteProjet():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text = datagrid_SocieteProjet.selectedItem.cle;
}

public function style_datagrid_SocieteProjet(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddSocieteContact():void{
var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
vcontactItem.text_idcontact.text = '';
vcontactItem.connexion_societe.text = text_cle.text ;
vcontactItem.mode ='1' ;
}

private function UpdateSocieteContact():void{
var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
vcontactItem.text_cle.text = datagrid_SocieteContact.selectedItem.cle;
}

public function style_datagrid_SocieteContact(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}



private function close():void {
	PopUpManager.removePopUp(this);
}

//Gestion du menu prinipale 

//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){
		newItem();
	}

	//Menu Enregistrer
	else if(myMenuBar.selectedIndex == 1){
		updateItem(text_idsociete.text);
	}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 2){
		delete_item();
	}
	//Export Excel
	else if(myMenuBar.selectedIndex == 3){
		navigateToURL( new URLRequest( 'csv/csv_client.php'), "_blank" );
	}
	else if(myMenuBar.selectedIndex == 4){
		close();
	}
} 

private function delete_item():void {
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message', 3, this, delete_item_result);
}

private function delete_item_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=societe&id="+datagrid.selectedItem.idsociete;
		restDelete.send();
		searchsociete();
	}else{  

	}	
}

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}



private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

public function style_datagrid_societe(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


