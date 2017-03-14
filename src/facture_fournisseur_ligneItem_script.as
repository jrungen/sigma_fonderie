import flash.net.navigateToURL;
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
public var vIDUpload:String = '';
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php?id="+hour();

private function hour():String{
	var CurrentDateTime:Date = new Date();
	var CurrentDF:DateFormatter = new DateFormatter();
	CurrentDF.formatString = "YYYYMMDDHH";
	var DateTimeString:String = CurrentDF.format(CurrentDateTime);
	vIDUpload = DateTimeString;
	return vIDUpload;
}

private function createListenerfacture_fournisseur_ligne(e:Event):void {
	event_facture_fournisseur_ligne(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restfacture_fournisseur_ligneRead.url = "facture_fournisseur_ligneRead.php?cle="+text_cle.text;
			restfacture_fournisseur_ligneRead.send();
			send_selection();
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
		if(Application.application.gsProfil =='user'){
			combo_statut_compta.enabled = false;
			if(fichier_text_pj_reglement.text!=''){
				btn_parcourir_pj_reglement.enabled = false;
			}else{
				btn_parcourir_pj_reglement.enabled = true;
			}
		}	
	}
	
	onLoad_facture_fournisseur_ligne();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_facture_fournisseur_ligne();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_fournisseur_ligne();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfacture_fournisseur_ligne:String):void {
	beforeUpdate_facture_fournisseur_ligne();	
	restfacture_fournisseur_ligneUpdate.url = "facture_fournisseur_ligneUpdate.php?id="+text_idfacture_fournisseur_ligne.text;
	restfacture_fournisseur_ligneUpdate.send();
	//outerDocument.datagridfacture_fournisseur_ligne.dataProvider.refresh();
	//restfacture_fournisseur_ligneList.send();
}	

private function createItem():void {
	beforeCreate_facture_fournisseur_ligne();	
	restfacture_fournisseur_ligneCreate.url = "facture_fournisseur_ligneCreate.php";
	restfacture_fournisseur_ligneCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_facture_fournisseur_ligne():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	combo_annee.text = date_date_paye.text.substr(6,10);
	verif();
	if (text_idfacture_fournisseur_ligne.text==''){
		var validators:Array = Validator.validateAll([valid_type_depenses, valid_beneficiaire, valid_statut,valid_acompte_reglement_ht,valid_date_date_reglement,valid_acompte_reglement]);
		if(!validators.length) {
			if (Number(date_date_paye.text.substr(6,10)) > 2012){
				if ((text_acompte_paye.text>'0')&&(text_num_cheque.text=='')){
					Alert.show("le champ \"N° pièce\" du règlement est obligatoire"); 
				}else{
					createItem();
					close();
				}
			}else{
				createItem();
				close();
				}
			}
	}else{
		if (Number(date_date_paye.text.substr(6,10)) > 2012){
			if ((text_acompte_paye.text>'0')&&(text_num_cheque.text=='')){
				Alert.show("le champ \"N° pièce\" du règlement est obligatoire");
				}else{
					updateItem(text_idfacture_fournisseur_ligne.text);
					close();
				}	
			}else{
				updateItem(text_idfacture_fournisseur_ligne.text);
				close();
			}
		}
}
// Btn_appliquer	
private function appliquer():void {
	if (text_idfacture_fournisseur_ligne.text==''){
	var validators:Array = Validator.validateAll([valid_type_depenses, valid_beneficiaire, valid_statut]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idfacture_fournisseur_ligne.text);
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
	onPrint_facture_fournisseur_ligne();	
}

private function send_selection():void {}

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
fichier_text_pj_reglement.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj_reglement(event:MouseEvent):void {
	if(fichier_text_pj_reglement.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj_reglement.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
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
fichier_text_pj_paye.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj_paye(event:MouseEvent):void {
	if(fichier_text_pj_paye.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj_paye.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}


private function OpenConnexionfacture_fournisseur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_facture_fournisseur;
vConnexion.categorie = "facture_fournisseur";
}

private function verif():void{
	if((combo_statut_compta.text=='')||(combo_statut_compta.text=='0')||(combo_statut_compta.text==null)){
		trace(combo_statut_compta);
		if((Number(text_acompte_paye.text)>0)||(Number(text_acompte_paye.text)<0)){
			combo_statut_compta.text = 'A comptabiliser';
		}
	}
}

private function verif_date_demande(){
	var CurrentDateTime:Date = new Date();
	var CurrentDF:DateFormatter = new DateFormatter();
	CurrentDF.formatString = "YYYYMMDD";
	var DateTimeString:String = CurrentDF.format(CurrentDateTime);

	var sChaine:String = date_date_reglement.text;
	sChaine = sChaine.split('/')[2] + sChaine.split('/')[1] + sChaine.split('/')[0];
	
	var sDiff:Number = Number(sChaine) - Number(DateTimeString);
	if(sDiff<0){
		Alert.show("La date sélectionnée ne peut être inférieure à aujourd'hui");
		date_date_reglement.selectedDate = CurrentDateTime;
	}
	
}
