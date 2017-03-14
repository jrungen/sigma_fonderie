// ActionScript file
import flash.events.Event;
private function onLoad_tiers():void {}
private function onCreate_tiers():void {}
private function onUpdate_tiers():void {}
private function beforeCreate_tiers():void {
	cle_tiers();
}
private function beforeUpdate_tiers():void {}
private function event_tiers(e:Event):void {}
private function onPrint_tiers():void {}
private function cle_tiers():void {
	// si la clé est vide
	if (mode=="1"){
		text_cle.text = text_nom.text+"/"+text_ville.text;
	}
}
private function initButton():void {}
private function rest_connexion_pays_result():void{}
private function send_selection_script():void{}