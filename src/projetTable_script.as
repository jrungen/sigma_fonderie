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

private function export_quadra():void {
	navigateToURL( new URLRequest( 'script/quadra.php'), "_blank" );
}
private function tableau_bord():void {
	navigateToURL( new URLRequest( 'script/tableau_bord_fonderie.xlsx'), "_blank" );
}

private function load():void {
	restprojetList.send();	
	if(Application.application.gsProfil !='user'){
		btn_export_quadra.visible=true;
	}
	if(Application.application.gsProfil !='user'){
		btn_tableau_bord.visible=true;
	}

}

private function onLoad(e:ResultEvent):void {
	onLoad_projet();
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_projet();	
}

private function searchprojet():void {
	restprojetList.send();	
	//calcul_total();
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idprojet:String):void {
	beforeCreate_projet();	
	restprojetUpdate.url = "projetUpdate.php?id="+idprojet;
	restprojetUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridprojet.dataProvider.refresh();
	restprojetList.send();
}	

private function newItem():void{			
	var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
	vprojetItem.combo_statut.data = "En cours";
	vprojetItem.mode = '1';
}   

private function openItem():void{			
	var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
	vprojetItem.text_cle.text = datagrid.selectedItem.cle;			
}  

private function AddProjetFctAvFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFctAvFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.selectedItem.cle;
}

public function style_datagrid_ProjetFctAvFournisseurPrestationsEvenementielles(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFactureFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurPrestationsEvenementielles.selectedItem.cle;
}

public function style_datagrid_ProjetFactureFournisseurPrestationsEvenementielles(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFactureAvoirFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureAvoirFournisseurTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFactureFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurTourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureFournisseurTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirsClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureAvoirsClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.selectedItem.cle;
}

public function style_datagrid_ProjetFactureAvoirsClientPrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureAvoirClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirClientTourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureAvoirClientTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientTourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureDepensesAnnexesPEPS():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_iddepenses_annexes.text = '';
vdepenses_annexesItem.connexion_projet.text = text_cle.text ;
vdepenses_annexesItem.mode ='1' ;
}

private function UpdateProjetFactureDepensesAnnexesPEPS():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_cle.text = datagrid_ProjetFactureDepensesAnnexesPEPS.selectedItem.cle;
}

public function style_datagrid_ProjetFactureDepensesAnnexesPEPS(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureDepensesAnnexesTA():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_iddepenses_annexes.text = '';
vdepenses_annexesItem.connexion_projet.text = text_cle.text ;
vdepenses_annexesItem.mode ='1' ;
}

private function UpdateProjetFactureDepensesAnnexesTA():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_cle.text = datagrid_ProjetFactureDepensesAnnexesTA.selectedItem.cle;
}

public function style_datagrid_ProjetFactureDepensesAnnexesTA(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAutrestourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureAutrestourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAutrestourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureAutrestourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAutrePrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientAutrePrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAutrePrestationEvenementielle.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientAutrePrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAccTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientAccTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAccTourismeAffaire.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientAccTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirsClientPrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureAvoirsClientPrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirsClientPrestationServices.selectedItem.cle;
}

public function style_datagrid_ProjetFactureAvoirsClientPrestationServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAutrePrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientAutrePrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAutrePrestationServices.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientAutrePrestationServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFactureFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurPrestationsServices.selectedItem.cle;
}

public function style_datagrid_ProjetFactureFournisseurPrestationsServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFctAvFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.mode ='1' ;
}

private function UpdateProjetFctAvFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFctAvFournisseurPrestationsServices.selectedItem.cle;
}

public function style_datagrid_ProjetFctAvFournisseurPrestationsServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientPrestationService():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientPrestationService():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientPrestationService.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientPrestationService(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.mode ='1' ;
}

private function UpdateProjetFactureClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientPrestationEvenementielle.selectedItem.cle;
}

public function style_datagrid_ProjetFactureClientPrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

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
		updateItem(text_idprojet.text);
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		close();
	}
	
	//Export Excel
	else if(myMenuBar.selectedIndex == 3){
		if(Application.application.gsProfil !='user'){
			navigateToURL( new URLRequest( 'csv/csv_projet.php'), "_blank" );
		}else{
			Alert.show('Vous n\'avez pas les droits pour exporter vers Excel.')
		}
	}

	else if(myMenuBar.selectedIndex == 4){
		close();
	}

	else if(myMenuBar.selectedIndex == 5){
		navigateToURL( new URLRequest( 'maj_totaux.php'), "_blank" );
	}
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_pj1_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj1_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj1_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj1_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj1_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj1_previsionnelle(event:Event):void {
fichier_text_pj1_previsionnelle.text = event.target.name;
}
public function openNewWindow_pj1_previsionnelle(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj1_previsionnelle.text);
navigateToURL(u,"_blank");
}
private function initFile_pj3_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj3_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj3_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj3_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj3_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj3_previsionnelle(event:Event):void {
fichier_text_pj3_previsionnelle.text = event.target.name;
}
public function openNewWindow_pj3_previsionnelle(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj3_previsionnelle.text);
navigateToURL(u,"_blank");
}
private function initFile_pj2_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj2_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj2_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj2_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj2_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj2_previsionnelle(event:Event):void {
fichier_text_pj2_previsionnelle.text = event.target.name;
}
public function openNewWindow_pj2_previsionnelle(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj2_previsionnelle.text);
navigateToURL(u,"_blank");
}


private function OpenConnexionsociete():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.categorie = "societe";
}private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

public function style_datagrid_projet(data:Object, col:AdvancedDataGridColumn):Object{
	return null;
}