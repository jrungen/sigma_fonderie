import flash.net.navigateToURL;
import flash.system.System;
import mx.charts.DateTimeAxis;
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
//private var serverSideScript:String = "upload.php";
// JR 19/05/2014 MAJ du système d'upload des fichiers
private var serverSideScript:String = "upload.php?id="+hour();

private function hour():String{
	var CurrentDateTime:Date = new Date();
	var CurrentDF:DateFormatter = new DateFormatter();
	CurrentDF.formatString = "YYYYMMDDHH";
	var DateTimeString:String = CurrentDF.format(CurrentDateTime);
	vIDUpload = DateTimeString;
	return vIDUpload;
}

private function createListenerprojet(e:Event):void {
	event_projet(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
	restprojetRead.url = "projetRead.php?cle="+text_cle.text;
	restprojetRead.send();
	send_selection();

	if(mode=='0'){
		if (Application.application.gsProfil =='user'){
			btn_connexion_pays_projet.enabled = false;
			text_lieu.enabled = false;
			btn_connexion_client.enabled = false;
		}
	}
}

private function onLoad(e:ResultEvent):void {
	// Si création de fiche
		var dateFormat:DateFormatter = new DateFormatter();
		dateFormat.formatString = "DD/MM/YYYY";
		var sDate:String = dateFormat.format(new Date());
		var sYear:String = sDate.substr(6,10);
	
	if(Application.application.gsProfil =='admin'){
		form_text_pays_client.enabled = true;
		form_text_cas.enabled = true;
	}
	if(mode=='1'){
		text_creation_par.text = Application.application.gsUser;
		date_date_creation.text = sDate;
		combo_annee.text = sYear;
		//met à zero lez champs recette previsionnel
		text_recette1_previsionnelle.text = '0';
		text_recette2_previsionnelle.text = '0';
	}else{
		text_modification_par.text = Application.application.gsUser;
		date_date_modification.selectedDate = new Date();
	}
	
	if(combo_type.text=='PRESTATION SERVICES'){
		hbox_depense_annexe_ta.visible=false;
		hbox_depense_annexe_btn.visible=false;
	}
	onLoad_projet();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_projet();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_projet();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idprojet:String):void {
	beforeUpdate_projet();	
	restprojetUpdate.url = "projetUpdate.php?id="+text_idprojet.text;
	restprojetUpdate.send();
	//outerDocument.datagridprojet.dataProvider.refresh();
	//restprojetList.send();
}	
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;


// Nouveau numéro
private var restHttp_numero:mx.rpc.http.HTTPService = new mx.rpc.http.HTTPService();
 
private function numero():void{
     // Création de l'HTTPService pour le bouton dupliquer
    restHttp_numero.url = "numero.php?table=projet&date_debut="+date_datedebut.text;
    restHttp_numero.method = "POST";
    restHttp_numero.addEventListener("result", resultHTTP_numero_result);
    restHttp_numero.send();
}
 
private function resultHTTP_numero_result(e:ResultEvent):void {
      // Récupérer le numéro
      text_numero.text = restHttp_numero.lastResult.autoincrement.nouveau.numero;
      text_cle.text = text_numero.text+"-"+text_numero_code.text;
  	// Création de la fiche
	restprojetCreate.url = "projetCreate.php";
	restprojetCreate.send();	
}

private function createItem():void {
	//beforeCreate_projet();
	if(text_numero.text==''){
		numero();
	}
}

	
//Gestion du menu prinipale 

// Actualiser
private function refresh_projet():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
		combo_annee.text = date_datedebut.text.substr(6,10);
verif()
	if (text_idprojet.text==''){
		var validators:Array = Validator.validateAll([valid_datedebut, valid_societe, valid_datefin, valid_lieu, valid_nom, valid_type, valid_utilisateur, valid_numero_code, valid_nb_reunion_prev, valid_nb_reunion_confirme, valid_comptable, valid_libelle,valid_connexion_pays, valid_departement]);
		if(!validators.length) {
			// Budget prévisionnel TA et PE-PS doit être > 0 si localisation = Autre
			if(combo_type.text=='AUTRES'){
				if((Number(text_recette1_previsionnelle.text) <= 0)||(Number(text_recette2_previsionnelle.text) <= 0)){
					Alert.show('Le budget prévisionnel TA et PE-PS doit être > 0 car la localisation est << Autre >>');
				}else{
					createItem();
					close();
				}
			}else{
			// Budget prévisionnel PE-PS doit être > 0 si localisation = PS
				if(Number(text_recette2_previsionnelle.text) <= 0){
					Alert.show('Le budget prévisionnel PE-PS doit être > 0 car la localisation est << PRESTATION SERVICES >>');
				}else{
					createItem();
					close();
				}

			}
		}
	}else{
		updateItem(text_idprojet.text);
		close();
	}
}



