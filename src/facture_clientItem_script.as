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
private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";

private function createListenerfacture_client(e:Event):void {
	event_facture_client(e);
}

private function load():void {
	PopUpManager.centerPopUp(this);
			restfacture_clientRead.url = "facture_clientRead.php?cle="+text_cle.text;
			restfacture_clientRead.send();
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
		if(Application.application.gsProfil =='user'){
			combo_statut_compta.enabled = false;
			combo_statut_compta_paiement.enabled = false;
			combo_statut_compta_paiement2.enabled = false;
			combo_statut_compta_paiement3.enabled = false;
			combo_banque.enabled = false;
			combo_compte_produit.enabled = false;
			combo_compte_tva.enabled = false;
			memo_note.enabled = false;
		}
	}else{
		text_modification_par.text = Application.application.gsUser;
		date_date_modification.selectedDate = new Date();
		if(Application.application.gsProfil =='user'){
			combo_statut_compta.enabled = false;
			combo_statut_compta_paiement.enabled = false;
			combo_statut_compta_paiement2.enabled = false;
			combo_statut_compta_paiement3.enabled = false;
			combo_banque.enabled = false;
			combo_compte_produit.enabled = false;
			combo_compte_tva.enabled = false;
			memo_note.enabled = false;
			
			if(Number(text_montant_ht.text)>0){
			btn_enregistrer.enabled=false;
			/*
			btn_parcourir_pj1.visible = false;
			btn_parcourir_pj2.visible = false;
			btn_parcourir_pj3.visible = false;
			*/
			btn_Add_FactureLigne.enabled = false;
			btn_Add_FactureLigneTA.enabled = false;
			btn_Delete_FactureLigne.enabled = false;
			btn_Delete_FactureLigneTA.enabled = false;
			}
		}
	}
	onLoad_facture_client();	
}

private function onCreate(e:ResultEvent):void {
	onCreate_facture_client();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_facture_client();	
}
			
private function close():void {
	PopUpManager.removePopUp(this);
}

private function updateItem(idfacture_client:String):void {

		beforeUpdate_facture_client();	
		restfacture_clientUpdate.url = "facture_clientUpdate.php?id="+text_idfacture_client.text;
		restfacture_clientUpdate.send();
		close();

	//outerDocument.datagridfacture_client.dataProvider.refresh();
	//restfacture_clientList.send();
}

// NUmero

import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;
// Nouveau numéro
private var restHttp_numero:mx.rpc.http.HTTPService = new mx.rpc.http.HTTPService();
 
private function numero():void{
      // Création de l'HTTPService pour le bouton dupliquer
            restHttp_numero.url = "numero.php?table=facture_client&annee="+date_date_facture.text.substr(6,4)+"&mois="+date_date_facture.text.substr(3,2);;
            restHttp_numero.method = "POST";
            restHttp_numero.addEventListener(ResultEvent.RESULT, resultHTTP_numero_result);
            restHttp_numero.send();
}
 
private function resultHTTP_numero_result(e:ResultEvent):void {
	// Récupérer le numéro
	text_numero.text = restHttp_numero.lastResult.autoincrement.nouveau.numero;
	text_cle.text = text_numero.text;
	restfacture_clientCreate.url = "facture_clientCreate.php";
	restfacture_clientCreate.send();
	close();

 }
private function createItem():void {
	//beforeCreate_facture_client();	
	if(text_numero.text==''){
		numero();
	}
}
	
//Gestion du menu prinipale 
// Actualiser
private function refresh_facture_client():void{
	if(refresh =='REFRESH'){
		send_selection();
		refresh = 'vide';
	} 
}

