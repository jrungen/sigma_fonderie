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


import mx.collections.Grouping;
import mx.collections.GroupingCollection;
import mx.collections.GroupingField;
import mx.collections.SummaryField;
import mx.collections.SummaryRow;

System.useCodePage = true;

private var urlRequest:URLRequest;
private var fileReferenceList:FileReferenceList;
private var serverSideScript:String = "upload.php";		
		
private var mode:String = "modif";

private function load():void {
	restaction_typeList.send();	
	
	// Vue
	restVue.url = "vue.php?categorie=action_type";
	restVue.send();

	// Bouton rechercher
	ApplicationControlBar_action_type.addEventListener(KeyboardEvent.KEY_DOWN, checkKey);	

}

//appuie sur bouton entrer
private  function checkKey(event:KeyboardEvent):void{
	if(event.charCode == 13){
		searchaction_type();
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
	
	date_date_creation.text = dateFormat.format(date_date_creation.text);
date_date_modification.text = dateFormat.format(date_date_modification.text);


	onLoad_action_type();	
}

private function onUpdate(e:ResultEvent):void {
	onUpdate_action_type();	
}

private function searchaction_type():void {
	restaction_typeList.send();	
}

private function send_selection(e:ListEvent):void {
	
	
} 			

private function updateItem(idaction_type:String):void {
	beforeCreate_action_type();	
	restaction_typeUpdate.url = "action_typeUpdate.php?id="+idaction_type;
	restaction_typeUpdate.send();
	Alert.show("Fiche sauvegardée");
	//outerDocument.datagridaction_type.dataProvider.refresh();
	restaction_typeList.send();
}	

private function newItem():void{			
	var vaction_typeItem:action_typeItem = action_typeItem(PopUpManager.createPopUp(this,action_typeItem,true));
	vaction_typeItem.mode = '1';
}   

private function openItem():void{			
	var vaction_typeItem:action_typeItem = action_typeItem(PopUpManager.createPopUp(this,action_typeItem,true));
	vaction_typeItem.text_idaction_type.text = datagrid_action_type.selectedItem.idaction_type;			
}  



private function close():void {
	PopUpManager.removePopUp(this);
}

private function delete_action_type():void {
	// Vérif permission
	restPermission.url = "script/permission.php?permission=delete&table=action_type&group="+Application.application.gsGroup+"&id="+text_idaction_type.text;
	restPermission.send();
}

private function permissionResult(e:ResultEvent):void {
	if(restPermission.lastResult.permission==0){
		Alert.show('Vous ne disposez pas des permissions nécessaires pour supprimer cette fiche.','Permission refusée');
	}else{
		Alert.show('Voulez-vous supprimer cette fiche ?', 'Message de confirmation', 3, this, delete_action_type_result);
	}
}

private function delete_action_type_result(event:CloseEvent):void {
	if(event.detail == Alert.YES){
		restDelete.url = "delete.php?categorie=action_type&id="+datagrid_action_type.selectedItem.idaction_type;
		restDelete.send();
		searchaction_type();
	}else{  

	}	
}

private function export_action_type():void {
	restaction_typeList_export.send();	
}

//Gestion du menu prinipale 

//les menus
public function menu(event:MouseEvent):void {
	//Menu Nouveau
	if(myMenuBar.selectedIndex == 0){
		newItem();
	}

	//Menu Enregistrer
	//else if(myMenuBar.selectedIndex == 1){
	//	updateItem(text_idaction_type.text);
	//}

	//Menu Supprimer
	else if(myMenuBar.selectedIndex == 1){
		delete_action_type();
	}
	
	//Menu Exporter
	else if(myMenuBar.selectedIndex == 2){
		export_action_type();
	}	
	
	//Menu Filtre avancé
	else if(myMenuBar.selectedIndex == 3){
		advancedFilter();
	}	
} 

private function SelectConnexion(source:String):void{
	restConnexion.url = "connexion.php?table="+source;
	restConnexion.send();
}







public function style_datagrid_action_type(data:Object, col:AdvancedDataGridColumn):Object{
	
	return null;
}

private function advancedFilter():void{
	advancedFilter_action_type.height=150;
	advancedFilter_action_type.visible = true;
}
private function advancedFilter_close():void{
	advancedFilter_action_type.height=0;
	advancedFilter_action_type.visible = false;
}