// Btn_appliquer	
private function appliquer():void {
	if (text_idprojet.text==''){
	var validators:Array = Validator.validateAll([valid_datedebut, valid_societe, valid_datefin, valid_lieu, valid_nom, valid_type, valid_utilisateur, valid_numero_code, valid_nb_reunion_prev, valid_nb_reunion_confirme, valid_comptable, valid_departement]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idprojet.text);
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
	onPrint_projet();	
}

private function imprimerHTML():void {
	navigateToURL( new URLRequest( 'modele/synthese.php?cle='+text_cle.text+'&tri='+combo_impression_tri_synthese.text), "_blank" );
}
/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idprojet.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idprojet.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idprojet.text==''){
			createItem();
		}else{
			updateItem(text_idprojet.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
restProjetFctAvFournisseurPrestationsEvenementielles.url = "ProjetFctAvFournisseurPrestationsEvenementielles_Vue.php?cle="+text_cle.text;
restProjetFctAvFournisseurPrestationsEvenementielles.send();
restProjetFactureFournisseurPrestationsEvenementielles.url = "ProjetFactureFournisseurPrestationsEvenementielles_Vue.php?cle="+text_cle.text;
restProjetFactureFournisseurPrestationsEvenementielles.send();
restProjetFactureAvoirFournisseurTourismeAffaire.url = "ProjetFactureAvoirFournisseurTourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureAvoirFournisseurTourismeAffaire.send();
restProjetFactureFournisseurTourismeAffaire.url = "ProjetFactureFournisseurTourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureFournisseurTourismeAffaire.send();
restProjetFactureAvoirsClientPrestationEvenementielle.url = "ProjetFactureAvoirsClientPrestationEvenementielle_Vue.php?cle="+text_cle.text;
restProjetFactureAvoirsClientPrestationEvenementielle.send();
restProjetFactureAvoirClientTourismeAffaire.url = "ProjetFactureAvoirClientTourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureAvoirClientTourismeAffaire.send();
restProjetFactureClientTourismeAffaire.url = "ProjetFactureClientTourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureClientTourismeAffaire.send();
restProjetFactureDepensesAnnexesPEPS.url = "ProjetFactureDepensesAnnexesPEPS_Vue.php?cle="+text_cle.text;
restProjetFactureDepensesAnnexesPEPS.send();
restProjetFactureDepensesAnnexesTA.url = "ProjetFactureDepensesAnnexesTA_Vue.php?cle="+text_cle.text;
restProjetFactureDepensesAnnexesTA.send();
restProjetFactureAutrestourismeAffaire.url = "ProjetFactureAutrestourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureAutrestourismeAffaire.send();
restProjetFactureClientAutrePrestationEvenementielle.url = "ProjetFactureClientAutrePrestationEvenementielle_Vue.php?cle="+text_cle.text;
restProjetFactureClientAutrePrestationEvenementielle.send();
restProjetFactureClientAccTourismeAffaire.url = "ProjetFactureClientAccTourismeAffaire_Vue.php?cle="+text_cle.text;
restProjetFactureClientAccTourismeAffaire.send();
restProjetFactureAvoirsClientPrestationServices.url = "ProjetFactureAvoirsClientPrestationServices_Vue.php?cle="+text_cle.text;
restProjetFactureAvoirsClientPrestationServices.send();
restProjetFactureClientAutrePrestationServices.url = "ProjetFactureClientAutrePrestationServices_Vue.php?cle="+text_cle.text;
restProjetFactureClientAutrePrestationServices.send();
restProjetFactureFournisseurPrestationsServices.url = "ProjetFactureFournisseurPrestationsServices_Vue.php?cle="+text_cle.text;
restProjetFactureFournisseurPrestationsServices.send();
restProjetFctAvFournisseurPrestationsServices.url = "ProjetFctAvFournisseurPrestationsServices_Vue.php?cle="+text_cle.text;
restProjetFctAvFournisseurPrestationsServices.send();
restProjetFactureClientPrestationService.url = "ProjetFactureClientPrestationService_Vue.php?cle="+text_cle.text;
restProjetFactureClientPrestationService.send();
restProjetFactureClientPrestationEvenementielle.url = "ProjetFactureClientPrestationEvenementielle_Vue.php?cle="+text_cle.text;
restProjetFactureClientPrestationEvenementielle.send();
restProjetAction.url = "ProjetAction_Vue.php?cle="+text_cle.text;
restProjetAction.send();
restprojetSatisfaction.url = "projetSatisfaction_Vue.php?cle="+text_cle.text;
restprojetSatisfaction.send();
} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function AddProjetFctAvFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation événementielles";
vfacture_fournisseurItem.combo_type.data = "Factures d'avoirs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFctAvFournisseurPrestationsEvenementielles(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFctAvFournisseurPrestationsEvenementielles_result);
}
private function Delete_ProjetFctAvFournisseurPrestationsEvenementielles_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFctAvFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFctAvFournisseurPrestationsEvenementielles(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation événementielles";
vfacture_fournisseurItem.combo_type.data = "Factures fournisseurs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureFournisseurPrestationsEvenementielles(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureFournisseurPrestationsEvenementielles_result);
}
private function Delete_ProjetFactureFournisseurPrestationsEvenementielles_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFactureFournisseurPrestationsEvenementielles.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}
private function UpdateProjetFactureFournisseurPrestationsEvenementielles():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurPrestationsEvenementielles.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureFournisseurPrestationsEvenementielles(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation Tourisme d'affaires";
vfacture_fournisseurItem.combo_type.data = "Factures d'avoirs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureAvoirFournisseurTourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureAvoirFournisseurTourismeAffaire_result);
}

