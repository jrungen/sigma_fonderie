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
	restdepenses_annexesList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_depenses_annexes();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_depenses_annexes();	
}

private function searchdepenses_annexes():void {
	restdepenses_annexesList.send();	
}

private function send_selection(e:ListEvent):void {
	restdepenses_annexesRead.url = "depenses_annexesRead.php?cle="+e.currentTarget.selectedItem.cle;
restdepenses_annexesRead.send();

	
} 			

private function updateItem(iddepenses_annexes:String):void {
	beforeCreate_depenses_annexes();	
	restdepenses_annexesUpdate.url = "depenses_annexesUpdate.php?id="+iddepenses_annexes;
	restdepenses_annexesUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagriddepenses_annexes.dataProvider.refresh();
	restdepenses_annexesList.send();
}	

private function newItem():void{			
	var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
	vdepenses_annexesItem.mode = '1';
}   

private function openItem():void{			
	var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
	vdepenses_annexesItem.text_cle.text = datagrid.selectedItem.cle;			
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
	//Export Excel
	else if(myMenuBar.selectedIndex == 1){
		if(Application.application.gsProfil !='user'){
			navigateToURL( new URLRequest( 'csv/csv_depenses_annexes.php'), "_blank" );
		}else{
			Alert.show('Vous n\'avez pas les droits pour exporter vers Excel.')
		}
	}
	/*
	//Menu Enregistrer
	else if(myMenuBar.selectedIndex == 1){
		updateItem(text_iddepenses_annexes.text);
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
	*/
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_pj():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj);
fileReference.upload(urlRequest);
fichier_text_pj.text = "Uploading...";
}
private function uploadCompleteHandler_pj(event:Event):void {
fichier_text_pj.text = event.target.name;
}
public function openNewWindow_pj(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj.text);
navigateToURL(u,"_blank");
}


private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}private function OpenConnexionprojet():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.categorie = "projet";
}private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

public function style_datagrid_depenses_annexes(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