// Btn_enregistrer
private function enregistrer():void {
	// Si création de fiche
	combo_annee.text = date_date_facture.text.substr(6,10);
	verif();
		if(cas()!='ERREUR'){
			if (text_idfacture_client.text==''){
				var validators:Array = Validator.validateAll([valid_date_facture, valid_operation, valid_type, valid_libelle]);
				if(!validators.length) {
					if (Number(date_date_facture.text.substr(6,10)) > 2012){
						if ( ((text_acompte1.text>'0')&&(fichier_text_pj1.text=='')) || ((text_acompte2.text>'0')&&(fichier_text_pj2.text=='')) || ((text_acompte3.text>'0')&&(fichier_text_pj3.text=='')) ){
							Alert.show("le champ \"Pièce\" du règlement est obligatoire");
						}else{
							// JR le 06/10/2016 Ajout controle si facture accompagnant
							if (combo_type.text == 'Facture accompagnant'){
								if( (text_acc_nom.text == '') || (text_acc_facturation_adresse1.text == '') || (text_acc_facturation_cp.text == '') || (text_acc_facturation_ville.text == '') ){
									Alert.show('Pour une facture accompagnant les champs, nom prénom, adresse, cp et ville de l\'onglet accompagnant sont obligatoire');
								}else{
									createItem();
								}
							}else{
								createItem();
							}
							// JR le 06/10/2016 Ajout controle si facture accompagnant
						}
					}else{
						createItem();
						}
					}
			}else{
				if (Number(date_date_facture.text.substr(6,10)) > 2012){
					if ( ((text_acompte1.text>'0')&&(fichier_text_pj1.text=='')) || ((text_acompte2.text>'0')&&(fichier_text_pj2.text=='')) || ((text_acompte3.text>'0')&&(fichier_text_pj3.text=='')) ){
						Alert.show("le champ \"N° pièce\" du règlement est obligatoire");
					}else{
						// JR le 06/10/2016 Ajout controle si facture accompagnant
						if (combo_type.text == 'Facture accompagnant'){
							if( (text_acc_nom.text == '') || (text_acc_facturation_adresse1.text == '') || (text_acc_facturation_cp.text == '') || (text_acc_facturation_ville.text == '') ){
								Alert.show('Pour une facture accompagnant les champs, nom prénom, adresse, cp et ville de l\'onglet accompagnant sont obligatoire');
							}else{
								updateItem(text_idfacture_client.text);
							}
						}else{
							updateItem(text_idfacture_client.text);
						}
						// JR le 06/10/2016 Ajout controle si facture accompagnant
					}	
				}else{
					updateItem(text_idfacture_client.text);
				}
			}
		}	
		
}
// Btn_appliquer	
private function appliquer():void {
	if (text_idfacture_client.text==''){
	var validators:Array = Validator.validateAll([valid_date_facture, valid_operation, valid_type]);
	if(!validators.length) {
		createItem();
		Alert.show("Fiche créée");
	}	
	}else{
		updateItem(text_idfacture_client.text);
		Alert.show("Fiche modifiée");
	}
}

// Btn_fermer
// Btn_fermer
private function fermer():void {
	Alert.show('Voulez-vous enregistrer cette fiche test ?', 'Message de confirmation', 3, this, close_result);
}

private function close_result(event:CloseEvent):void {

	if ((Application.application.gsProfil =='user')&&(mode=='0')&&(Number(text_montant_ht.text)>0)){
		close();
		Alert.show("Fiche non enregistré  « merci de contacter le service administratif »");
	}else{
		if(event.detail == Alert.YES){
			enregistrer();
		}else{
			close();
		}
	}
}

// Brn Imprimer
private function imprimer():void {
	onPrint_facture_client();	
}

/*
//les menus
public function menu(event:MouseEvent):void {
	//Menu fichier
	if(myMenuBar.selectedIndex == 0){

	}

	//Menu Appliquer
	else if(myMenuBar.selectedIndex == 1){
		if (text_idfacture_client.text==''){
			createItem();
			Alert.show("Fiche créée");
		}else{
			updateItem(text_idfacture_client.text);
			Alert.show("Fiche modifiée");
		}
	}

	//Menu Enregistrer et fermer
	else if(myMenuBar.selectedIndex == 2){
		if (text_idfacture_client.text==''){
			createItem();
		}else{
			updateItem(text_idfacture_client.text);
		}
		close();
	}
	else if(myMenuBar.selectedIndex == 3){
		close();
	}
}  
*/