private function Delete_ProjetFactureAvoirFournisseurTourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureAvoirFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureAvoirFournisseurTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation Tourisme d'affaires";
vfacture_fournisseurItem.combo_type.data = "Factures fournisseurs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureFournisseurTourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureFournisseurTourismeAffaire_result);
}

private function Delete_ProjetFactureFournisseurTourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFactureFournisseurTourismeAffaire.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureFournisseurTourismeAffaire():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurTourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureFournisseurTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirsClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation événementielles";
vfacture_clientItem.combo_type.data = "Facture d'avoir client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureAvoirsClientPrestationEvenementielle(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureAvoirsClientPrestationEvenementielle_result);
}

private function Delete_ProjetFactureAvoirsClientPrestationEvenementielle_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureAvoirsClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureAvoirsClientPrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation tourisme d'affaires";
vfacture_clientItem.combo_type.data = "Facture d'avoir client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureAvoirClientTourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureAvoirClientTourismeAffaire_result);
}

private function Delete_ProjetFactureAvoirClientTourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureAvoirClientTourismeAffaire.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureAvoirClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirClientTourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureAvoirClientTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation tourisme d'affaires";
vfacture_clientItem.combo_type.data = "Facture client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.mode='1';
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientTourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientTourismeAffaire_result);
}

private function Delete_ProjetFactureClientTourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientTourismeAffaire.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureClientTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientTourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureDepensesAnnexesPEPS():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_iddepenses_annexes.text = '';
vdepenses_annexesItem.connexion_projet.text = text_cle.text ;
vdepenses_annexesItem.combo_objet.data = "Prestation Evenementielles";
vdepenses_annexesItem.connexion_utilisateur.data = connexion_utilisateur.text ;
vdepenses_annexesItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureDepensesAnnexesPEPS(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureDepensesAnnexesPEPS_result);
}

