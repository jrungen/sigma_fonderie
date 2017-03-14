// ActionScript file

import flash.net.navigateToURL;
import flash.system.System;

import mx.controls.Alert;
import mx.core.Application;
import mx.events.ListEvent;
import mx.managers.PopUpManager;
import mx.rpc.events.ResultEvent;
System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

private function tableau_bord_honoraire():void {
	navigateToURL( new URLRequest( 'script/tcd_ligne_facture_v2.xlsx'), "_blank" );
}

private function load():void {
	restfacture_clientList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_facture_client();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_client();	
}

private function searchfacture_client():void {
	restfacture_clientList.send();	
}

private function send_selection(e:ListEvent):void {
	restfacture_clientRead.url = "facture_clientRead.php?cle="+e.currentTarget.selectedItem.cle;
restfacture_clientRead.send();

	restFactureLigneTA.url = "FactureLigneTA_Vue.php?cle="+e.currentTarget.selectedItem.cle;
restFactureLigneTA.send();
restFactureLigne.url = "FactureLigne_Vue.php?cle="+e.currentTarget.selectedItem.cle;
restFactureLigne.send();

} 			

private function updateItem(idfacture_client:String):void {
	beforeCreate_facture_client();	
	restfacture_clientUpdate.url = "facture_clientUpdate.php?id="+idfacture_client;
	restfacture_clientUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfacture_client.dataProvider.refresh();
	restfacture_clientList.send();
}	

private function newItem():void{			
	var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
	vfacture_clientItem.mode = '1';
}   

private function openItem():void{			
	var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
	vfacture_clientItem.text_cle.text = datagrid.selectedItem.cle;			
}  

private function AddFactureLigneTA():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_idfacture_client_ligne.text = '';
vfacture_client_ligneItem.connexion_facture_client.text = text_cle.text ;
vfacture_client_ligneItem.mode ='1' ;
}

private function UpdateFactureLigneTA():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_cle.text = datagrid_FactureLigneTA.selectedItem.cle;
}

public function style_datagrid_FactureLigneTA(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddFactureLigne():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_idfacture_client_ligne.text = '';
vfacture_client_ligneItem.connexion_facture_client.text = text_cle.text ;
vfacture_client_ligneItem.mode ='1' ;
}

private function UpdateFactureLigne():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_cle.text = datagrid_FactureLigne.selectedItem.cle;
}

public function style_datagrid_FactureLigne(data:Object, col:AdvancedDataGridColumn):Object{

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

	//Export Excel
	else if(myMenuBar.selectedIndex == 1){
		if(Application.application.gsProfil !='user'){
			navigateToURL( new URLRequest( 'csv/csv_facture_client.php'), "_blank" );
		}else{
			Alert.show('Vous n\'avez pas les droits pour exporter vers Excel.')
		}
	}
	// impression facture client et autre TA
	else if(myMenuBar.selectedIndex == 2){
		if(combo_filtre.text != "Facture Client et Autre TA"){
			Alert.show("Merci de choisir le filtre : Facture Client et Autre TA");
		}else{
			cbAllHandler_TA();
		}
	}
	
	// impression facture client et autre  PE-PS
	else if(myMenuBar.selectedIndex == 3){
		if(combo_filtre.text != "Facture Client et Autre PE-PS"){
			Alert.show("Merci de choisir le filtre : Facture Client et Autre PE-PS");
		}else{
			cbAllHandler_PEPS();
		}
	}
	// impression facture Avoir TA
	else if(myMenuBar.selectedIndex == 4){
		if(combo_filtre.text != "Facture Avoir TA"){
			Alert.show("Merci de choisir le filtre : Facture Avoir TA");
		}else{
			cbAllHandler_AVOIR_TA();
		}
	}
	
	// impression facture Avoir PE-PS
	else if(myMenuBar.selectedIndex == 5){
		if(combo_filtre.text != "Facture Avoir PE-PS"){
			Alert.show("Merci de choisir le filtre : Facture Avoir PE-PS");
		}else{
			cbAllHandler_AVOIR_PEPS();
		}
	}
	// impression facture Accompagnant
	else if(myMenuBar.selectedIndex == 6){
		if(combo_filtre.text != "Facture Accompagnant"){
			Alert.show("Merci de choisir le filtre : Facture Accompagnant");
		}else{
			cbAllHandler_ACC();
		}
	}
	
	// impression facture Avoir Accompagnant
	else if(myMenuBar.selectedIndex == 7){
		if(combo_filtre.text != "Facture Avoir Accompagnant"){
			Alert.show("Merci de choisir le filtre : Facture Avoir Accompagnant");
		}else{
			cbAllHandler_AVOIR_ACC();
		}
	}
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_pj1():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj1);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj1(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj1);
fileReference.upload(urlRequest);
fichier_text_pj1.text = "Uploading...";
}
private function uploadCompleteHandler_pj1(event:Event):void {
fichier_text_pj1.text = event.target.name;
}
public function openNewWindow_pj1(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj1.text);
navigateToURL(u,"_blank");
}
private function initFile_pj2():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj2);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj2(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj2);
fileReference.upload(urlRequest);
fichier_text_pj2.text = "Uploading...";
}
private function uploadCompleteHandler_pj2(event:Event):void {
fichier_text_pj2.text = event.target.name;
}
public function openNewWindow_pj2(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj2.text);
navigateToURL(u,"_blank");
}
private function initFile_pj3():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj3);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj3(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj3);
fileReference.upload(urlRequest);
fichier_text_pj3.text = "Uploading...";
}
private function uploadCompleteHandler_pj3(event:Event):void {
fichier_text_pj3.text = event.target.name;
}
public function openNewWindow_pj3(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj3.text);
navigateToURL(u,"_blank");
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


private function OpenConnexionsociete():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.categorie = "societe";
}private function OpenConnexionprojet():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.categorie = "projet";
}private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}

public function style_datagrid_facture_client(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}


