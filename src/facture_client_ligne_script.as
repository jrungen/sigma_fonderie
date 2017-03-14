
import flash.errors.MemoryError;
private function onLoad_facture_client_ligne():void
{
	text_puttc.enabled = false;
	text_total_montant_ht.enabled = false;
	text_total_montant_ttc.enabled = false;
	if(text_objet_parent.text =="Prestation tourisme d'affaires")
	{
		text_puttc.enabled = true;
		text_puht.visible = false;
		text_total_montant_ht.visible = false;
		combo_taux_tva.enabled = false;
		combo_taux_tva.visible = false;
	}
	if(text_objet_parent.text =="Prestation événementielles")
	{
		text_puht.enabled = true;
		text_puttc.enabled = true;
		text_puht.visible = true;
		text_puttc.visible = true;
		text_total_montant_ht.enabled = true;
		text_total_montant_ttc.enabled = true;
		text_total_montant_ht.visible = true;
		text_total_montant_ttc.visible = true;
		combo_taux_tva.enabled = true;
		combo_taux_tva.visible = true;
	}
	change_label();
}

private function onCreate_facture_client_ligne():void {} 	
private function onUpdate_facture_client_ligne():void {} 	
private function event_facture_client_ligne(e:Event):void {}
private function onPrint_facture_client_ligne():void {
      // Lancer une URL pour l'impression
}
private function beforeCreate_facture_client_ligne():void {
	cle_facture_client_ligne();
} 	
private function beforeUpdate_facture_client_ligne():void {}
private function cle_facture_client_ligne():void {
	// si la clé est vide
	if (text_cle.text==''){
		var txt:Number = Math.random();
		text_cle.text = connexion_facture_client.text+"-"+txt.toString().substr(10,5);
	}
}
public function change_label():void {
	if (combo_taux_tva.text == 'Ancien'){
		tva_affiche.label = "Taux TVA 19.6%";
	}else{
		tva_affiche.label = "Taux TVA 20%";
	}
}

private function calcul_factureClient_ligne():void 
{
	
	if(text_objet_parent.text =="Prestation tourisme d'affaires")
	{
		var somme_montantTTC_TA:Number = Number(text_puttc.text) * Number(text_qte.text)
		text_total_montant_ttc.text = somme_montantTTC_TA.toFixed(2);
	}
	else
	{
		
		if (combo_taux_tva.text == 'Ancien'){
			var prixUnitaireTTC:Number = Number(text_puht.text)*1.196;
			var somme_ht:Number = Number(text_puht.text) * Number(text_qte.text);
			var somme_ttc:Number = (somme_ht*1.196);
		}else{
			var prixUnitaireTTC:Number = Number(text_puht.text)*1.20;
			var somme_ht:Number = Number(text_puht.text) * Number(text_qte.text);
			var somme_ttc:Number = (somme_ht*1.20);
		}
		
			text_puttc.text = prixUnitaireTTC.toFixed(2);
			text_total_montant_ht.text = somme_ht.toFixed(2);
			text_total_montant_ttc.text = somme_ttc.toFixed(2);
		
		if(text_objet_parent.text =="Prestation événementielles")
		{
			if((text_cas.text =='A') || (text_cas.text =='C')|| (text_cas.text =='F'))
			{
				text_total_montant_ht.text = somme_ht.toFixed(2);
				text_total_montant_ttc.text = somme_ttc.toFixed(2);
			}
			else
			{
				text_total_montant_ht.text = somme_ht.toFixed(2);
				text_total_montant_ttc.text = text_total_montant_ht.text;
			}
		}
		if(text_objet_parent.text =="Prestation de services")
		{
			if((text_cas.text=='B') || (text_cas.text=='D') || (text_cas.text=='E') || (text_cas.text=='G') || (text_cas.text=='H') || (text_cas.text=='I'))
			{
				text_total_montant_ht.text = somme_ht.toFixed(2);
				text_total_montant_ttc.text = text_total_montant_ht.text;
			}
			// JRN ici rajouter un else pour prendre en compte les lignes hors TVA des prestation de Service du cas D 
		}
		
	}


}
private function initButton():void
{
}
private function rest_connexion_facture_client_result():void
{
}