private function send_selection():void {
	restFactureLigneTA.url = "FactureLigneTA_Vue.php?cle="+text_cle.text;
restFactureLigneTA.send();
restFactureLigne.url = "FactureLigne_Vue.php?cle="+text_cle.text;
restFactureLigne.send();

} 	

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function AddFactureLigneTA():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_idfacture_client_ligne.text = '';
vfacture_client_ligneItem.connexion_facture_client.text = text_cle.text ;
vfacture_client_ligneItem.text_objet_parent.data = combo_objet.text;
vfacture_client_ligneItem.text_objet_parent.visible =false;
vfacture_client_ligneItem.mode="1";
refresh = 'REFRESH';
}

private function Delete_FactureLigneTA(id:String):void{
restDelete.url = "delete.php?categorie=facture_client_ligne&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFactureLigneTA():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_cle.text = datagrid_FactureLigneTA.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FactureLigneTA(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}

private function AddFactureLigne():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_idfacture_client_ligne.text = '';
vfacture_client_ligneItem.connexion_facture_client.text = text_cle.text ;
vfacture_client_ligneItem.text_objet_parent.data = combo_objet.text;
vfacture_client_ligneItem.text_objet_parent.visible =false;
vfacture_client_ligneItem.text_cas.data = text_cas.text;
vfacture_client_ligneItem.mode = "1";
refresh = 'REFRESH';
}

private function Delete_FactureLigne(id:String):void{
restDelete.url = "delete.php?categorie=facture_client_ligne&id="+id;
restDelete.send();
send_selection();
}

private function UpdateFactureLigne():void{
var vfacture_client_ligneItem:facture_client_ligneItem = facture_client_ligneItem(PopUpManager.createPopUp(this,facture_client_ligneItem,true));
vfacture_client_ligneItem.text_cle.text = datagrid_FactureLigne.selectedItem.cle;
refresh = 'REFRESH';
}
public function style_datagrid_FactureLigne(data:Object, col:AdvancedDataGridColumn):Object{

return null;
}



private function initFile_pj1():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj1);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj1(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj1);
fileReference.upload(urlRequest);
fichier_text_pj1.text = "Uploading...";
}
private function uploadCompleteHandler_pj1(event:Event):void {
fichier_text_pj1.text = event.target.name;
}
public function openNewWindow_pj1(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj1.text);
navigateToURL(u,"_blank");
}
private function initFile_pj2():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj2);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj2(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj2);
fileReference.upload(urlRequest);
fichier_text_pj2.text = "Uploading...";
}
private function uploadCompleteHandler_pj2(event:Event):void {
fichier_text_pj2.text = event.target.name;
}
public function openNewWindow_pj2(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj2.text);
navigateToURL(u,"_blank");
}
private function initFile_pj3():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj3);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj3(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj3);
fileReference.upload(urlRequest);
fichier_text_pj3.text = "Uploading...";
}
private function uploadCompleteHandler_pj3(event:Event):void {
fichier_text_pj3.text = event.target.name;
}
public function openNewWindow_pj3(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj3.text);
navigateToURL(u,"_blank");
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
fichier_text_pj.text = event.target.name;
}
public function openNewWindow_pj(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/"+fichier_text_pj.text);
navigateToURL(u,"_blank");
}


