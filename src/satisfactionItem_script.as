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
private var serverSideScript:String = "upload.php?table=satisfaction";

private function createListenersatisfaction(e:Event):void {
	event_satisfaction(e);
}

private function load():void {
	Alert.yesLabel = "Oui";
    Alert.noLabel = "Non";
	
	PopUpManager.centerPopUp(this);
	if(text_idsatisfaction.text==''){
		restsatisfactionRead.url = "satisfactionRead.php?cle="+text_cle.text;	
	}else{
		restsatisfactionRead.url = "satisfactionRead.php?idsatisfaction="+text_idsatisfaction.text;
	}
	restsatisfactionRead.send();
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
text_ca_ht.text = numberFormat.format(text_ca_ht.text);
date_date_preparation.text = dateFormat.format(date_date_preparation.text);
date_date_realisation.text = dateFormat.format(date_date_realisation.text);

		send_selection();
		
		// Vérif permission
		restPermission.url = "script/permission.php?permission=update&table=satisfaction&group="+Application.application.gsGroup+"&id="+text_idsatisfaction.text;
		restPermission.send();
	}
	onLoad_satisfaction();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_satisfaction();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_satisfaction();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idsatisfaction:String):void {
	beforeUpdate_satisfaction();	
	restsatisfactionUpdate.url = "satisfactionUpdate.php?id="+text_idsatisfaction.text+"&user="+Application.application.gsUser;
	restsatisfactionUpdate.send();
	//outerDocument.datagridsatisfaction.dataProvider.refresh();
	//restsatisfactionList.send();
}	

private function createItem():void {
	beforeCreate_satisfaction();	
	restsatisfactionCreate.url = "satisfactionCreate.php";
	restsatisfactionCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_satisfaction():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	var i:uint;
	var validators:Array = Validator.validateAll([valid_fournisseur, valid_projet, valid_utilisateur]);
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
			updateItem(text_idsatisfaction.text);
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
	var validators:Array = Validator.validateAll([valid_fournisseur, valid_projet, valid_utilisateur]);
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
			updateItem(text_idsatisfaction.text);
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
	onPrint_satisfaction();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idsatisfaction.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idsatisfaction.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idsatisfaction.text==''){
			createItem();
		}else{
			updateItem(text_idsatisfaction.text);
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





private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,true));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}

private function OpenConnexionprojet():void{
var vConnexion:projetConnexion = projetConnexion(PopUpManager.createPopUp(this,projetConnexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.targetComplement = connexion_projet_complement;
vConnexion.categorie = "projet";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "projet";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionprojetItem():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text =connexion_projet.text;
}

private function OpenConnexionutilisateur():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.targetComplement = connexion_utilisateur_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "utilisateur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateurItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur.text;
}

private function OpenConnexioneval_preparation():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_eval_preparation;
vConnexion.targetComplement = connexion_eval_preparation_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "eval_preparation";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexioneval_preparationItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_eval_preparation.text;
}

private function OpenConnexioneval_realisation():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_eval_realisation;
vConnexion.targetComplement = connexion_eval_realisation_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "satisfaction";
vConnexion.connexion_source = "eval_realisation";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexioneval_realisationItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_eval_realisation.text;
}