private function Delete_ProjetFactureDepensesAnnexesPEPS_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=depenses_annexes&id="+datagrid_ProjetFactureDepensesAnnexesPEPS.selectedItem.iddepenses_annexes;
		restDelete.send();
		send_selection();
	}else{
	}
}
private function UpdateProjetFactureDepensesAnnexesPEPS():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_cle.text = datagrid_ProjetFactureDepensesAnnexesPEPS.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureDepensesAnnexesPEPS(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

// ajouter par Jonathan
private function AddProjetAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.mode= '1';
vactionItem.text_idaction.text = '';
vactionItem.connexion_projet.text = text_cle.text;
vactionItem.connexion_projet_complement.text = text_cle.text;
vactionItem.connexion_utilisateur.data = connexion_utilisateur.text;
refresh = 'REFRESH';
}

private function Delete_ProjetAction(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetAction_result);
}

private function Delete_ProjetAction_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=action&id="+datagrid_ProjetAction.selectedItem.idaction;
		restDelete.send();
		send_selection();
	}else{
	
	}

}

/*
private function Delete_ProjetAction(id:String):void{
restDelete.url = "delete.php?categorie=action&id="+id;
restDelete.send();
send_selection();
}

private function Delete_commandeVenteprod():void{
	restPermissioncommandeVenteprod.url = "script/permission.php?permission=delete&table=venteprod&group="+Application.application.gsGroup+"&id="+datagrid_commandeVenteprod.selectedItem.idventeprod;
	restPermissioncommandeVenteprod.send();
}

private function permissioncommandeVenteprodResult(e:ResultEvent):void {
	if(restPermissioncommandeVenteprod.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_commandeVenteprod_result);
	}
}

private function delete_commandeVenteprod_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = 'delete.php?categorie=venteprod&id='+datagrid_commandeVenteprod.selectedItem.idventeprod;
		restDelete.send();
		send_selection();
	}else{
	
	}
}
*/
private function UpdateProjetAction():void{
var vactionItem:actionItem = actionItem(PopUpManager.createPopUp(this,actionItem,true));
vactionItem.text_cle.text = datagrid_ProjetAction.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetAction(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

// ajouter par Jonathan 17/03/2014
private function AddprojetSatisfaction():void{
var vsatisfactionItem:satisfactionItem = satisfactionItem(PopUpManager.createPopUp(this,satisfactionItem,true));
vsatisfactionItem.mode= '1';
vsatisfactionItem.text_idsatisfaction.text = '';
vsatisfactionItem.connexion_projet.text = text_cle.text;
vsatisfactionItem.connexion_projet_complement.text = text_cle.text;
vsatisfactionItem.connexion_utilisateur.data = connexion_utilisateur.text;
vsatisfactionItem.connexion_utilisateur_complement.data = connexion_utilisateur.text;
refresh = 'REFRESH';
}

private function Delete_projetSatisfaction(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_projetSatisfaction_result);
}

private function Delete_projetSatisfaction_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=satisfaction&id="+datagrid_projetSatisfaction.selectedItem.idsatisfaction;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateprojetSatisfaction():void{
var vsatisfactionItem:satisfactionItem = satisfactionItem(PopUpManager.createPopUp(this,satisfactionItem,true));
vsatisfactionItem.text_cle.text = datagrid_projetSatisfaction.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_projetSatisfaction(data:Object, col:AdvancedDataGridColumn):Object{
return null;
}

private function AddProjetFactureDepensesAnnexesTA():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_iddepenses_annexes.text = '';
vdepenses_annexesItem.connexion_projet.text = text_cle.text ;
vdepenses_annexesItem.combo_objet.data = "Prestation Tourisme d'affaires";
vdepenses_annexesItem.connexion_utilisateur.data = connexion_utilisateur.text ;
vdepenses_annexesItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureDepensesAnnexesTA(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureDepensesAnnexesTA_result);
}

private function Delete_ProjetFactureDepensesAnnexesTA_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=depenses_annexes&id="+datagrid_ProjetFactureDepensesAnnexesTA.selectedItem.iddepenses_annexes;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureDepensesAnnexesTA():void{
var vdepenses_annexesItem:depenses_annexesItem = depenses_annexesItem(PopUpManager.createPopUp(this,depenses_annexesItem,true));
vdepenses_annexesItem.text_cle.text = datagrid_ProjetFactureDepensesAnnexesTA.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureDepensesAnnexesTA(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAutrestourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation tourisme d'affaires";
vfacture_clientItem.combo_type.data = "Facture autre";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureAutrestourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureAutrestourismeAffaire_result);
}

