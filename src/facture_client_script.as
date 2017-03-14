import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.Alert;
import mx.controls.Button;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;


// Bouton dupliquer
//private var dupliquerButton:Button = new Button();
//private var restHttp_dupliquer:mx.rpc.http.HTTPService = new mx.rpc.http.HTTPService();
 
private function initButton():void {
	/*
      // Création du bouton dupliquer
      dupliquerButton.x = 150;
      dupliquerButton.y = 350;
      dupliquerButton.id="btn_facture_client_dupliquer";
      dupliquerButton.label = "Dupliquer";
      dupliquerButton.addEventListener(MouseEvent.CLICK,btn_dupliquer)
      tab_facture_client_principal.addChild(dupliquerButton);
	*/
}
/*
private function btn_dupliquer(e:Event):void{
      // Création de l'HTTPService pour le bouton dupliquer
      if(Number(text_acompte1.text)>0){
            Alert.show('Attention, vous ne pouvez pas dupliquer cette facture car un paiement a déjà été effectué.')
      }else{
            restHttp_dupliquer.url = "dupliquer.php?table=facture_client&cle="+text_cle.text+"&table_liee=facture_client_ligne";
            restHttp_dupliquer.method = "POST";
            restHttp_dupliquer.addEventListener("result", resultHTTP_dupliquer);
            //service.addEventListener("fault", httpFault);
            restHttp_dupliquer.send();
      }
}
 
private function resultHTTP_dupliquer(e:ResultEvent):void {
      Alert.show('La fiche a été dupliqué');
}
*/

private function onLoad_facture_client():void 
{
	// USER 
	if(Application.application.gsProfil =='user')
	{
		text_acompte1.enabled = false;
		text_acompte2.enabled = false;
		text_acompte3.enabled = false;
		date_date1.enabled = false;
		date_date2.enabled = false;
		date_date3.enabled = false;
		fichier_text_pj1.enabled = false;
		fichier_text_pj2.enabled = false;
		fichier_text_pj3.enabled = false;
		//grise le combo Type(Facture client, Facture Accompagnant, etc)
		combo_type.enabled = false;
		combo_reglee.enabled = false;
		combo_statut.enabled = false;
		text_cas.enabled = true;
		btn_Delete_FactureLigneTA.visible = false;
		btn_Delete_FactureLigne.visible = false;

	}
	
	griseAccompagnant();
	afficheDetailFacturation();
	//verifie le statut
	if((Number(text_montant_restant.text)== 0)&&(Number(text_montant_ht.text)!= 0 ))
	{
		combo_statut.text ="Terminé";
	}

	if(text_delai_paiement.text=="")
	{
		text_delai_paiement.text ="30";
	}

	// vérif si clé = à vide
	if (mode =='0'){
		if (text_cle.text == ''){
			Alert.show('Attention la fiche N° '+text_numero.text+' ne peut être chargé,\nmerci de réessayer ou de contacter le service Administratif.');
			close();
		}
	}
}



private function onCreate_facture_client():void {
	remplirChampsSociete();

} 	

private function onUpdate_facture_client():void 
{
	// actualiseTable();
	remplirChampsSociete();
	recup_montant();
	//Alert.show('onUpdate');

} 	

private function beforeCreate_facture_client():void {
	cle_facture_client();
	recup_montant();
}

private function event_facture_client(e:Event):void {
    tab_facture_client.addEventListener(Event.CHANGE,refresh_tab);
    //connexion_societe.addEventListener(Event.,remplirChampsSociete);
}

public function refresh_tab(e:Event):void {
	/*
	if(mode="1"){
		// Récupérer un numéro de projet et enregistrer la fiche
		//numero();
		mode=="0";
	}
	*/

}	

private function onPrint_facture_client():void {
      // Lancer une URL pour l'impression
	switch (combo_type.text) { 
		case 'Facture client':
			navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_client&cle='+text_idfacture_client.text), "_blank" );
	      	if(combo_objet.text!='Prestation tourisme d\'affaires'){
		      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_client_pe&cle='+text_idfacture_client.text), "_blank" );
	      	} 	
			break ; 
		
		case 'Facture d\'avoir client':	
	      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_avoir&cle='+text_idfacture_client.text), "_blank" );
	      	if(combo_objet.text!='Prestation tourisme d\'affaires'){
		      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_avoir_pe&cle='+text_idfacture_client.text), "_blank" );
	      	}
			break ; 	
		
		case 'Facture accompagnant':	
	      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_accompagnant&cle='+text_idfacture_client.text), "_blank" );
			break ;

		case 'Facture d\'avoir accompagnant':	
	      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_accompagnant_avoir&cle='+text_idfacture_client.text), "_blank" );
			break ; 
			
		case 'Facture autre':	
	      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_client&cle='+text_idfacture_client.text), "_blank" );
	      	if(combo_objet.text!='Prestation tourisme d\'affaires')
	      	{
		      	navigateToURL( new URLRequest( 'modele/html2pdf.php?modele=facture_client_pe&cle='+text_idfacture_client.text), "_blank" );
	      	}; 
	      	break ;
		
		default: 
		Alert.show('Aucun modèle d\'impression n\'a été défini.')
	
	} 
}

