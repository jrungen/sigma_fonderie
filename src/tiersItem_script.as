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
private var serverSideScript:String = "upload.php?table=tiers";

private function createListenertiers(e:Event):void {
	event_tiers(e);
}

private function load():void {
	Alert.yesLabel = "Oui";
    Alert.noLabel = "Non";
	
	PopUpManager.centerPopUp(this);
	if(text_idtiers.text==''){
		resttiersRead.url = "tiersRead.php?cle="+text_cle.text;	
	}else{
		resttiersRead.url = "tiersRead.php?idtiers="+text_idtiers.text;
	}
	resttiersRead.send();
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
		restPermission.url = "script/permission.php?permission=update&table=tiers&group="+Application.application.gsGroup+"&id="+text_idtiers.text;
		restPermission.send();
	}
	onLoad_tiers();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_tiers();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_tiers();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idtiers:String):void {
	beforeUpdate_tiers();	
	resttiersUpdate.url = "tiersUpdate.php?id="+text_idtiers.text+"&user="+Application.application.gsUser;
	resttiersUpdate.send();
	//outerDocument.datagridtiers.dataProvider.refresh();
	//resttiersList.send();
}	

private function createItem():void {
	beforeCreate_tiers();	
	resttiersCreate.url = "tiersCreate.php";
	resttiersCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_tiers():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	var i:uint;
	var validators:Array = Validator.validateAll([valid_nom, valid_tel, valid_ville, valid_civilite, valid_adresse, valid_pays, valid_prenom]);
	var message:String = "";
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
			updateItem(text_idtiers.text);
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
	var validators:Array = Validator.validateAll([valid_nom, valid_tel, valid_ville, valid_civilite, valid_adresse, valid_pays, valid_prenom]);
	var message:String = "";
	if (mode=='1'){
		if(!validators.length) {
			createItem();
			mode='0';
			Alert.show("Fiche ajoutée");
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
			updateItem(text_idtiers.text);
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
	onPrint_tiers();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idtiers.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idtiers.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idtiers.text==''){
			createItem();
		}else{
			updateItem(text_idtiers.text);
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





private function OpenConnexionpays():void{
var vConnexion:paysConnexion = paysConnexion(PopUpManager.createPopUp(this,paysConnexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.targetComplement = connexion_pays_complement;
vConnexion.categorie = "pays";
vConnexion.categorie_source = "tiers";
vConnexion.connexion_source = "pays";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionpaysItem():void{
var vpaysItem:paysItem = paysItem(PopUpManager.createPopUp(this,paysItem,true));
vpaysItem.text_cle.text =connexion_pays.text;
}





