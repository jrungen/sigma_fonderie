import mx.collections.Grouping;
import mx.collections.GroupingCollection;
import mx.collections.GroupingField;
import mx.controls.Alert;

private function type_depense():void{}

private function onLoad_facture_fournisseur():void {
	// si prestation TA on grise les champs HT et TVA
	if (combo_objet.text=='Prestation Tourisme d\'affaires'){
		text_montant_ht_19_6.visible = false;
		text_montant_ht_55.visible = false;
		text_montant_tva_19_6.visible = false;
		text_montant_tva_55.visible = false;
		text_montant_ht.visible = false;
		text_frais_port_ht.visible = false;
		text_montant_tva.visible = false;
		combo_taux_tva.enabled = false;
		combo_taux_tva.visible = false;
	}
	change_label();
	
	// vérif si clé = à vide
	if (mode =='0'){
		if (text_cle.text == ''){
			Alert.show('Attention la fiche N° '+text_numero.text+' ne peut être chargé,\nmerci de réessayer ou de contacter le service Administratif.');
			close();
		}
	}
}

private function initDG():void{
	//Alert.show('test');
	var myGroupColl:GroupingCollection = new GroupingCollection();
	myGroupColl.source = datagrid_FactureFournisseur.dataProvider;
	var group:Grouping = new Grouping();
	var gf:GroupingField = new GroupingField("statut");
	group.fields = [gf];
	myGroupColl.grouping=group;
	datagrid_FactureFournisseur.dataProvider=myGroupColl;
	myGroupColl.refresh();
}

private function onCreate_facture_fournisseur():void {
} 	
private function event_facture_fournisseur(e:Event):void {
}
private function onPrint_facture_fournisseur():void {
      // Lancer une URL pour l'impression
}
private function onUpdate_facture_fournisseur():void 
{

}

private function beforeCreate_facture_fournisseur():void {
		cle_facture_fournisseur();
		//calcul_facture_fournisseur();
}
private function beforeUpdate_facture_fournisseur():void 
{
	calcul_facture_fournisseur();
}

public function cle_facture_fournisseur():void 
{
	// si la clé est vide
	if (text_cle.text==''){
		var txt:Number = Math.random();
		
		text_cle.text = connexion_projet.text+"-"+txt.toString().substr(10,5);
		combo_facture_regle.text = '';
	}
}

