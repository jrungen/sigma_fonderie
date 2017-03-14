import mx.formatters.NumberFormatter;
import mx.formatters.NumberBaseRoundType;
import mx.controls.Alert;
/*
//Formattage des champs de données numériques
private var afficheFormat:NumberFormatter = new NumberFormatter();
private function numFormat():void
{

	//afficheFormat.decimalSeparatorTo = ".";
	afficheFormat.precision = 2;
	afficheFormat.useThousandsSeparator;
	//afficheFormat.rounding = NumberBaseRoundType.UP;
	//afficheFormat.thousandsSeparatorTo = " ";

	text_recette1_previsionnelle.text =  afficheFormat.format(text_recette1_previsionnelle.text);
	text_depense1_previsionnelle.text =  afficheFormat.format(text_depense1_previsionnelle.text);
	text_recette2_previsionnelle.text =  afficheFormat.format(text_recette2_previsionnelle.text);
	text_depense2_previsionnelle.text =  afficheFormat.format(text_depense2_previsionnelle.text);

	text_marge1_previsionnelle.text = afficheFormat.format(text_marge1_previsionnelle.text);
	text_marge2_previsionnelle.text = afficheFormat.format(text_marge2_previsionnelle.text);

}

private function afficherNombre(value:Number):String 
{
	return afficheFormat.format(value);
}
*/
private function onLoad_projet():void 
{
	//initialise le statut à En cours au lancement
	if(combo_statut.text =='(...)')
	{
		combo_statut.text = 'En cours';
	}
	// appel de la fonction localisation
	if(Application.application.gsProfil !='user')
	{
		localisation();
		
	}
	
	// USER 
	if(Application.application.gsProfil =='user')
	{	
		combo_statut.enabled = false;
		if(combo_type.text=='')
		{
			localisation();
		}
		else
		{
			localisation();
			if(combo_type.text=='INTERNATIONAL HORS UE')
			{
				text_recette2_previsionnelle.enabled = false;
				text_depense2_previsionnelle.enabled = false;
			}
			//déactiver les champs obligatoires dans l'onglet Dossier
			combo_type.enabled = false;
			//combo_type.disabledAlpha = 0.05;
			combo_nom.enabled = false;
			text_numero_code.enabled = false;
			combo_pays.enabled = false;
			connexion_societe.enabled = false;
			text_lieu.enabled = false;
			date_datedebut.enabled = false;
			date_datefin.enabled = false;
			
			//déactiver les champs obligatoires dans l'onglet Client T.Affaires
			//datagrid_ProjetFactureClientTourismeAffaire.enabled=false;
			//datagrid_ProjetFactureAvoirClientTourismeAffaire.enabled=false;
			//datagrid_ProjetFactureClientAutreTourismeAffaire.enabled=false;
			
			//si une pièce jointe est attachée
			if(fichier_text_pj1_previsionnelle.text!='')
			{
				fichier_text_pj1_previsionnelle.enabled = false;
			}
			if(fichier_text_pj2_previsionnelle.text!='')
			{
				fichier_text_pj2_previsionnelle.enabled = false;
			}	
			if(fichier_text_pj3_previsionnelle.text!='')
			{
				fichier_text_pj3_previsionnelle.enabled = false;
			}

		}
	}
	//initialise le statut à En cours au lancement
	if((combo_statut.text =="Terminé")&&(Application.application.gsProfil =='user'))
	{
		
		text_numero.enabled = false;
		connexion_utilisateur.enabled = false;
		text_recette1_previsionnelle.enabled = false;
		text_depense1_previsionnelle.enabled = false;
		text_marge1_previsionnelle.enabled = false;
		fichier_text_pj1_previsionnelle.enabled = false;
		fichier_text_pj3_previsionnelle.enabled = false;
		fichier_text_pj2_previsionnelle.enabled = false;
		//btn_parcourir_pj1_previsionnelle.enabled = false;
		//btn_parcourir_pj2_previsionnelle.enabled = false;
		//btn_parcourir_pj2_previsionnelle.enabled = false;
		//btn_ouvrir_pj1_previsionnelle.enabled = false;
		//btn_ouvrir_pj2_previsionnelle.enabled = false;
		//btn_ouvrir_pj3_previsionnelle.enabled = false;
		combo_pj_confirmee.enabled = false;
		date_date1_previsionnelle.enabled = false;
		date_date2_previsionnelle.enabled = false;
		date_date3_previsionnelle.enabled = false;
		combo_pj_confirmee.enabled = false;
	}
	//Griser marge
	text_marge1_previsionnelle.enabled = false;
	text_marge2_previsionnelle.enabled = false;

}

