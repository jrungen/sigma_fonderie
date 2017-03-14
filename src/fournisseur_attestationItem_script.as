import mx.core.ContainerGlobals;
import mx.core.Application;
import mx.events.CollectionEvent;
import mx.controls.Alert;		  
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.managers.PopUpManager;
import mx.collections.ArrayCollection;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.events.CloseEvent; 
/* Validator */
import mx.validators.Validator;
import mx.utils.StringUtil;
import mx.events.ValidationResultEvent;
import mx.formatters.DateFormatter;
import flash.net.navigateToURL;
import flash.system.System;
System.useCodePage = true;
public var mode:String = '0';
public var saveType:String = 'Enregistrer';
public var refresh:String;
public var vIDUpload:String = '';
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php?table=fournisseur_attestation&id="+hour();

private function hour():String{
	var CurrentDateTime:Date = new Date();
	var CurrentDF:DateFormatter = new DateFormatter();
	CurrentDF.formatString = "YYYYMMDDHH";
	var DateTimeString:String = CurrentDF.format(CurrentDateTime);
	vIDUpload = DateTimeString;
	return vIDUpload;
}

private function createListenerfournisseur_attestation(e:Event):void {
	event_fournisseur_attestation(e);
}

private function load():void {
	Alert.yesLabel = "Oui";
    Alert.noLabel = "Non";
	
	PopUpManager.centerPopUp(this);
	if(text_idfournisseur_attestation.text==''){
		restfournisseur_attestationRead.url = "fournisseur_attestationRead.php?cle="+text_cle.text;	
	}else{
		restfournisseur_attestationRead.url = "fournisseur_attestationRead.php?idfournisseur_attestation="+text_idfournisseur_attestation.text;
	}
	restfournisseur_attestationRead.send();
}


private function onLoad(e:ResultEvent):void {
	// Si création de fiche
	// Date
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
	var sDate:String = dateFormat.format(new Date());
	var sYear:String = sDate.substr(6,10);

	// Time
	var dateFormatTime:DateFormatter = new DateFormatter();
	dateFormatTime.formatString = "HH:NN:SS";
	var sTime:String = dateFormatTime.format(new Date());

	var numberFormat:NumberFormatter = new NumberFormatter();
	numberFormat.decimalSeparatorFrom = ".";
	numberFormat.decimalSeparatorTo = ".";
	numberFormat.precision="-1";

	numberFormat.thousandsSeparatorFrom="";
	numberFormat.thousandsSeparatorTo="";
	numberFormat.useNegativeSign="true";
	numberFormat.useThousandsSeparator="true";
	
	if(mode=='1'){
		date_date_creation.text = sDate;
		date_date_modification.text = sDate;
		combo_annee.text = sYear;
		text_creation_par.text = Application.application.gsUser;
		text_modification_par.text = Application.application.gsUser;
		text_heure_creation.text = sTime;
		text_heure_modification.text = sTime;
	}else{
		date_date_attestation.text = dateFormat.format(date_date_attestation.text);
date_date_document.text = dateFormat.format(date_date_document.text);
date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);

		send_selection();
		
		// Vérif permission
		restPermission.url = "script/permission.php?permission=update&table=fournisseur_attestation&group="+Application.application.gsGroup+"&id="+text_idfournisseur_attestation.text;
		restPermission.send();
	}
	onLoad_fournisseur_attestation();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_fournisseur_attestation();	
	if(mode=='1'){
		mode='0';
		if(saveType == 'Appliquer'){
			text_idfournisseur_attestation.text = restfournisseur_attestationCreate.lastResult.id;
			Alert.show(String(restfournisseur_attestationCreate.lastResult.message));
		}
	}		
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_fournisseur_attestation();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfournisseur_attestation:String):void {
	beforeUpdate_fournisseur_attestation();	
	restfournisseur_attestationUpdate.url = "fournisseur_attestationUpdate.php?id="+text_idfournisseur_attestation.text+"&user="+Application.application.gsUser;
	restfournisseur_attestationUpdate.send();
	//outerDocument.datagridfournisseur_attestation.dataProvider.refresh();
	//restfournisseur_attestationList.send();
}	

private function createItem():void {
	beforeCreate_fournisseur_attestation();	
	restfournisseur_attestationCreate.url = "fournisseur_attestationCreate.php";
	restfournisseur_attestationCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_fournisseur_attestation():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	var i:uint;
	var validators:Array = Validator.validateAll([valid_fournisseur, valid_date_attestation, valid_date_document]);
	var message:String = "";
	saveType = 'Enregistrer';
	
	if (mode=='1'){
		if(!validators.length) {
			createItem();
			close();
		}else{
			 //boucle sur les résultats et retrouve l'id correspondant
			 for (i = 0;i<validators.length;i++){
			 	
			 	if(validators[i].target.source.id.substr(0,9)=='connexion'){
			 		message  += '- ' + validators[i].target.source.parent.parent.parent.label + "\n";
			 	}else{
			 		message  += '- ' + validators[i].target.source.parent.label + "\n";
			 	}
			 }
			 Alert.show(message,'Attention champ(s) obligatoire(s)');
		}
	}else{
		if(!validators.length) {
			updateItem(text_idfournisseur_attestation.text);
			close();
		}else{
			  //boucle sur les résultats et retrouve l'id correspondant
			 for (i = 0;i<validators.length;i++){
			 	
			 	if(validators[i].target.source.id.substr(0,9)=='connexion'){
			 		message  += '- ' + validators[i].target.source.parent.parent.parent.label + "\n";
			 	}else{
			 		message  += '- ' + validators[i].target.source.parent.label + "\n";
			 	}
			 }
			 Alert.show(message,'Attention champ(s) obligatoire(s)');
		}	
	}
}

