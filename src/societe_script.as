import mx.controls.Button;
import mx.core.Application;


// Bouton verification du TVA Intracommunautaire
private var Btn_VerifTVA:Button = new Button();

private function initButton():void {
	// Création du bouton Btn_VerifTVA
	Btn_VerifTVA.x = 5;
	Btn_VerifTVA.y = 200;
	//Btn_VerifTVA.id="btn_facture_fournisseur_ligne_convert";
	Btn_VerifTVA.label = "Lien TVA";
	Btn_VerifTVA.addEventListener(MouseEvent.CLICK,Verif_TVA)
	tab_societe_principal.addChild(Btn_VerifTVA);
	
}

private function Verif_TVA(e:Event):void{
	// Redirection vers une URL
	navigateToURL( new URLRequest( 'http://ec.europa.eu/taxation_customs/vies/lang.do?fromWhichPage=vieshome&selectedLanguage=FR'), "_blank" );
}


private function onLoad_societe():void 
{
	text_caht.enabled = false;
	text_margeht.enabled = false;

}

private function onCreate_societe():void {
} 	

private function onUpdate_societe():void {
	calculHT();
}

private function beforeCreate_societe():void {
	cle_societe();
}
 	
private function event_societe(e:Event):void {
}
private function onPrint_societe():void {
      // Lancer une URL pour l'impression
}
private function beforeUpdate_societe():void {
}

public function cle_societe():void {
	// si la clé est vide
	if (text_cle.text=='')
	{
		text_cle.text = cleanAccent(text_nom.text)+"/"+cleanAccent(text_ville.text);
	}
}	 

public function calculHT():void 
{
	
	var totalHT:Number =0;
	for each (var row_toHT:Object in datagrid_SocieteProjet.dataProvider) 
	{
		if (row_toHT.ca_ht =="")
		{
			row_toHT.ca_ht = "0";
		}
  		totalHT += Number(row_toHT.ca_ht);
  	}
  	text_caht.text = totalHT.toFixed(2);
  	
  	var totalmarge:Number =0;
	for each (var row_marge:Object in datagrid_SocieteProjet.dataProvider) 
	{
  		if (row_marge.total_marge =="")
		{
			row_marge.total_marge = "0";
		}
		totalmarge += Number(row_marge.total_marge);
  	}
  	
  	text_margeht.text = totalmarge.toFixed(2);
  		 
}

private function rest_connexion_pays_result():void {}
private function cleanAccent(str:String):String{
	var pattern:RegExp = /é/gi;
    str = str.replace(pattern, "e");
    pattern=/è/gi;
    str = str.replace(pattern, "e");
    pattern=/à/gi;
    str = str.replace(pattern, "a");
    pattern=/ä/gi;
    str = str.replace(pattern, "a");
    pattern=/ë/gi;
    str = str.replace(pattern, "e");
    pattern=/ï/gi;
    str = str.replace(pattern, "i");
    pattern=/ö/gi;
    str = str.replace(pattern, "o");
    pattern=/ü/gi;
    str = str.replace(pattern, "u");
    pattern=/'/gi;
    str = str.replace(pattern, "_");
    return str;
}