public function calcul_commission():void 
{
	if (text_ttc_commission.text =="")
	{
		text_ttc_commission.text = "0";
	}
	else
	{
	text_ttc_commission.text = (Number(text_commission_ht.text) + Number(text_tva_s_commission.text) + Number(text_tva_s_commission_55.text) + Number(text_tva_s_commission_locale.text)).toFixed(2);
	}
}
public function change_label():void {
	if (combo_taux_tva.text == 'Ancien'){
		mht_196.label = "Montant HT 19,6%";
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
		text_montant_ht_19_6.text = montant_ht_196.toFixed(2);
		
		montant_tva_196 = Number(text_montant_ttc.text) - Number(montant_ht_196.toFixed(2));
		text_montant_tva_19_6.text = montant_tva_196.toFixed(2);
	}else{
		montant_ht_20 = Number(text_montant_ttc.text) / 1.20;
		text_montant_ht_19_6.text = montant_ht_20.toFixed(2);
		
		montant_tva_20 = Number(text_montant_ttc.text) - Number(montant_ht_20.toFixed(2));
		text_montant_tva_19_6.text = montant_tva_20.toFixed(2);
	}
}
private function etat_FournisseurPE():void
{
	// CAS A
	if(text_cas.text == 'A'){
		if (combo_objet.text=='Prestation Tourisme d\'affaires')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
			// TVA 5.5, 7 et 19.6		
			text_montant_ht_19_6.visible = false;
			text_montant_ht_55.visible = false;
			text_montant_ht_7.visible = false;				
			text_montant_tva_19_6.visible = false;
			text_montant_tva_55.visible = false;
			text_montant_tva_7.visible = false;
			
			// HT LOCAL
			text_montant_ht_locale.visible = false;
			text_montant_ht_locale_reduit.visible = false;
			text_montant_tva_locale.visible = false;
			text_montant_tva_locale_reduit.visible = false;
			
			// Montant non assujetti
			text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		}// Fin TA
		
		
		if (combo_objet.text=='Prestation événementielles')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = true;
				text_montant_ht_55.visible = true;
				text_montant_tva_19_6.visible = true;
				text_montant_tva_55.visible = true;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
			// TVA 5.5 - 19.6		
			text_montant_ht_19_6.visible = false;
			text_montant_ht_55.visible = false;
			text_montant_tva_19_6.visible = false;
			text_montant_tva_55.visible = false;
			
			// HT LOCAL
			text_montant_ht_locale.visible = false;
			text_montant_ht_locale_reduit.visible = false;
			text_montant_tva_locale.visible = false;
			text_montant_tva_locale_reduit.visible = false;
			
			// Montant non assujetti
			text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		} // Fin PE
	}// Fin cas A

	// CAS B
	if(text_cas.text == 'B'){
		if (combo_objet.text=='Prestation Tourisme d\'affaires')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
			// TVA 5.5, 7 et 19.6		
			text_montant_ht_19_6.visible = false;
			text_montant_ht_55.visible = false;
			text_montant_ht_7.visible = false;				
			text_montant_tva_19_6.visible = false;
			text_montant_tva_55.visible = false;
			text_montant_tva_7.visible = false;
			
			// HT LOCAL
			text_montant_ht_locale.visible = false;
			text_montant_ht_locale_reduit.visible = false;
			text_montant_tva_locale.visible = false;
			text_montant_tva_locale_reduit.visible = false;
			
			// Montant non assujetti
			text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		}// Fin TA
		
		
		if (combo_objet.text=='Prestation événementielles')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = true;
				text_montant_ht_55.visible = true;
				text_montant_tva_19_6.visible = true;
				text_montant_tva_55.visible = true;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
			
			// Montant non assujetti
			text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		} // Fin PE
	}// Fin cas B

	// CAS C
	if(text_cas.text == 'C'){
		if (combo_objet.text=='Prestation Tourisme d\'affaires')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		}// Fin TA
		
		
		if (combo_objet.text=='Prestation événementielles')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = true;
				text_montant_ht_55.visible = true;
				text_montant_tva_19_6.visible = true;
				text_montant_tva_55.visible = true;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		} // Fin PE
	}// Fin cas C	

	// CAS D
	if(text_cas.text == 'D'){
		if (combo_objet.text=='Prestation Tourisme d\'affaires')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		}// Fin TA
		
		
		if (combo_objet.text=='Prestation événementielles')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = true;
				text_montant_ht_55.visible = true;
				text_montant_tva_19_6.visible = true;
				text_montant_tva_55.visible = true;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		} // Fin PE
	}// Fin cas D

	// CAS E
	if(text_cas.text == 'E'){
		if (combo_objet.text=='Prestation Tourisme d\'affaires')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
			
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5, 7 et 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_ht_7.visible = false;				
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				text_montant_tva_7.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		}// Fin TA
		
		
		if (combo_objet.text=='Prestation événementielles')
		{
			//France
			if(connexion_pays.text=='France')
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = true;
				text_montant_ht_55.visible = true;
				text_montant_tva_19_6.visible = true;
				text_montant_tva_55.visible = true;
				
				// HT LOCAL
				text_montant_ht_locale.visible = false;
				text_montant_ht_locale_reduit.visible = false;
				text_montant_tva_locale.visible = false;
				text_montant_tva_locale_reduit.visible = false;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
			//Hors UE
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
	
			// TVA 5.5 - 19.6		
			text_montant_ht_19_6.visible = false;
			text_montant_ht_55.visible = false;
			text_montant_tva_19_6.visible = false;
			text_montant_tva_55.visible = false;
			
			// HT LOCAL
			text_montant_ht_locale.visible = false;
			text_montant_ht_locale_reduit.visible = false;
			text_montant_tva_locale.visible = false;
			text_montant_tva_locale_reduit.visible = false;
			
			// Montant non assujetti
			text_montant_ht_0.visible = true;
			}
			
			//UE
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				// TVA 5.5 - 19.6		
				text_montant_ht_19_6.visible = false;
				text_montant_ht_55.visible = false;
				text_montant_tva_19_6.visible = false;
				text_montant_tva_55.visible = false;
				
				// HT LOCAL
				text_montant_ht_locale.visible = true;
				text_montant_ht_locale_reduit.visible = true;
				text_montant_tva_locale.visible = true;
				text_montant_tva_locale_reduit.visible = true;
				
				// Montant non assujetti
				text_montant_ht_0.visible = true;
			}
			
		} // Fin PE
	}// Fin cas E
	
	// CAS I
	if(text_cas.text == 'I'){

		// TVA 5.5, 7 et 19.6		
		text_montant_ht_19_6.visible = false;
		text_montant_ht_55.visible = false;
		text_montant_ht_7.visible = false;				
		text_montant_tva_19_6.visible = false;
		text_montant_tva_55.visible = false;
		text_montant_tva_7.visible = false;
		
		// HT LOCAL
		text_montant_ht_locale.visible = false;
		text_montant_ht_locale_reduit.visible = false;
		text_montant_tva_locale.visible = false;
		text_montant_tva_locale_reduit.visible = false;
		
		// Montant non assujetti
		text_montant_ht_0.visible = true;

	}// Fin cas I
}