private function OpenConnexionsociete():void{
	//connexion_societe.text = '';
	var vConnexion:connexion = connexion(PopUpManager.createPopUp(this,connexion,true));
	vConnexion.targetComponent = connexion_societe;
	vConnexion.categorie = "societe";
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

private function verif():void{

	if(combo_statut_compta.text==null){
		trace("statut_compta");
		if(Number(combo_compte_produit.text)>0){
			combo_statut_compta.text = 'A comptabiliser';
		}
		
		if(Number(combo_compte_tva.text)>0){
			combo_statut_compta.text = 'A comptabiliser';
		}

	}
	
	if((combo_statut_compta_paiement.text==null)||(combo_statut_compta_paiement.text=='0')||(combo_statut_compta_paiement.text=='')){
		trace("combo_statut_compta_paiement");
		if((Number(text_acompte1.text)>0)||(Number(text_acompte1.text)<0)){
			combo_statut_compta_paiement.text = 'A comptabiliser';
		}
	}

	if((combo_statut_compta_paiement2.text==null)||(combo_statut_compta_paiement2.text=='0')||(combo_statut_compta_paiement2.text=='')){
		trace('combo_statut_compta_paiement2.text');
		if((Number(text_acompte2.text)>0)||(Number(text_acompte2.text)<0)){
			combo_statut_compta_paiement2.text = 'A comptabiliser';
		}
	}
	
	if((combo_statut_compta_paiement3.text==null)||(combo_statut_compta_paiement3.text=='0')||(combo_statut_compta_paiement3.text=='')){
		trace('combo_statut_compta_paiement3');
		if((Number(text_acompte3.text)>0)||(Number(text_acompte3.text)<0)){
			combo_statut_compta_paiement3.text = 'A comptabiliser';
		}
	}

}
private function cas():String{
	var vErreur:String = '';
	//Alert.show(text_pays.text);
	//Alert.show(text_pays_projet.text);

	if(Application.application.gsProfil =='user'){
	
		//A- Client France - Projet France :
		if (text_cas.text == 'A'){
			if(text_pays_projet.text=='France')
			{
				if(text_pays.text=='France')
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
		
		//B- Client hors UE - Projet Hors UE :
		if (text_cas.text == 'B'){
			if((text_pays_projet.text!='Allemagne') && (text_pays_projet.text!='Autriche')  && (text_pays_projet.text!='Belgique') && (text_pays_projet.text!='Bulgarie') && (text_pays_projet.text!='Chypre') && (text_pays_projet.text!='Croatie') && (text_pays_projet.text!='Danemark') && (text_pays_projet.text!='Espagne') && (text_pays_projet.text!='Estonie') && (text_pays_projet.text!='Finlande') && (text_pays_projet.text!='France') && (text_pays_projet.text!='Grèce') && (text_pays_projet.text!='Hongrie') && (text_pays_projet.text!='Irlande') && (text_pays_projet.text!='Italie') && (text_pays_projet.text!='Lettonie') && (text_pays_projet.text!='Lituanie') && (text_pays_projet.text!='Luxembourg') && (text_pays_projet.text!='Malte') && (text_pays_projet.text!='Pays-Bas') && (text_pays_projet.text!='Pologne') && (text_pays_projet.text!='Portugal') && (text_pays_projet.text!='République tchèque') && (text_pays_projet.text!='Roumanie') && (text_pays_projet.text!='Royaume-Uni') && (text_pays_projet.text!='Slovaquie') && (text_pays_projet.text!='Slovénie') && (text_pays_projet.text!='Suède'))
			{
				if((text_pays.text!='Allemagne') && (text_pays.text!='Autriche')  && (text_pays.text!='Belgique') && (text_pays.text!='Bulgarie') && (text_pays.text!='Chypre') && (text_pays.text!='Croatie') && (text_pays.text!='Danemark') && (text_pays.text!='Espagne') && (text_pays.text!='Estonie') && (text_pays.text!='Finlande') && (text_pays.text!='France') && (text_pays.text!='Grèce') && (text_pays.text!='Hongrie') && (text_pays.text!='Irlande') && (text_pays.text!='Italie') && (text_pays.text!='Lettonie') && (text_pays.text!='Lituanie') && (text_pays.text!='Luxembourg') && (text_pays.text!='Malte') && (text_pays.text!='Pays-Bas') && (text_pays.text!='Pologne') && (text_pays.text!='Portugal') && (text_pays.text!='République tchèque') && (text_pays.text!='Roumanie') && (text_pays.text!='Royaume-Uni') && (text_pays.text!='Slovaquie') && (text_pays.text!='Slovénie') && (text_pays.text!='Suède'))
				{
					vErreur = '';
				}else{			
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
		
		//C -  Client France - Projet HORS UE
		if (text_cas.text == 'C'){
			if((text_pays_projet.text!='France') &&(text_pays_projet.text!='Allemagne') && (text_pays_projet.text!='Autriche')  && (text_pays_projet.text!='Belgique') && (text_pays_projet.text!='Bulgarie') && (text_pays_projet.text!='Chypre') && (text_pays_projet.text!='Croatie') && (text_pays_projet.text!='Danemark') && (text_pays_projet.text!='Espagne') && (text_pays_projet.text!='Estonie') && (text_pays_projet.text!='Finlande') && (text_pays_projet.text!='Grèce') && (text_pays_projet.text!='Hongrie') && (text_pays_projet.text!='Irlande') && (text_pays_projet.text!='Italie') && (text_pays_projet.text!='Lettonie') && (text_pays_projet.text!='Lituanie') && (text_pays_projet.text!='Luxembourg') && (text_pays_projet.text!='Malte') && (text_pays_projet.text!='Pays-Bas') && (text_pays_projet.text!='Pologne') && (text_pays_projet.text!='Portugal') && (text_pays_projet.text!='République tchèque') && (text_pays_projet.text!='Roumanie') && (text_pays_projet.text!='Royaume-Uni') && (text_pays_projet.text!='Slovaquie') && (text_pays_projet.text!='Slovénie') && (text_pays_projet.text!='Suède'))		
			{
				if(text_pays.text=='France')
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	
		//D -   Client UE - Projet France
		if (text_cas.text == 'D'){
			if(text_pays_projet.text=='France')
			{
				if((text_pays.text=='Allemagne') || (text_pays.text=='Autriche') || (text_pays.text=='Belgique') || (text_pays.text=='Bulgarie') || (text_pays.text=='Chypre') || (text_pays.text=='Croatie') || (text_pays.text=='Danemark') || (text_pays.text=='Espagne') || (text_pays.text=='Estonie') || (text_pays.text=='Finlande') || (text_pays.text=='Grèce') || (text_pays.text=='Hongrie') || (text_pays.text=='Irlande') || (text_pays.text=='Italie') || (text_pays.text=='Lettonie') || (text_pays.text=='Lituanie') || (text_pays.text=='Luxembourg') || (text_pays.text=='Malte') || (text_pays.text=='Pays-Bas') || (text_pays.text=='Pologne') || (text_pays.text=='Portugal') || (text_pays.text=='République tchèque') || (text_pays.text=='Roumanie') || (text_pays.text=='Royaume-Uni') || (text_pays.text=='Slovaquie') || (text_pays.text=='Slovénie')|| (text_pays.text=='Suède'))			
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	
		//E - Client UE - Projet UE
		if (text_cas.text == 'E'){
			if((text_pays_projet.text=='Allemagne')||(text_pays_projet.text=='Autriche') || (text_pays_projet.text=='Autriche') || (text_pays_projet.text=='Belgique') || (text_pays_projet.text=='Bulgarie') || (text_pays_projet.text=='Chypre') || (text_pays_projet.text=='Croatie') || (text_pays_projet.text=='Danemark') || (text_pays_projet.text=='Espagne') || (text_pays_projet.text=='Estonie') || (text_pays_projet.text=='Finlande') || (text_pays_projet.text=='Grèce') || (text_pays_projet.text=='Hongrie') || (text_pays_projet.text=='Irlande') || (text_pays_projet.text=='Italie') || (text_pays_projet.text=='Lettonie') || (text_pays_projet.text=='Lituanie') || (text_pays_projet.text=='Luxembourg') || (text_pays_projet.text=='Malte') || (text_pays_projet.text=='Pays-Bas') || (text_pays_projet.text=='Pologne') || (text_pays_projet.text=='Portugal') || (text_pays_projet.text=='République tchèque') || (text_pays_projet.text=='Roumanie') || (text_pays_projet.text=='Royaume-Uni') || (text_pays_projet.text=='Slovaquie') || (text_pays_projet.text=='Slovénie')|| (text_pays_projet.text=='Suède'))
			{
				if((text_pays.text=='Allemagne') || (text_pays.text=='Autriche') || (text_pays.text=='Belgique') || (text_pays.text=='Bulgarie') || (text_pays.text=='Chypre') || (text_pays.text=='Croatie') || (text_pays.text=='Danemark') || (text_pays.text=='Espagne') || (text_pays.text=='Estonie') || (text_pays.text=='Finlande') || (text_pays.text=='Grèce') || (text_pays.text=='Hongrie') || (text_pays.text=='Irlande') || (text_pays.text=='Italie') || (text_pays.text=='Lettonie') || (text_pays.text=='Lituanie') || (text_pays.text=='Luxembourg') || (text_pays.text=='Malte') || (text_pays.text=='Pays-Bas') || (text_pays.text=='Pologne') || (text_pays.text=='Portugal') || (text_pays.text=='République tchèque') || (text_pays.text=='Roumanie') || (text_pays.text=='Royaume-Uni') || (text_pays.text=='Slovaquie') || (text_pays.text=='Slovénie')|| (text_pays.text=='Suède'))
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	
		//F- Client France - Projet UE HORS FRANCE
		if (text_cas.text == 'F'){
			if((text_pays_projet.text=='Allemagne') || (text_pays_projet.text=='Autriche') || (text_pays_projet.text=='Belgique') || (text_pays_projet.text=='Bulgarie') || (text_pays_projet.text=='Chypre') || (text_pays_projet.text=='Croatie') || (text_pays_projet.text=='Danemark') || (text_pays_projet.text=='Espagne') || (text_pays_projet.text=='Estonie') || (text_pays_projet.text=='Finlande') || (text_pays_projet.text=='Grèce') || (text_pays_projet.text=='Hongrie') || (text_pays_projet.text=='Irlande') || (text_pays_projet.text=='Italie') || (text_pays_projet.text=='Lettonie') || (text_pays_projet.text=='Lituanie') || (text_pays_projet.text=='Luxembourg') || (text_pays_projet.text=='Malte') || (text_pays_projet.text=='Pays-Bas') || (text_pays_projet.text=='Pologne') || (text_pays_projet.text=='Portugal') || (text_pays_projet.text=='République tchèque') || (text_pays_projet.text=='Roumanie') || (text_pays_projet.text=='Royaume-Uni') || (text_pays_projet.text=='Slovaquie') || (text_pays_projet.text=='Slovénie')|| (text_pays_projet.text=='Suède'))		
			{
				if(text_pays.text=='France')
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	
		//G- Client UE - Projet Hors UE
		if (text_cas.text == 'G'){
			if((text_pays_projet.text!='Allemagne') && (text_pays_projet.text!='Autriche')  && (text_pays_projet.text!='Belgique') && (text_pays_projet.text!='Bulgarie') && (text_pays_projet.text!='Chypre') && (text_pays_projet.text!='Croatie') && (text_pays_projet.text!='Danemark') && (text_pays_projet.text!='Espagne') && (text_pays_projet.text!='Estonie') && (text_pays_projet.text!='Finlande') && (text_pays_projet.text!='France') && (text_pays_projet.text!='Grèce') && (text_pays_projet.text!='Hongrie') && (text_pays_projet.text!='Irlande') && (text_pays_projet.text!='Italie') && (text_pays_projet.text!='Lettonie') && (text_pays_projet.text!='Lituanie') && (text_pays_projet.text!='Luxembourg') && (text_pays_projet.text!='Malte') && (text_pays_projet.text!='Pays-Bas') && (text_pays_projet.text!='Pologne') && (text_pays_projet.text!='Portugal') && (text_pays_projet.text!='République tchèque') && (text_pays_projet.text!='Roumanie') && (text_pays_projet.text!='Royaume-Uni') && (text_pays_projet.text!='Slovaquie') && (text_pays_projet.text!='Slovénie') && (text_pays_projet.text!='Suède'))
			{
				if((text_pays.text=='Allemagne') || (text_pays.text=='Autriche') || (text_pays.text=='Belgique') || (text_pays.text=='Bulgarie') || (text_pays.text=='Chypre') || (text_pays.text=='Croatie') || (text_pays.text=='Danemark') || (text_pays.text=='Espagne') || (text_pays.text=='Estonie') || (text_pays.text=='Finlande') || (text_pays.text=='Grèce') || (text_pays.text=='Hongrie') || (text_pays.text=='Irlande') || (text_pays.text=='Italie') || (text_pays.text=='Lettonie') || (text_pays.text=='Lituanie') || (text_pays.text=='Luxembourg') || (text_pays.text=='Malte') || (text_pays.text=='Pays-Bas') || (text_pays.text=='Pologne') || (text_pays.text=='Portugal') || (text_pays.text=='République tchèque') || (text_pays.text=='Roumanie') || (text_pays.text=='Royaume-Uni') || (text_pays.text=='Slovaquie') || (text_pays.text=='Slovénie')|| (text_pays.text=='Suède'))
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	
		//H- Client HORS UE - Projet UE
		if (text_cas.text == 'H'){
			if((text_pays_projet.text=='Allemagne') || (text_pays_projet.text=='Autriche') || (text_pays_projet.text=='Belgique') || (text_pays_projet.text=='Bulgarie') || (text_pays_projet.text=='Chypre') || (text_pays_projet.text=='Croatie') || (text_pays_projet.text=='Danemark') || (text_pays_projet.text=='Espagne') || (text_pays_projet.text=='Estonie') || (text_pays_projet.text=='Finlande') || (text_pays_projet.text=='Grèce') || (text_pays_projet.text=='Hongrie') || (text_pays_projet.text=='Irlande') || (text_pays_projet.text=='Italie') || (text_pays_projet.text=='Lettonie') || (text_pays_projet.text=='Lituanie') || (text_pays_projet.text=='Luxembourg') || (text_pays_projet.text=='Malte') || (text_pays_projet.text=='Pays-Bas') || (text_pays_projet.text=='Pologne') || (text_pays_projet.text=='Portugal') || (text_pays_projet.text=='République tchèque') || (text_pays_projet.text=='Roumanie') || (text_pays_projet.text=='Royaume-Uni') || (text_pays_projet.text=='Slovaquie') || (text_pays_projet.text=='Slovénie')|| (text_pays_projet.text=='Suède'))
			{
				if((text_pays.text!='Allemagne') && (text_pays.text!='Autriche')  && (text_pays.text!='Belgique') && (text_pays.text!='Bulgarie') && (text_pays.text!='Chypre') && (text_pays.text!='Croatie') && (text_pays.text!='Danemark') && (text_pays.text!='Espagne') && (text_pays.text!='Estonie') && (text_pays.text!='Finlande') && (text_pays.text!='France') && (text_pays.text!='Grèce') && (text_pays.text!='Hongrie') && (text_pays.text!='Irlande') && (text_pays.text!='Italie') && (text_pays.text!='Lettonie') && (text_pays.text!='Lituanie') && (text_pays.text!='Luxembourg') && (text_pays.text!='Malte') && (text_pays.text!='Pays-Bas') && (text_pays.text!='Pologne') && (text_pays.text!='Portugal') && (text_pays.text!='République tchèque') && (text_pays.text!='Roumanie') && (text_pays.text!='Royaume-Uni') && (text_pays.text!='Slovaquie') && (text_pays.text!='Slovénie') && (text_pays.text!='Suède'))
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
		
		//I- Client HORS UE - Projet FRANCE
		if (text_cas.text == 'I'){
			if((text_pays_projet.text=='France'))
			{
				if((text_pays.text!='Allemagne') && (text_pays.text!='Autriche')  && (text_pays.text!='Belgique') && (text_pays.text!='Bulgarie') && (text_pays.text!='Chypre') && (text_pays.text!='Croatie') && (text_pays.text!='Danemark') && (text_pays.text!='Espagne') && (text_pays.text!='Estonie') && (text_pays.text!='Finlande') && (text_pays.text!='France') && (text_pays.text!='Grèce') && (text_pays.text!='Hongrie') && (text_pays.text!='Irlande') && (text_pays.text!='Italie') && (text_pays.text!='Lettonie') && (text_pays.text!='Lituanie') && (text_pays.text!='Luxembourg') && (text_pays.text!='Malte') && (text_pays.text!='Pays-Bas') && (text_pays.text!='Pologne') && (text_pays.text!='Portugal') && (text_pays.text!='République tchèque') && (text_pays.text!='Roumanie') && (text_pays.text!='Royaume-Uni') && (text_pays.text!='Slovaquie') && (text_pays.text!='Slovénie') && (text_pays.text!='Suède'))
				{
					vErreur = '';
				}else{
					Alert.show('Attention le cas de la facture client est différent du cas du projet « merci de contacter le service administratif »');
					vErreur = 'ERREUR';
				}
			}
		}
	}// fin if gsProfil == user
	return vErreur;
	
}