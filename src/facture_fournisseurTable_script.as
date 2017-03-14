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
	restfacture_fournisseurList.send();	
}

private function onLoad(e:ResultEvent):void {
	onLoad_facture_fournisseur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_fournisseur();	
}

private function searchfacture_fournisseur():void {
	restfacture_fournisseurList.send();	
}

private function send_selection(e:ListEvent):void {
	restfacture_fournisseurRead.url = "facture_fournisseurRead.php?cle="+e.currentTarget.selectedItem.cle;
restfacture_fournisseurRead.send();

	restFactureFournisseur.url = "FactureFournisseur_Vue.php?cle="+e.currentTarget.selectedItem.cle;
restFactureFournisseur.send();

} 			

private function updateItem(idfacture_fournisseur:String):void {
	beforeCreate_facture_fournisseur();	
	restfacture_fournisseurUpdate.url = "facture_fournisseurUpdate.php?id="+idfacture_fournisseur;
	restfacture_fournisseurUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfacture_fournisseur.dataProvider.refresh();
	restfacture_fournisseurList.send();
}	

private function newItem():void{			
	var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
	vfacture_fournisseurItem.mode = '1';
}   

private function openItem():void{			
	var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
	vfacture_fournisseurItem.text_cle.text = datagrid.selectedItem.cle;			
}  

private function AddFactureFournisseur():void{
var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
vfacture_fournisseur_ligneItem.text_idfacture_fournisseur_ligne.text = '';
vfacture_fournisseur_ligneItem.connexion_facture_fournisseur.text = text_cle.text ;
vfacture_fournisseur_ligneItem.mode ='1' ;
}

private function UpdateFactureFournisseur():void{
var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
vfacture_fournisseur_ligneItem.text_cle.text = datagrid_FactureFournisseur.selectedItem.cle;
}

public function style_datagrid_FactureFournisseur(data:Object, col:AdvancedDataGridColumn):Object{
if (data["statut"]=='A régler') return{color:0xFF0000,fontWeight:"bold"} ;

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
	/*
	//Menu Enregistrer
	else if(myMenuBar.selectedIndex == 1){
		updateItem(text_idfacture_fournisseur.text);
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		close();
	}
	*/
	//Export Excel
	else if(myMenuBar.selectedIndex == 1){
		if(Application.application.gsProfil !='user'){
			navigateToURL( new URLRequest( 'csv/csv_facture_fournisseur.php'), "_blank" );
		}else{
			Alert.show('Vous n\'avez pas les droits pour exporter vers Excel.')
		}
	}

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


private function OpenConnexionprojet():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.categorie = "projet";
}private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

public function style_datagrid_facture_fournisseur(data:Object, col:AdvancedDataGridColumn):Object{
	 if (data["statut"]=='A régler') return{color:0xFF0000,fontWeight:"bold"};
	return null;
}