private function beforeUpdate_facture_client():void{
	//alerte_resteDu();
	recup_montant();

}

public function cle_facture_client():void{
	// si la clé est vide
	if(text_numero.text==''){
		//numero();
	}
	text_cle.text = text_numero.text;
}

public function recup_montant():void{ 
	
	text_montant_ht.enabled = true;
	text_montant_tva.enabled = true;
	text_montant_ttc.enabled = true;
	//calcule le montant des champs de Détail Facturation
	var total_ht:Number = 0;
	var total_ttc:Number = 0;
	var tax_seul:Number = 0;
	for each (var row:Object in datagrid_FactureLigne.dataProvider) 
	{
 		total_ht += Number(row.total_montant_ht);
 		 
		total_ttc += Number(row.total_montant_ttc);
	}
	if(combo_objet.text =="Prestation tourisme d'affaires")
	{
		text_montant_ttc.text = total_ttc.toFixed(2);
		tax_seul = Number(text_montant_ttc.text)*0.2;
		text_montant_tva.text = tax_seul.toFixed(2);
		
		text_montant_ht.text = (total_ttc - tax_seul).toFixed(2);
	}
	else
	{
		tax_seul = (total_ttc-total_ht);
		//affiche les résultats dans Paiement       
		text_montant_ht.text = total_ht.toFixed(2);
		text_montant_tva.text = tax_seul.toFixed(2);
		text_montant_ttc.text = total_ttc.toFixed(2);
		if(combo_objet.text =="Prestation événementielles")
		{
			//ETAT prise en compte
			if((text_cas.text=='B') || (text_cas.text=='D') || (text_cas.text=='E') || (text_cas.text=='G') || (text_cas.text=='H') || (text_cas.text=='I'))
			{
				//text_montant_ht.text = '0.00';
				text_montant_tva.text ='0.00';
			}
			
			if((text_cas.text=='A')|| (text_cas.text=='C')|| (text_cas.text=='F'))
			{
				text_montant_tva.text = tax_seul.toFixed(2);
			}

		}
	}
	text_montant_total_paiement_ttc.text =total_ttc.toFixed(2);
	
	if(combo_reglee.text!="Avoir")
	{
		//affiche le montant payé et calcule le reste du
		var reste:Number;
		var Sommeacompte:Number;
		Sommeacompte = 	Number(text_acompte1.text)+ Number(text_acompte2.text) + Number(text_acompte3.text);
		//var montant_ttc:Number = Number(text_montant_ttc.text);
		reste = Number(text_montant_ttc.text) - Number(Sommeacompte.toFixed(2));
		//Alert.show('Montant TTC :'+String(Number(text_montant_ttc.text)));
		//Alert.show('Somme acompte :'+String(Number(text_acompte1.text)+ Number(text_acompte2.text) + Number(text_acompte3.text) ) );
		text_acompte_total.text = Sommeacompte.toFixed(2);
		text_montant_restant.text = reste.toFixed(2);
		
		if(text_montant_restant.text=='0.00')
		{
			if((Number(text_montant_ttc.text)>0)||(Number(text_montant_ttc.text)<0))
			{
				combo_reglee.text = 'Payée';
			}
		}
		else
		{
			combo_reglee.text = 'Non payée';
		}
		//rendre visible les accomptes au cas où c'est caché
		text_pourcentage1.visible = true;
		text_pourcentage2.visible = true;
		text_acompte_clt_1.visible = true;
		text_acompte_clt_2.visible = true;
		date_acompte_date1.visible = true;
		date_acompte_date2.visible = true;
		
		//rendre visible les états au cas où c'est caché
		text_acompte1.visible = true;
		text_acompte2.visible = true;
		text_acompte3.visible = true;
		date_date1.visible = true;
		date_date2.visible = true;
		date_date3.visible = true;
		fichier_text_pj1.visible = true;
		fichier_text_pj2.visible = true;
		fichier_text_pj3.visible = true;
		
		//griser les boutons des pièces jointes
		/*
		btn_parcourir_pj1.enabled = true;
		btn_parcourir_pj2.enabled = true;
		btn_parcourir_pj3.enabled = true;
		btn_ouvrir_pj1.enabled = true;
		btn_ouvrir_pj2.enabled = true;
		btn_ouvrir_pj3.enabled = true;
		*/
	}
	else
	{
		text_montant_restant.text=(Number(text_montant_ttc.text)*-1).toFixed(2);
	
		//cacher les accomptes et les états paiements
		/*
		text_pourcentage1.text ="";
		text_pourcentage2.text ="";
		text_acompte_clt_1.text="";
		text_acompte_clt_2.text="";
		date_acompte_date1.text="";
		date_acompte_date2.text="";
		*/
		text_pourcentage1.visible = false;
		text_pourcentage2.visible = false;
		text_acompte_clt_1.visible = false;
		text_acompte_clt_2.visible = false;
		date_acompte_date1.visible = false;
		date_acompte_date2.visible = false;
		text_acompte1.visible = false;
		text_acompte2.visible = false;
		text_acompte3.visible = false;
		date_date1.visible = false;
		date_date2.visible = false;
		date_date3.visible = false;
		fichier_text_pj1.visible = false;
		fichier_text_pj2.visible = false;
		fichier_text_pj3.visible = false;
		
		text_acompte_total.visible = false;
		//griser les boutons des pièces jointes
		/*
		btn_parcourir_pj1.enabled = false;
		btn_parcourir_pj2.enabled = false;
		btn_parcourir_pj3.enabled = false;
		btn_ouvrir_pj1.enabled = false;
		btn_ouvrir_pj2.enabled = false;
		btn_ouvrir_pj3.enabled = false;
		*/
	}
	
}

