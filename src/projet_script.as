import flash.events.Event;

import mx.controls.Alert;
import mx.printing.*;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

private function onLoad_projet():void 
{
	
	//initialise le statut à En cours au lancement
	if(combo_statut.text =='(...)')
	{
		combo_statut.text = 'En cours';
	}

	// appel de la fonction localisation
	localisation();

	// USER 
	if(Application.application.gsProfil =='user'){	

		combo_statut.enabled = false;
		// Désactiver les boutons suppression si profil = USER
		btn_Delete_ProjetFactureClientTourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureAvoirClientTourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureClientAccTourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureAutrestourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureClientPrestationEvenementielle.enabled = false;
		btn_Delete_ProjetFactureAvoirsClientPrestationEvenementielle.enabled = false;
		btn_Delete_ProjetFactureClientAutrePrestationEvenementielle.enabled = false;
		btn_Delete_ProjetFactureClientPrestationService.enabled = false;
		btn_Delete_ProjetFactureAvoirsClientPrestationServices.enabled = false;
		btn_Delete_ProjetFactureClientAutrePrestationServices.enabled = false;
		btn_Delete_ProjetFactureFournisseurTourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureAvoirFournisseurTourismeAffaire.enabled = false;
		btn_Delete_ProjetFactureFournisseurPrestationsEvenementielles.enabled = false;
		btn_Delete_ProjetFctAvFournisseurPrestationsEvenementielles.enabled = false;
		btn_Delete_ProjetFactureFournisseurPrestationsServices.enabled = false;
		btn_Delete_ProjetFctAvFournisseurPrestationsServices.enabled = false;
		btn_Delete_ProjetFactureDepensesAnnexesPEPS.enabled = false;
		btn_Delete_ProjetFactureDepensesAnnexesTA.enabled = false;

		if(combo_type.text!='')
		{
			confirmePieceJointe();
			//déactiver les champs obligatoires dans l'onglet Dossier
			combo_type.enabled = false;
			combo_nom.enabled = false;
			text_numero_code.enabled = false;
			connexion_pays.enabled = false;
			connexion_societe.enabled = false;
			text_lieu.enabled = false;
			date_datedebut.enabled = false;
			date_datefin.enabled = false;
			text_nb_reunion_prev.enabled = false;
			text_nb_reunion_confirme.enabled = false;
			
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
		fichier_text_pj1_previsionnelle.enabled = false;
		fichier_text_pj3_previsionnelle.enabled = false;
		fichier_text_pj2_previsionnelle.enabled = false;
		combo_pj_confirmee.enabled = false;
		date_date1_previsionnelle.enabled = false;
		date_date2_previsionnelle.enabled = false;
		date_date3_previsionnelle.enabled = false;
		combo_pj_confirmee.enabled = false;
		
		// Griser les boutons ajout sir statut = 'Terminé' et prodfil = 'USER'
		btn_Add_ProjetFactureClientTourismeAffaire.enabled = false;
		btn_Add_ProjetFactureAvoirClientTourismeAffaire.enabled = false;
		btn_Add_ProjetFactureClientAccTourismeAffaire.enabled = false;
		btn_Add_ProjetFactureAutrestourismeAffaire.enabled = false;
		btn_Add_ProjetFactureClientPrestationEvenementielle.enabled = false;
		btn_Add_ProjetFactureAvoirsClientPrestationEvenementielle.enabled = false;
		btn_Add_ProjetFactureClientAutrePrestationEvenementielle.enabled = false;
		btn_Add_ProjetFactureClientPrestationService.enabled = false;
		btn_Add_ProjetFactureAvoirsClientPrestationServices.enabled = false;
		btn_Add_ProjetFactureClientAutrePrestationServices.enabled = false;
		btn_Add_ProjetFactureFournisseurTourismeAffaire.enabled = false;
		btn_Add_ProjetFactureAvoirFournisseurTourismeAffaire.enabled = false;
		btn_Add_ProjetFactureFournisseurPrestationsEvenementielles.enabled = false;
		btn_Add_ProjetFctAvFournisseurPrestationsEvenementielles.enabled = false;
		btn_Add_ProjetFactureFournisseurPrestationsServices.enabled = false;
		btn_Add_ProjetFctAvFournisseurPrestationsServices.enabled = false;
		btn_Add_ProjetFactureDepensesAnnexesPEPS.enabled = false;
		btn_Add_ProjetFactureDepensesAnnexesTA.enabled = false;
	}
	//Griser marge
	text_marge1_previsionnelle.enabled = false;
	text_marge2_previsionnelle.enabled = false;
	
	// vérif si clé = à vide
	if (mode == '0'){
		if (text_cle.text == ''){
			Alert.show('Attention la fiche N° '+text_numero.text+' ne peut être chargé,\nmerci de réessayer ou de contacter le service Administratif.');
			close();
		}
	}

}

private function onCreate_projet():void 
{
	//cle_projet()

} 	

private function event_projet(e:Event):void {
    //connexion_pays.addEventListener(Event.RENDER, myEventHandler);
    tab_projet.addEventListener(Event.CHANGE,refresh_tab);
    tab_projet.addEventListener(KeyboardEvent.KEY_DOWN,keyPressed);
   // datagrid_ProjetFactureClientTourismeAffaire.addEventListener(Event.RENDER,refresh_projet);
}

public function refresh_tab(e:Event):void {
	if (tab_projet.selectedIndex==1)
		{
			/*
			if(mode="1"){
				// Récupérer un numéro de projet et enregistrer la fiche
				numero();
				mode="0";
			}
			*/
		}


	if(combo_type.text=='PRESTATION SERVICES')
	{
		if (tab_projet.selectedIndex==5)
		{
			synthese();
		}
	}	
	
	if(combo_type.text=='AUTRES')
	{
	//trace(tab_projet.getTabAt(tab_projet.selectedIndex));
		if (tab_projet.selectedIndex==7){
			//trace(tab_projet.selectedIndex);
			synthese();
		}
	}
}

private function keyPressed(evt:KeyboardEvent):void{}

private function onPrint_projet():void 
{
      // Lancer une URL pour l'impression
	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=synthese&cle='+text_cle.text+'&tri='+combo_impression_tri_synthese.text), "_blank" );
  	//imprimer01();
}

public function imprimer01():void
{
	//Instance de la classe FlexPrintJob
	var imprime:FlexPrintJob = new FlexPrintJob();
	if (imprime.start() != true)
	{ 
	return;
	}
	// Ajouter les objets(composants) à imprimer.
    imprime.addObject(tab_projet_affaire, FlexPrintJobScaleType.SHOW_ALL);
    // Envoyer à l'imprimante
    imprime.send();
	
}  

private function onUpdate_projet():void {}

// A la création d'une nouvelle fiche
private function beforeCreate_projet():void 
{
	//cle_projet();
	synthese();
} 	  	 	

private function beforeUpdate_projet():void 
{
	synthese();

}

public function cle_projet():void {
	// si la clé est vide
	//if(text_numero.text==''){
		//numero();
	//}
}


private function localisation():void 
{
	tab_projet.addChild(tab_projet_action);
	tab_projet.addChild(tab_projet_ta_factures_client);
	tab_projet.addChild(tab_projet_pe_ta_factures_client);
	tab_projet.addChild(tab_projet_ps_factures_client);
	tab_projet.addChild(tab_projet_ta_factures_four);
	tab_projet.addChild(tab_projet_pe_factures_four);
	tab_projet.addChild(tab_projet_ps_factures_four);
	tab_projet.addChild(tab_projet_depenses_annexes);
	tab_projet.addChild(tab_projet_synthese);
	tab_projet.addChild(tab_projet_satisfaction);
	tab_projet.addChild(tab_projet_systeme);
	//test affichage système
      // A la création la localisatione est vide
      if(combo_type.text=='')
      {
            tab_projet.removeChild(tab_projet_ta_factures_client);
            tab_projet.removeChild(tab_projet_pe_ta_factures_client);
            tab_projet.removeChild(tab_projet_ps_factures_client);
            tab_projet.removeChild(tab_projet_ta_factures_four);
            tab_projet.removeChild(tab_projet_pe_factures_four);
            tab_projet.removeChild(tab_projet_ps_factures_four);
            tab_projet.removeChild(tab_projet_depenses_annexes);
            tab_projet.removeChild(tab_projet_synthese);
            tab_projet.removeChild(tab_projet_systeme);
       }
       
       //Si état est 'AUTRES'
       if(combo_type.text=='AUTRES')
		{
			//Alert.show(combo_type.text);
			//Afficher les onglets necessaires
			tab_projet.addChild(tab_projet_ta_factures_client);
            tab_projet.addChild(tab_projet_pe_ta_factures_client);
            tab_projet.addChild(tab_projet_ta_factures_four);
            tab_projet.addChild(tab_projet_pe_factures_four);
            tab_projet.addChild(tab_projet_depenses_annexes);
            tab_projet.addChild(tab_projet_synthese);
			tab_projet.addChild(tab_projet_satisfaction);
            tab_projet.addChild(tab_projet_systeme);
                        
            tab_projet.removeChild(tab_projet_ps_factures_client);
			tab_projet.removeChild(tab_projet_ps_factures_four);	
			// Synthèse
			text_ps_montant_recette_ht.enabled = false;
			text_ps_montant_depense_ht.enabled = false;
			text_ps_marge_ht.enabled = false;
		}

      //F - PRESTATION SERVICE
       	if(combo_type.text=='PRESTATION SERVICES')
		{
			//Alert.show(combo_type.text);
			//Afficher les onglets necessaires
			tab_projet.addChild(tab_projet_ps_factures_client);
			tab_projet.addChild(tab_projet_ps_factures_four);
			tab_projet.addChild(tab_projet_depenses_annexes);
			tab_projet.addChild(tab_projet_synthese);
			tab_projet.addChild(tab_projet_satisfaction);
			tab_projet.addChild(tab_projet_systeme);
			
			tab_projet.removeChild(tab_projet_ta_factures_client);
			tab_projet.removeChild(tab_projet_ta_factures_four);
			tab_projet.removeChild(tab_projet_pe_ta_factures_client);
            tab_projet.removeChild(tab_projet_pe_factures_four);	
            
            text_ta_montant_recette_ttc.enabled = false;
			text_ta_montant_recette_accompagnant.enabled = false;
			text_ta_montant_recette_total_ttc.enabled = false;
			text_ta_montant_depense_ttc.enabled = false;
			text_ta_marge_ttc.visible = false;
			
			text_pe_montant_recette_ht.enabled = false;
			text_pe_montant_depense_ht.enabled = false;
			text_ta_marge_ht.enabled = false;
			text_ta_tva_marge.enabled = false;
			
			text_recette1_previsionnelle.enabled = false;
			text_depense1_previsionnelle.enabled = false;

			// Synthèse
			text_str_tourisme_affaire.enabled = false;
			text_str_presta_evenement.enabled = false;
			text_str_total.enabled = false;
			text_st_total_balance.enabled = false;
			
			text_ps_montant_recette_ht.enabled = true;
			text_ps_montant_depense_ht.enabled = true;
			text_ps_marge_ht.enabled = true;
			
			datagrid_ProjetFactureDepensesAnnexesTA.visible = false;
			datagrid_ProjetFactureDepensesAnnexesPEPS.visible = true;
			// pour cacher les boutons c'est dans projetitem_script.as
			
			//Alert.show(combo_type.text);
		}
}

public function synthese():void
{
	//Déclarer les propriétés du NumberFormatter
	////////////////////////////////////////////////
	// PRESTATIONS TOURISME D'AFFAIRES
	////////////////////////////////////////////////
	// Montant recette TTC = Facture client - avoir
	var total:Number = 0;
	var total1:Number = 0; // Recette client
	var total2:Number = 0; // Avoir client
	var total3:Number = 0; //Autres
	var total4:Number = 0;
	var total5:Number = 0;
	var total6:Number = 0;
	var tvaRecette:Number;
	var tvaDepense:Number;
	for each (var row1:Object in datagrid_ProjetFactureClientTourismeAffaire.dataProvider) 
	{
  		total1 += Number(row1.montant_ttc);
  	}
	  	
	for each (var row2:Object in datagrid_ProjetFactureAvoirClientTourismeAffaire.dataProvider) 
	{
  		total2 += Number(row2.montant_ttc);
  	}
  	
  	for each (var rowFacture_autre_ta:Object in datagrid_ProjetFactureAutrestourismeAffaire.dataProvider) 
	{
  		total3 += Number(rowFacture_autre_ta.montant_ttc);
  	}
  	
  	total = total1+total2+total3;	
	text_ta_montant_recette_ttc.text = total.toFixed(2);
	

	// Total factures Accompagnants
	total2 = 0;
	for each (var row_acc:Object in datagrid_ProjetFactureClientAccTourismeAffaire.dataProvider) 
	{
  		total2 += Number(row_acc.montant_ttc);
  	}
	text_ta_montant_recette_accompagnant.text = total2.toFixed(2);
	
	// Montant recette total TTC
	var result:Number = 0;
	result = Number(text_ta_montant_recette_accompagnant.text) + Number(text_ta_montant_recette_ttc.text);
	text_ta_montant_recette_total_ttc.text = result.toFixed(2);
	
	// Montant Dépenses TTC = Facture fournisseur - avoir 
	total1=0;
	total2=0;
	total3=0;
	total=0;
	for each (var row3:Object in datagrid_ProjetFactureFournisseurTourismeAffaire.dataProvider) 
	{
  		total1 += Number(row3.montant_ttc);
  	}
	  	
	for each (var row4:Object in datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.dataProvider) 
	{
  		total2 += Number(row4.montant_ttc);
  	}
  	
  	for each (var row_depense_annexe:Object in datagrid_ProjetFactureDepensesAnnexesTA.dataProvider) 
  	{
  		// total3 += Number(row_depense_annexe.montant_ttc);
		// JR le 01/06/2016
	  	if (row_depense_annexe.montant_ttc == '0.00'){
	  	 	total3 += Number(row_depense_annexe.montant_reglement_ttc);
	  	}else{
	  	 	total3 += Number(row_depense_annexe.montant_ttc);
	  	}
  	}  	

	total = total1+total2+total3;
	text_ta_montant_depense_ttc.text = total.toFixed(2);
	
	// Marge TA
	var marge:Number = 0;
	marge = Number(text_ta_montant_recette_total_ttc.text) - Number(text_ta_montant_depense_ttc.text);
	text_ta_marge_ttc.text = marge.toFixed(2);
	
	var ta_tva_marge:Number = 0 ;
	ta_tva_marge = Number(text_ta_marge_ttc.text)-Number(text_ta_marge_ttc.text)/1.2;
	// JR le 05/08/2014 ajout du cas G dans TVA_MARGE = 0
	if((text_cas.text == 'B') || (text_cas.text == 'C') || (text_cas.text == 'G'))
	{
		text_ta_tva_marge.text = '0';
	}
	else
	{
		if(Number(text_ta_tva_marge.text)<0){
			text_ta_tva_marge.text = '0';
		}else{
			text_ta_tva_marge.text = ta_tva_marge.toFixed(2);
		}
	}
	if(Number(text_ta_tva_marge.text)<0){
		text_ta_tva_marge.text = '0';
	}
	
	
////////////////////////////////////////////////
// PRESTATIONS EVENEMENTIELLES
////////////////////////////////////////////////
if(combo_type.text=='AUTRES'){
	
	// Montant recette HT
	total1=0;
	total2=0;
	total3=0;
	for each (var row_recette_pe:Object in datagrid_ProjetFactureClientPrestationEvenementielle.dataProvider) 
	{
		if((text_cas.text!='A')&&(text_cas.text!='C')&&(text_cas.text!='F')){
  			total1 += Number(row_recette_pe.montant_ttc);
  		}else{
  			total1 += Number(row_recette_pe.montant_ht);	
  		}
  	}
	  	
	for each (var row_recette_pe_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.dataProvider) 
	{
		if((text_cas.text!='A')&&(text_cas.text!='C')&&(text_cas.text!='F')){
  			total2 += Number(row_recette_pe_avoir.montant_ttc);
  		}else{
  			total2 += Number(row_recette_pe_avoir.montant_ht);	
  		}
  	}
  	
  	for each (var row_recette_pe_autres:Object in datagrid_ProjetFactureClientAutrePrestationEvenementielle.dataProvider) 
  	{
		if((text_cas.text!='A')&&(text_cas.text!='C')&&(text_cas.text!='F')){
  			total3 += Number(row_recette_pe_autres.montant_ttc);
  		}else{
  			total3 += Number(row_recette_pe_autres.montant_ht);	
  		}

  	}
  	
  	total = (total1+total2)+total3;
 	trace(total1);
  	trace(total2);
  	trace(total3);
  	if(combo_type.text=='AUTRES'){
  		text_pe_montant_recette_ht.text = total.toFixed(2);
  	}else{
  		text_pe_montant_recette_ht.text = '0';
  	}
  	
  	//Montant recette TTC
  	total1=0;
	total2=0;
	total3=0;
  	for each (var row_recetteTTC_pe:Object in datagrid_ProjetFactureClientPrestationEvenementielle.dataProvider) 
  	{
  		total1 += Number(row_recetteTTC_pe.montant_ttc);
  	}
	  	
	for each (var row_recetteTTC_pe_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.dataProvider) 
	{
  		total2 += Number(row_recetteTTC_pe_avoir.montant_ttc);
  	}

   	for each (var row_recetteTTC_pe_autres:Object in datagrid_ProjetFactureClientAutrePrestationEvenementielle.dataProvider) 
   	{
  		total3 += Number(row_recetteTTC_pe_autres.montant_ttc);
  	}
  	
	
	 total = (total1-total2)+total3;
	 tvaRecette = total - Number(text_pe_montant_recette_ht.text);

	// Montant dépenses HT/TTC
	total1=0;
	total2=0;
	total3=0;
	
	for each (var row_depense_pe:Object in datagrid_ProjetFactureFournisseurPrestationsEvenementielles.dataProvider) 
	{
		/*
  		if(row_depense_pe.pays=='France'){
  			total1 += Number(row_depense_pe.montant_ht);
  		}else{
  			//total1 += Number(row_depense_pe.montant_ttc);
  			// JRN 20131001
  			if(Number(row_depense_pe.montant_ttc)>0){
  				total1 += Number(row_depense_pe.montant_ttc);	
  			}else{
  				total1 += Number(row_depense_pe.montant_ht);
  			}
  		}
  		*/
  		// JRN le 08/02/2016 A la demande de Corinne je retire les anciennes condition, si il y a une HT on le prend 
  		// JRN le 07/06/2016 correction au lieu de supérieur je met différent de 0 pour prendre les nb négatif
  	  	if( Number(row_depense_pe.montant_ht) != 0 ){
  			total1 += Number(row_depense_pe.montant_ht);	
  		}else{
  			total1 += Number(row_depense_pe.montant_ttc);
  		}
  	}
  	
  	for each (var row_depense_pe_avoir:Object in datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.dataProvider) 
  	{
  		/*
  		if(row_depense_pe_avoir.pays=='France'){
  			total2 += Number(row_depense_pe_avoir.montant_ht);
  		}else{
  			//total2 += Number(row_depense_pe_avoir.montant_ttc);
  			if(Number(row_depense_pe_avoir.montant_ttc)>0){
  				total2 += Number(row_depense_pe_avoir.montant_ttc);
  			}else{
  				total2 += Number(row_depense_pe_avoir.montant_ht);
  			}
  		}
  		*/
  		// JRN le 08/02/2016 A la demande de Corinne je retire les anciennes condition, si il y a une HT on le prend 
  		// JRN le 07/06/2016 correction au lieu de supérieur je met différent de 0 pour prendre les nb négatif
  	  	if(Number(row_depense_pe_avoir.montant_ht) != 0){
  			total2 += Number(row_depense_pe_avoir.montant_ht);	
  		}else{
  			total2 += Number(row_depense_pe_avoir.montant_ttc);
  		}
  	}
 	//if(combo_type.text=='FRANCE ET UNION EUROPEENNE'){
	for each (var row_depense_annexe_pe:Object in datagrid_ProjetFactureDepensesAnnexesPEPS.dataProvider) 
	  	{
  			if(row_depense_annexe_pe.pays=='France'){
  				// total3 += Number(row_depense_annexe_pe.montant_ht);
  				// JR le 01/06/2016
		  		if (row_depense_annexe_pe.montant_ht == '0.00'){
		  		 	total3 += Number(row_depense_annexe_pe.montant_reglement_ttc);
		  		}else{
		  		 	total3 += Number(row_depense_annexe_pe.montant_ht);
		  		}
  			}else{
  				// total3 += Number(row_depense_annexe_pe.montant_ttc);
  				// JR le 01/06/2016
		  		if (row_depense_annexe_pe.montant_ttc == '0.00'){
		  		 	total3 += Number(row_depense_annexe_pe.montant_reglement_ttc);
		  		}else{
		  		 	total3 += Number(row_depense_annexe_pe.montant_ttc);
		  		}
  			}
	 	}

  	total = total1+total2+total3;
  	if(combo_type.text=='AUTRES'){
		text_pe_montant_depense_ht.text = total.toFixed(2);	
  	}else{
  		text_pe_montant_depense_ht.text = '0';
  	}
	//Alert.show(text_pe_montant_depense_ht.text);	
	
	//Marge HT
	marge = Number(text_pe_montant_recette_ht.text) - Number(text_pe_montant_depense_ht.text);

  	if(combo_type.text=='AUTRES'){
		text_ta_marge_ht.text = marge.toFixed(2);
  	}else{
		text_ta_marge_ht.text = '0';
  	}
	
	//Montant dépenses TTC
	total1=0;
	total2=0;
  	for each (var row_depenseTTC_pe:Object in datagrid_ProjetFactureFournisseurPrestationsEvenementielles.dataProvider) 
  	{
  		total1 += Number(row_depenseTTC_pe.montant_ttc);
  	}
	  	
	for each (var row_depenseTTC_pe_avoir:Object in datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.dataProvider) 
	{
  		total2 += Number(row_depenseTTC_pe_avoir.montant_ttc);
  	}
  	
  	total = total1-total2;
	tvaDepense = total - Number(text_pe_montant_depense_ht.text);
	
}

	
	////////////////////////////////////////////////
	// Prestation PS   
	////////////////////////////////////////////////
	
	// Montant recette HT
	total1=0;
	total2=0;
	total3=0;
	
	for each (var row_recette_ps:Object in datagrid_ProjetFactureClientPrestationService.dataProvider) 
	{
  		total1 += Number(row_recette_ps.montant_ht);
  	}
	  	
	for each (var row_recette_ps_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationServices.dataProvider) 
	{
  		total2 += Number(row_recette_ps_avoir.montant_ht);
  	}
  	
  	for each (var row_recette_ps_autres:Object in datagrid_ProjetFactureClientAutrePrestationServices.dataProvider) 
  	{
  		total3 += Number(row_recette_ps_autres.montant_ht);
  	}
  	total = 0;
  	total = total1+total2+total3;
	if(combo_type.text=='PRESTATION SERVICES')
	{  	
  		text_ps_montant_recette_ht.text = total.toFixed(2);
  	}
  	// JR le 22/06/2016 test
  	// Alert.show('Facture client : '+String(total));
  	
	// Montant dépenses HT
	total1=0;
	total2=0;
	total3 = 0;
	for each (var row_depense_ps:Object in datagrid_ProjetFactureFournisseurPrestationsServices.dataProvider) 
	{
  		total1 += Number(row_depense_ps.montant_ht);
  	}
  	
  	for each (var row_depense_ps_avoir:Object in datagrid_ProjetFctAvFournisseurPrestationsServices.dataProvider) 
  	{
  		total2 += Number(row_depense_ps_avoir.montant_ht);
  	}
	
  	if(combo_type.text=='PRESTATION SERVICES')
  	{
	  	for each (var row_depense_annexe_ps:Object in datagrid_ProjetFactureDepensesAnnexesPEPS.dataProvider)
	  	{
	  		// total3 += Number(row_depense_annexe_ps.montant_ht);
	  		// JR le 01/06/2016
	  		if (row_depense_annexe_ps.montant_ht == '0.00'){
	  		 	total3 += Number(row_depense_annexe_ps.montant_reglement_ttc);
	  		}else{
	  		 	total3 += Number(row_depense_annexe_ps.montant_ht);
	  		}
	  	}
  	}
  	total = 0;
	total = total1+total2+total3;
	if(combo_type.text=='PRESTATION SERVICES')
	{  	
		// Init PE
		text_pe_montant_recette_ht.text = '0.00';
		text_pe_montant_depense_ht.text = '0.00';
		text_ta_marge_ht.text = '0.00';
		text_ps_montant_depense_ht.text = total.toFixed(2);	
		//Marge HT
		marge = Number(text_ps_montant_recette_ht.text) - Number(text_ps_montant_depense_ht.text);
		text_ps_marge_ht.text = marge.toFixed(2);

	}
	
  	// JR le 22/06/2016 test
  	// Alert.show('Facture fournisseur : '+String(total));
	
	//Montant dépenses TTC
	total1=0;
	total2=0;
  	for each (var row_depenseTTC_ps:Object in datagrid_ProjetFactureFournisseurPrestationsServices.dataProvider) 
  	{
  		total1 += Number(row_depenseTTC_ps.montant_ttc);
  	}
	  	
	for each (var row_depenseTTC_ps_avoir:Object in datagrid_ProjetFctAvFournisseurPrestationsServices.dataProvider) 
	{
  		total2 += Number(row_depenseTTC_ps_avoir.montant_ttc);
  	}
  	
  	total = total1-total2;
	tvaDepense = total - Number(text_ps_montant_depense_ht.text);
	text_ps_tva_marge.text = (tvaRecette-tvaDepense).toFixed(2);
	
	//Montant total tva locale
	total1=0;
	total2=0;
  	for each (var row_tvalocale__pe:Object in datagrid_ProjetFactureFournisseurPrestationsEvenementielles.dataProvider) 
  	{
  		total1 += Number(row_tvalocale__pe.montant_tva_locale);
  	}
	  	
	for each (var row_tvalocaleAv__pe:Object in datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.dataProvider) 
	{
  		total2 += Number(row_tvalocaleAv__pe.montant_tva_locale);
  	}
	total = 0;
	total = total1+total2;
	text_montant_total_tva_locale.text = total.toFixed(2);


	////////////////////////////////////////////////
	// SYNTHESE
	////////////////////////////////////////////////
	// Synthèse
	if(combo_type.text=='PRESTATION SERVICES')
	{
		var ps_ca:Number = 0;
		var ps_marge:Number = 0;
		var ps_taux_marge:Number = 0;
		
		ps_ca = Number(text_ps_montant_recette_ht.text);
		ps_marge = Number(text_ps_marge_ht.text);
		text_ca_ht.text = ps_ca.toFixed(2);
		text_total_marge.text = ps_marge.toFixed(2);
		ps_taux_marge = (Number(text_total_marge.text)/Number(text_ps_montant_recette_ht.text))*100;
		text_taux_marge.text = ps_taux_marge.toFixed(2);
	}else{

		//CA HT
		var fu_ca:Number = 0;
		fu_ca = Number(text_ta_montant_recette_total_ttc.text) + Number(text_pe_montant_recette_ht.text) - Number(text_ta_tva_marge.text);
		text_ca_ht.text = fu_ca.toFixed(2);
		
		//Total marge opération
		var fu_taux_marge:Number = 0;
		if((text_cas.text == 'A')||(text_cas.text == 'F')||(text_cas.text == 'E')||(text_cas.text == 'D'))
		{ 
			fu_taux_marge = (Number(text_ta_marge_ttc.text) - Number(text_ta_tva_marge.text)) + Number(text_ta_marge_ht.text);
			text_total_marge.text = fu_taux_marge.toFixed(2);
		
		}else{
			fu_taux_marge = Number(text_ta_marge_ttc.text) + Number(text_ta_marge_ht.text);
			text_total_marge.text = fu_taux_marge.toFixed(2);
		}	
	
		//Taux de marge %
		text_taux_marge.text = ((Number(text_total_marge.text) / Number(text_ca_ht.text))*100).toFixed(2);
	
	}
	
	///////////////////////////////////	
	// SITUATION DE TRESORERIE - Prestations Tourisme d'affaires
	//////////////////////////////////
	
		// Recette
	  	total1=0;
		total2=0;
		total3=0;
		total4=0;
		
	  	for each (var row_recetteTTC_ta:Object in datagrid_ProjetFactureClientTourismeAffaire.dataProvider) 
	  	{
	  		total1 += Number(row_recetteTTC_ta.acompte_total);
	  	}
		  	
		for each (var row_recetteTTC_ta_avoir:Object in datagrid_ProjetFactureAvoirClientTourismeAffaire.dataProvider) 
		{
	  		total2 += Number(row_recetteTTC_ta_avoir.acompte_total);
	  	}
	  	
	  	for each (var row_recetteTTC_ta_acc:Object in datagrid_ProjetFactureClientAccTourismeAffaire.dataProvider) 
	  	{
	  		total3 += Number(row_recetteTTC_ta_acc.acompte_total);
	  	}
	  	
	  	for each (var row_recetteTTC_ta_autres:Object in datagrid_ProjetFactureAutrestourismeAffaire.dataProvider) 
	  	{
	  		total4 += Number(row_recetteTTC_ta_autres.acompte_total);
	  	}
	  	// JR le 07/08/2014 correction d'un bug le total 4 n'était pas pris en compte dans le total recette TA
		total = total1+total2+total3+total4;
		text_str_tourisme_affaire.text = total.toFixed(2);
	  	
	
	  	// Dépense
		total1=0;
		total2=0;
		total3=0;
		for each (var row_depense_ta_situation:Object in datagrid_ProjetFactureFournisseurTourismeAffaire.dataProvider) 
		{
	  		total1 += Number(row_depense_ta_situation.total_regle);
	  	}

	  	for each (var row_depense_ta_avoir_situation:Object in datagrid_ProjetFactureAvoirFournisseurTourismeAffaire.dataProvider) 
	  	{
	  		total2 += Number(row_depense_ta_avoir_situation.total_regle);
	  	}

	  	for each (var row_depense_annexe_situation_ta:Object in datagrid_ProjetFactureDepensesAnnexesTA.dataProvider) 
	  	{
	  		total3 += Number(row_depense_annexe_situation_ta.total_reglement);
	  	}

		total = total1+total2+total3;
		
		text_str_presta_evenement.text = total.toFixed(2);
		
		// Total
		total1 = 0;
		total1 = Number(text_str_tourisme_affaire.text)-Number(text_str_presta_evenement.text);
		text_str_total.text = total1.toFixed(2) ;
		
		///////////////////////////////////	
		// SITUATION DE TRESORERIE - PE_PS
		//////////////////////////////////
		// SITUATION DE TRESORERIE - Prestations Evénementielles
  		total1=0;
		total2=0;
		total3=0;
		if(combo_type.text == 'AUTRES')
		{
		  	// Recette
		  	for each (var row_recetteTTC_pe2:Object in datagrid_ProjetFactureClientPrestationEvenementielle.dataProvider) 
		  	{
		  		total1 += Number(row_recetteTTC_pe2.acompte_total);
		  	}
			  	
			for each (var row_recetteTTC_pe2_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationEvenementielle.dataProvider) 
			{
		  		total2 += Number(row_recetteTTC_pe2_avoir.acompte_total);
		  	}
		  	
		  	for each (var row_recetteTTC_pe2_autres:Object in datagrid_ProjetFactureClientAutrePrestationEvenementielle.dataProvider) 
		  	{
		  		total3 += Number(row_recetteTTC_pe2_autres.acompte_total);
		  	}
			total = total1+total2+total3;
			text_std_tourisme_affaire.text = total.toFixed(2);
		  	
		  	// Dépense
			total1=0;
			total2=0;
			total3=0;
			total4=0;
			total5=0;
			// PE
			for each (var row_depense_pe_situation:Object in datagrid_ProjetFactureFournisseurPrestationsEvenementielles.dataProvider) 
			{
		  		total1 += Number(row_depense_pe_situation.total_regle);
		  	}
		  	
		  	for each (var row_depense_pe_avoir_situation:Object in datagrid_ProjetFctAvFournisseurPrestationsEvenementielles.dataProvider) 
		  	{
		  		total2 += Number(row_depense_pe_avoir_situation.total_regle);
		  	}
		
		  	for each (var row_depense_pe_annexe_situation:Object in datagrid_ProjetFactureDepensesAnnexesPEPS.dataProvider)
		  	{
				total3 += Number(row_depense_pe_annexe_situation.total_reglement);
		  	}
			
			//PS
			for each (var row_depense_ps_situation:Object in datagrid_ProjetFactureFournisseurPrestationsServices.dataProvider) 
			{
		  		total4 += Number(row_depense_ps_situation.montant_ht);
		  	}
		  	
		  	for each (var row_depense_ps_avoir_situation:Object in datagrid_ProjetFctAvFournisseurPrestationsServices.dataProvider) 
		  	{
		  		total5 += Number(row_depense_ps_avoir_situation.montant_ht);
		  	}
		  	
		  	//for each (var row_depense_annexe_ps:Object in datagrid_ProjetFactureDepensesAnnexesPEPS.dataProvider) 
	  		//{
	  		//	total6 += Number(row_depense_annexe_ps.montant_ht);
	  		//} 

			//total = total1+total2+total3+total4+total5+total6;
			total = total1+total2+total3+total4+total5;
			text_std_presta_evenement.text = total.toFixed(2);	
			
			// Total
			total1= 0;
			total1 = Number(text_std_tourisme_affaire.text)-Number(text_std_presta_evenement.text);
			text_std_total.text =total1.toFixed(2);
		}
		
		// SITUATION DE TRESORERIE - PRESTATION SERVICES
		if(combo_type.text == 'PRESTATION SERVICES')
		{
			// Recette
		  	for each (var row_recetteTTC_ps:Object in datagrid_ProjetFactureClientPrestationService.dataProvider) 
		  	{
		  		total1 += Number(row_recetteTTC_ps.acompte_total);
		  	}
			  	
			for each (var row_recetteTTC_ps_avoir:Object in datagrid_ProjetFactureAvoirsClientPrestationServices.dataProvider) 
			{
		  		total2 += Number(row_recetteTTC_ps_avoir.acompte_total);
		  	}
		  	
		  	for each (var row_recetteTTC_ps_autres:Object in datagrid_ProjetFactureClientAutrePrestationServices.dataProvider) 
		  	{
		  		total3 += Number(row_recetteTTC_ps_autres.acompte_total);
		  	}
			total = total1+total2+total3;
			text_std_tourisme_affaire.text = total.toFixed(2);
		  	
		  	// Dépense
			total1 = 0;
			total2 = 0;
			total3 = 0;
			for each (var row_depense_ps_situation:Object in datagrid_ProjetFactureFournisseurPrestationsServices.dataProvider) 
			{
		  		total1 += Number(row_depense_ps_situation.total_regle);
		  	}
		  	
		  	for each (var row_depense_ps_avoir_situation:Object in datagrid_ProjetFctAvFournisseurPrestationsServices.dataProvider) 
		  	{
		  		total2 += Number(row_depense_ps_avoir_situation.total_regle);
		  	}
		
		  	for each (var row_depense_ps_annexe_situation:Object in datagrid_ProjetFactureDepensesAnnexesPEPS.dataProvider) 
		  	{
		  		// JR le 01/06/2016 correction de la règle 
		  		total3 += Number(row_depense_ps_annexe_situation.total_reglement);
		  	}  	
			total = total1+total2+total3;
			text_std_presta_evenement.text = total.toFixed(2);	
			
			// Total
			total1= 0;
			total1 = Number(text_std_tourisme_affaire.text)-Number(text_std_presta_evenement.text);
			text_std_total.text =total1.toFixed(2);
		}
		//TOTAL BALANCE  
		text_st_total_balance.text = (Number(text_str_total.text) + Number(text_std_total.text)).toFixed(2);
		
		/*
		// si le total est inférieur à 0 j'affiche 0 sinon j'affiche le total
		var total_balance_calcul:Number = 0;
		total_balance_calcul = Number(text_st_total_balance.text);
		if (total_balance_calcul < 0){
			text_st_total_balance.text = (Number(0)).toFixed(2);
		}else{
			text_st_total_balance.text = (Number(total_balance_calcul)).toFixed(2);
		}
		// JR le 29/06/2016 finalement on s'est trompé sur cette demande, car le problème venait des problèmes de calcul de marge sur les dépenses annexesin
		*/
				
}

public function marge_ta():void
{

      var result:Number;
 /*
    // On remplace l’espace par rien
    var xRecette:Number = Number(text_recette1_previsionnelle.text.replace(" ",""));
    var xDepense:Number = Number(text_depense1_previsionnelle.text.replace(" ",""));
*/
    result = Number(text_recette1_previsionnelle.text) - Number(text_depense1_previsionnelle.text);
 
	// on format le résultat
    text_marge1_previsionnelle.text = result.toFixed(2);
    //text_marge1_previsionnelle.text = afficheFormat.format(result);
}

public function marge_pe_ps():void
{
      var result2:Number;
 
// on format le résultat
	result2 =  Number(text_recette2_previsionnelle.text)-Number(text_depense2_previsionnelle.text);
    text_marge2_previsionnelle.text = result2.toFixed(2);
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

		if(combo_pj_confirmee.text=='1')
		{
			fichier_text_pj1_previsionnelle.enabled =false;
			combo_pj_confirmee.enabled =false;
			btn_parcourir_pj1_previsionnelle.enabled = false;
		//	datagrid_ProjetFactureClientPrestationEvenementielle.montant_ttc.visible=false;
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


public function Pays_Client():void
{
	rest_connexion_societe.url="societeList.php?field=cle&search="+connexion_societe.text+"&view=Par défaut";
    rest_connexion_societe.send();

}

private function rest_connexion_pays_result():void

{
	//rest_connexion_societe_result();
}

private function rest_connexion_societe_result():void
{
	//Alert.show("Recherche société pays");
	if(text_pays_client.text==''){	
		//Alert.show(rest_connexion_societe.lastResult.societeList.item.pays.to);
		text_pays_client.text = rest_connexion_societe.lastResult.societeList.item.pays;
	}
	
	if(text_cas.text==''){	
		cas();
	}

	if((text_cas.text == 'B') || (text_cas.text == 'C'))
	{
		text_recette2_previsionnelle.enabled = true;
		text_depense2_previsionnelle.enabled = true;
		text_ta_tva_marge.enabled = false;
		text_pe_montant_recette_ht.enabled = false;
		text_pe_montant_depense_ht.enabled = false; 
		text_ta_marge_ht.enabled = false;
		text_ps_montant_recette_ht.enabled = false;
		text_ps_montant_depense_ht.enabled = false;
		text_ps_marge_ht.enabled = false;
		text_std_tourisme_affaire.enabled = false;
		text_std_presta_evenement.enabled = false;
		text_std_total.enabled = false;
		text_st_total_balance.enabled = false;
		
		datagrid_ProjetFactureDepensesAnnexesPEPS.visible = true;
	}
			
	if((text_cas.text == 'A') || (text_cas.text == 'D') || (text_cas.text == 'E'))
	{
		//Dégriser les champs et tables
		text_recette2_previsionnelle.enabled = true;
		text_depense2_previsionnelle.enabled = true;
		text_ps_montant_recette_ht.enabled = false;
		text_ps_montant_depense_ht.enabled = false;
		text_ps_marge_ht.enabled = false;
		text_ps_montant_recette_ht.enabled = false;
		text_ps_montant_depense_ht.enabled = false;
		text_ps_marge_ht.enabled = false;

		datagrid_ProjetFactureDepensesAnnexesPEPS.visible = true;
	}
	// JR le 05/08/2014 ajout du cas G pas de TVA_MARGE
	if(text_cas.text == 'G')
	{
		text_ta_tva_marge.enabled = false;
	}
}

private function cas():void{
	if(connexion_pays.text!="")
	{
		//A- Client France - Projet France :
		if(text_pays_client.text=='France')
		{
			if(connexion_pays.text=='France')
			{							
					text_cas.text = 'A';	
			}
		}

		//B- Client hors UE - Projet Hors UE :
		if((text_pays_client.text!='Allemagne') && (text_pays_client.text!='Autriche')  && (text_pays_client.text!='Belgique') && (text_pays_client.text!='Bulgarie') && (text_pays_client.text!='Chypre') && (text_pays_client.text!='Croatie') && (text_pays_client.text!='Danemark') && (text_pays_client.text!='Espagne') && (text_pays_client.text!='Estonie') && (text_pays_client.text!='Finlande') && (text_pays_client.text!='France') && (text_pays_client.text!='Grèce') && (text_pays_client.text!='Hongrie') && (text_pays_client.text!='Irlande') && (text_pays_client.text!='Italie') && (text_pays_client.text!='Lettonie') && (text_pays_client.text!='Lituanie') && (text_pays_client.text!='Luxembourg') && (text_pays_client.text!='Malte') && (text_pays_client.text!='Pays-Bas') && (text_pays_client.text!='Pologne') && (text_pays_client.text!='Portugal') && (text_pays_client.text!='République tchèque') && (text_pays_client.text!='Roumanie') && (text_pays_client.text!='Royaume-Uni') && (text_pays_client.text!='Slovaquie') && (text_pays_client.text!='Slovénie') && (text_pays_client.text!='Suède'))
		{
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
				text_cas.text = 'B';
			}
		}

		//C -  Client France - Projet HORS UE
		if(text_pays_client.text=='France')
		{
			if((connexion_pays.text!='France') &&(connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie') && (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
				text_cas.text = 'C';
			}
		}
						
		//D -   Client UE - Projet France
		if((text_pays_client.text=='Allemagne') || (text_pays_client.text=='Autriche') || (text_pays_client.text=='Belgique') || (text_pays_client.text=='Bulgarie') || (text_pays_client.text=='Chypre') || (text_pays_client.text=='Croatie') || (text_pays_client.text=='Danemark') || (text_pays_client.text=='Espagne') || (text_pays_client.text=='Estonie') || (text_pays_client.text=='Finlande') || (text_pays_client.text=='Grèce') || (text_pays_client.text=='Hongrie') || (text_pays_client.text=='Irlande') || (text_pays_client.text=='Italie') || (text_pays_client.text=='Lettonie') || (text_pays_client.text=='Lituanie') || (text_pays_client.text=='Luxembourg') || (text_pays_client.text=='Malte') || (text_pays_client.text=='Pays-Bas') || (text_pays_client.text=='Pologne') || (text_pays_client.text=='Portugal') || (text_pays_client.text=='République tchèque') || (text_pays_client.text=='Roumanie') || (text_pays_client.text=='Royaume-Uni') || (text_pays_client.text=='Slovaquie') || (text_pays_client.text=='Slovénie')|| (text_pays_client.text=='Suède'))
		{
			if(connexion_pays.text=='France')
			{
				//text_cas.text = 'D - UE_France';
				text_cas.text = 'D';
			}
		}
		
		//E - Client UE - Projet UE
		if((text_pays_client.text=='Allemagne') || (text_pays_client.text=='Autriche') || (text_pays_client.text=='Belgique') || (text_pays_client.text=='Bulgarie') || (text_pays_client.text=='Chypre') || (text_pays_client.text=='Croatie') || (text_pays_client.text=='Danemark') || (text_pays_client.text=='Espagne') || (text_pays_client.text=='Estonie') || (text_pays_client.text=='Finlande') || (text_pays_client.text=='Grèce') || (text_pays_client.text=='Hongrie') || (text_pays_client.text=='Irlande') || (text_pays_client.text=='Italie') || (text_pays_client.text=='Lettonie') || (text_pays_client.text=='Lituanie') || (text_pays_client.text=='Luxembourg') || (text_pays_client.text=='Malte') || (text_pays_client.text=='Pays-Bas') || (text_pays_client.text=='Pologne') || (text_pays_client.text=='Portugal') || (text_pays_client.text=='République tchèque') || (text_pays_client.text=='Roumanie') || (text_pays_client.text=='Royaume-Uni') || (text_pays_client.text=='Slovaquie') || (text_pays_client.text=='Slovénie')|| (text_pays_client.text=='Suède'))
		{
			if((connexion_pays.text=='Allemagne') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				text_cas.text = 'E';
			}
		}

		//F- Client France - Projet UE HORS FRANCE
		if(text_pays_client.text=='France')
		{
			if((connexion_pays.text=='Allemagne') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				text_cas.text = 'F';
			}
		}
		
		//G- Client UE - Projet Hors UE
		if((text_pays_client.text=='Allemagne') || (text_pays_client.text=='Autriche') || (text_pays_client.text=='Belgique') || (text_pays_client.text=='Bulgarie') || (text_pays_client.text=='Chypre') || (text_pays_client.text=='Croatie')|| (text_pays_client.text=='Danemark') || (text_pays_client.text=='Espagne') || (text_pays_client.text=='Estonie') || (text_pays_client.text=='Finlande') || (text_pays_client.text=='Grèce') || (text_pays_client.text=='Hongrie') || (text_pays_client.text=='Irlande') || (text_pays_client.text=='Italie') || (text_pays_client.text=='Lettonie') || (text_pays_client.text=='Lituanie') || (text_pays_client.text=='Luxembourg') || (text_pays_client.text=='Malte') || (text_pays_client.text=='Pays-Bas') || (text_pays_client.text=='Pologne') || (text_pays_client.text=='Portugal') || (text_pays_client.text=='République tchèque') || (text_pays_client.text=='Roumanie') || (text_pays_client.text=='Royaume-Uni') || (text_pays_client.text=='Slovaquie') || (text_pays_client.text=='Slovénie')|| (text_pays_client.text=='Suède'))
		{
			if((connexion_pays.text!='Allemagne') && (connexion_pays.text!='Autriche')  && (connexion_pays.text!='Belgique') && (connexion_pays.text!='Bulgarie') && (connexion_pays.text!='Chypre') && (connexion_pays.text!='Croatie')&& (connexion_pays.text!='Danemark') && (connexion_pays.text!='Espagne') && (connexion_pays.text!='Estonie') && (connexion_pays.text!='Finlande') && (connexion_pays.text!='France') && (connexion_pays.text!='Grèce') && (connexion_pays.text!='Hongrie') && (connexion_pays.text!='Irlande') && (connexion_pays.text!='Italie') && (connexion_pays.text!='Lettonie') && (connexion_pays.text!='Lituanie') && (connexion_pays.text!='Luxembourg') && (connexion_pays.text!='Malte') && (connexion_pays.text!='Pays-Bas') && (connexion_pays.text!='Pologne') && (connexion_pays.text!='Portugal') && (connexion_pays.text!='République tchèque') && (connexion_pays.text!='Roumanie') && (connexion_pays.text!='Royaume-Uni') && (connexion_pays.text!='Slovaquie') && (connexion_pays.text!='Slovénie') && (connexion_pays.text!='Suède'))
			{
				text_cas.text = 'G';
			}
		}
		
		//H- Client HORS UE - Projet UE
		if((text_pays_client.text!='Allemagne') && (text_pays_client.text!='Autriche')  && (text_pays_client.text!='Belgique') && (text_pays_client.text!='Bulgarie') && (text_pays_client.text!='Chypre') && (text_pays_client.text!='Croatie') && (text_pays_client.text!='Danemark') && (text_pays_client.text!='Espagne') && (text_pays_client.text!='Estonie') && (text_pays_client.text!='Finlande') && (text_pays_client.text!='France') && (text_pays_client.text!='Grèce') && (text_pays_client.text!='Hongrie') && (text_pays_client.text!='Irlande') && (text_pays_client.text!='Italie') && (text_pays_client.text!='Lettonie') && (text_pays_client.text!='Lituanie') && (text_pays_client.text!='Luxembourg') && (text_pays_client.text!='Malte') && (text_pays_client.text!='Pays-Bas') && (text_pays_client.text!='Pologne') && (text_pays_client.text!='Portugal') && (text_pays_client.text!='République tchèque') && (text_pays_client.text!='Roumanie') && (text_pays_client.text!='Royaume-Uni') && (text_pays_client.text!='Slovaquie') && (text_pays_client.text!='Slovénie') && (text_pays_client.text!='Suède'))
		{
			if((connexion_pays.text=='Allemagne')||(connexion_pays.text=='Autriche') || (connexion_pays.text=='Autriche') || (connexion_pays.text=='Belgique') || (connexion_pays.text=='Bulgarie') || (connexion_pays.text=='Chypre') || (connexion_pays.text=='Croatie') || (connexion_pays.text=='Danemark') || (connexion_pays.text=='Espagne') || (connexion_pays.text=='Estonie') || (connexion_pays.text=='Finlande') || (connexion_pays.text=='Grèce') || (connexion_pays.text=='Hongrie') || (connexion_pays.text=='Irlande') || (connexion_pays.text=='Italie') || (connexion_pays.text=='Lettonie') || (connexion_pays.text=='Lituanie') || (connexion_pays.text=='Luxembourg') || (connexion_pays.text=='Malte') || (connexion_pays.text=='Pays-Bas') || (connexion_pays.text=='Pologne') || (connexion_pays.text=='Portugal') || (connexion_pays.text=='République tchèque') || (connexion_pays.text=='Roumanie') || (connexion_pays.text=='Royaume-Uni') || (connexion_pays.text=='Slovaquie') || (connexion_pays.text=='Slovénie')|| (connexion_pays.text=='Suède'))
			{
				text_cas.text = 'H';
			}
		}
		
		//I- Client HORS UE - Projet FRANCE
		if((text_pays_client.text!='Allemagne') && (text_pays_client.text!='Autriche')  && (text_pays_client.text!='Belgique') && (text_pays_client.text!='Bulgarie') && (text_pays_client.text!='Chypre') && (text_pays_client.text!='Croatie') && (text_pays_client.text!='Danemark') && (text_pays_client.text!='Espagne') && (text_pays_client.text!='Estonie') && (text_pays_client.text!='Finlande') && (text_pays_client.text!='France') && (text_pays_client.text!='Grèce') && (text_pays_client.text!='Hongrie') && (text_pays_client.text!='Irlande') && (text_pays_client.text!='Italie') && (text_pays_client.text!='Lettonie') && (text_pays_client.text!='Lituanie') && (text_pays_client.text!='Luxembourg') && (text_pays_client.text!='Malte') && (text_pays_client.text!='Pays-Bas') && (text_pays_client.text!='Pologne') && (text_pays_client.text!='Portugal') && (text_pays_client.text!='République tchèque') && (text_pays_client.text!='Roumanie') && (text_pays_client.text!='Royaume-Uni') && (text_pays_client.text!='Slovaquie') && (text_pays_client.text!='Slovénie') && (text_pays_client.text!='Suède'))
		{
			if((connexion_pays.text=='France'))
			{
				text_cas.text = 'I';
			}
		}
	}
}
private function rest_connexion_utilisateur_result():void{}

private var majButton:Button = new Button();
private function initButton():void{
	// Création du bouton MAJ
	majButton.x = 140;
	majButton.y = 26;
	majButton.id="btn_maj";
	majButton.label = "Mettre à jour";
	majButton.addEventListener(MouseEvent.CLICK,btn_maj)
	tab_projet_satisfaction.addChild(majButton);
}
private function btn_maj(e:Event):void{
	// Création de l'HTTPService séquence
	restHttp_sequence.url = "script/satisfaction_maj.php?projet="+text_cle.text+"&utilisateur="+connexion_utilisateur.text;
	restHttp_sequence.method = "POST";
	//restHttp_sequence.addEventListener("result", restHttp_sequence_result);
	restHttp_sequence.send();
	Alert.show('Fiche(s) satisfaction mise(s) à jour');
}

private var restHttp_sequence:mx.rpc.http.HTTPService = new mx.rpc.http.HTTPService(); 

private function restHttp_sequence_result(e:ResultEvent):void {
	//restHttp_sequence.lastResult.satisfaction.statut.valeur;
}