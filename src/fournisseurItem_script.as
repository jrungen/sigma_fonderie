import flash.system.System;

import mx.controls.Alert;
import mx.core.Application;
import mx.events.CloseEvent;
import mx.formatters.DateFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.ResultEvent;
import mx.validators.Validator;
System.useCodePage = true;

public var mode:String = '0';
public var refresh:String;
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php?table=fournisseur";

private function createListenerfournisseur(e:Event):void {
	event_fournisseur(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
	if(text_idfournisseur.text==''){
		restfournisseurRead.url = "fournisseurRead.php?cle="+text_cle.text;	
	}else{
		restfournisseurRead.url = "fournisseurRead.php?idfournisseur="+text_idfournisseur.text;
	}
	restfournisseurRead.send();
}


private function onLoad(e:ResultEvent):void {
	// Si création de fiche

	// Formatage pour année création
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
	// rempli l'année dans système
	var sDate:String = dateFormat.format(new Date());
	var sYear:String = sDate.substr(6,10);
	
	var numberFormat:NumberFormatter = new NumberFormatter();
	numberFormat.decimalSeparatorFrom = ".";
	numberFormat.decimalSeparatorTo = ".";
	numberFormat.precision="-1";

	numberFormat.thousandsSeparatorFrom="";
	numberFormat.thousandsSeparatorTo="";
	numberFormat.useNegativeSign="true";
	numberFormat.useThousandsSeparator="true";
	
	if(mode=='1'){
		text_creation_par.text = Application.application.gsUser;
		date_date_creation.text=sDate;
		combo_annee.text = sYear;
	}else{
		text_modification_par.text = Application.application.gsUser;
		date_date_modification.selectedDate = new Date();
		send_selection();
	}
	onLoad_fournisseur();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_fournisseur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_fournisseur();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfournisseur:String):void {
	beforeUpdate_fournisseur();	
	restfournisseurUpdate.url = "fournisseurUpdate.php?id="+text_idfournisseur.text;
	restfournisseurUpdate.send();
	restfournisseurUpdate.url = "script/update_date_fournisseur.php?cle="+text_cle.text;
	restfournisseurUpdate.send();
	//outerDocument.datagridfournisseur.dataProvider.refresh();
	//restfournisseurList.send();
}	

private function createItem():void {
	beforeCreate_fournisseur();	
	restfournisseurCreate.url = "fournisseurCreate.php";
	restfournisseurCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_fournisseur():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (mode=='1'){
		var validators:Array = Validator.validateAll([valid_cp, valid_ville, valid_nom, valid_pays, valid_adresse,valid_tel]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idfournisseur.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (mode=='1'){
	var validators:Array = Validator.validateAll([valid_cp, valid_ville, valid_nom, valid_pays]);
	if(!validators.length) {
		createItem();
		mode='0';
		Alert.show("Fiche ajoutée");
	}	
	}else{
		updateItem(text_idfournisseur.text);
		Alert.show("Fiche enregistrée");
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
	onPrint_fournisseur();	
}

private function send_selection():void {
	restFournisseurAction.url = "FournisseurAction_Vue.php?cle="+text_cle.text;
	restFournisseurAction.send();
	restFournisseurFactureFournisseur.url = "FournisseurFactureFournisseur_Vue.php?cle="+text_cle.text+"&search="+text_search_FournisseurFacture.text;
	restFournisseurFactureFournisseur.send();
	restFournisseurFournisseur_attestation.url = "FournisseurFournisseur_attestation_Vue.php?cle="+text_cle.text;
	restFournisseurFournisseur_attestation.send();
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

//ajouté par Jonathan vue action
private function AddFournisseurAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.mode= '1';
vactionItem.text_idaction.text = '';
vactionItem.connexion_fournisseur.text = text_cle.text;
vactionItem.connexion_fournisseur_complement.text = text_cle.text;
refresh = 'REFRESH';
}

private function Delete_FournisseurAction(id:String):void{
restDelete.url = "delete.php?categorie=action&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFournisseurAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.text_cle.text = datagrid_FournisseurAction.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FournisseurAction(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

//ajouté par JRN 2013-10-02 vue Fournisseur Attestation
private function AddFournisseurFournisseur_attestation():void{
var vfournisseur_attestationItem:fournisseur_attestationItem = fournisseur_attestationItem(PopUpManager.createPopUp(this,fournisseur_attestationItem,true));
vfournisseur_attestationItem.mode= '1';
vfournisseur_attestationItem.text_idfournisseur_attestation.text = '';
vfournisseur_attestationItem.connexion_fournisseur.text = text_cle.text;
vfournisseur_attestationItem.connexion_fournisseur_complement.text = text_cle.text;
refresh = 'REFRESH';
}

private function Delete_FournisseurFournisseur_attestation(id:String):void{
restDelete.url = "delete.php?categorie=fournisseur_attestation&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFournisseurFournisseur_attestation():void{
var vfournisseur_attestationItem:fournisseur_attestationItem = fournisseur_attestationItem(PopUpManager.createPopUp(this,fournisseur_attestationItem,true));
vfournisseur_attestationItem.text_cle.text = datagrid_FournisseurFournisseur_attestation.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FournisseurFournisseur_attestation(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

//ajouté par Jonathan vue Facture Fournisseur
private function AddFournisseurFactureFournisseur():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_fournisseur.text = text_cle.text;
vfacture_fournisseurItem.combo_type.data = "Factures fournisseurs";
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
refresh = 'REFRESH';
}

private function Delete_FournisseurFactureFournisseur(id:String):void{
restDelete.url = "delete.php?categorie=facture_fournisseur&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFournisseurFactureFournisseur():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_FournisseurFactureFournisseur.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FournisseurFactureFournisseur(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}