private function Delete_ProjetFactureAutrestourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureAutrestourismeAffaire.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureAutrestourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAutrestourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureAutrestourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAutrePrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation événementielles";
vfacture_clientItem.combo_type.data = "Facture autre";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientAutrePrestationEvenementielle(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientAutrePrestationEvenementielle_result);
}

private function Delete_ProjetFactureClientAutrePrestationEvenementielle_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientAutrePrestationEvenementielle.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureClientAutrePrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAutrePrestationEvenementielle.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientAutrePrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAccTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation tourisme d'affaires";
vfacture_clientItem.combo_type.data = "Facture accompagnant";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientAccTourismeAffaire(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientAccTourismeAffaire_result);
}

private function Delete_ProjetFactureClientAccTourismeAffaire_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientAccTourismeAffaire.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureClientAccTourismeAffaire():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAccTourismeAffaire.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientAccTourismeAffaire(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureAvoirsClientPrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation de services";
vfacture_clientItem.combo_type.data = "Facture d'avoir client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureAvoirsClientPrestationServices(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureAvoirsClientPrestationServices_result);
}

private function Delete_ProjetFactureAvoirsClientPrestationServices_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureAvoirsClientPrestationServices.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureAvoirsClientPrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureAvoirsClientPrestationServices.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureAvoirsClientPrestationServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientAutrePrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation de services";
vfacture_clientItem.combo_type.data = "Facture autre";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientAutrePrestationServices(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientAutrePrestationServices_result);
}

private function Delete_ProjetFactureClientAutrePrestationServices_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientAutrePrestationServices.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}
private function UpdateProjetFactureClientAutrePrestationServices():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientAutrePrestationServices.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientAutrePrestationServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation de services";
vfacture_fournisseurItem.combo_type.data = "Factures fournisseurs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureFournisseurPrestationsServices(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureFournisseurPrestationsServices_result);
}

private function Delete_ProjetFactureFournisseurPrestationsServices_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFactureFournisseurPrestationsServices.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFactureFournisseurPrestationsServices.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureFournisseurPrestationsServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFctAvFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_idfacture_fournisseur.text = '';
vfacture_fournisseurItem.connexion_projet.text = text_cle.text ;
vfacture_fournisseurItem.combo_objet.data = "Prestation de services";
vfacture_fournisseurItem.combo_type.data = "Factures d'avoirs";
vfacture_fournisseurItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_fournisseurItem.combo_facture_regle.data = 'A régler';
vfacture_fournisseurItem.text_cas.data = text_cas.text;
vfacture_fournisseurItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFctAvFournisseurPrestationsServices(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFctAvFournisseurPrestationsServices_result);
}

private function Delete_ProjetFctAvFournisseurPrestationsServices_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_fournisseur&id="+datagrid_ProjetFctAvFournisseurPrestationsServices.selectedItem.idfacture_fournisseur;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFctAvFournisseurPrestationsServices():void{
var vfacture_fournisseurItem:facture_fournisseurItem = facture_fournisseurItem(PopUpManager.createPopUp(this,facture_fournisseurItem,true));
vfacture_fournisseurItem.text_cle.text = datagrid_ProjetFctAvFournisseurPrestationsServices.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFctAvFournisseurPrestationsServices(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientPrestationService():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation de services";
vfacture_clientItem.combo_type.data = "Facture client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode='1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientPrestationService(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientPrestationService_result);
}

private function Delete_ProjetFactureClientPrestationService_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientPrestationService.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureClientPrestationService():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientPrestationService.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientPrestationService(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddProjetFactureClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_idfacture_client.text = '';
vfacture_clientItem.connexion_projet.text = text_cle.text ;
vfacture_clientItem.combo_objet.data = "Prestation événementielles";
vfacture_clientItem.combo_type.data = "Facture client";
vfacture_clientItem.connexion_utilisateur.data = connexion_utilisateur.text;
vfacture_clientItem.connexion_societe.data = connexion_societe.text;
vfacture_clientItem.text_cas.data = text_cas.text;
vfacture_clientItem.text_pays_projet.text = connexion_pays.text;
vfacture_clientItem.mode = '1';
refresh = 'REFRESH';
}

