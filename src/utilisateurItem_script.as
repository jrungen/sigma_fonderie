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
private var serverSideScript:String = "upload.php?table=utilisateur";

private function createListenerutilisateur(e:Event):void {
	event_utilisateur(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
	if(text_idutilisateur.text==''){
		restutilisateurRead.url = "utilisateurRead.php?cle="+text_cle.text;	
	}else{
		restutilisateurRead.url = "utilisateurRead.php?idutilisateur="+text_idutilisateur.text;
	}
	restutilisateurRead.send();
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
		combo_annee.text = sYear;
	}else{
		date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);

		send_selection();

	}
	onLoad_utilisateur();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_utilisateur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_utilisateur();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idutilisateur:String):void {
	beforeUpdate_utilisateur();	
	restutilisateurUpdate.url = "utilisateurUpdate.php?id="+text_idutilisateur.text;
	restutilisateurUpdate.send();
	//outerDocument.datagridutilisateur.dataProvider.refresh();
	//restutilisateurList.send();
}	

private function createItem():void {
	beforeCreate_utilisateur();	
	restutilisateurCreate.url = "utilisateurCreate.php";
	restutilisateurCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_utilisateur():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (mode=='1'){
		var validators:Array = Validator.validateAll([valid_login, valid_cle, valid_password, valid_profil]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idutilisateur.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (mode=='1'){
	var validators:Array = Validator.validateAll([valid_login, valid_cle, valid_password, valid_profil]);
	if(!validators.length) {
		createItem();
		mode='0';
		Alert.show("Fiche ajoutée");
	}	
	}else{
		updateItem(text_idutilisateur.text);
		Alert.show("Fiche enregistrée");
	}
}

// Btn_fermer
private function fermer():void {
	close();
}

// Brn Imprimer
private function imprimer():void {
	onPrint_utilisateur();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idutilisateur.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idutilisateur.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idutilisateur.text==''){
			createItem();
		}else{
			updateItem(text_idutilisateur.text);
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