private function onCreate_projet():void 
{
	//cle_projet()

} 

private function event_projet(e:Event):void{
}

public function cle_projet(e:Event):void {
	text_cle.text = text_numero.text;
}



private function onPrint_projet():void 
{
      // Lancer une URL pour l'impression
}
private function onUpdate_projet():void 
{
	//cle_projet()
	//Alert.show(connexion_societe.toString());
	
}

// A la création d'une nouvelle fiche
private function beforeCreate_projet():void 
{
//	cle_projet();
} 	  	 	

private function beforeUpdate_projet():void 
{

}


private function localisation():void 
{
	tab_projet.addChild(tab_projet_ta_factures_client);
	tab_projet.addChild(tab_projet_pe_ta_factures_client);
	tab_projet.addChild(tab_projet_ta_factures_four);
	tab_projet.addChild(tab_projet_pe_factures_four);
	tab_projet.addChild(tab_projet_depenses_annexes);
	tab_projet.addChild(tab_projet_synthese);
      // A la création la localisatione est vide
      if(combo_type.text=='')
      {
            tab_projet.removeChild(tab_projet_ta_factures_client);
            tab_projet.removeChild(tab_projet_pe_ta_factures_client);
            tab_projet.removeChild(tab_projet_ta_factures_four);
            tab_projet.removeChild(tab_projet_pe_factures_four);
            tab_projet.removeChild(tab_projet_depenses_annexes);
            tab_projet.removeChild(tab_projet_synthese);
       }
     
      //FRANCE ET UE
      if(combo_type.text=='FRANCE ET UNION EUROPEENNE')
      {
            tab_projet.addChild(tab_projet_ta_factures_client);
            tab_projet.addChild(tab_projet_pe_ta_factures_client);
            tab_projet.addChild(tab_projet_ta_factures_four);
            tab_projet.addChild(tab_projet_pe_factures_four);
            tab_projet.addChild(tab_projet_depenses_annexes);
            tab_projet.addChild(tab_projet_synthese);
            //Dégriser les onglets
			text_recette2_previsionnelle.enabled = true;
			text_depense2_previsionnelle.enabled = true;
			//text_marge2_previsionnelle.enabled = true;
      }
 		
 
 
      //INTERNATIONAL HORS UE
      if(combo_type.text=='INTERNATIONAL HORS UE')
      {
            tab_projet.addChild(tab_projet_ta_factures_client);
            tab_projet.addChild(tab_projet_ta_factures_four);
            tab_projet.addChild(tab_projet_depenses_annexes);
            tab_projet.addChild(tab_projet_synthese);

            
            tab_projet.removeChild(tab_projet_pe_ta_factures_client);
            tab_projet.removeChild(tab_projet_pe_factures_four);
            
            text_recette2_previsionnelle.enabled = false;
			text_depense2_previsionnelle.enabled = false;
			//text_marge2_previsionnelle.enabled = false;
      }
     /*
      //PRESTATION SERVICE
       	if(combo_type.text=='PRESTATION SERVICES')
		{
			
			
		}
	*/	
       
}


