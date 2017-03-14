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

private function createListeneraction(e:Event):void {
	event_action(e);
}

private function load():void {
	Alert.yesLabel = "Oui";
    Alert.noLabel = "Non";
	
	PopUpManager.centerPopUp(this);
	if(text_idaction.text==''){
		restactionRead.url = "actionRead.php?cle="+text_cle.text;	
	}else{
		restactionRead.url = "actionRead.php?idaction="+text_idaction.text;
	}
	restactionRead.send();
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
		//date_date_modification.text = sDate;
		text_creation_par.text = Application.application.gsUser;
		combo_annee.text = sYear;
	}else{
		//date_date_creation.text = dateFormat.format(date_date_creation.text);
		text_modification_par.text = Application.application.gsUser;
		date_date_modification.text = dateFormat.format(date_date_modification.text);
		date_date_fin.text = dateFormat.format(date_date_fin.text);
		date_date_debut.text = dateFormat.format(date_date_debut.text);
		text_duree.text = numberFormat.format(text_duree.text);

		send_selection();
		
		// Vérif permission
		restPermission.url = "script/permission.php?permission=update&table=action&group="+Application.application.gsGroup+"&id="+text_idaction.text;
		restPermission.send();
	}
	onLoad_action();	
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		btn_enregistrer.enabled = false;
		btn_appliquer.enabled = false;
	}
}

private function onCreate(e:ResultEvent):void {
	onCreate_action();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_action();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idaction:String):void {
	beforeUpdate_action();	
	restactionUpdate.url = "actionUpdate.php?id="+text_idaction.text+"&user="+Application.application.gsUser;
	restactionUpdate.send();
	//outerDocument.datagridaction.dataProvider.refresh();
	//restactionList.send();
}	

private function createItem():void {
	beforeCreate_action();	
	restactionCreate.url = "actionCreate.php";
	restactionCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_action():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	var i:uint;
	var validators:Array = Validator.validateAll([valid_nom, valid_statut]);
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
			updateItem(text_idaction.text);
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
	var validators:Array = Validator.validateAll([valid_nom, valid_statut]);
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
			updateItem(text_idaction.text);
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
	onPrint_action();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idaction.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idaction.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idaction.text==''){
			createItem();
		}else{
			updateItem(text_idaction.text);
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



private function initFile_fichier_joint():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_fichier_joint);
fileReferenceList.browse();
}
private function fileSelectedHandler_fichier_joint(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_fichier_joint);
fileReference.upload(urlRequest);
fichier_text_fichier_joint.text = "Uploading...";
}
private function uploadCompleteHandler_fichier_joint(event:Event):void {
fichier_text_fichier_joint.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_fichier_joint(event:MouseEvent):void {
	if(fichier_text_fichier_joint.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_fichier_joint.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}


private function OpenConnexiontype():void{
var vConnexion:action_typeConnexion = action_typeConnexion(PopUpManager.createPopUp(this,action_typeConnexion,true));
vConnexion.targetComponent = connexion_type;
vConnexion.targetComplement = connexion_type_complement;
vConnexion.categorie = "action_type";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "type";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexiontypeItem():void{
var vaction_typeItem:action_typeItem = action_typeItem(PopUpManager.createPopUp(this,action_typeItem,true));
vaction_typeItem.text_cle.text =connexion_type.text;
}

private function OpenConnexionsociete():void{
var vConnexion:societeConnexion = societeConnexion(PopUpManager.createPopUp(this,societeConnexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.targetComplement = connexion_societe_complement;
vConnexion.categorie = "societe";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "societe";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionsocieteItem():void{
var vsocieteItem:societeItem = societeItem(PopUpManager.createPopUp(this,societeItem,true));
vsocieteItem.text_cle.text =connexion_societe.text;
}

private function OpenConnexionprojet():void{
var vConnexion:projetConnexion = projetConnexion(PopUpManager.createPopUp(this,projetConnexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.targetComplement = connexion_projet_complement;
vConnexion.categorie = "projet";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "projet";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionprojetItem():void{
var vprojetItem:projetItem = projetItem(PopUpManager.createPopUp(this,projetItem,true));
vprojetItem.text_cle.text =connexion_projet.text;
}

private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,true));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,true));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}

private function OpenConnexionutilisateur():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.targetComplement = connexion_utilisateur_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "utilisateur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateurItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur.text;
}

private function OpenConnexionutilisateur_cc():void{
var vConnexion:utilisateurConnexion = utilisateurConnexion(PopUpManager.createPopUp(this,utilisateurConnexion,true));
vConnexion.targetComponent = connexion_utilisateur_cc;
vConnexion.targetComplement = connexion_utilisateur_cc_complement;
vConnexion.categorie = "utilisateur";
vConnexion.categorie_source = "action";
vConnexion.connexion_source = "utilisateur_cc";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionutilisateur_ccItem():void{
var vutilisateurItem:utilisateurItem = utilisateurItem(PopUpManager.createPopUp(this,utilisateurItem,true));
vutilisateurItem.text_cle.text =connexion_utilisateur_cc.text;
}





