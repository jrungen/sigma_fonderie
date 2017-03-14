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
	restfacture_fournisseur_ligneList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_facture_fournisseur_ligne();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_fournisseur_ligne();	
}

private function searchfacture_fournisseur_ligne():void {
	restfacture_fournisseur_ligneList.send();	
}

private function send_selection(e:ListEvent):void {
	restfacture_fournisseur_ligneRead.url = "facture_fournisseur_ligneRead.php?cle="+e.currentTarget.selectedItem.cle;
restfacture_fournisseur_ligneRead.send();

	
} 			

private function updateItem(idfacture_fournisseur_ligne:String):void {
	beforeCreate_facture_fournisseur_ligne();	
	restfacture_fournisseur_ligneUpdate.url = "facture_fournisseur_ligneUpdate.php?id="+idfacture_fournisseur_ligne;
	restfacture_fournisseur_ligneUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfacture_fournisseur_ligne.dataProvider.refresh();
	restfacture_fournisseur_ligneList.send();
}	

private function newItem():void{			
	var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
	vfacture_fournisseur_ligneItem.mode = '1';
}   

private function openItem():void{			
	var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
	vfacture_fournisseur_ligneItem.text_cle.text = datagrid.selectedItem.cle;			
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
		updateItem(text_idfacture_fournisseur_ligne.text);
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

private function initFile_pj_reglement():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_reglement);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_reglement(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_reglement);
fileReference.upload(urlRequest);
fichier_text_pj_reglement.text = "Uploading...";
}
private function uploadCompleteHandler_pj_reglement(event:Event):void {
fichier_text_pj_reglement.text = event.target.name;
}
public function openNewWindow_pj_reglement(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj_reglement.text);
navigateToURL(u,"_blank");
}
private function initFile_pj_paye():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_paye);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_paye(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_paye);
fileReference.upload(urlRequest);
fichier_text_pj_paye.text = "Uploading...";
}
private function uploadCompleteHandler_pj_paye(event:Event):void {
fichier_text_pj_paye.text = event.target.name;
}
public function openNewWindow_pj_paye(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj_paye.text);
navigateToURL(u,"_blank");
}


private function OpenConnexionfacture_fournisseur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_facture_fournisseur;
vConnexion.categorie = "facture_fournisseur";
}

public function style_datagrid_facture_fournisseur_ligne(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