public function calcul_facture_fournisseur():void 
{
	// Montant TTC des lignes de règlements
	var total1:Number = 0;
	total1 = 0;
	
	for each (var row_1:Object in datagrid_FactureFournisseur.dataProvider) {
  		total1 += Number(row_1.acompte_reglement);
  	}
	text_total_acompte.text = total1.toFixed(2);
	
	// Montant HT des lignes de règlements
	var totalHT:Number = 0;
	totalHT = 0;
	
	for each (var row_HT:Object in datagrid_FactureFournisseur.dataProvider) {
  		totalHT += Number(row_HT.acompte_reglement_ht);
  	}
	text_total_acompte_ht.text = totalHT.toFixed(2);
	if(totalHT.toFixed(2)=='0.00'){
		text_total_acompte_ht.text = text_montant_ht.text;
	}
	
	// Total règlement des lignes de règlements
	var total2:Number = 0;
	total2 = 0;
	for each (var row_2:Object in datagrid_FactureFournisseur.dataProvider) {
  		total2 += Number(row_2.acompte_paye);
  	}
	text_total_regle.text = total2.toFixed(2);

	// Montant restant dû
	var total3:Number = 0;
	total3 = Number(text_total_acompte.text) - Number(text_total_regle.text);
	text_montant_restant_du.text = total3.toFixed(2);
	text_montant_restant_du_facturation.text = (Number(text_montant_ttc.text) - Number(text_total_regle.text)).toFixed(2);
	
	/*
	// montant HT 19.6%
	var ht196:Number = 0;
	ht196 = Number(text_montant_ttc.text) / 1.196;
	text_montant_ht_19_6.text = ht196.toFixed(2);
	
	// Montant TVA 19.6%
	var tva196:Number = 0;
	tva196 = Number(text_montant_ttc.text) - Number(text_montant_ht_19_6.text);
	text_montant_tva_19_6.text = tva196.toFixed(2);
	
	// montant HT 5.5%
	var ht55:Number = 0;
	ht55 = Number(text_montant_ttc.text) / 1.055;
	text_montant_ht_55.text = ht55.toFixed(2);
	
	// Montant TVA 5.5%
	var tva55:Number = 0;
	tva55 = Number(text_montant_ttc.text) - Number(text_montant_ht_55.text);
	text_montant_tva_55.text = tva55.toFixed(2);	
	*/
	
	//montant TTC
	var montant_tva_196:Number = 0;
	var montant_tva_55:Number = 0;
	var montant_ht:Number = 0;
	var montant_non_assuj:Number = 0;
	var montant_frais_port:Number = 0;
	var montant_tva:Number = 0;
	var montant_ttc:Number = 0;
	var montant_commission:Number = 0;

	

	/*
	montant_tva_196 = Number(text_montant_ht_19_6.text) * 0.196;
	text_montant_tva_19_6.text =  montant_tva_196.toFixed(2);

	montant_tva_55 = Number(text_montant_ht_55.text) * 0.055;
	text_montant_tva_55.text = montant_tva_55.toFixed(2);
	*/
		
	//TVA Locale...new
	var tva_locale:Number = 0;
	var tva_pays:Number = 0;
	var tva_pays_reduit:Number = 0;
	if(text_taxe_pays.text =='')
	{
		tva_pays = 0;
		tva_pays_reduit = 0;
	}
	else
	{
		tva_pays = Number(text_taxe_pays.text)/100;
		tva_pays_reduit = Number(text_taxe_pays_reduit.text)/100;
	}
	//Calcul TVA local
	
	if (text_montant_ht_locale.text !='')
	{
		text_montant_tva_locale.text  = (Number(text_montant_ht_locale.text) * tva_pays).toFixed(2);	
	}
	//Calcul TVA local reduit
	if (text_montant_ht_locale_reduit.text !='')
	{
		text_montant_tva_locale_reduit.text = (Number(text_montant_ht_locale_reduit.text) * tva_pays_reduit).toFixed(2);
	}
	
	//Total HT
	montant_ht = Number(text_montant_ht_19_6.text) + Number(text_montant_ht_55.text) + Number(text_montant_ht_7.text) + Number(text_montant_ht_0.text) + Number(text_montant_ht_locale.text) + Number(text_montant_ht_locale_reduit.text) + Number(text_frais_port_ht.text);
	text_montant_ht.text = montant_ht.toFixed(2);
	
	//Montant TVA
	montant_tva = Number(text_montant_tva_55.text) + Number(text_montant_tva_19_6.text)+ Number(text_montant_tva_7.text) + Number(text_montant_tva_locale.text)+ Number(text_montant_tva_locale_reduit.text);
	text_montant_tva.text = montant_tva.toFixed(2);
	
	//Commission
	montant_commission = Number(text_commission_ht.text)+Number(text_tva_s_commission.text)+Number(text_tva_s_commission_55.text)+ Number(text_tva_s_commission_locale.text);
	text_ttc_commission.text = montant_commission.toFixed(2);
	
	//Montant TTC
	montant_ttc = Number(text_montant_ht.text) + Number(text_montant_tva.text) + Number(text_frais_port.text) - Number(text_Remise.text) - Number(text_ttc_commission.text);
	text_montant_ttc.text = montant_ttc.toFixed(2);
		
	// Montant_TVA_19_6 = Montant_HT_19_6  * 0.196
	// Montant_HT = Montant_HT_19_6 + Montant_HT_55 + Montant_HT_0
	// montant_ttc = Montant_HT_19_6 + Montant_HT_55 + Montant_HT_0 + Frais_de_port_TTC - Remise + Montant_TVA_19_6 + Montant_TVA_55
	// montant_tva = Montant_TVA_19_6 + Montant_TVA_55
	
	/*
	var RemiseCommission:Number = Number(text_Remise.text) + Number(text_ttc_commission.text);
	var TotalRegleFraisPort:Number = Number(text_total_regle.text)+Number(text_frais_port.text);
	var MontantTTC_final:Number = TotalRegleFraisPort - RemiseCommission;
	text_montant_ttc.text = MontantTTC_final.toFixed(2);
	*/

	//verifie si le montant ttc = total reglément
	trace(text_montant_restant_du.text);
	if(text_montant_restant_du.text =='0.00')
	{
		combo_action.text ="";
	}
	
	
	if(text_montant_ttc.text == text_total_regle.text)
	{ 
		combo_facture_regle.text = "Réglé";
	}
	else
	{
		combo_facture_regle.text = "A régler";
	}	
	
}
private function calcul_TVA():void {
	var montant_tva_196:Number = 0;
	var montant_tva_55:Number = 0;
	var montant_tva_7:Number = 0;
	var montant_tva_20:Number = 0;
	var montant_tva_10:Number = 0;

	// JRN mise à jour le 15/11/2013
	if (combo_taux_tva.text == 'Ancien'){
		montant_tva_196 = Number(text_montant_ht_19_6.text) * 0.196;
		text_montant_tva_19_6.text =  montant_tva_196.toFixed(2);
	
		montant_tva_55 = Number(text_montant_ht_55.text) * 0.055;
		text_montant_tva_55.text = montant_tva_55.toFixed(2);
	
		montant_tva_7 = Number(text_montant_ht_7.text) * 0.07;
		text_montant_tva_7.text = montant_tva_7.toFixed(2);
	}else{
		montant_tva_20 = Number(text_montant_ht_19_6.text) * 0.20;
		text_montant_tva_19_6.text =  montant_tva_20.toFixed(2);
	
		montant_tva_55 = Number(text_montant_ht_55.text) * 0.055;
		text_montant_tva_55.text = montant_tva_55.toFixed(2);
	
		montant_tva_10 = Number(text_montant_ht_7.text) * 0.10;
		text_montant_tva_7.text = montant_tva_10.toFixed(2);
	}

}

