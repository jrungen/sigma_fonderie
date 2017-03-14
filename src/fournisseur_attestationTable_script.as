// ActionScript file

import mx.validators.EmailValidator;
import mx.containers.ViewStack;
import mx.controls.Alert;
import mx.events.CloseEvent; 
import mx.events.ListEvent;
import mx.events.MenuEvent;
import mx.core.Application;
import mx.formatters.DateFormatter;
import mx.formatters.NumberFormatter;
import mx.managers.PopUpManager;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import flash.net.navigateToURL;
import flash.system.System;
import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
import mx.controls.advancedDataGridClasses.AdvancedDataGridRendererProvider;

import mx.collections.Grouping;
import mx.collections.GroupingCollection;
import mx.collections.GroupingField;
import mx.collections.SummaryField;
import mx.collections.SummaryRow;
import module.massedit.massEdit;

System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

[Bindable]
private var ar_format:Array= new Array();
private var sumFieldArray:Array= new Array();

[Bindable]
public var menuData:Array = [
    {label: "Nouveau"},
    {label: "Supprimer"},
    {label: "Exporter vers CSV"},
    {label: "Graphique"}, 
    {label: "Mettre à jour en masse"}    
];

private function load():void {
	Alert.yesLabel = "Oui";
    Alert.noLabel = "Non";
	// Vue
	restVue.url = "vue.php?categorie=fournisseur_attestation";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_fournisseur_attestation.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);
	
	// Load Table	
	onLoadTable();	
}
public function restVue_resultHandler(re:ResultEvent):void {
	restfournisseur_attestationList.send();	
}

public function datagrid_fournisseur_attestation_resultHandler(re:ResultEvent):void {
		// Column
		var cols:Array = new Array();
		for (var j:int = 0; j< re.result.column.item.length; j++) {
			var column:AdvancedDataGridColumn = new AdvancedDataGridColumn;
			column.headerText= re.result.column.item[j].label;
			column.dataField = re.result.column.item[j].datafield;
			column.visible = re.result.column.item[j].visible;
			column.width = re.result.column.item[j].width;
			if (re.result.column.item[j].format=='Date'){
				column.formatter = dateFormatter;
				column.setStyle("textAlign","center");
			}
			if (re.result.column.item[j].format=='Number'){
				column.formatter = numberFormatter;
				column.setStyle("textAlign","right");
			}
			
			if (re.result.column.item[j].format=='Integer'){
				column.formatter = integerFormatter;
				column.setStyle("textAlign","right");
			}
			
			cols.push(column);
        }
		datagrid_fournisseur_attestation.columns = cols;        
		
		// Color       
		// Vider tableau 
		ar_format.splice(0,ar_format.length);	
		if(re.result.format.item.length>0){
			for (var k:int = 0; k< re.result.format.item.length; k++) {			
				var newItemFormat:Array = new Array();
				newItemFormat.datafield = re.result.format.item[k].datafield;
				newItemFormat.value = re.result.format.item[k].value;
				newItemFormat.code = re.result.format.item[k].code;
				newItemFormat.fontweight = re.result.format.item[k].fontweight;
				newItemFormat.fontstyle = re.result.format.item[k].fontstyle;
				ar_format.push(newItemFormat);
			}
			
			// Refresh
			datagrid_fournisseur_attestation.invalidateList();
		}

		// Grouping
		var group1:String = re.result.grouping.group1;
		var group2:String = re.result.grouping.group2;
		var group3:String = re.result.grouping.group3;
		var expanded:String = re.result.grouping.expanded;

		if(group1==null) group1 = '';
		if(group2==null) group2 = '';
		if(group3==null) group3 = '';
		
			if((group1!='')||(group2!='')||(group3!='')){	
			if(expanded=='0'){
				datagrid_fournisseur_attestation.displayItemsExpanded = true;
			}else{
				datagrid_fournisseur_attestation.displayItemsExpanded = false;
			}
			/*
			if(group1!=''){
				group1 = group1.split('.')[1];
			}
			
			if(group2!=''){
				group2 = group2.split('.')[1];
			}

			if(group3!=''){
				group3 = group3.split('.')[1];
			}
			*/
			
			// Regroupement
			var myGroupColl:GroupingCollection = new GroupingCollection();
			myGroupColl.source = datagrid_fournisseur_attestation.dataProvider;
			var group:Grouping=new Grouping();
			
			if(group1!=''){
				var gf1:GroupingField=new GroupingField(group1);
			}
			
			if(group2!=''){
				var gf2:GroupingField=new GroupingField(group2);
			}	

			if(group3!=''){
				var gf3:GroupingField=new GroupingField(group3);
			}	

			
			if((group1!='')&&(group2=='')){
				group.fields=[gf1];
			}

			if((group1!='')&&(group2!='')){
				group.fields=[gf1,gf2];
			}

			if((group1!='')&&(group2!='')&&(group3!='')){
				group.fields=[gf1,gf2,gf3];
			}
			
			// Atribuer l'objet Grouping à la propriété grouping de Grouping Collection
			myGroupColl.grouping = group;

			// SUM
			var sr:SummaryRow = new SummaryRow();
			
	  		for (var l:int = 0; l< re.result.summary.item.length; l++) {	
	  			var newItemFields:Array = new Array();
				var sf:SummaryField = new SummaryField;
				sf.dataField = re.result.summary.item[l].field;
				sf.operation = "SUM";
				sf.label = re.result.summary.item[l].field;
				sumFieldArray.push(sf);		
	        }
	        
			sr.fields = sumFieldArray;
			sr.summaryPlacement = "group";
			
			if(group1!=''){
				gf1.summaries = [sr];
			}
			
			if(group2!=''){
				gf2.summaries = [sr];
			}	

			if(group3!=''){
				gf3.summaries = [sr];
			}	
			
			// Refresh
			myGroupColl.refresh();
			datagrid_fournisseur_attestation.dataProvider=myGroupColl;
		}
		
		// Refresh
		datagrid_fournisseur_attestation.invalidateList();	
}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchfournisseur_attestation();
	}
}

