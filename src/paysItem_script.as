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
public var refresh:String;
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php?table=pays";

private function createListenerpays(e:Event):void {
	event_pays(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
	if(text_idpays.text==''){
		restpaysRead.url = "paysRead.php?cle="+text_cle.text;	
	}else{
		restpaysRead.url = "paysRead.php?idpays="+text_idpays.text;
	}
	restpaysRead.send();
}


private function onLoad(e:ResultEvent):void {
	// Si création de fiche
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
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
		date_date_creation.text = sDate;
		date_date_modification.text = sDate;
		combo_annee.text = sYear;
	}else{
		date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);

		send_selection();
		
		// Vérif permission
		restPermission.url = "script/permission.php?permission=update&table=pays&group="+Application.application.gsGroup+"&id="+text_idpays.text;
		restPermission.send();
	}
	onLoad_pays();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_pays();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_pays();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idpays:String):void {
	beforeUpdate_pays();	
	restpaysUpdate.url = "paysUpdate.php?id="+text_idpays.text+"&user="+Application.application.gsUser;
	restpaysUpdate.send();
	//outerDocument.datagridpays.dataProvider.refresh();
	//restpaysList.send();
}	

private function createItem():void {
	beforeCreate_pays();	
	restpaysCreate.url = "paysCreate.php";
	restpaysCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_pays():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (mode=='1'){
		var validators:Array = Validator.validateAll([valid_cle]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idpays.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (mode=='1'){
	var validators:Array = Validator.validateAll([valid_cle]);
	if(!validators.length) {
		createItem();
		mode='0';
		Alert.show("Fiche ajoutée");
	}	
	}else{
		updateItem(text_idpays.text);
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
	onPrint_pays();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idpays.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idpays.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idpays.text==''){
			createItem();
		}else{
			updateItem(text_idpays.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
	
} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}









