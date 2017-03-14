private function onLoad_contact():void {
}

private function onCreate_contact():void {
} 	

private function onUpdate_contact():void {
}

private function beforeCreate_contact():void {
	cle_contact();
} 	
private function event_contact(e:Event):void {
}
private function onPrint_contact():void {
      // Lancer une URL pour l'impression
}
private function beforeUpdate_contact():void {
}

public function cle_contact():void {
	// si la clé est vide
	if (text_cle.text=='')
	{
		text_cle.text = text_prenom.text+"-"+text_nom.text;
	}
}
private function initButton():void
{
}
private function rest_connexion_societe_result():void
{
}