private function onLoad(e:ResultEvent):void {
	var dateFormat:DateFormatter = new DateFormatter();
	dateFormat.formatString = "DD/MM/YYYY";
	var sDate:String = dateFormat.format(new Date());
	var sYear:String = sDate.substr(6,10);

	var numberFormat:NumberFormatter = new NumberFormatter();
	numberFormat.decimalSeparatorFrom = ".";
	numberFormat.decimalSeparatorTo = ".";
	numberFormat.precision="-1";
	numberFormat.thousandsSeparatorFrom=" ";
	numberFormat.thousandsSeparatorTo=" ";
	numberFormat.useNegativeSign="true";
	numberFormat.useThousandsSeparator="true";
	
	date_date_attestation.text = dateFormat.format(date_date_attestation.text);
date_date_document.text = dateFormat.format(date_date_document.text);
date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);


	onLoad_fournisseur_attestation();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_fournisseur_attestation();	
}

private function searchfournisseur_attestation():void {
	restfournisseur_attestationList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
	send_selection_script();
} 			

private function send_selection_object(o:Object):void {
	
	
	send_selection_script();
} 		

private function updateItem(idfournisseur_attestation:String):void {
	beforeCreate_fournisseur_attestation();	
	restfournisseur_attestationUpdate.url = "fournisseur_attestationUpdate.php?id="+idfournisseur_attestation;
	restfournisseur_attestationUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridfournisseur_attestation.dataProvider.refresh();
	restfournisseur_attestationList.send();
}	

private function newItem():void{			
	var vfournisseur_attestationItem:fournisseur_attestationItem = fournisseur_attestationItem(PopUpManager.createPopUp(this,fournisseur_attestationItem,Application.application.gsModal));
	vfournisseur_attestationItem.mode = '1';
}   

private function openItem():void{			
	var vfournisseur_attestationItem:fournisseur_attestationItem = fournisseur_attestationItem(PopUpManager.createPopUp(this,fournisseur_attestationItem,Application.application.gsModal));
	vfournisseur_attestationItem.text_idfournisseur_attestation.text = datagrid_fournisseur_attestation.selectedItem.idfournisseur_attestation;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_fournisseur_attestation():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=fournisseur_attestation&group="+Application.application.gsGroup+"&id="+text_idfournisseur_attestation.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_fournisseur_attestation_result);
	}
}

private function delete_fournisseur_attestation_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=fournisseur_attestation&id="+datagrid_fournisseur_attestation.selectedItem.idfournisseur_attestation;
		restDelete.send();
		searchfournisseur_attestation();
	}else{  

	}	
}

private function export_fournisseur_attestation():void {
	navigateToURL( new URLRequest( 'fournisseur_attestationList_export.php?search='+textSearch.text+'&field='+combo_recherche.text+'&view='+connexion_vue_complement.text+'&user='+Application.application.gsUser), "_blank" );
	
}

//Gestion du menu prinipale 

//les menus
public function menu(event:MouseEvent):void {
	//Menu Nouveau
	if(myMenuBar.selectedIndex == 0){
		newItem();
	}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_fournisseur_attestation();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_fournisseur_attestation();
	}	

	if(myMenuBar.selectedIndex == 3)
	{
		var vGraph:_graph = _graph(PopUpManager.createPopUp(this,_graph,Application.application.gsModal));
		
		// Récupérer les paramètres du graphique
		vGraph.graphVue = connexion_vue.text;

	}
	
	if(myMenuBar.selectedIndex == 4)
	{
		if(connexion_vue_complement.text!='Par défaut'){
			var vmassEdit:massEdit = massEdit(PopUpManager.createPopUp(this,massEdit,Application.application.gsModal));
			vmassEdit.sView = connexion_vue.text;
			vmassEdit.sSearch = textSearch.text;
			vmassEdit.sSearchField = combo_recherche.text;
		}else{
			Alert.show('Vous ne pouvez pas faire de modification en masse sur une vue Par défaut, merci de sélectionner une autre vue.','Message');	
		}
	}		
	
	menu_options(event);	
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}

