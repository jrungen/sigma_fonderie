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
	restfacture_client_ligneList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_facture_client_ligne();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_client_ligne();	
}

private function searchfacture_client_ligne():void {
	restfacture_client_ligneList.send();	
}

private function send_selection(e:ListEvent):void {
	restfacture_client_ligneRead.url = "facture_client_ligneRead.php?cle="+e.currentTarget.selectedItem.cle;
restfacture_client_ligneRead.send();

	
} 			

private function updateItem(idfacture_client_ligne:String):void {
	beforeCreate_facture_client_ligne();	
	restfacture_client_ligneUpdate.url = "facture_client_ligneUpdate.php?id="+idfacture_client_ligne;
	restfacture_client_ligneUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfacture_client_ligne.dataProvider.refresh();
	restfacture_client_ligneList.send();
}	

private function newItem():void{			
	var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
	vfacture_client_ligneItem.mode = '1';
}   

private function openItem():void{			
	var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
	vfacture_client_ligneItem.text_cle.text = datagrid.selectedItem.cle;			
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
		updateItem(text_idfacture_client_ligne.text);
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



private function OpenConnexioncle():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_facture_client;
vConnexion.categorie = "cle";
}

public function style_datagrid_facture_client_ligne(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