private function Delete_ProjetFactureClientPrestationEvenementielle(id:String):void{
	Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, Delete_ProjetFactureClientPrestationEvenementielle_result);
}

private function Delete_ProjetFactureClientPrestationEvenementielle_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=facture_client&id="+datagrid_ProjetFactureClientPrestationEvenementielle.selectedItem.idfacture_client;
		restDelete.send();
		send_selection();
	}else{
	}
}

private function UpdateProjetFactureClientPrestationEvenementielle():void{
var vfacture_clientItem:facture_clientItem = facture_clientItem(PopUpManager.createPopUp(this,facture_clientItem,true));
vfacture_clientItem.text_cle.text = datagrid_ProjetFactureClientPrestationEvenementielle.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_ProjetFactureClientPrestationEvenementielle(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}



private function initFile_pj1_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj1_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj1_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj1_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj1_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj1_previsionnelle(event:Event):void {
fichier_text_pj1_previsionnelle.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj1_previsionnelle(event:MouseEvent):void {
	if(fichier_text_pj1_previsionnelle.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj1_previsionnelle.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}
private function initFile_pj3_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj3_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj3_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj3_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj3_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj3_previsionnelle(event:Event):void {
fichier_text_pj3_previsionnelle.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj3_previsionnelle(event:MouseEvent):void {
	if(fichier_text_pj3_previsionnelle.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj3_previsionnelle.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}
private function initFile_pj2_previsionnelle():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj2_previsionnelle);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj2_previsionnelle(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj2_previsionnelle);
fileReference.upload(urlRequest);
fichier_text_pj2_previsionnelle.text = "Uploading...";
}
private function uploadCompleteHandler_pj2_previsionnelle(event:Event):void {
fichier_text_pj2_previsionnelle.text = vIDUpload+ '-' +event.target.name;
}
public function openNewWindow_pj2_previsionnelle(event:MouseEvent):void {
	if(fichier_text_pj3_previsionnelle.text!=''){
		var u:URLRequest = new URLRequest("files/"+fichier_text_pj2_previsionnelle.text);
		navigateToURL(u,"_blank");
	}else{
		Alert.show('Aucun fichier lié');
	}
}


private function OpenConnexionsociete():void{
var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
vConnexion.targetComponent = connexion_societe;
vConnexion.categorie = "societe";
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

private function verif():void {
	var vPaysClient:String = text_pays_client.text;
	var vCas:String = text_cas.text;
	var vErreur:String = '';
	
	//A- Client France Projet France :
	if(vCas == 'A'){
		if(vPaysClient!='France'){
			vErreur = 'Le pays du client facturé ne correspond pas au cas A du projet.'
		}
	}
	
	//B- Client hors UE  Projet Hors UE :
	if(vCas == 'B'){
		if((connexion_pays.text=='Allemagne') || (connexion_pays.text=='Autriche')  || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='France') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie') || (connexion_pays.text=='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas B du projet.'
		}
	}

	//C -  Client France - Projet HORS UE
	if(vCas=='C')
	{
		if((connexion_pays.text=='France') ||(connexion_pays.text=='Allemagne') || (connexion_pays.text=='Autriche')  || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie') || (connexion_pays.text=='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas C du projet.'
		}
	}
					
	//D -   Client UE - Projet France
	if(vCas=='D')
	{
		if(connexion_pays.text!='France')
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas D du projet.'
		}
	}
	
	//E -    Client UE - Projet UE
	if(vCas=='E')
	{
		if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche') && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie')&& (connexion_pays.text!='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas E du projet.'
		}
	}

	//F-  Client France - Projet UE HORS FRANCE
	if(vCas=='F')
	{
		if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche') && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie')&& (connexion_pays.text!='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas F du projet.'
		}
	}
	
	//G- Client UE - Projet Hors UE
	if(vCas=='G')
	{
		if((connexion_pays.text=='Allemagne') || (connexion_pays.text=='Autriche')  || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='France') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie') || (connexion_pays.text=='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas G du projet.'
		}
	}

	//H- Client HORS UE - Projet UE
	if(vCas=='H')
	{
		if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche') && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie')&& (connexion_pays.text!='Suède'))
		{
			vErreur = 'Le pays du client facturé ne correspond pas au cas H du projet.'
		}
	}
	if(vErreur!=''){
		Alert.show(vErreur);
	}

}


