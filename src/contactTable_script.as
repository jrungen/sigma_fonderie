// ActionScript file

import mx.validators.EmailValidator;
import mx.containers.ViewStack;
import mx.controls.Alert;
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
	restcontactList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_contact();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_contact();	
}

private function searchcontact():void {
	restcontactList.send();	
}

private function send_selection(e:ListEvent):void {
	restcontactRead.url = "contactRead.php?cle="+e.currentTarget.selectedItem.cle;
restcontactRead.send();

	
} 			

private function updateItem(idcontact:String):void {
	beforeCreate_contact();	
	restcontactUpdate.url = "contactUpdate.php?id="+idcontact;
	restcontactUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridcontact.dataProvider.refresh();
	restcontactList.send();
}	

private function newItem():void{			
	var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
	vcontactItem.mode = '1';
}   

private function openItem():void{			
	var vcontactItem:contactItem = contactItem(PopUpManager.createPopUp(this,contactItem,true));
	vcontactItem.text_cle.text = datagrid.selectedItem.cle;			
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
		updateItem(text_idcontact.text);
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}



private function OpenConnexionsociete():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.categorie = "societe";
}

public function style_datagrid_contact(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


