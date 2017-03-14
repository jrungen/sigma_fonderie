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

import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;
// Nouveau numéro
private var restHttp_numero:mx.rpc.http.HTTPService = new mx.rpc.http.HTTPService();
 
private function numero():void{
      // Création de l'HTTPService pour le bouton dupliquer
        restHttp_numero.url = "numero.php?table=facture_fournisseur&annee="+date_date_facture.text.substr(6,4)+"&mois="+date_date_facture.text.substr(3,2);
        restHttp_numero.method = "POST";
        restHttp_numero.addEventListener("result", resultHTTP_numero_result);
        restHttp_numero.send();
}
 
private function resultHTTP_numero_result(e:ResultEvent):void {
	// Récupérer le numéro
	var sYearFacture:String = date_date_facture.text.substr(6,10);
	if(Number(sYearFacture)>2012){
		if(text_numero.text==''){
			text_numero.text = restHttp_numero.lastResult.autoincrement.nouveau.numero;
			//text_cle.text = text_numero.text;
		}
	}
	
	if(text_idfacture_fournisseur.text==''){
		restfacture_fournisseurCreate.url = "facture_fournisseurCreate.php";
		restfacture_fournisseurCreate.send();	
	}else{
		restfacture_fournisseurUpdate.url = "facture_fournisseurUpdate.php?id="+text_idfacture_fournisseur.text;
		restfacture_fournisseurUpdate.send();
	}
	close();
}
 
private function rest_connexion_fournisseur_send():void
{
	//Alert.show('rest_connexion_fournisseur_send');
	rest_connexion_fournisseur.url = "fournisseurList.php?field=cle&search="+connexion_fournisseur.text+"&view=Par défaut";
    rest_connexion_fournisseur.send();

}
private function rest_connexion_fournisseur_result():void
{
    if(connexion_pays.text==''){
    	connexion_pays.text = rest_connexion_fournisseur.lastResult.fournisseurList.item.pays;
    }

}

private function createListenerfacture_fournisseur(e:Event):void {
	event_facture_fournisseur(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restfacture_fournisseurRead.url = "facture_fournisseurRead.php?cle="+text_cle.text;
			restfacture_fournisseurRead.send();
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
	}
		// USER 
	if(Application.application.gsProfil =='user')
	{
		text_montant_ht_19_6.enabled = false;
		text_montant_ht_55.enabled = false;
		text_montant_tva_19_6.enabled = false;
		text_montant_ht_0.enabled = false;
		text_montant_tva_55.enabled = false;
		text_montant_ht.enabled = false;
		text_frais_port_ht.enabled = false;
		text_montant_tva.enabled = false;
		text_Remise.enabled = false;
		text_frais_port.enabled = false;
		text_montant_ttc.enabled = false;
		text_total_regle.enabled = false;
		text_montant_restant_du.enabled = false;
		btn_parcourir_pj.enabled = false;
		text_commission_ht.enabled = false;
		text_tva_s_commission.enabled = false;
		text_tva_s_commission_55.enabled = false;
		text_ttc_commission.enabled = false;
		text_montant_ht_locale.enabled = false;
		text_montant_tva_locale.enabled = false;
		text_taxe_pays.enabled = false;
		text_taxe_pays_reduit.enabled = false;
		text_montant_ht_locale_reduit.enabled = false;
		text_montant_tva_locale_reduit.enabled = false;
		combo_facture_regle.enabled = false;
		combo_validation.enabled = false;
		btn_Delete_FactureFournisseur.enabled=false;
		text_numero.enabled=false;
		date_date_facture.enabled = false;
		text_montant_ht_7.enabled = false;
		combo_compte_charge.enabled = false;
		combo_compte_tva.enabled = false;
		text_montant_restant_du_facturation.enabled = false;
		memo_note_comptable.enabled = false;
		text_montant_tva_7.enabled = false;
		text_tva_s_commission_locale.enabled = false;
		combo_statut_compta.enabled = false;
	}

	onLoad_facture_fournisseur();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_facture_fournisseur();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_fournisseur();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfacture_fournisseur:String):void {
	beforeUpdate_facture_fournisseur();	
	numero();
}	

private function createItem():void {
	beforeCreate_facture_fournisseur();
	// A Activer le 01/01/2013
	numero();

}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_facture_fournisseur():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	
		combo_annee.text = date_date_facture.text.substr(6,10);
		verif();
		if(text_fourniseur.text==''){
			text_fourniseur.text = connexion_fournisseur.text;
		}

	if (text_idfacture_fournisseur.text==''){
		var validators:Array = Validator.validateAll([valid_connexion_fournisseur,valid_connexion_pays]);
		if(!validators.length) {
			createItem();
			
		}
	}else{
		updateItem(text_idfacture_fournisseur.text);
		
	}
}

// Btn_appliquer	
private function appliquer():void {
	if (text_idfacture_fournisseur.text==''){
	var validators:Array = Validator.validateAll([valid_connexion_fournisseur,valid_connexion_pays]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idfacture_fournisseur.text);
		Alert.show("Fiche modifiée");
	}
}

// Btn_fermer
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
	onPrint_facture_fournisseur();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idfacture_fournisseur.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idfacture_fournisseur.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idfacture_fournisseur.text==''){
			createItem();
		}else{
			updateItem(text_idfacture_fournisseur.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
	restFactureFournisseur.url = "FactureFournisseur_Vue.php?cle="+text_cle.text;
restFactureFournisseur.send();

} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function AddFactureFournisseur():void{
var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
vfacture_fournisseur_ligneItem.text_idfacture_fournisseur_ligne.text = '';
vfacture_fournisseur_ligneItem.connexion_facture_fournisseur.text = text_cle.text ;
vfacture_fournisseur_ligneItem.combo_type_depenses.data = combo_item.text;
vfacture_fournisseur_ligneItem.text_cas.data =text_cas.text;
refresh = 'REFRESH';
}

private function Delete_FactureFournisseur(id:String):void{
restDelete.url = "delete.php?categorie=facture_fournisseur_ligne&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFactureFournisseur():void{
var vfacture_fournisseur_ligneItem:facture_fournisseur_ligneItem = facture_fournisseur_ligneItem(PopUpManager.createPopUp(this,facture_fournisseur_ligneItem,true));
vfacture_fournisseur_ligneItem.text_cle.text = datagrid_FactureFournisseur.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FactureFournisseur(data:Object, col:AdvancedDataGridColumn):Object{
if (data["statut"]=='A régler') return{color:0xFF0000,fontWeight:"bold"} ;

return null;
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


private function OpenConnexionprojet():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_projet;
vConnexion.categorie = "projet";
}

private function OpenConnexionutilisateur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_utilisateur;
vConnexion.categorie = "utilisateur";
}

private function OpenConnexionpays():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_pays;
vConnexion.categorie = "pays";
}

private function OpenConnexionfournisseur():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.categorie = "fournisseur";
}

private function verif():void{
	
	if((combo_statut_compta.text=='')||(combo_statut_compta.text=='0')||(combo_statut_compta.text==null)){
		trace('combo_statut_compta');
		if((Number(combo_compte_charge.text)>0)||(Number(combo_compte_tva.text)>0)){
			combo_statut_compta.text = 'A comptabiliser';
		}
	}
}