private function pays():void
{
	
	if(combo_type.text=='INTERNATIONAL HORS UE')
	{ 
		trace(combo_type.text);
		if((combo_pays.text=='Allemagne')||(combo_pays.text=='Autriche') || (combo_pays.text=='Autriche') || (combo_pays.text=='Belgique') || (combo_pays.text=='Bulgarie') || (combo_pays.text=='Chypre') || (combo_pays.text=='Danemark') || (combo_pays.text=='Espagne') || (combo_pays.text=='Estonie') || (combo_pays.text=='Finlande') || (combo_pays.text=='France') || (combo_pays.text=='Grèce') || (combo_pays.text=='Hongrie') || (combo_pays.text=='Irlande') || (combo_pays.text=='Italie') || (combo_pays.text=='Lettonie') || (combo_pays.text=='Lituanie') || (combo_pays.text=='Luxembourg') || (combo_pays.text=='Malte') || (combo_pays.text=='Pays-Bas') || (combo_pays.text=='Pologne') || (combo_pays.text=='Portugal') || (combo_pays.text=='République tchèque') || (combo_pays.text=='Roumanie') || (combo_pays.text=='Royaume-Uni') || (combo_pays.text=='Slovaquie') || (combo_pays.text=='Slovénie')|| (combo_pays.text=='Suède'))
		{
			trace(combo_pays.text);
			combo_type.text='FRANCE ET UNION EUROPEENNE';
			localisation();
		}
	}
	
	if(combo_type.text=='FRANCE ET UNION EUROPEENNE')
	{
		trace(combo_type.text);
		if((combo_pays.text!='Allemagne') && (combo_pays.text!='Autriche')  && (combo_pays.text!='Belgique') && (combo_pays.text!='Bulgarie') && (combo_pays.text!='Chypre') && (combo_pays.text!='Danemark') && (combo_pays.text!='Espagne') && (combo_pays.text!='Estonie') && (combo_pays.text!='Finlande') && (combo_pays.text!='France') && (combo_pays.text!='Grèce') && (combo_pays.text!='Hongrie') && (combo_pays.text!='Irlande') && (combo_pays.text!='Italie') && (combo_pays.text!='Lettonie') && (combo_pays.text!='Lituanie') && (combo_pays.text!='Luxembourg') && (combo_pays.text!='Malte') && (combo_pays.text!='Pays-Bas') && (combo_pays.text!='Pologne') && (combo_pays.text!='Portugal') && (combo_pays.text!='République tchèque') && (combo_pays.text!='Roumanie') && (combo_pays.text!='Royaume-Uni') && (combo_pays.text!='Slovaquie') && (combo_pays.text!='Slovénie') && (combo_pays.text!='Suède'))
		{
			trace(combo_pays.text);
			combo_type.text='INTERNATIONAL HORS UE';
			localisation();
		}	
	}
	
}

public function synthese():void
{
	//Déclarer les propriétés du NumberFormatter
	//afficheFormat.decimalSeparatorTo = ".";
	//afficheFormat.precision = 2;
	//afficheFormat.useThousandsSeparator;
	//afficheFormat.rounding = NumberBaseRoundType.UP;
	//afficheFormat.thousandsSeparatorTo = " ";
	////////////////////////////////////////////////
	// Prestation TA
	////////////////////////////////////////////////
	
	// Montant recette TTC = Facture client - avoir
	var total:Number = 0;
	var total1:Number = 0; // Recette client
	var total2:Number = 0; // Avoir client
	for each (var row1:Object in datagrid_ProjetFactureClientTourismeAffaire.dataProvider) {
  		total1 += Number(row1.montant_ttc);
  	}
	  	
	for each (var row2:Object in datagrid_ProjetFactureAvoirClientTourismeAffaire.dataProvider) {
  		total2 += Number(row2.montant_ttc);
  	}
  	total = total1-total2;	
	text_ta_montant_recette_ttc.text = total.toString();

	// Total factures Accompagnants
	total2 = 0;
	for each (var row_acc:Object in datagrid_ProjetFactureClientAccTourismeAffaire.dataProvider) {
  		total2 += Number(row_acc.montant_ttc);
  	}
	text_ta_montant_recette_accompagnant.text = total2.toString();
	
	// Montant recette total TTC
	var result:Number = 0;
	result = Number(text_ta_montant_recette_accompagnant.text) + Number(text_ta_montant_recette_ttc.text);
	text_ta_montant_recette_total_ttc.text = result.toString();
	
	// Montant Dépenses TTC = Facture fournisseur - avoir 
	total1=0;
	total2=0
	for each (var row3:Object in datagrid_ProjetFactureFournisseurTourismeAffaire.dataProvider) {
  		total1 += Number(row3.montant_ttc);
  	}
	  	
	for each (var row4:Object in datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.dataProvider) {
  		total2 += Number(row4.montant_ttc);
  	}
  	total = total1-total2;	
	text_ta_montant_depense_ttc.text = total.toFixed();
	
	// Marge TA
	var marge:Number = 0;
	marge = Number(text_ta_montant_recette_total_ttc.text) - Number(text_ta_montant_depense_ttc.text);
	text_ta_marge_ttc.text = marge.toFixed();
		
	////////////////////////////////////////////////
	// Prestation PE
	////////////////////////////////////////////////
	
	// Montant recette HT
	total1=0;
	total2=0;
	for each (var row_recette_pe:Object in datagrid_ProjetFactureClientPrestationEvenementielle.dataProvider) {
  		total1 += Number(row_recette_pe.montant_ht);
  	}
	  	
	for each (var row_recette_pe_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.dataProvider) {
  		total2 += Number(row_recette_pe_avoir.montant_ht);
  	}
  	total = total1-total2;	
	text_pe_montant_recette_ht.text = total.toFixed();

	// Montant dépenses HT
	total1=0;
	total2=0
	for each (var row_depense_pe:Object in datagrid_ProjetFactureFournisseurPrestationsEvenementielles.dataProvider) {
  		total1 += Number(row_depense_pe.montant_ht);
  	}
	  	
	for each (var row_depense_pe_avoir:Object in datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.dataProvider) {
  		total2 += Number(row_depense_pe_avoir.montant_ht);
  	}
  	total = total1-total2;	
	text_pe_montant_depense_ht.text = total.toFixed();	
	
	//Marge HT
	marge = Number(text_pe_montant_recette_ht.text) - Number(text_pe_montant_depense_ht.text);
	text_ta_marge_ht.text = marge.toFixed();
	
	
	////////////////////////////////////////////////
	// SYNTHESE
	////////////////////////////////////////////////

}

