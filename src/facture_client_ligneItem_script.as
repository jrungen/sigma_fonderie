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

private function createListenerfacture_client_ligne(e:Event):void {
	event_facture_client_ligne(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restfacture_client_ligneRead.url = "facture_client_ligneRead.php?cle="+text_cle.text;
			restfacture_client_ligneRead.send();
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
			btn_parcourir_facture.enabled = false;
			btn_enregistrer.enabled = false;
		}
	}

	onLoad_facture_client_ligne();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_facture_client_ligne();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_client_ligne();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfacture_client_ligne:String):void {
	beforeUpdate_facture_client_ligne();	
	restfacture_client_ligneUpdate.url = "facture_client_ligneUpdate.php?id="+text_idfacture_client_ligne.text;
	restfacture_client_ligneUpdate.send();
	//outerDocument.datagridfacture_client_ligne.dataProvider.refresh();
	//restfacture_client_ligneList.send();
}	

private function createItem():void {
	beforeCreate_facture_client_ligne();	
	restfacture_client_ligneCreate.url = "facture_client_ligneCreate.php";
	restfacture_client_ligneCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_facture_client_ligne():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	if (text_idfacture_client_ligne.text==''){
		var validators:Array = Validator.validateAll([valid_facture_client]);
		if(!validators.length) {
			createItem();
			close();
		}
	}else{
		updateItem(text_idfacture_client_ligne.text);
		close();
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (text_idfacture_client_ligne.text==''){
	var validators:Array = Validator.validateAll([valid_facture_client]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idfacture_client_ligne.text);
		Alert.show("Fiche modifiée");
	}
}

// Btn_fermer
private function fermer():void {
	close();
}

// Brn Imprimer
private function imprimer():void {
	onPrint_facture_client_ligne();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idfacture_client_ligne.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idfacture_client_ligne.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idfacture_client_ligne.text==''){
			createItem();
		}else{
			updateItem(text_idfacture_client_ligne.text);
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





private function OpenConnexioncle():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_facture_client;
vConnexion.categorie = "cle";
}




