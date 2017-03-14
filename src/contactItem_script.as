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
private var serverSideScript:String = "upload.php";

private function createListenercontact(e:Event):void {
	event_contact(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restcontactRead.url = "contactRead.php?cle="+text_cle.text;
			restcontactRead.send();
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
		combo_annee.text = sYear;
	}
	onLoad_contact();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_contact();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_contact();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idcontact:String):void {
	beforeUpdate_contact();	
	restcontactUpdate.url = "contactUpdate.php?id="+text_idcontact.text;
	restcontactUpdate.send();
	//outerDocument.datagridcontact.dataProvider.refresh();
	//restcontactList.send();
}	

private function createItem():void {
	beforeCreate_contact();	
	restcontactCreate.url = "contactCreate.php";
	restcontactCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_contact():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (text_idcontact.text==''){
		var validators:Array = Validator.validateAll([valid_prenom, valid_nom]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idcontact.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (text_idcontact.text==''){
	var validators:Array = Validator.validateAll([valid_prenom, valid_nom]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idcontact.text);
		Alert.show("Fiche modifiée");
	}
}

// Btn_fermer
private function fermer():void {
	close();
}

// Brn Imprimer
private function imprimer():void {
	onPrint_contact();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idcontact.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idcontact.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idcontact.text==''){
			createItem();
		}else{
			updateItem(text_idcontact.text);
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





private function OpenConnexionsociete():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.categorie = "societe";
}