public function marge_ta():void
{
	//proprietes de formattage de la marge
	//afficheFormat.precision = 2;
	//afficheFormat.useThousandsSeparator;
	//
	var result:Number;
	result = Number(text_recette1_previsionnelle.text) - Number(text_depense1_previsionnelle.text);
	text_marge1_previsionnelle.text = result.toFixed();
	//formattage de la marge
	//text_marge1_previsionnelle.text = afficheFormat.format(text_marge1_previsionnelle.text);
	//text_recette1_previsionnelle.text = afficheFormat.format(text_recette1_previsionnelle.text);
	//text_depense1_previsionnelle.text = afficheFormat.format(text_depense1_previsionnelle.text);
}

public function marge_pe_ps():void
{
	//proprietes de formattage de la marge
	//afficheFormat.precision = 2;
	//afficheFormat.useThousandsSeparator;
	//
	var result2:Number;
	result2 = Number(text_recette2_previsionnelle.text) - Number(text_depense2_previsionnelle.text);
	text_marge2_previsionnelle.text = result2.toFixed();
	//formattage de la marge
	//text_marge2_previsionnelle.text = afficheFormat.format(text_marge2_previsionnelle.text);
}

public function AdminReinitRecette():void
{
	if(Application.application.gsProfil !='user')
	{
		text_recette2_previsionnelle.text = '0';
		text_depense2_previsionnelle.text = '0';
		text_marge2_previsionnelle.text = '0';
	}
}

public function confirmePieceJointe():void
{
	if(Application.application.gsProfil =='user')
	{
		/*
		if(combo_pj_confirmee.text!="")
		{
			//var numConfirme:Number = Number(combo_pj_confirmee.text);
			var fichierPJ:String = "fichier_text_pj"+combo_pj_confirmee.text+"_previsionnelle";
			fichierPJ.enabled = false;
		}
		*/
		if(combo_pj_confirmee.text=='1')
		{
			fichier_text_pj1_previsionnelle.enabled =false;
			combo_pj_confirmee.enabled =false;
		}
		if(combo_pj_confirmee.text=='2')
		{
			fichier_text_pj3_previsionnelle.enabled =false;
			combo_pj_confirmee.enabled =false;
		}
		if(combo_pj_confirmee.text=='3')
		{
			fichier_text_pj2_previsionnelle.enabled =false;
			combo_pj_confirmee.enabled =false;
		}
		
	}
}