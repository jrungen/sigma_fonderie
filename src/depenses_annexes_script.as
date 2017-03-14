import flash.events.Event;

import mx.controls.Alert;
import mx.controls.Label;
private function onLoad_depenses_annexes():void 
{
	if(date_date.text==''){
		combo_statut.text='A régler';
	}
	
	if (combo_objet.text != 'Prestation Tourisme d\'affaires'){
		combo_taux_tva.enabled = true;
		combo_taux_tva.visible = true;
	}else{		
		combo_taux_tva.enabled = false;
		combo_taux_tva.visible = false;
	}	
	change_label();
	
	// vérif si clé = à vide
	if (mode == '0'){
		if (text_cle.text == ''){
			Alert.show('Attention la fiche N° '+text_cle.text+' ne peut être chargé,\nmerci de réessayer ou de contacter le service Administratif.');
			close();
		}
	}
	
}
private function onCreate_depenses_annexes():void {}
private function onUpdate_depenses_annexes():void {}
private function event_depenses_annexes(e:Event):void {}
private function onPrint_depenses_annexes():void {
      // Lancer une URL pour l'impression
	navigateToURL( new URLRequest( 'modele/word_depense_annexe.php?id='+text_iddepenses_annexes.text+'&file=lettre_cheque_depense_annexe.xml'), "_blank" );
}
private function imprimer2():void {
      // Lancer une URL pour l'impression
	navigateToURL( new URLRequest( 'modele/word_depense_annexe.php?id='+text_iddepenses_annexes.text+'&file=lettre_cheque_depense_annexe_hsbc.xml'), "_blank" );
}
private function beforeCreate_depenses_annexes():void 
{
	cle_depensesAnnexes();
}
private function beforeUpdate_depenses_annexes():void {

}
public function cle_depensesAnnexes():void {
	// si la clé est vide
	var temps:Date = new Date();
	if (text_cle.text==''){
		text_cle.text = connexion_projet.text+"/"+temps.getTime();
	}
} 
public function casVirementRip():void 
{
	if(combo_reglements.text != "Virement")
	{
		memo_rib.enabled = false;	
	}
	else
	{
		memo_rib.enabled = true;	
	}
}
public function change_label():void {
	if (combo_taux_tva.text == 'Ancien'){
		mht_196.label = "Montant HT 19.6%";
		mht_7.label = "Montant HT 7%";
		mtva_196.label = "Montant TVA 19.6%";
		mtva_7.label = "Montant TVA 7%";
	}else{
		mht_196.label = "Montant HT 20%";
		mht_7.label = "Montant HT 10%";
		mtva_196.label = "Montant TVA 20%";
		mtva_7.label = "Montant TVA 10%";
	}
}
public function tva_inverse():void {
	// JRN mise à jour le 15/11/2013
	var montant_ht_196:Number = 0;
	var montant_ht_20:Number = 0;
	var montant_tva_196:Number = 0;
	var montant_tva_20:Number = 0;
	
	if (combo_taux_tva.text == 'Ancien'){
		montant_ht_196 = Number(text_montant_ttc.text) / 1.196;
		text_montant_ht_196.text = montant_ht_196.toFixed(2);
		
		montant_tva_196 = Number(text_montant_ttc.text) - Number(montant_ht_196.toFixed(2));
		text_montant_tva_196.text = montant_tva_196.toFixed(2);
	}else{
		montant_ht_20 = Number(text_montant_ttc.text) / 1.20;
		text_montant_ht_196.text = montant_ht_20.toFixed(2);
		
		montant_tva_20 = Number(text_montant_ttc.text) - Number(montant_ht_20.toFixed(2));
		text_montant_tva_196.text = montant_tva_20.toFixed(2);
	}
}
public function calcul_depense_annexe():void {
	
	// montant TTC
	var montant_tva_196:Number = 0;
	var montant_tva_55:Number = 0;
	var montant_tva_7:Number = 0;
	var montant_tva_20:Number = 0;
	var montant_tva_10:Number = 0;
	var total_ht:Number = 0;
	var montant_ht:Number = 0;
	var montant_non_assuj:Number = 0;
	var montant_frais_port:Number = 0;
	var montant_tva:Number = 0;
	var montant_ttc:Number = 0;
	var montant_restant:Number = 0;
	// Label JRN mise à jour le 20/11/2013
	var label_tva_196:Label;
	var label_ht_196:Label;
	var label_tva_7:Label;
	var label_ht_7:Label;

	// JRN mise à jour le 15/11/2013
	if (combo_taux_tva.text == 'Ancien'){
		
		montant_tva_196 = Number(text_montant_ht_196.text) * 0.196;
		text_montant_tva_196.text =  montant_tva_196.toFixed(2);
	
		montant_tva_55 = Number(text_montant_ht_55.text) * 0.055;
		text_montant_tva_55.text = montant_tva_55.toFixed(2);
	
		montant_tva_7 = Number(text_montant_ht_7.text) * 0.07;
		text_montant_tva_7.text = montant_tva_7.toFixed(2);
	
		total_ht = Number(text_montant_ht_196.text) + Number(text_montant_ht_55.text)+ Number(text_montant_ht_7.text);
		text_total_ht.text = total_ht.toFixed(2);
		
		montant_tva = Number(text_montant_tva_55.text) + Number(text_montant_tva_196.text)+ Number(text_montant_tva_7.text);
		text_montant_tva.text = montant_tva.toFixed(2);
		
		montant_ht = Number(text_total_ht.text) + Number(text_montant_na_tva.text);
		text_montant_ht.text = montant_ht.toFixed(2);
	
		montant_ttc = Number(text_montant_ht.text) + Number(text_montant_tva.text);
		text_montant_ttc.text = montant_ttc.toFixed(2);
		
		montant_restant = Number(text_montant_ttc.text) - Number(text_total_reglement.text);
		text_montant_restant_du.text = montant_restant.toFixed(2);
	}else{
		
		montant_tva_20 = Number(text_montant_ht_196.text) * 0.20;
		text_montant_tva_196.text =  montant_tva_20.toFixed(2);
	
		montant_tva_55 = Number(text_montant_ht_55.text) * 0.055;
		text_montant_tva_55.text = montant_tva_55.toFixed(2);
	
		montant_tva_10 = Number(text_montant_ht_7.text) * 0.10;
		text_montant_tva_7.text = montant_tva_10.toFixed(2);
	
		total_ht = Number(text_montant_ht_196.text) + Number(text_montant_ht_55.text)+ Number(text_montant_ht_7.text);
		text_total_ht.text = total_ht.toFixed(2);
		
		montant_tva = Number(text_montant_tva_55.text) + Number(text_montant_tva_196.text)+ Number(text_montant_tva_7.text);
		text_montant_tva.text = montant_tva.toFixed(2);
		
		montant_ht = Number(text_total_ht.text) + Number(text_montant_na_tva.text);
		text_montant_ht.text = montant_ht.toFixed(2);
	
		montant_ttc = Number(text_montant_ht.text) + Number(text_montant_tva.text);
		text_montant_ttc.text = montant_ttc.toFixed(2);
		
		montant_restant = Number(text_montant_ttc.text) - Number(text_total_reglement.text);
		text_montant_restant_du.text = montant_restant.toFixed(2);
	}
}
private function initButton():void{}
private function rest_connexion_projet_result():void{}
private function rest_connexion_utilisateur_result():void{}
private function rest_connexion_pays_result():void{}
private function rest_connexion_tiers_result():void{}