// Btn_appliquer	
private function appliquer():void {
	var i:uint;
	var validators:Array = Validator.validateAll([valid_fournisseur, valid_date_attestation, valid_date_document]);
	var message:String = "";
	saveType = 'Appliquer';
	if (mode=='1'){
		if(!validators.length) {
			createItem();
		}else{
				 //boucle sur les résultats et retrouve l'id correspondant
				 for (i = 0;i<validators.length;i++){
					
					if(validators[i].target.source.id.substr(0,9)=='connexion'){
						message  += '- ' + validators[i].target.source.parent.parent.parent.label + "\n";
					}else{
						message  += '- ' + validators[i].target.source.parent.label + "\n";
					}
				 }
				 Alert.show(message,'Attention champ(s) obligatoire(s)');
		}	
	}else{
		if(!validators.length) {
			updateItem(text_idfournisseur_attestation.text);
			Alert.show("Fiche enregistrée");
		}else{
			  //boucle sur les résultats et retrouve l'id correspondant
			 for (i = 0;i<validators.length;i++){
			 	
			 	if(validators[i].target.source.id.substr(0,9)=='connexion'){
			 		message  += '- ' + validators[i].target.source.parent.parent.parent.label + "\n";
			 	}else{
			 		message  += '- ' + validators[i].target.source.parent.label + "\n";
			 	}
			 }
			 Alert.show(message,'Attention champ(s) obligatoire(s)');
		}	
	}
}

// Btn_fermer
private function fermer():void {
	if(mode=='1'){
		Alert.show('Voulez-vous enregistrer cette fiche ?', 'Message de confirmation', 3, this, close_result);
	}else{
		close();
	}
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
	onPrint_fournisseur_attestation();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idfournisseur_attestation.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idfournisseur_attestation.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idfournisseur_attestation.text==''){
			createItem();
		}else{
			updateItem(text_idfournisseur_attestation.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
	
	
	send_selection_script();
} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}



private function initFile_pj_kbis():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_kbis);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_kbis(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_kbis);
fileReference.upload(urlRequest);
fichier_text_pj_kbis.text = "Uploading...";
}
private function uploadCompleteHandler_pj_kbis(event:Event):void {
fichier_text_pj_kbis.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj_kbis(event:MouseEvent):void {
if(fichier_text_pj_kbis.text!=''){
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_kbis.text);
navigateToURL(u,"_blank");
}else{
Alert.show('Aucun fichier lié');
}
}
private function initFile_pj_urssaf_rsi():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_urssaf_rsi);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_urssaf_rsi(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_urssaf_rsi);
fileReference.upload(urlRequest);
fichier_text_pj_urssaf_rsi.text = "Uploading...";
}
private function uploadCompleteHandler_pj_urssaf_rsi(event:Event):void {
fichier_text_pj_urssaf_rsi.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj_urssaf_rsi(event:MouseEvent):void {
if(fichier_text_pj_urssaf_rsi.text!=''){
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_urssaf_rsi.text);
navigateToURL(u,"_blank");
}else{
Alert.show('Aucun fichier lié');
}
}
private function initFile_pj_autre():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_autre);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_autre(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_autre);
fileReference.upload(urlRequest);
fichier_text_pj_autre.text = "Uploading...";
}
private function uploadCompleteHandler_pj_autre(event:Event):void {
fichier_text_pj_autre.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj_autre(event:MouseEvent):void {
if(fichier_text_pj_autre.text!=''){
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_autre.text);
navigateToURL(u,"_blank");
}else{
Alert.show('Aucun fichier lié');
}
}


private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,Application.application.gsModal));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "fournisseur_attestation";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
if(connexion_fournisseur.text!=''){
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,Application.application.gsModal));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}else{
Alert.show('Attention la connexion est vide');
}
}





private function copier():void{			
	var vfournisseur_attestationItem:fournisseur_attestationItem = fournisseur_attestationItem(PopUpManager.createPopUp(this,fournisseur_attestationItem,Application.application.gsModal));
	vfournisseur_attestationItem.text_idfournisseur_attestation.text = text_idfournisseur_attestation.text;
	vfournisseur_attestationItem.mode = '1';
}  