private function calcul_HT_avec_TVA():void {
	var montant_ht_tva_196:Number = 0;
	var montant_ht_tva_55:Number = 0;
	var montant_ht_tva_7:Number = 0;
	var montant_ht_tva_20:Number = 0;
	var montant_ht_tva_10:Number = 0;

	// JRN mise à jour le 15/11/2013
	if (combo_taux_tva.text == 'Ancien'){
		montant_ht_tva_196 = Number(text_montant_tva_19_6.text) / 0.196;
		text_montant_ht_19_6.text = montant_ht_tva_196.toFixed(2)
		
		montant_ht_tva_55 = Number(text_montant_tva_55.text) / 0.055;
		text_montant_ht_55.text = montant_ht_tva_55.toFixed(2);
	
		montant_ht_tva_7 = Number(text_montant_tva_7.text) / 0.07;
		text_montant_ht_7.text = montant_ht_tva_7.toFixed(2);
	}else{
		montant_ht_tva_20 = Number(text_montant_tva_19_6.text) / 0.20;
		text_montant_ht_19_6.text = montant_ht_tva_20.toFixed(2)
		
		montant_ht_tva_55 = Number(text_montant_tva_55.text) / 0.055;
		text_montant_ht_55.text = montant_ht_tva_55.toFixed(2);
	
		montant_ht_tva_10 = Number(text_montant_tva_7.text) / 0.10;
		text_montant_ht_7.text = montant_ht_tva_10.toFixed(2);
	}

}

