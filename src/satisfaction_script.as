// ActionScript file
import flash.events.Event;
private function onLoad_satisfaction():void {
}

private function onCreate_satisfaction():void {
} 	

private function onUpdate_satisfaction():void {
} 	 			

private function beforeCreate_satisfaction():void {
	cle_satisfaction();
}	
private function beforeUpdate_satisfaction():void {

}

private function event_satisfaction(e:Event):void {
	
}

private function onPrint_satisfaction():void {
	
} 		

private function cle_satisfaction():void {
	// si la clé est vide
	if (mode=="1"){
		var temps:Date = new Date();
		text_cle.text = connexion_projet_complement.text+'-'+temps.getDate()+temps.getTime();
	}
}

private function initButton():void{}
private function rest_connexion_fournisseur_result():void{}
private function rest_connexion_projet_result():void{}
private function rest_connexion_utilisateur_result():void{}
private function rest_connexion_eval_preparation_result():void{}
private function rest_connexion_eval_realisation_result():void{}
// Si on génère il faut ajouter ça dans la fonction export_satisfaction dat satisfactionTable_script.as
// navigateToURL( new URLRequest( 'satisfactionList_export.php?search='+textSearch.text+'&field='+combo_recherche.text), "_blank" );