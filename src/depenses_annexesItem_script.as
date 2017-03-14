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

private function createListenerdepenses_annexes(e:Event):void {
	event_depenses_annexes(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restdepenses_annexesRead.url = "depenses_annexesRead.php?cle="+text_cle.text;
			restdepenses_annexesRead.send();
			send_selection();
	// USER 
	if(Application.application.gsProfil =='user')
	{	
		text_num_comptable.enabled = false;
		text_montant_ht_196.enabled = false;
		text_montant_tva_196.enabled = false;
		text_montant_ht_55.enabled = false;
		text_montant_tva_55.enabled = false;
		text_montant_ht_7.enabled = false;
		text_montant_tva_7.enabled = false;
		text_total_ht.enabled = false;
		text_montant_na_tva.enabled = false;
		text_montant_ht.enabled = false;
		text_montant_tva.enabled = false;
		text_montant_ttc.enabled = false;
		date_regle_le.enabled = false;
		text_num_cheque.enabled = false;
		combo_validation.enabled = false;
		text_total_reglement.enabled = false;

		// statut grisé si le champs est remplis
		combo_statut.enabled = false;
		combo_statut_compta.enabled = false;
		combo_statut_compta_banque.enabled = false;
		combo_banque.enabled = false;
	}

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
	}
	onLoad_depenses_annexes();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_depenses_annexes();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_depenses_annexes();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(iddepenses_annexes:String):void {
	beforeUpdate_depenses_annexes();	
	restdepenses_annexesUpdate.url = "depenses_annexesUpdate.php?id="+text_iddepenses_annexes.text;
	restdepenses_annexesUpdate.send();
	//outerDocument.datagriddepenses_annexes.dataProvider.refresh();
	//restdepenses_annexesList.send();
}	

private function createItem():void {
	beforeCreate_depenses_annexes();	
	restdepenses_annexesCreate.url = "depenses_annexesCreate.php";
	restdepenses_annexesCreate.send();
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_depenses_annexes():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	combo_annee.text = date_date.text.substr(6,10);
	verif();
	if (text_iddepenses_annexes.text==''){
		var validators:Array = Validator.validateAll([valid_utilisateur, valid_date, valid_type_depense, valid_pays]);
		if(!validators.length) {
			/*
			// Ajouté par Jonathan le 20/01/2014
			if ((combo_type_depense.text=="Remboursement frais médecin")&&(connexion_tiers.text=='')){
				Alert.show("le champ Tiers est obligatoire"); 
			}else{
				updateItem(text_iddepenses_annexes.text);
				close();
			}
			
			if (Number(date_date.text.substr(6,10)) > 2012){
				// Modifié le 20/03/2013 par Marvin
				// Remplace text_montant_ttc par text_total_reglement
				if ((Number(text_total_reglement.text)>0)&&(text_num_cheque.text=='')){
					Alert.show("le champ \"N° de pièce\" du règlement est obligatoire"); 
				}else{
					createItem();
					close();
				}
			*/
			
			if (Number(date_date.text.substr(6,10)) > 2012){
				// Modifié le 20/03/2013 par Marvin
				// Remplace text_montant_ttc par text_total_reglement
				if ((Number(text_total_reglement.text)>0)&&(text_num_cheque.text=='')){
					Alert.show("le champ \"N° de pièce\" du règlement est obligatoire"); 
				}else{
					// Ajouté par Jonathan le 20/01/2014
					if ((combo_type_depense.text=="Remboursement frais médecin")&&(connexion_tiers.text=='')){
						Alert.show("le champ Tiers est obligatoire"); 
					}else{
						createItem();
						close();
					}
				}
			}else{
				createItem();
				close();
				}
			}
	}else{
		
		if (Number(date_date.text.substr(6,10)) > 2012){
			if ( (Number(text_total_reglement.text)>0) && (text_num_cheque.text=='') ){
				Alert.show("le champ \"N° de pièce\" du règlement est obligatoire");
			}else{
				// Ajouté par Jonathan le 20/01/2014
				if ((combo_type_depense.text=="Remboursement frais médecin")&&(connexion_tiers.text=='')){
					Alert.show("le champ Tiers est obligatoire"); 
				}else{
					updateItem(text_iddepenses_annexes.text);
					close();
				}
			}
		}else{
			updateItem(text_iddepenses_annexes.text);
			close();
		}
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (text_iddepenses_annexes.text==''){
	var validators:Array = Validator.validateAll([valid_utilisateur, valid_date, valid_type_depense]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_iddepenses_annexes.text);
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
	onPrint_depenses_annexes();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_iddepenses_annexes.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_iddepenses_annexes.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_iddepenses_annexes.text==''){
			createItem();
		}else{
			updateItem(text_iddepenses_annexes.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_pj():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj);
fileReference.upload(urlRequest);
fichier_text_pj.text = "Uploading...";
}
private function uploadCompleteHandler_pj(event:Event):void {
fichier_text_pj.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj(event:MouseEvent):void {
	if(fichier_text_pj.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}


private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}

private function OpenConnexionprojet():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.categorie = "projet";
}

private function OpenConnexiontiers():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_tiers;
vConnexion.categorie = "tiers";
}

private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

private function verif():void{
	// Condition ajoutée le 20/03/2013 par Marvin
	//Alert.show("Vérif");
	if((Number(text_total_reglement.text)!=0)||(Number(text_montant_ttc.text)!=0)){
		if(Number(text_montant_restant_du.text)==0){
			combo_statut.text = 'Réglé';
		}else{
			combo_statut.text = 'A régler';
		}
	}
	//Alert.show("Vérif 2");
	if((combo_statut_compta.text==null)||(combo_statut_compta.text=='')){
		if((Number(combo_compte_charge.text)>0)||(Number(combo_compte_tva.text)>0)||(Number(combo_compte_charge_pas_tva.text)>0)){
			combo_statut_compta.text = 'A comptabiliser';
		}
	}
	
	//Alert.show("Vérif 3");
	//if((combo_statut_compta_banque.text==null)||(combo_statut_compta_banque.text=='')){
	//	if(Number(text_total_reglement.text)>0){
	//		combo_statut_compta_banque.text = 'A comptabiliser';
	//	}
	//}
	if (combo_statut_compta_banque.text != 'Comptabilisée'){
		if(Number(text_total_reglement.text)>0){
			combo_statut_compta_banque.text = 'A comptabiliser';
		}else{
			combo_statut_compta_banque.text = null;
		}
	}
}