// Bouton verification du TVA Intracommunautaire
//private var Btn_VerifTVA:Button = new Button();

private function initButton():void {
	/*
	// Création du bouton Btn_VerifTVA
	Btn_VerifTVA.x = 2;
	Btn_VerifTVA.y = 272;
	//Btn_VerifTVA.id="btn_facture_fournisseur_ligne_convert";
	Btn_VerifTVA.label = "Lien TVA";
	Btn_VerifTVA.addEventListener(MouseEvent.CLICK,Verif_TVA)
	tab_facture_fournisseur_règlement.addChild(Btn_VerifTVA);
	*/
	  var myGroupColl:GroupingCollection = new GroupingCollection();
      myGroupColl.source = datagrid_FactureFournisseur.dataProvider;
      var group:Grouping = new Grouping();
      var gf:GroupingField = new GroupingField("statut");
      group.fields = [gf];
      myGroupColl.grouping=group;
      datagrid_FactureFournisseur.dataProvider=myGroupColl;
      myGroupColl.refresh();
}

private function Verif_TVA(e:Event):void{
	// Redirection vers une URL
	navigateToURL( new URLRequest( 'http://en.wikipedia.org/wiki/Tax_rates_around_the_world'), "_blank" );
}

private function rest_connexion_pays_result():void
{
	text_taxe_pays.text = rest_connexion_pays.lastResult.paysList.item.taux_tva_normal;
	text_taxe_pays_reduit.text = rest_connexion_pays.lastResult.paysList.item.taux_tva_reduit;
}

private function rest_connexion_pays_send():void
{
	rest_connexion_pays.url = "paysList.php?field=cle&search="+connexion_pays.text+"&view=Par défaut";
    rest_connexion_pays.send();
}

private function rest_connexion_projet_result():void
{
}
private function rest_connexion_utilisateur_result():void
{
}


public function style_datagrid_FactureFournisseur2(data:Object, col:AdvancedDataGridColumn):Object{
      if (data["statut"]=='A régler'){
            return{color:0xFF0000,fontWeight:"bold"}
      }
      return null;
}