public function alerte_resteDu():void
{
 	var reste:Number = Number(text_montant_restant.text);
 	if( reste>0)
	 {
	 	Alert.show("la somme due n'est pas réglée.  Il reste" + reste);
	 }
}

public function griseAccompagnant():void
{
	if(combo_type.text=="Facture accompagnant")
	{
		tab_facture_client_accompagnant.enabled = true;
		//Grise les champs adresse facturation
		text_clt_reference.enabled = false;
		connexion_societe.enabled = false;
		text_contact.enabled = false;
		text_facturation_adresse1.enabled = false;
		text_facturation_cp.enabled = false;
		text_facturation_ville.enabled = false;
		text_pays.enabled = false;
	}
	else
	{
		tab_facture_client_accompagnant.enabled = false;
		//reactive les champs adresse facturation
		text_clt_reference.enabled = true;
		connexion_societe.enabled = true;
		text_contact.enabled = true;
		text_facturation_adresse1.enabled = true;
		text_facturation_cp.enabled = true;
		text_facturation_ville.enabled = true;
		text_pays.enabled = true;
	}
	restfacture_clientRead.url = "facture_clientRead.php?cle="+text_cle.text;

}

public function calculAccompte():void
{
	var per:Number = Number(text_pourcentage1.text)+Number(text_pourcentage2.text);
	if(per>100)
	{
		Alert.show("Le pourcentage ne peut pas dépasser 100.");
		text_acompte_clt_1.text ="";
		text_acompte_clt_2.text ="";
	}
	else
	{
		text_acompte_clt_1.text = ((Number(text_pourcentage1.text)/100) * Number(text_montant_ttc.text)).toFixed(2); 
		text_acompte_clt_2.text = ((Number(text_pourcentage2.text)/100) * Number(text_montant_ttc.text)).toFixed(2);
	}
}

public function afficheDetailFacturation():void
{
	if(combo_objet.text =="Prestation tourisme d'affaires")
	{
		tab_facture_client.removeChild(tab_facture_client_detail_facturation);
		text_montant_ht.visible = false;
		text_montant_tva.visible = false;
	}
	else
	{
		tab_facture_client.removeChild(tab_facture_client_detail_facturation_ta);
		text_montant_ht.visible = true;
		text_montant_tva.visible = true;
	}
}

private function remplirChampsSociete():void
{
  rest_connexion_societe.url="societeList.php?field=cle&search="+connexion_societe.text+"&view=Par défaut";
  rest_connexion_societe.send();
}

private function rest_connexion_societe_result():void
{
  text_facturation_adresse1.text = rest_connexion_societe.lastResult.societeList.item.adresse;
  text_facturation_adresse2.text = rest_connexion_societe.lastResult.societeList.item.adressesuite;
  text_facturation_cp.text = rest_connexion_societe.lastResult.societeList.item.cp;
  text_facturation_ville.text = rest_connexion_societe.lastResult.societeList.item.ville;
  text_pays.text = rest_connexion_societe.lastResult.societeList.item.pays;
}

private function rest_connexion_projet_result():void{}
private function rest_connexion_utilisateur_result():void{}