private function initFile_pj_kbis():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_kbis);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_kbis(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_kbis);
fileReference.upload(urlRequest);
fichier_text_pj_kbis.text = "Uploading...";
}
private function uploadCompleteHandler_pj_kbis(event:Event):void {
fichier_text_pj_kbis.text = event.target.name;
}
public function openNewWindow_pj_kbis(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_kbis.text);
navigateToURL(u,"_blank");
}
private function initFile_pj_urssaf_rsi():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_urssaf_rsi);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_urssaf_rsi(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_urssaf_rsi);
fileReference.upload(urlRequest);
fichier_text_pj_urssaf_rsi.text = "Uploading...";
}
private function uploadCompleteHandler_pj_urssaf_rsi(event:Event):void {
fichier_text_pj_urssaf_rsi.text = event.target.name;
}
public function openNewWindow_pj_urssaf_rsi(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_urssaf_rsi.text);
navigateToURL(u,"_blank");
}
private function initFile_pj_autre():void {
urlRequest = new URLRequest(serverSideScript);
fileReferenceList = new FileReferenceList();
fileReferenceList.addEventListener(Event.SELECT, fileSelectedHandler_pj_autre);
fileReferenceList.browse();
}
private function fileSelectedHandler_pj_autre(event:Event):void {
var fileReference:FileReference;
var fileReferenceList:FileReferenceList = FileReferenceList(event.target);
var fileList:Array = fileReferenceList.fileList;
fileReference = FileReference(fileList[0]);
fileReference.addEventListener(Event.COMPLETE, uploadCompleteHandler_pj_autre);
fileReference.upload(urlRequest);
fichier_text_pj_autre.text = "Uploading...";
}
private function uploadCompleteHandler_pj_autre(event:Event):void {
fichier_text_pj_autre.text = event.target.name;
}
public function openNewWindow_pj_autre(event:MouseEvent):void {
var u:URLRequest = new URLRequest("files/fournisseur_attestation/"+fichier_text_pj_autre.text);
navigateToURL(u,"_blank");
}


private function OpenConnexionfournisseur():void{
var vConnexion:fournisseurConnexion = fournisseurConnexion(PopUpManager.createPopUp(this,fournisseurConnexion,Application.application.gsModal));
vConnexion.targetComponent = connexion_fournisseur;
vConnexion.targetComplement = connexion_fournisseur_complement;
vConnexion.categorie = "fournisseur";
vConnexion.categorie_source = "fournisseur_attestation";
vConnexion.connexion_source = "fournisseur";
vConnexion.filtre = ''+'-'+''+'-'+''+'-'+'';
}

private function OpenConnexionfournisseurItem():void{
if(connexion_fournisseur.text!=''){
var vfournisseurItem:fournisseurItem = fournisseurItem(PopUpManager.createPopUp(this,fournisseurItem,Application.application.gsModal));
vfournisseurItem.text_cle.text =connexion_fournisseur.text;
}else{
Alert.show('Attention la connexion est vide');
}
}





public function style_datagrid_fournisseur_attestation(data:Object, col:AdvancedDataGridColumn):Object{
	/*
	
	*/
	for each (var row:Object in ar_format){
		if (data[row.datafield]==row.value) return{color:row.code,rowColor : 0x339900, fontWeight:row.fontweight, fontStyle:row.fontstyle};
	}
	return null;
}

private function advancedFilter():void{
	advancedFilter_fournisseur_attestation.height=150;
	advancedFilter_fournisseur_attestation.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_fournisseur_attestation.height=0;
	advancedFilter_fournisseur_attestation.visible = false;
}

private function OpenConnexionvue():void{
var vConnexion:vueConnexion = vueConnexion(PopUpManager.createPopUp(this,vueConnexion,Application.application.gsModal));
vConnexion.targetComponent = connexion_vue;
vConnexion.targetComplement = connexion_vue_complement;
vConnexion.categorie = "vue";
vConnexion.categorie_source = "fournisseur_attestation";
vConnexion.connexion_source = "vue";
vConnexion.filtre = 'categorie'+'-'+'fournisseur_attestation'+'-'+''+'-'+'';
}  

private function OpenConnexionvueItem():void{
var vvueItem:vueItem = vueItem(PopUpManager.createPopUp(this,vueItem,Application.application.gsModal));
vvueItem.text_cle.text = connexion_vue.text;
}

