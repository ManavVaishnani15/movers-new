<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Administration - Edit Record</title>
<link rel="stylesheet" href="foundation-6.2.4/css/foundation.css">
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css">
<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/jquery-ui.css"/>
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/typeahead.jquery.min.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="scripts/script.js"></script>
<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style type="text/css">
        .tt-menu {
          margin: -5px 0;
          padding: 5px;
          background-color: #fff;
          border: 1px solid #ccc;
          border: 1px solid rgba(0, 0, 0, 0.2);
        }
        .tt-input{
            vertical-align: baseline !important;
        }
    </style>
</head>
<body>

<!--- Display DocuSign Success/Error/Info Messages --->
<cfif IsDefined("session.docusignSuccess")>
    <div style="background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 15px; margin: 20px; border-radius: 5px;">
        <strong><i class="fa fa-check-circle"></i> Success:</strong> <cfoutput>#session.docusignSuccess#</cfoutput>
    </div>
    <cfset StructDelete(session, "docusignSuccess")>
</cfif>

<cfif IsDefined("session.docusignError")>
    <div style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 15px; margin: 20px; border-radius: 5px;">
        <strong><i class="fa fa-exclamation-triangle"></i> Error:</strong> <cfoutput>#session.docusignError#</cfoutput>
    </div>
    <cfset StructDelete(session, "docusignError")>
</cfif>

<cfif IsDefined("session.docusignInfo")>
    <div style="background-color: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; padding: 15px; margin: 20px; border-radius: 5px;">
        <strong><i class="fa fa-info-circle"></i> Info:</strong> <cfoutput>#session.docusignInfo#</cfoutput>
    </div>
    <cfset StructDelete(session, "docusignInfo")>
</cfif>

<cfif parameterexists(un) is 'no'>
<b>Log In</b><br>
<form action="main.cfm" method="post">
username <input type="text" name="username" size="15"><br>
password <input type="password" name="password" size="15"><br>
<input type="submit" value="Log In">
</form>
<cfabort>
<cfelse>
<cfquery name="verify" datasource="aaalh3x_onestep">
select * from MEMBERS
where username='#un#' and temp_pw=#pw# and active=1
</cfquery>
 <cfif #verify.recordcount# is 0>
 <b>Log In</b><br>
 <form action="main.cfm" method="post">
 username <input type="text" name="username" size="15"><br>
 password <input type="password" name="password" size="15"><br>
 <input type="submit" value="Log In">
 </form>
 <cfabort>
 </cfif>
</cfif>

<cfif Isdefined("form.markThisRecordComplete")>
<cfquery name="comp" datasource="aaalh3x_onestep">
update carrier_records
set active='3', AccountStatus = 'Complete'
where id=#clientid#
</cfquery>
    <!---- remove from printQueue ---->
    <cfquery name="qKillFromQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM carrier_printQueue
        WHERE clientID = #clientid#
        </cfquery>
    <!--- remove from label queue ----->
    <cfquery name="qKillFromLabelQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM carrier_Letter_sends
        WHERE cust_hook = #clientid# and 
          sent = 0 and
          active = 1
     </cfquery>	
</cfif>


<cfif isDefined("url.DeleteRealtorImage")>
	<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\#url.DeleteRealtorImage#"> 
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE carrier_records
	SET ProfilePhoto = ''
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("url.DeleteRealtorCardImage")>
	<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\#url.DeleteRealtorCardImage#"> 
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE carrier_records
	SET BusinessCardPhoto = ''
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("form.submitheadshot")>
	<cfif isDefined("form.oldheadshotImage")>
		<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\#form.oldheadshotImage#">
	</cfif>
	<cffile action="upload" destination="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\" filefield="headshotImage" nameconflict="makeunique"> 
	<cfset theFilename = cffile.serverfile>
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE carrier_records
	SET ProfilePhoto = '#theFilename#'
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("form.submitcardimage")>
	<cfif IsDefined("form.oldbusinesscardImage")>
		<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\#form.oldbusinesscardImage#">
	</cfif>
	<cffile action="upload" destination="C:\home\top12movingbiz.com\wwwroot\admin\images\CarrierImages\" filefield="cardImage" nameconflict="makeunique"> 
	<cfset theFilename = cffile.serverfile>
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE carrier_records
	SET BusinessCardPhoto = '#theFilename#'
	WHERE ID = #ClientID#
	</cfquery>
</cfif>

<!--- Include DocuSign Handler --->
<cfinclude template="docusign_handler.cfm">

<!--- Delete Move Job Agreement Form --->
<cfif IsDefined("url.deleteMoveJobForm") AND IsDefined("url.formID")>
	<cfquery name="deleteMoveJobForm" datasource="aaalh3x_onestep">
	DELETE FROM carrier_move_job_agreements
	WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formID#">
	AND carrier_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ClientID#">
	</cfquery>
	<cfset session.deleteSuccess = true>
	<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no">
</cfif>

<cfif IsDefined("form.SaveMoveJobForm")>
	<!--- Check if we're updating an existing form or creating a new one --->
	<cfif IsDefined("form.MoveJobFormID") AND form.MoveJobFormID NEQ "">
		<!--- Update existing form --->
		<cfquery name="updateMoveJobForm" datasource="aaalh3x_onestep">
		UPDATE carrier_move_job_agreements
		SET customer_name = '#form.CustomerName#',
			customer_phone = '#form.CustomerPhone#',
			customer_email = '#form.CustomerEmail#',
			move_from = '#form.MoveFrom#',
			move_to = '#form.MoveTo#',
			packing_loading_date = <cfif form.PackingLoadingDate NEQ '' AND IsDate(form.PackingLoadingDate)>'#DateFormat(form.PackingLoadingDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			delivery_date = <cfif form.DeliveryDate NEQ '' AND IsDate(form.DeliveryDate)>'#DateFormat(form.DeliveryDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			preferred_delivery_date = <cfif form.PreferredDeliveryDate NEQ '' AND IsDate(form.PreferredDeliveryDate)>'#DateFormat(form.PreferredDeliveryDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			move_type = '#form.MoveType#',
			storage_needed = '#form.StorageNeeded#',
			days_in_storage = <cfif IsNumeric(form.DaysInStorage)>#form.DaysInStorage#<cfelse>NULL</cfif>,
			miles = <cfif IsNumeric(form.Miles)>#form.Miles#<cfelse>NULL</cfif>,
			approx_travel_time_hours = '#form.ApproxTravelTime#',
			total_hours_billed = '#form.TotalHoursBilled#',
			men_required = <cfif IsNumeric(form.MenRequired)>#form.MenRequired#<cfelse>NULL</cfif>,
			suggested_truck_size = '#form.SuggestedTruckSize#',
			residence_type = '#form.ResidenceType#',
			elevator = '#form.Elevator#',
			stairs_inside = '#form.StairsInside#',
			stairs_outside = '#form.StairsOutside#',
			long_carry = '#form.LongCarry#',
			move_size = '#form.MoveSize#',
			weight_cubic_feet = '#form.WeightCubicFeet#',
			packing = '#form.Packing#',
			total_items = <cfif IsNumeric(form.TotalItems)>#form.TotalItems#<cfelse>NULL</cfif>,
			dishpacks = <cfif IsNumeric(form.Dishpacks)>#form.Dishpacks#<cfelse>NULL</cfif>,
			small_boxes = <cfif IsNumeric(form.SmallBoxes)>#form.SmallBoxes#<cfelse>NULL</cfif>,
			book_boxes = <cfif IsNumeric(form.BookBoxes)>#form.BookBoxes#<cfelse>NULL</cfif>,
			medium_boxes = <cfif IsNumeric(form.MediumBoxes)>#form.MediumBoxes#<cfelse>NULL</cfif>,
			large_boxes = <cfif IsNumeric(form.LargeBoxes)>#form.LargeBoxes#<cfelse>NULL</cfif>,
			extra_large_boxes = <cfif IsNumeric(form.ExtraLargeBoxes)>#form.ExtraLargeBoxes#<cfelse>NULL</cfif>,
			boxes_6 = <cfif IsNumeric(form.Boxes6)>#form.Boxes6#<cfelse>NULL</cfif>,
			boxes_6_5 = <cfif IsNumeric(form.Boxes65)>#form.Boxes65#<cfelse>NULL</cfif>,
			mirror_picture_boxes = <cfif IsNumeric(form.MirrorPictureBoxes)>#form.MirrorPictureBoxes#<cfelse>NULL</cfif>,
			wardrobe_boxes = <cfif IsNumeric(form.WardrobeBoxes)>#form.WardrobeBoxes#<cfelse>NULL</cfif>,
			flat_tv_boxes = <cfif IsNumeric(form.FlatTVBoxes)>#form.FlatTVBoxes#<cfelse>NULL</cfif>,
			flat_screen_tv_count = <cfif IsNumeric(form.FlatScreenTVCount)>#form.FlatScreenTVCount#<cfelse>NULL</cfif>,
			crib_mattress = <cfif IsNumeric(form.CribMattress)>#form.CribMattress#<cfelse>NULL</cfif>,
			single_bed_boxes = <cfif IsNumeric(form.SingleBedBoxes)>#form.SingleBedBoxes#<cfelse>NULL</cfif>,
			double_bed_boxes = <cfif IsNumeric(form.DoubleBedBoxes)>#form.DoubleBedBoxes#<cfelse>NULL</cfif>,
			king_queen_bed_boxes = <cfif IsNumeric(form.KingQueenBedBoxes)>#form.KingQueenBedBoxes#<cfelse>NULL</cfif>,
			other_material_needed = '#form.OtherMaterialNeeded#',
			accessorial = '#form.Accessorial#',
			extra_info = '#form.ExtraInfo#',
			virtual_survey = '#form.VirtualSurvey#',
			other_estimate = '#form.OtherEstimate#',
			binding_estimate = '#form.BindingEstimate#',
			non_binding_estimate = '#form.NonBindingEstimate#',
			not_to_exceed = '#form.NotToExceed#',
			flat_rate = '#form.FlatRate#',
			hourly_estimate = '#form.HourlyEstimate#',
			amount_paid_to_carrier = '#form.AmountPaidToCarrier#',
			addendum = '#form.Addendum#',
			updated_at = NOW()
		WHERE id = #form.MoveJobFormID#
		</cfquery>
	<cfelse>
		<cfquery name="insertMoveJobForm" datasource="aaalh3x_onestep">
		INSERT INTO carrier_move_job_agreements(
			carrier_id, customer_name, customer_phone, customer_email,
			move_from, move_to, packing_loading_date, delivery_date, preferred_delivery_date,
			move_type, storage_needed, days_in_storage, miles,
			approx_travel_time_hours, total_hours_billed, men_required,
			suggested_truck_size, residence_type, elevator,
			stairs_inside, stairs_outside, long_carry,
			move_size, weight_cubic_feet, packing, total_items,
			dishpacks, small_boxes, book_boxes, medium_boxes, large_boxes, extra_large_boxes,
			boxes_6, boxes_6_5, mirror_picture_boxes, wardrobe_boxes,
			flat_tv_boxes, flat_screen_tv_count, crib_mattress,
			single_bed_boxes, double_bed_boxes, king_queen_bed_boxes,
			other_material_needed, accessorial, extra_info,
			virtual_survey, other_estimate, binding_estimate, non_binding_estimate,
			not_to_exceed, flat_rate, hourly_estimate, amount_paid_to_carrier, addendum
		)
		VALUES(
			#ClientID#, '#form.CustomerName#', '#form.CustomerPhone#', '#form.CustomerEmail#',
			'#form.MoveFrom#', '#form.MoveTo#',
			<cfif form.PackingLoadingDate NEQ '' AND IsDate(form.PackingLoadingDate)>'#DateFormat(form.PackingLoadingDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			<cfif form.DeliveryDate NEQ '' AND IsDate(form.DeliveryDate)>'#DateFormat(form.DeliveryDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			<cfif form.PreferredDeliveryDate NEQ '' AND IsDate(form.PreferredDeliveryDate)>'#DateFormat(form.PreferredDeliveryDate, "yyyy-mm-dd")#'<cfelse>NULL</cfif>,
			'#form.MoveType#', '#form.StorageNeeded#',
			<cfif IsNumeric(form.DaysInStorage)>#form.DaysInStorage#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.Miles)>#form.Miles#<cfelse>NULL</cfif>,
			'#form.ApproxTravelTime#', '#form.TotalHoursBilled#',
			<cfif IsNumeric(form.MenRequired)>#form.MenRequired#<cfelse>NULL</cfif>,
			'#form.SuggestedTruckSize#', '#form.ResidenceType#', '#form.Elevator#',
			'#form.StairsInside#', '#form.StairsOutside#', '#form.LongCarry#',
			'#form.MoveSize#', '#form.WeightCubicFeet#', '#form.Packing#',
			<cfif IsNumeric(form.TotalItems)>#form.TotalItems#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.Dishpacks)>#form.Dishpacks#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.SmallBoxes)>#form.SmallBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.BookBoxes)>#form.BookBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.MediumBoxes)>#form.MediumBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.LargeBoxes)>#form.LargeBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.ExtraLargeBoxes)>#form.ExtraLargeBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.Boxes6)>#form.Boxes6#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.Boxes65)>#form.Boxes65#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.MirrorPictureBoxes)>#form.MirrorPictureBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.WardrobeBoxes)>#form.WardrobeBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.FlatTVBoxes)>#form.FlatTVBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.FlatScreenTVCount)>#form.FlatScreenTVCount#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.CribMattress)>#form.CribMattress#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.SingleBedBoxes)>#form.SingleBedBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.DoubleBedBoxes)>#form.DoubleBedBoxes#<cfelse>NULL</cfif>,
			<cfif IsNumeric(form.KingQueenBedBoxes)>#form.KingQueenBedBoxes#<cfelse>NULL</cfif>,
			'#form.OtherMaterialNeeded#', '#form.Accessorial#', '#form.ExtraInfo#',
			'#form.VirtualSurvey#', '#form.OtherEstimate#', '#form.BindingEstimate#', '#form.NonBindingEstimate#',
			'#form.NotToExceed#', '#form.FlatRate#', '#form.HourlyEstimate#', '#form.AmountPaidToCarrier#', '#form.Addendum#'
		)
		</cfquery>
		<cfquery name="getLastInsertID" datasource="aaalh3x_onestep">
		SELECT LAST_INSERT_ID() as lastID
		</cfquery>
		<cfset formID = getLastInsertID.lastID>
	</cfif>
	
	<!--- Generate PDF for Move Job Agreement --->
	<cfif NOT IsDefined("form.MoveJobFormID") OR form.MoveJobFormID EQ "">
		<cfset formID = getLastInsertID.lastID>
	<cfelse>
		<cfset formID = form.MoveJobFormID>
	</cfif>
	
	<!--- Get the saved form data to generate PDF --->
	<cfquery name="getFormData" datasource="aaalh3x_onestep">
	SELECT *
	FROM carrier_move_job_agreements
	WHERE id = #formID#
	</cfquery>
	
	<!--- Check if PDF already exists for this form --->
	<cfif IsDefined("getFormData.pdf_path") AND getFormData.pdf_path NEQ "" AND NOT IsNull(getFormData.pdf_path)>
		<!--- Delete old PDF file if name changed --->
		<cfset oldPdfPath = "C:\lucee\tomcat\webapps\ROOT\movers\admin\CarrierDocuments\#getFormData.pdf_path#">
	</cfif>
	
	<!--- Always extract customer last name from full name --->
	<cfset customerFullName = form.CustomerName>
	<cfset nameArray = ListToArray(customerFullName, " ")>
	<cfif ArrayLen(nameArray) GT 0>
		<cfset customerLastName = nameArray[ArrayLen(nameArray)]>
	<cfelse>
		<cfset customerLastName = customerFullName>
	</cfif>
	
	<!--- Sanitize filename (remove special characters) --->
	<cfset customerLastName = REReplace(customerLastName, "[^a-zA-Z0-9]", "", "ALL")>
	
	<!--- Generate filename with customer last name only --->
	<cfset pdfFileName = "#customerLastName#.pdf">
	
	<!--- Delete old PDF file if it exists and name changed --->
	<cfif IsDefined("oldPdfPath") AND FileExists(oldPdfPath) AND getFormData.pdf_path NEQ pdfFileName>
		<cffile action="delete" file="#oldPdfPath#">
	</cfif>
	
	<cfset pdfFilePath = "C:\lucee\tomcat\webapps\ROOT\movers\admin\CarrierDocuments\#pdfFileName#">
	
	<!--- Set URL-like variables for the template --->
	<cfset url.clientid = ClientID>
	<cfset url.formid = formID>
	
	<!--- Generate PDF using cfdocument --->
	<cfdocument
      format="PDF" pagetype="letter" scale="88" 
      margintop="0.3" marginbottom="0.3" marginleft="0.3" marginright="0.3"
      filename="#pdfFilePath#"
      overwrite="yes" >
  
    <cfinclude template="letters/move_job_agreement.cfm">
  </cfdocument>
	
	<!--- Update pdf_path in database --->
	<cfquery name="updatePDFPath" datasource="aaalh3x_onestep">
	UPDATE carrier_move_job_agreements
	SET pdf_path = '#pdfFileName#'
	WHERE id = #formID#
	</cfquery>
	
	<!--- Redirect to clear form (no formID = blank form) --->
	<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfif IsDefined("form.UpdateBoxRateButton")>
	<cfquery name="checkForExisting" datasource="aaalh3x_onestep">
	SELECT *
	FROM carrier_packingrates
	WHERE ClientID = #ClientID#
	</cfquery>
    <cfquery name="getBoxes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_packingBoxes
    </cfquery>
	<cfif checkForExisting.RecordCount>
	<cfoutput query="getBoxes">
		<cfquery name="updateRates" datasource="aaalh3x_onestep">
		UPDATE carrier_packingrates
		SET PackingMaterial = '#Evaluate('PackingMaterial' & getBoxes.ID)#',
			PackingLabor = '#Evaluate('PackingLabor' & getBoxes.ID)#',
			PackingTotal = '#Evaluate('PackingTotal' & getBoxes.ID)#',
			Unpacking = '#Evaluate('Unpacking' & getBoxes.ID)#'
		WHERE ClientID = #ClientID# and
			BoxID = #getBoxes.ID#
		</cfquery>
	</cfoutput>
	<cfelse>
    <cfoutput query="getBoxes">
    	<cfquery name="addRates" datasource="aaalh3x_onestep">
    	INSERT INTO carrier_packingrates(BoxID, ClientID, PackingMaterial, PackingLabor, PackingTotal, Unpacking)
    	VALUES(#getBoxes.ID#,#ClientID#,'#Evaluate('PackingMaterial' & getBoxes.ID)#','#Evaluate('PackingLabor' & getBoxes.ID)#','#Evaluate('PackingTotal' & getBoxes.ID)#','#Evaluate('Unpacking' & getBoxes.ID)#')
    	</cfquery>
    </cfoutput>
	</cfif>
		<!--- update comments --->
		<cfquery name="checkComments" datasource="aaalh3x_onestep">
		SELECT *
		FROM carrier_comments
		WHERE ClientID = #ClientID#
		</cfquery>
		<cfif checkComments.RecordCount>
			<cfquery name="updateComments" datasource="aaalh3x_onestep">
			UPDATE carrier_comments
			SET packingComments = '#form.packingComments#'
			WHERE ClientID = #ClientID#
			</cfquery>
		<cfelse>
			<cfquery name="insertComments" datasource="aaalh3x_onestep">
			INSERT INTO carrier_comments(ClientID,PackingComments)
			VALUES(#ClientID#,'#form.packingComments#')
			</cfquery>
		</cfif>
		<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfif IsDefined("form.UpdateLocalRatesButton")>
	<cfquery name="checkForExisting" datasource="aaalh3x_onestep">
	SELECT *
	FROM carrier_localrates
	WHERE ClientID = #ClientID#
	</cfquery>
    <cfquery name="getRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_localratetypes
    </cfquery>
	<cfif checkForExisting.RecordCount>
	<cfoutput query="getRateTypes">
		<cfquery name="updateRates" datasource="aaalh3x_onestep">
		UPDATE carrier_localrates
		SET Rate = '#Evaluate('rateValue' & getRateTypes.ID)#'
		WHERE ClientID = #ClientID# and
			RateTypeID = #getRateTypes.ID#
		</cfquery>
	</cfoutput>
	<cfelse>
	<cfoutput query="getRateTypes">
		<cfquery name="addRates" datasource="aaalh3x_onestep">
		INSERT INTO carrier_localrates(RateTypeID, ClientID, Rate)
		VALUES(#getRateTypes.ID#,#ClientID#,'#Evaluate('rateValue' & getRateTypes.ID)#')
		</cfquery>
	</cfoutput>
	</cfif>
		<!--- update comments --->
		<cfquery name="checkComments" datasource="aaalh3x_onestep">
		SELECT *
		FROM carrier_comments
		WHERE ClientID = #ClientID#
		</cfquery>
		<cfif checkComments.RecordCount>
			<cfquery name="updateComments" datasource="aaalh3x_onestep">
			UPDATE carrier_comments
			SET MiscChargeComments = '#form.MiscComments#'
			WHERE ClientID = #ClientID#
			</cfquery>
		<cfelse>
			<cfquery name="insertComments" datasource="aaalh3x_onestep">
			INSERT INTO carrier_comments(ClientID,MiscChargeComments)
			VALUES(#ClientID#,'#form.MiscComments#')
			</cfquery>
		</cfif>
	<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfif IsDefined("form.UpdateStorageRatesButton")>
	<cfquery name="checkForExisting" datasource="aaalh3x_onestep">
	SELECT *
	FROM carrier_storageRates
	WHERE ClientID = #ClientID#
	</cfquery>
    <cfquery name="getRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_storageratetypes
    </cfquery>
	<cfif checkForExisting.RecordCount>
	<cfoutput query="getRateTypes">
		<cfquery name="updateRates" datasource="aaalh3x_onestep">
		UPDATE carrier_storagerates
		SET Rate = '#Evaluate('StorageRateValue' & getRateTypes.ID)#'
		WHERE StorageRateID = #getRateTypes.ID# and
			ClientID = #ClientID#
		</cfquery>
	</cfoutput>
	<cfelse>
	<cfoutput query="getRateTypes">
		<cfquery name="addRates" datasource="aaalh3x_onestep">
		INSERT INTO carrier_storagerates(StorageRateID, ClientID, Rate)
		VALUES(#getRateTypes.ID#,#ClientID#,'#Evaluate('StorageRateValue' & getRateTypes.ID)#')
		</cfquery>
	</cfoutput>
	</cfif>
		<!--- update comments --->
		<cfquery name="checkComments" datasource="aaalh3x_onestep">
		SELECT *
		FROM carrier_comments
		WHERE ClientID = #ClientID#
		</cfquery>
		<cfif checkComments.RecordCount>
			<cfquery name="updateComments" datasource="aaalh3x_onestep">
			UPDATE carrier_comments
			SET GeneralComments = '#form.GeneralComments#'
			WHERE ClientID = #ClientID#
			</cfquery>
		<cfelse>
			<cfquery name="insertComments" datasource="aaalh3x_onestep">
			INSERT INTO carrier_comments(ClientID,GeneralComments)
			VALUES(#ClientID#,'#form.GeneralComments#')
			</cfquery>
		</cfif>
	<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfif isDefined("form.submitDocument")>
	<cffile action="upload" destination="C:\lucee\tomcat\webapps\ROOT\movers\admin\CarrierDocuments" filefield="documentFile" nameconflict="makeunique"> 
	<cfset theFilename = cffile.serverfile>
	<cfquery name="logDocumentfile" datasource="aaalh3x_onestep">
	INSERT INTO carrier_supportdocs(ClientID, Document)
	VALUES(#ClientID#,'#theFilename#')
	</cfquery>
</cfif>

<cfif isDefined("url.killDocument") and url.killDocument eq "true">
	<cfquery name="getDocumentfile" datasource="aaalh3x_onestep">
	SELECT *
	FROM carrier_supportdocs
	WHERE ID = #ID# and
		ClientID = #ClientID#
	</cfquery>
	<cfif getDocumentfile.RecordCount>
	<cffile action="delete" file="C:\lucee\tomcat\webapps\ROOT\movers\admin\CarrierDocuments\#getDocumentfile.Document#">
	<cfquery name="getDocumentfile" datasource="aaalh3x_onestep">
	DELETE
	FROM carrier_supportdocs
	WHERE ID = #ID# and
		ClientID = #ClientID#
	</cfquery>
	</cfif>
</cfif>

<!--- Delete Move Job Agreement PDF --->
<cfif isDefined("url.killMoveJobPDF") and url.killMoveJobPDF eq "true" and isDefined("url.moveJobID")>
	<cfquery name="getMoveJobPDF" datasource="aaalh3x_onestep">
	SELECT pdf_path
	FROM carrier_move_job_agreements
	WHERE id = #url.moveJobID# 
	AND carrier_id = #ClientID#
	</cfquery>
	<cfif getMoveJobPDF.RecordCount and getMoveJobPDF.pdf_path NEQ "">
		<cfset pdfFullPath = "C:\lucee\tomcat\webapps\ROOT\movers\admin\CarrierDocuments\#getMoveJobPDF.pdf_path#">
		<cfif FileExists(pdfFullPath)>
			<cffile action="delete" file="#pdfFullPath#">
		</cfif>
		<cfquery name="deleteMoveJobPDF" datasource="aaalh3x_onestep">
		UPDATE carrier_move_job_agreements
		SET pdf_path = NULL
		WHERE id = #url.moveJobID#
		AND carrier_id = #ClientID#
		</cfquery>
	</cfif>
	<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>


<cfset fulldatenow = now()>
<cfset datenow = dateformat(fulldatenow, "YYYY-MM-DD")>

<!--- systems for marking postal mail for today --->
<cfif parameterexists(mark_initial) is 'yes'>
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from carrier_LETTER_SENDS
        where send_type=1 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,active,cust_hook,sent_date,user_hook)
             values ('999','1','1',#clientid#,'#datenow#',#verify.id#)
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,active,cust_hook,sent_date,user_hook)
             values ('999','1','1',#clientid#,'#datenow#',#verify.id#)
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_LeasingAgent) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from carrier_LETTER_SENDS
        where send_type=101 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('101','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('101','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_MortgageOfficer) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from carrier_LETTER_SENDS
        where send_type=102 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('102','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into carrier_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('102','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_follow) is 'yes'>
	
	<cfquery name="getinfo" datasource="aaalh3x_onestep">
		select * from carrier_records
		where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	</cfquery>
	
    <cfset appointment_date = Now()>
	<cfif appointment_date neq ''>
		
		<cfquery name="checkFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
			select *
			from carrier_LETTER_SENDS
			where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
			and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
            and user_hook = #verify.ID#
            and sent = 0
			order by followup_date
		</cfquery>
        
		
		<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
			<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
				insert into carrier_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date,date_time_to_order_on_sheet)
				values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">)
			</cfquery>
			
			<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,appointment_date)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,appointment_date)>
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfquery name="q" datasource="aaalh3x_onestep">
					insert into carrier_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
			</cfloop>
			
			<!--- Send email to Anthony and Maria to let them know that a new follow-up label is queued--->
			<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
				#getinfo.first_name# #getinfo.last_name#<br />
				#getinfo.from_address# #getinfo.from_address2#<br />
				#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
			</cfmail>--->
		<cfelse>
			<!--- Force the first label in queue to have a follow up date now so it can be printed --->
			<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
				update carrier_LETTER_SENDS
				set active = <cfqueryparam cfsqltype="cf_sql_bit" value="1">,
					followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,
                    sent = 1,
					date_time_to_order_on_sheet = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">,
					user_hook = '#verify.id#'<!--- This is important so that the current user can see the customer's follow up label in the front-end even if the current user hasn't entered the customer in the database --->
				where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#checkFollowUpLabelBeforeAppointmentDate.id[1]#">
			</cfquery>
			<!--- Send email to Anthony and Maria to let them know that a new follow-up label is queued--->
			<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
				#getinfo.first_name# #getinfo.last_name#<br />
				#getinfo.from_address# #getinfo.from_address2#<br />
				#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
			</cfmail>--->
		</cfif>
	</cfif>
</cfif>



<cfif isDefined("form.UpdateRecordButton")>
<cfquery name="updateInfo" datasource="aaalh3x_onestep">
UPDATE carrier_records
SET repfirstname = '#Rep_first_name#', replastname = '#Rep_last_name#', cellphone = '#Rep_cellPhone#', emailaddress = '#Rep_email#',
	streetaddress = '#Rep_address#', city = '#Rep_city#', state = '#Rep_State#', zip = '#rep_zip#', County = '#County#',
    Phone = '#Rep_Phone#', fax = '#fax#', mailingaddress = '#mailingaddress#', mailingCity = '#mailingcity#',
    mailingState = '#mailingState#', mailingZip = '#mailingzip#', mailingCounty = '#mailingCounty#',
    CompanyName = '#CompanyName#', AccountStatus = '#AccountStatus#', MC = '#MC#', USDOT = '#USDOT#',
    DBA1 = '#DBA1#', DBA2 = '#DBA2#', AddToListOfCarriers = '#AddToListOfCarriers#', StateDOT = '#StateDOT#',
    cellphone2 = '#Rep_cellPhone2#', cellphone3 = '#Rep_cellPhone3#', cellphone4 = '#Rep_cellPhone4#',
    Emailaddress2 = '#Rep_email2#', Emailaddress3 = '#Rep_email3#', Emailaddress4 = '#Rep_email4#',
    CompanyPosition = '#Rep_Position#', CompanyWebsite = '#CompanyWebsite#',
    AddTo409Agreement = '#AddTo409Agreement#', AddTo409Agreement2 = '#AddTo409Agreement2#', AddTo409Agreement3 = '#AddTo409Agreement3#',
    AddToMoveJobAgreement = '#AddToMoveJobAgreement#', AddToMoveJobAgreement2 = '#AddToMoveJobAgreement2#', AddToMoveJobAgreement3 = '#AddToMoveJobAgreement3#',
    Rep2firstname = '#Rep2_first_name#', Rep2lastname = '#Rep2_last_name#', Rep2phone = '#Rep2_Phone#',
    Rep2Emailaddress = '#Rep2_email#', Rep2cellphone = '#Rep2_cellPhone#', Rep2Position = '#Rep2_Position#',
    Rep2cellphone2 = '#Rep2_cellPhone2#', Rep2cellphone3 = '#Rep2_cellPhone3#', Rep2cellphone4 = '#Rep2_cellPhone4#',
    Rep2Emailaddress2 = '#Rep2_email2#', Rep2Emailaddress3 = '#Rep2_email3#', Rep2Emailaddress4 = '#Rep2_email4#',
    Rep3firstname = '#Rep3_first_name#', Rep3lastname = '#Rep3_last_name#', Rep3phone = '#Rep3_Phone#',
    Rep3Emailaddress = '#Rep3_email#', Rep3cellphone = '#Rep3_cellPhone#', Rep3Position = '#Rep3_Position#',
    Rep3cellphone2 = '#Rep3_cellPhone2#', Rep3cellphone3 = '#Rep3_cellPhone3#', Rep3cellphone4 = '#Rep3_cellPhone4#',
    Rep3Emailaddress2 = '#Rep3_email2#', Rep3Emailaddress3 = '#Rep3_email3#', Rep3Emailaddress4 = '#Rep3_email4#'
WHERE ID = #ClientID#
</cfquery>
 <!--- Add to Carrier List if requested --->
 <cfif IsDefined("form.AddToListOfCarriers")>
   <cfquery name="checkCarrierList" datasource="aaalh3x_onestep">
     SELECT ID FROM carrier_list WHERE CarrierID = #ClientID#
   </cfquery>
   <cfif checkCarrierList.RecordCount EQ 0>
     <!--- Insert new record with AddToList value (1 for Yes, 0 for No) --->
     <cfquery name="addCarrierList" datasource="aaalh3x_onestep">
       INSERT INTO carrier_list (CompanyName, USDOT, MC, CarrierID, AddToList)
       VALUES ('#CompanyName#', '#USDOT#', '#MC#', #ClientID#, <cfif form.AddToListOfCarriers eq "Yes">1<cfelse>0</cfif>)
     </cfquery>
   <cfelse>
     <!--- Update existing record with AddToList value (1 for Yes, 0 for No) --->
     <cfquery name="updateCarrierList" datasource="aaalh3x_onestep">
       UPDATE carrier_list SET
         CompanyName = '#CompanyName#',
         USDOT = '#USDOT#',
         MC = '#MC#',
         AddToList = <cfif form.AddToListOfCarriers eq "Yes">1<cfelse>0</cfif>
       WHERE CarrierID = #ClientID#
     </cfquery>
   </cfif>
 </cfif>
<!--- update more info ---->
<cfquery name="checkMoreInfo" datasource="aaalh3x_onestep">
SELECT *
FROM carrier_moreinfo
WHERE ClientID = #ClientID#
</cfquery>
<cfif checkMoreInfo.RecordCount>
	<cfquery name="updateInfo" datasource="aaalh3x_onestep">
	UPDATE carrier_moreinfo
	SET TruckNumberSize = '#TruckNumberSize#',
		TractorNumber = '#TractorNumber#',
		TrailerNumber = '#TrailerNumber#',
		TotalDrivers = '#TotalDrivers#',
		BIPDLevel = '#BIPDLevel#',
		CargoLevel = '#CargoLevel#',
		ThirdPartyMoveIns = '#ThirdPartyMoveIns#',
		StorageFacilities = '#StorageFacilities#',
		StorageComments = '#StorageComments#',
		PublishedTariffRates = '#PublishedTariffRates#',
		PublishedTariffRateComments = '#PublishedTariffRateComments#'
	WHERE ClientID = #ClientID#
	</cfquery>
<cfelse>
	<cfquery name="insertInfo" datasource="aaalh3x_onestep">
	INSERT INTO carrier_moreinfo(ClientID,TruckNumberSize,TractorNumber,TrailerNumber,TotalDrivers,BIPDLevel,CargoLevel,ThirdPartyMoveIns,StorageFacilities,StorageComments,PublishedTariffRates,PublishedTariffRateComments)
	VALUES(#ClientID#,'#TruckNumberSize#','#TractorNumber#','#TrailerNumber#','#TotalDrivers#','#BIPDLevel#','#CargoLevel#','#ThirdPartyMoveIns#','#StorageFacilities#','#StorageComments#','#PublishedTariffRates#','#PublishedTariffRateComments#')
	</cfquery>
</cfif>

<cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfset datenow = dateformat(now(), "YYYY-MM-DD")>
<cfquery name="getInfo" datasource="aaalh3x_onestep">
SELECT *
FROM carrier_records
WHERE ID = #ClientID#
</cfquery>
<cfquery name="getcomments" datasource="aaalh3x_onestep">
SELECT *
FROM carrier_comments
WHERE ClientID = #ClientID#
</cfquery>

<cfquery name="get_initial" datasource="aaalh3x_onestep">
select * from carrier_LETTER_SENDS
where send_type=999 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfquery name="checkEmailedNew" datasource="aaalh3x_onestep">
select * from carrier_LETTER_SENDS
where (send_type=8 or send_type=9) and sent=2 and cust_hook=#clientid#
</cfquery>
<cfquery name="checkEmailedFollowup" datasource="aaalh3x_onestep">
select * from carrier_LETTER_SENDS
where (send_type=10 or send_type = 11) and sent=2 and cust_hook=#clientid#
</cfquery>
<cfquery name="get_booked" datasource="aaalh3x_onestep">
	SELECT * FROM carrier_printqueue pq left join carrier_LETTER_SENDS ls on pq.id = ls.printqueueId
	where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
    and pq.memberID = #verify.ID#
	order by pq.followup_date
</cfquery>

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b><cfoutput>Administration - Viewing #getInfo.RepFirstname# #getInfo.RepLastname# from #getInfo.CompanyName#</cfoutput></b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table>

<div class="row">
    <div class="large-12 columns">
    <div class="row">
        <div class="small-7 columns">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size:12px">
  <tr>
    <th scope="col">Letter</th>
    <th scope="col">Date</th>
    <th scope="col">Letter Generation</th>
  </tr>
  <tr>
    <td>Main Letter sent</td>
    <td align="center">(<cfif #get_initial.sent# is 1>Mailed<cfelseif #get_initial.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_initial.sent_date, "MMM D, YYYY")#) </cfoutput></td>
  	<td rowspan="8" valign="top">
    <cfoutput>
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
      <tr>
        <td><strong>Carrier Letter</strong><br>
        	<a href="carrierPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=new" style="color:blue;">Queue</a> | <a href="carrier_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_initial=y" style="color:blue;">Mark Mailed</a> | <a href="letters/carrierEmailNew.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" target="_blank" style="color:blue;">Email</a></td>
      </tr>
      <tr>
        <td><strong>Follow Up Letter</strong><br>
        <a href="carrierPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=followUp" style="color:blue;">Queue</a> | <a href="carrier_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_Follow=y" style="color:blue;">Mark Mailed</a> | <a href="letters/carrierEmailFollowup.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" target="_blank" style="color:blue;">Email</a>
        </td>
      </tr>
    </table>
	</cfoutput>
    </td>
  </tr>
  <cfif checkEmailedNew.RecordCount>
  <cfoutput query="checkEmailedNew">
  <tr>
    <td>Main Letter sent</td>
    <td align="center">(Emailed #dateformat(checkEmailedNew.sent_date, "MMM D, YYYY")# <cfif checkEmailedNew.send_type eq 9> - 2nd</cfif>)</td>
  </tr>
  </cfoutput>
  </cfif>
  <cfif checkEmailedFollowup.RecordCount>
  <cfoutput query="checkEmailedFollowup">
  <tr>
    <td>Follow Up Letter sent</td>
    <td align="center">(Emailed #dateformat(checkEmailedFollowup.sent_date, "MMM D, YYYY")# <cfif checkEmailedFollowup.send_type eq 11> - 2nd</cfif>)</td>
  </tr>
  </cfoutput>
  </cfif>
  <cfoutput query="get_booked">
  <cfif get_booked.sent eq 0 or get_booked.sent eq ''>
  <tr>
    <td>Follow Up #get_booked.currentRow# Not Sent</td>
    <td align="center">&nbsp;</td>
  </tr>
  <cfelse>
  <tr>
    <td>Follow Up #get_booked.currentRow# Sent</td>
    <td align="center"><cfif get_booked.sent eq 1>(Mailed #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<cfelseif get_booked.sent eq 2>(Emailed #dateformat(get_booked.sent_date, "MMM D, YYYY")#)</cfif> </td>
  </tr>
  </cfif>
  </cfoutput>
</table>
    <cfif getInfo.Active eq 3>
    	<h3>Carrier Marked COMPLETE</h3>
    </cfif>
    	</div>
        <div class="small-5 columns">
        <cfoutput>
			<table border="0" cellspacing="0" cellpadding="5" width="50%" align="right">
				<tr>
					<td><a href="main.cfm?un=#un#&pw=#pw#"><img src="images/section1.png" width="125"></a></td>
					<td><a href="mainCarrier.cfm?un=#un#&pw=#pw#"><img src="images/section2.png" width="125"></a></td>
					<td><a href="mainRealtor.cfm?un=#un#&pw=#pw#"><img src="images/section3.png" width="125"></a></td>
				</tr>
			</table>
        </cfoutput>
        <br>
        <table border="0" cellspacing="0" cellpadding="5" width="50%" align="right">
        	<tr>
        		<td><a data-open="uploadImage"><cfif getInfo.profilePhoto neq ""><cfoutput><img src="images/carrierImages/#getInfo.profilePhoto#" width="142"></cfoutput><cfelse><img src="images/placeholder.png"></cfif></a></td>
        		<td><a data-open="uploadCardImage"><cfif getInfo.BusinessCardPhoto neq ""><cfoutput><img src="images/carrierImages/#getInfo.BusinessCardPhoto#" width="300"></cfoutput><cfelse><img src="images/placeholder2.png"></cfif></a></td>
        	</tr>	
        </table>
    	</div>
    </div>
    </div>
</div>

<div class="reveal" id="uploadImage" data-reveal data-close-on-click="false" data-close-on-esc="false">
  <h3 style="text-align:center;">Upload Carrier Headshot</h3>
	<cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall" method="post" enctype="multipart/form-data">
		<cfif getInfo.profilePhoto neq "">
			<input type="hidden" name="oldheadshotImage" value="#getInfo.profilePhoto#">
			<img src="images/carrierImages/#getInfo.profilePhoto#" width="75"><br>
				<a href="carrier_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall&DeleteRealtorImage=#getInfo.profilePhoto#">[click here to delete this image]</a>
			<br><br>
		</cfif>
	</cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="headshotImage" class="text-left">Select Image:</label>
        </div>
        <div class="small-9 columns">
          <input type="file" name="headshotImage" id="headshotImage">
        </div>
     </div>
     <div class="row">
     	<div class="small-12 columns" style="text-align:center;">
     	<input type="submit" class="button" name="submitheadshot" value="Upload Headshot">
     	</div>
     </div>
	</form>
  <button class="close-button" data-close aria-label="Close modal" type="button">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<div class="reveal" id="uploadCardImage" data-reveal data-close-on-click="false" data-close-on-esc="false">
  <h3 style="text-align:center;">Upload Carrier Business Card</h3>
	<cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall" method="post" enctype="multipart/form-data">
		<cfif getInfo.BusinessCardPhoto neq "">
			<input type="hidden" name="oldbusinesscardImage" value="#getInfo.BusinessCardPhoto#">
			<img src="images/carrierImages/#getInfo.BusinessCardPhoto#" width="150"><br>
				<a href="carrier_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall&DeleteRealtorCardImage=#getInfo.BusinessCardPhoto#">[click here to delete this image]</a>
			<br><br>
		</cfif>
	</cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="cardImage" class="text-left">Select Image:</label>
        </div>
        <div class="small-9 columns">
          <input type="file" name="cardImage" id="cardImage">
        </div>
     </div>
     <div class="row">
     	<div class="small-12 columns" style="text-align:center;">
     	<input type="submit" class="button" name="submitcardimage" value="Upload Business Card">
     	</div>
     </div>
	</form>
  <button class="close-button" data-close aria-label="Close modal" type="button">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
<div class="reveal" id="uploadDocument" data-reveal data-close-on-click="false" data-close-on-esc="false">
  <h3 style="text-align:center;">Upload Carrier Document</h3>
  <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall" method="post" enctype="multipart/form-data"></cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="cardImage" class="text-left">Select Document:</label>
        </div>
        <div class="small-9 columns">
          <input type="file" name="documentFile" id="documentFile">
        </div>
     </div>
     <div class="row">
     	<div class="small-12 columns" style="text-align:center;">
     	<input type="submit" class="button" name="submitDocument" value="Upload Document">
     	</div>
     </div>
  </form>
  <button class="close-button" data-close aria-label="Close modal" type="button">
    <span aria-hidden="true">&times;</span>
  </button>
</div>



<div class="row">
    <div class="large-12 columns">
    
	<fieldset class="fieldset">
    <legend><strong>Carrier Documents</strong></legend>
	<cfquery name="getDocuments" datasource="aaalh3x_onestep">
	select * 
	from carrier_supportdocs
	where ClientID = #clientid#
	</cfquery>
	
	<!--- Get Move Job Agreement PDFs --->
	<cfquery name="getMoveJobPDFs" datasource="aaalh3x_onestep">
	SELECT id, customer_name, pdf_path, packing_loading_date, created_at, updated_at
	FROM carrier_move_job_agreements
	WHERE carrier_id = #clientid#
	AND pdf_path IS NOT NULL
	AND pdf_path != ''
	ORDER BY id DESC
	</cfquery>
	
	<div class="row">
		<!-- LEFT COLUMN : Carrier Documents -->
		<div class="small-8 columns">
			<cfif getDocuments.recordCount eq 0 AND getMoveJobPDFs.recordCount eq 0>
					<h5>No Carrier Documents Found</h5>
			<cfelse>
				<!--- Display Move Job Agreement PDFs --->
				<cfif getMoveJobPDFs.recordCount gt 0>
					<h6><strong>Move Job Agreements:</strong></h6>
					<cfoutput query="getMoveJobPDFs">
						<!--- Extract last name from customer_name --->
						<cfset displayNameArray = ListToArray(customer_name, " ")>
						<cfif ArrayLen(displayNameArray) GT 0>
							<cfset displayLastName = displayNameArray[ArrayLen(displayNameArray)]>
						<cfelse>
							<cfset displayLastName = customer_name>
						</cfif>
						<div style="margin-bottom:8px; padding:8px; background-color:##f9f9f9; border-left:3px solid ##2199e8;">
							<a href="CarrierDocuments/#pdf_path#" target="_blank" style="font-weight:bold;">
								<i class="fa fa-file-pdf-o" style="color:##d32f2f;"></i> #displayLastName#
							</a>
							<cfif IsDate(updated_at)>
								<span style="color:##666; font-size:12px; margin-left:10px;">
									(#DateFormat(updated_at, "mm/dd/yyyy")#)
								</span>
							<cfelseif IsDate(created_at)>
								<span style="color:##666; font-size:12px; margin-left:10px;">
									(#DateFormat(created_at, "mm/dd/yyyy")#)
								</span>
							</cfif>
							<a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&killMoveJobPDF=true&moveJobID=#id#"
								title="DELETE PDF" style="margin-left:10px; color:red;">[x]</a>
						</div>
					</cfoutput>
					<br>
				</cfif>
				
				<!--- Display Support Documents --->
				<cfif getDocuments.recordCount gt 0>
					<h6><strong>Other Documents:</strong></h6>
					<cfoutput query="getDocuments">
						<div>
							<a href="CarrierDocuments/#Document#" target="_blank">
									<strong>#Document#</strong>
							</a>
							<a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&killDocument=true&ID=#ID#"
								title="DELETE DOCUMENT">[x]</a>
						</div>
					</cfoutput>
				</cfif>
			</cfif>

			<br>
			<a data-open="uploadDocument" class="button tiny">
				UPLOAD A DOCUMENT
			</a>

		</div>

		<!-- RIGHT COLUMN : 409 Agreement -->
		<div class="small-4 columns text-right">
        <h5 style="margin-bottom:5px;">409 Agreement</h5>

        <cfoutput>
            <span style="display:inline-flex; align-items:center; gap:6px; font-size:14px;">
                
                <span style="font-size:18px;">PDF</span>

                <a href="letters/agreement_pdf.cfm?clientid=#clientid#&un=#un#&pw=#pw#"
                  target="_blank"
                  title="Open Agreement PDF"
                  style="font-size:18px; color:##555; text-decoration:none;">
                    <i class="fa fa-file-pdf-o"></i>
                </a>

            </span>
        </cfoutput>
    </div>

	</div>
	</fieldset>
    
    	
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addDataForm" data-abide novalidate></cfoutput>
	<fieldset class="fieldset">
    <legend><strong>Company / Account Status</strong></legend>
    <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="CompanyName" class="text-left middle">Company Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="CompanyName" size="20" id="CompanyName" placeholder="Company Name" value="#CompanyName#">
        </div>
        <div class="small-3 columns">
          <label for="AccountStatus" class="text-left middle">Status</label>
        </div>
        <div class="small-3 columns">
          <select name="AccountStatus" id="AccountStatus">
          	<option value="Open"<cfif AccountStatus eq "Open" or AccountStatus eq ""> selected</cfif>>Open</option>
          	<option value="Under Contract"<cfif AccountStatus eq "Under Contract"> selected</cfif>>Under Contract</option>
          	<option value="Complete"<cfif AccountStatus eq "Complete"> selected</cfif>>Complete</option>
          </select>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="DBA1" class="text-left middle">1st DBA</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="DBA1" size="20" id="DBA1" placeholder="1st DBA" value="#DBA1#">
        </div>
        <div class="small-3 columns">
          <label for="AddToListOfCarriers" class="text-left middle">Add to List of Carriers</label>
        </div>
        <div class="small-3 columns">
          <select name="AddToListOfCarriers" id="AddToListOfCarriers">
          	<option value="No"<cfif AddToListOfCarriers eq "No" or AddToListOfCarriers eq ""> selected</cfif>>NO</option>
          	<option value="Yes"<cfif AddToListOfCarriers eq "Yes"> selected</cfif>>YES</option>
          </select>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="DBA2" class="text-left middle">2nd DBA</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="DBA2" size="20" id="DBA2" placeholder="2nd DBA" value="#DBA2#">
        </div>
        <div class="small-3 columns">
          <label for="StateDOT" class="text-left middle">State DOT##</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="StateDOT" size="20" id="StateDOT" placeholder="State DOT Number" value="#StateDOT#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="MC" class="text-left middle">MC##</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="MC" size="20" id="MC" placeholder="MC Number" value="#MC#">
        </div>
        <div class="small-3 columns">
          <label for="USDOT" class="text-left middle">USDOT##</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="USDOT" size="20" id="USDOT" placeholder="USDOT Number" value="#USDOT#">
        </div>
      </div>
      </cfoutput>
	</fieldset>

	<fieldset class="fieldset">
    <legend><strong>Owner or Company Representative</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_first_name" class="text-left middle">First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_first_name" size="20" id="Rep_first_name" placeholder="First Name" value="#repfirstname#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_last_name" class="text-left middle">Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_last_name" size="20" id="Rep_last_name" placeholder="Last Name" value="#replastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_Phone" class="text-left middle">Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_Phone" size="20" id="Rep_Phone" placeholder="Phone" value="#phone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email" class="text-left middle">Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email" size="20" id="Rep_email" placeholder="Email" value="#Emailaddress#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone" class="text-left middle">Cell Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone" size="20" id="Rep_cellPhone" placeholder="Cell Phone" value="#cellphone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email2" class="text-left middle">Email 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email2" size="20" id="Rep_email2" placeholder="Email 2" value="#Emailaddress2#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone2" class="text-left middle">Cell Phone 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone2" size="20" id="Rep_cellPhone2" placeholder="Cell Phone 2" value="#cellphone2#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email3" class="text-left middle">Email 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email3" size="20" id="Rep_email3" placeholder="Email 3" value="#Emailaddress3#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone3" class="text-left middle">Cell Phone 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone3" size="20" id="Rep_cellPhone3" placeholder="Cell Phone 3" value="#cellphone3#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email4" class="text-left middle">Email 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email4" size="20" id="Rep_email4" placeholder="Email 4" value="#Emailaddress4#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone4" class="text-left middle">Cell Phone 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone4" size="20" id="Rep_cellPhone4" placeholder="Cell Phone 4" value="#cellphone4#">
        </div>
        <div class="small-3 columns">
          <label for="Fax" class="text-left middle">Fax</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Fax" size="20" id="Fax" placeholder="Fax" value="#Fax#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_Position" class="text-left middle">Position in Company</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_Position" size="20" id="Rep_Position" placeholder="Company Position" value="#CompanyPosition#">
        </div>
        <div class="small-3 columns">
          <label for="CompanyWebsite" class="text-left middle">Company Website</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="CompanyWebsite" size="20" id="CompanyWebsite" placeholder="Website" value="#CompanyWebsite#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AddTo409Agreement" class="text-left middle">Add to 409 Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddTo409Agreement" id="AddTo409Agreement">
            <option value="0"<cfif AddTo409Agreement eq 0 or AddTo409Agreement eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddTo409Agreement eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
        <div class="small-3 columns">
          <label for="AddToMoveJobAgreement" class="text-left middle">Add to Move Job Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddToMoveJobAgreement" id="AddToMoveJobAgreement">
            <option value="0"<cfif AddToMoveJobAgreement eq 0 or AddToMoveJobAgreement eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddToMoveJobAgreement eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
      </div>
      </cfoutput>
	</fieldset>

	<fieldset class="fieldset">
    <legend><strong>Company Representative 2</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_first_name" class="text-left middle">First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_first_name" size="20" id="Rep2_first_name" placeholder="First Name" value="#Rep2firstname#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_last_name" class="text-left middle">Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_last_name" size="20" id="Rep2_last_name" placeholder="Last Name" value="#Rep2lastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_Phone" class="text-left middle">Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_Phone" size="20" id="Rep2_Phone" placeholder="Phone" value="#Rep2phone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_email" class="text-left middle">Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_email" size="20" id="Rep2_email" placeholder="Email" value="#Rep2Emailaddress#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_cellPhone" class="text-left middle">Cell Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_cellPhone" size="20" id="Rep2_cellPhone" placeholder="Cell Phone" value="#Rep2cellphone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_email2" class="text-left middle">Email 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_email2" size="20" id="Rep2_email2" placeholder="Email 2" value="#Rep2Emailaddress2#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_cellPhone2" class="text-left middle">Cell Phone 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_cellPhone2" size="20" id="Rep2_cellPhone2" placeholder="Cell Phone 2" value="#Rep2cellphone2#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_email3" class="text-left middle">Email 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_email3" size="20" id="Rep2_email3" placeholder="Email 3" value="#Rep2Emailaddress3#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_cellPhone3" class="text-left middle">Cell Phone 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_cellPhone3" size="20" id="Rep2_cellPhone3" placeholder="Cell Phone 3" value="#Rep2cellphone3#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_email4" class="text-left middle">Email 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_email4" size="20" id="Rep2_email4" placeholder="Email 4" value="#Rep2Emailaddress4#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep2_cellPhone4" class="text-left middle">Cell Phone 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_cellPhone4" size="20" id="Rep2_cellPhone4" placeholder="Cell Phone 4" value="#Rep2cellphone4#">
        </div>
        <div class="small-3 columns">
          <label for="Rep2_Position" class="text-left middle">Position in Company</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep2_Position" size="20" id="Rep2_Position" placeholder="Company Position" value="#Rep2Position#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AddTo409Agreement2" class="text-left middle">Add to 409 Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddTo409Agreement2" id="AddTo409Agreement2">
            <option value="0"<cfif AddTo409Agreement2 eq 0 or AddTo409Agreement2 eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddTo409Agreement2 eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
        <div class="small-3 columns">
          <label for="AddToMoveJobAgreement2" class="text-left middle">Add to Move Job Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddToMoveJobAgreement2" id="AddToMoveJobAgreement2">
            <option value="0"<cfif AddToMoveJobAgreement2 eq 0 or AddToMoveJobAgreement2 eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddToMoveJobAgreement2 eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
      </div>
      </cfoutput>
	</fieldset>

	<fieldset class="fieldset">
    <legend><strong>Company Representative 3</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_first_name" class="text-left middle">First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_first_name" size="20" id="Rep3_first_name" placeholder="First Name" value="#Rep3firstname#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_last_name" class="text-left middle">Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_last_name" size="20" id="Rep3_last_name" placeholder="Last Name" value="#Rep3lastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_Phone" class="text-left middle">Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_Phone" size="20" id="Rep3_Phone" placeholder="Phone" value="#Rep3phone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_email" class="text-left middle">Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_email" size="20" id="Rep3_email" placeholder="Email" value="#Rep3Emailaddress#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_cellPhone" class="text-left middle">Cell Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_cellPhone" size="20" id="Rep3_cellPhone" placeholder="Cell Phone" value="#Rep3cellphone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_email2" class="text-left middle">Email 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_email2" size="20" id="Rep3_email2" placeholder="Email 2" value="#Rep3Emailaddress2#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_cellPhone2" class="text-left middle">Cell Phone 2</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_cellPhone2" size="20" id="Rep3_cellPhone2" placeholder="Cell Phone 2" value="#Rep3cellphone2#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_email3" class="text-left middle">Email 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_email3" size="20" id="Rep3_email3" placeholder="Email 3" value="#Rep3Emailaddress3#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_cellPhone3" class="text-left middle">Cell Phone 3</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_cellPhone3" size="20" id="Rep3_cellPhone3" placeholder="Cell Phone 3" value="#Rep3cellphone3#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_email4" class="text-left middle">Email 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_email4" size="20" id="Rep3_email4" placeholder="Email 4" value="#Rep3Emailaddress4#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep3_cellPhone4" class="text-left middle">Cell Phone 4</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_cellPhone4" size="20" id="Rep3_cellPhone4" placeholder="Cell Phone 4" value="#Rep3cellphone4#">
        </div>
        <div class="small-3 columns">
          <label for="Rep3_Position" class="text-left middle">Position in Company</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep3_Position" size="20" id="Rep3_Position" placeholder="Company Position" value="#Rep3Position#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AddTo409Agreement3" class="text-left middle">Add to 409 Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddTo409Agreement3" id="AddTo409Agreement3">
            <option value="0"<cfif AddTo409Agreement3 eq 0 or AddTo409Agreement3 eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddTo409Agreement3 eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
        <div class="small-3 columns">
          <label for="AddToMoveJobAgreement3" class="text-left middle">Add to Move Job Agreement</label>
        </div>
        <div class="small-3 columns">
          <select name="AddToMoveJobAgreement3" id="AddToMoveJobAgreement3">
            <option value="0"<cfif AddToMoveJobAgreement3 eq 0 or AddToMoveJobAgreement3 eq ""> selected="selected"</cfif>>No</option>
            <option value="1"<cfif AddToMoveJobAgreement3 eq 1> selected="selected"</cfif>>Yes</option>
          </select>
        </div>
      </div>
      </cfoutput>
	</fieldset>
	  
    <fieldset class="fieldset">
    <legend><strong>Mailing Address</strong></legend>
  <cfoutput query="getInfo">

    <div class="row">
        <div class="small-3 columns">
          <label for="mailingaddress" class="text-left middle">Address</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingaddress" size="20" id="mailingaddress" placeholder="Address" value="#mailingaddress#">
        </div>
        <div class="small-3 columns">
          <label for="mailingcity" class="text-left middle">City</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingcity" size="20" id="mailingcity" placeholder="City" value="#mailingcity#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="mailingState" class="text-left middle">State</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingState" size="20" id="mailingState" placeholder="Sate" value="#mailingstate#">
        </div>
        <div class="small-3 columns">
          <label for="mailingzip" class="text-left middle">Zip</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingzip" size="20" id="mailingzip" placeholder="Zip Code" value="#mailingzip#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="mailingCounty" class="text-left middle">County</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingCounty" size="20" id="mailingCounty" placeholder="County" value="#mailingCounty#">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>
    
    </cfoutput>
    </fieldset>

    <fieldset class="fieldset">
      <legend><strong>Physical Address</strong></legend>
    <cfoutput query="getInfo">

      <div class="row">
          <div class="small-3 columns">
            <label for="Rep_address" class="text-left middle">Address</label>
          </div>
          <div class="small-3 columns">
            <input type="text" name="Rep_address" size="20" id="Rep_address" placeholder="Address" value="#streetaddress#">
          </div>
          <div class="small-3 columns">
            <label for="Rep_city" class="text-left middle">City</label>
          </div>
          <div class="small-3 columns">
            <input type="text" name="Rep_city" size="20" id="Rep_city" placeholder="City" value="#city#">
          </div>
        </div>
      <div class="row">
          <div class="small-3 columns">
            <label for="Rep_State" class="text-left middle">State</label>
          </div>
          <div class="small-3 columns">
            <input type="text" name="Rep_State" size="20" id="Rep_State" placeholder="Sate" value="#state#">
          </div>
          <div class="small-3 columns">
            <label for="Rep_zip" class="text-left middle">Zip</label>
          </div>
          <div class="small-3 columns">
            <input type="text" name="Rep_zip" size="20" id="Rep_zip" placeholder="City" value="#zip#">
          </div>
        </div>
      <div class="row">
          <div class="small-3 columns">
            <label for="County" class="text-left middle">County</label>
          </div>
          <div class="small-3 columns">
            <input type="text" name="County" size="20" id="County" placeholder="County" value="#County#">
          </div>
          <div class="small-3 columns">
            
          </div>
          <div class="small-3 columns">
            
          </div>
        </div>
      
      </cfoutput>
      </fieldset>

    <fieldset class="fieldset">
    <legend><strong>More Info</strong></legend>
    <cfquery name="getMoreInfo" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_moreinfo
    WHERE ClientID = #ClientID#
    </cfquery>
    <cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="trucksNumber" class="text-left middle">Total number of Trucks</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="TruckNumberSize" size="20" id="TruckNumberSize" placeholder="Total number of Trucks" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TruckNumberSize#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="BIPDLevel" class="text-left middle">BIPD Level</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="BIPDLevel" size="20" id="BIPDLevel" placeholder="BIPD Level" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.BIPDLevel#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="trailerNumber" class="text-left middle">Total Number of Trailers</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="trailerNumber" size="20" id="trailerNumber" placeholder="Total number of Trailers" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TrailerNumber#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="cargoLevel" class="text-left middle">Cargo Level</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="cargoLevel" size="20" id="cargoLevel" placeholder="Cargo Level" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.CargoLevel#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="tractorNumber" class="text-left middle">Total Number of Tractors</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="tractorNumber" size="20" id="tractorNumber" placeholder="Total number of Tractors" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TractorNumber#</cfif>">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>

    <div class="row">
        <div class="small-3 columns">
          <label for="TotalDrivers" class="text-left middle">Total Number of Drivers</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="TotalDrivers" size="20" id="TotalDrivers" placeholder="Total number of Drivers" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TotalDrivers#</cfif>">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>

    <div class="row">
        <div class="small-3 columns">
          <label for="thirdPartyIns" class="text-left middle">Third Party Moving Ins.</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="ThirdPartyMoveIns" size="20" id="ThirdPartyMoveIns" placeholder="Third Party Moving Ins." value="<cfif getMoreInfo.RecordCount>#getMoreInfo.ThirdPartyMoveIns#</cfif>">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="StorageFacilities" class="text-left middle">Storage Facilities</label>
        </div>
        <div class="small-3 columns">
          No <input type="radio" name="StorageFacilities" id="StorageFacilities" value="0"<cfif getMoreInfo.RecordCount and getMoreInfo.StorageFacilities eq 0 or getMoreInfo.StorageFacilities eq ""> checked="checked"</cfif>> Yes <input type="radio" name="StorageFacilities" id="StorageFacilities" value="1"<cfif getMoreInfo.RecordCount and getMoreInfo.StorageFacilities eq 1> checked="checked"</cfif>>
        </div>
        <div class="small-3 columns">
          <label for="storageComments" class="text-left middle">Comment</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="storageComments" size="20" id="storageComments" placeholder="Storage Comments" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.StorageComments#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="publishedTariffRates" class="text-left middle">Published Tariff Rates</label>
        </div>
        <div class="small-3 columns">
          No <input type="radio" name="publishedTariffRates" id="publishedTariffRates" value="0"<cfif getMoreInfo.RecordCount and getMoreInfo.publishedTariffRates eq 0 or getMoreInfo.publishedTariffRates eq ""> checked="checked"</cfif>> Yes <input type="radio" name="publishedTariffRates" id="publishedTariffRates" value="1"<cfif getMoreInfo.RecordCount and getMoreInfo.PublishedTariffRates eq 1> checked="checked"</cfif>>
        </div>
        <div class="small-3 columns">
          <label for="tariffComments" class="text-left middle">Comment</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="PublishedTariffRateComments" size="20" id="PublishedTariffRateComments" placeholder="Published Tariff Rate Comments" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.PublishedTariffRateComments#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AuthorityFirstGranted" class="text-left middle">Authority First Granted (Year)</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="AuthorityFirstGranted" size="20" id="AuthorityFirstGranted" placeholder="Year" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.AuthorityFirstGranted#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="YearsInBusiness" class="text-left middle">How many years in business</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="YearsInBusiness" size="20" id="YearsInBusiness" placeholder="Years" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.YearsInBusiness#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AuthorityType" class="text-left middle">Authority Type</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="AuthorityType" size="20" id="AuthorityType" placeholder="Authority Type" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.AuthorityType#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="CargoType" class="text-left middle">Cargo Type</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="CargoType" size="20" id="CargoType" placeholder="Cargo Type" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.CargoType#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Milage" class="text-left middle">Milage</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Milage" size="20" id="Milage" placeholder="Milage" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.Milage#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="MilageYear" class="text-left middle">Year</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="MilageYear" size="20" id="MilageYear" placeholder="Year" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.MilageYear#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AnyComplaints" class="text-left middle">Any Complaints</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="AnyComplaints" size="60" id="AnyComplaints" placeholder="Any Complaints" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.AnyComplaints#</cfif>">
        </div>
      </div>
    </cfoutput>
    </fieldset>
    
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Record" name="UpdateRecordButton" class="button">
        </div>
      </div>
      </form>
  
    <!---     Move job form --->
    <!--- Only load form data if editing (formID in URL) --->
    <cfif IsDefined("url.formID") AND url.formID NEQ "">
      <cfquery name="getMoveJobForm" datasource="aaalh3x_onestep">
      SELECT *
      FROM carrier_move_job_agreements
      WHERE carrier_id = #clientid# AND id = #url.formID#
      </cfquery>
    <cfelse>
      <!--- Empty query for blank form --->
      <cfset getMoveJobForm = QueryNew("id,customer_name,customer_phone,customer_email,move_from,move_to,packing_loading_date,delivery_date,preferred_delivery_date,move_type,storage_needed,days_in_storage,miles,approx_travel_time_hours,total_hours_billed,men_required,suggested_truck_size,residence_type,elevator,stairs_inside,stairs_outside,long_carry,move_size,weight_cubic_feet,packing,total_items,dishpacks,small_boxes,book_boxes,medium_boxes,large_boxes,extra_large_boxes,boxes_6,boxes_6_5,mirror_picture_boxes,wardrobe_boxes,flat_tv_boxes,flat_screen_tv_count,crib_mattress,single_bed_boxes,double_bed_boxes,king_queen_bed_boxes,other_material_needed,accessorial,extra_info,virtual_survey,other_estimate,binding_estimate,non_binding_estimate,not_to_exceed,flat_rate,hourly_estimate,amount_paid_to_carrier,addendum")>
    </cfif>
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#<cfif IsDefined('url.formID') AND url.formID NEQ ''>&formID=#url.formID#</cfif>" method="post" name="moveJobAgreementForm"></cfoutput>
    <fieldset class="fieldset">
    <legend><strong>Move Job Agreement Form</strong></legend>
    <cfoutput>
    <input type="hidden" name="MoveJobFormID" id="MoveJobFormID" value="<cfif IsDefined('url.formID') AND url.formID NEQ ''>#url.formID#</cfif>">
    <div class="row">
        <div class="small-10 columns">
          <cfif IsDefined('url.formID') AND url.formID NEQ '' AND getMoveJobForm.RecordCount>
            <p><strong>Editing Form ID: #getMoveJobForm.id# - Customer: #getMoveJobForm.customer_name#</strong></p>
          <cfelse>
            <p><strong>Create New Move Job Agreement Form</strong></p>
          </cfif>
        </div>
        <div class="small-2 columns">
          <a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" class="button small">New Form</a>
        </div>
    </div>
    <div class="row">
        <div class="small-2 columns">
          <label for="CustomerName" class="text-left middle">Customer Name:</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="CustomerName" id="CustomerName" placeholder="Customer Name" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.customer_name#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="CustomerPhone" class="text-left middle">Customer phone number</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="CustomerPhone" id="CustomerPhone" placeholder="Customer Phone Number" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.customer_phone#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="CustomerEmail" class="text-left middle">Customer email</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="CustomerEmail" id="CustomerEmail" placeholder="Customer email" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.customer_email#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="MoveFrom" class="text-left middle">Move from</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="MoveFrom" id="MoveFrom" placeholder="Move from" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.move_from#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="MoveTo" class="text-left middle">Move to</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="MoveTo" id="MoveTo" placeholder="Move to" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.move_to#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="PackingLoadingDate" class="text-left middle">Packing/loading date</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingLoadingDate" id="datepickerCarrierPacking" class="remindmedropdowna" placeholder="MM/DD/YYYY" value="<cfif getMoveJobForm.RecordCount AND IsDate(getMoveJobForm.packing_loading_date)>#DateFormat(getMoveJobForm.packing_loading_date, 'mm/dd/yyyy')#</cfif>" size="10">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="DeliveryDate" class="text-left middle">Delivery date</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="DeliveryDate" id="datepickerCarrierDelivery" class="remindmedropdowna" placeholder="MM/DD/YYYY" value="<cfif getMoveJobForm.RecordCount AND IsDate(getMoveJobForm.delivery_date)>#DateFormat(getMoveJobForm.delivery_date, 'mm/dd/yyyy')#</cfif>" size="10">
        </div>
        <div class="small-2 columns">
          <label for="PreferredDeliveryDate" class="text-left middle">Customer preferred delivery date</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="PreferredDeliveryDate" id="datepickerCarrierPreferred" class="remindmedropdowna" placeholder="MM/DD/YYYY" value="<cfif getMoveJobForm.RecordCount AND IsDate(getMoveJobForm.preferred_delivery_date)>#DateFormat(getMoveJobForm.preferred_delivery_date, 'mm/dd/yyyy')#</cfif>" size="10">
        </div>
        <div class="small-2 columns">
          <label for="MoveType" class="text-left middle">Move type</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="MoveType" id="MoveType" placeholder="Move type" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.move_type#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="StorageNeeded" class="text-left middle">Storage needed</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="StorageNeeded" id="StorageNeeded" placeholder="Storage needed" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.storage_needed#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="DaysInStorage" class="text-left middle">Days in storage</label>
        </div>
        <div class="small-2 columns">
          <input type="number" name="DaysInStorage" id="DaysInStorage" placeholder="Days in storage" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.days_in_storage#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="Miles" class="text-left middle">Miles</label>
        </div>
        <div class="small-2 columns">
          <input type="number" name="Miles" id="Miles" placeholder="Miles" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.miles#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="ApproxTravelTime" class="text-left middle">Approx travel time</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="ApproxTravelTime" id="ApproxTravelTime" placeholder="Hours" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.approx_travel_time_hours#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="TotalHoursBilled" class="text-left middle">Total hours billed</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="TotalHoursBilled" id="TotalHoursBilled" placeholder="Total hours billed" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.total_hours_billed#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="MenRequired" class="text-left middle">Men Required</label>
        </div>
        <div class="small-2 columns">
          <input type="number" name="MenRequired" id="MenRequired" placeholder="Men Required" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.men_required#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="SuggestedTruckSize" class="text-left middle">Suggested Truck size & number to use</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="SuggestedTruckSize" id="SuggestedTruckSize" placeholder="Truck size" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.suggested_truck_size#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="ResidenceType" class="text-left middle">Residence type</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="ResidenceType" id="ResidenceType" placeholder="Residence type" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.residence_type#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="Elevator" class="text-left middle">Elevator</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="Elevator" id="Elevator" placeholder="Elevator" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.elevator#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="StairsInside" class="text-left middle">Stairs inside</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="StairsInside" id="StairsInside" placeholder="Stairs inside" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.stairs_inside#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="StairsOutside" class="text-left middle">Stairs outside</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="StairsOutside" id="StairsOutside" placeholder="Stairs outside" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.stairs_outside#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="LongCarry" class="text-left middle">Long carry</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="LongCarry" id="LongCarry" placeholder="Long carry" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.long_carry#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="MoveSize" class="text-left middle">Move Size</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="MoveSize" id="MoveSize" placeholder="Move Size" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.move_size#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="WeightCubicFeet" class="text-left middle">Weight & Cubic Feet</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="WeightCubicFeet" id="WeightCubicFeet" placeholder="Weight & Cubic Feet" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.weight_cubic_feet#</cfif>">
        </div>
        <div class="small-2 columns">
          <label for="Packing" class="text-left middle">Packing</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="Packing" id="Packing" placeholder="Packing" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.packing#</cfif>">
        </div>
      </div>
    
    <div class="row">
        <div class="small-2 columns">
          <label for="TotalItems" class="text-left middle">Total Items Number</label>
        </div>
        <div class="small-2 columns">
          <input type="number" name="TotalItems" id="TotalItems" placeholder="Total Items" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.total_items#</cfif>">
        </div>
        <div class="small-2 columns">
        </div>
        <div class="small-2 columns">
        </div>
        <div class="small-2 columns">
        </div>
        <div class="small-2 columns">
        </div>
      </div>
    
    <hr>
    
    <div class="row">
        <div class="small-5 columns">
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>5.1 or Dishpacks:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="Dishpacks" id="Dishpacks" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.dishpacks#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>1.5 or Small Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="SmallBoxes" id="SmallBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.small_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Book Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="BookBoxes" id="BookBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.book_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>3.0 or Medium Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="MediumBoxes" id="MediumBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.medium_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>4.5 or Large Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="LargeBoxes" id="LargeBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.large_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>5.0 Extra Large Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="ExtraLargeBoxes" id="ExtraLargeBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.extra_large_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>6.0 Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="Boxes6" id="Boxes6" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.boxes_6#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>6.5 Boxes</strong></label></div>
            <div class="small-4 columns"><input type="number" name="Boxes65" id="Boxes65" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.boxes_6_5#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Mirror or picture Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="MirrorPictureBoxes" id="MirrorPictureBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.mirror_picture_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Wardrobe (18-24 inches) Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="WardrobeBoxes" id="WardrobeBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.wardrobe_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Flat TV boxes or wrap:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="FlatTVBoxes" id="FlatTVBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.flat_tv_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Flat Screen TV ##:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="FlatScreenTVCount" id="FlatScreenTVCount" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.flat_screen_tv_count#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Crib mattress:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="CribMattress" id="CribMattress" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.crib_mattress#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Single Bed Bag or Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="SingleBedBoxes" id="SingleBedBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.single_bed_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>Double Bed Bag or Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="DoubleBedBoxes" id="DoubleBedBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.double_bed_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-8 columns"><label class="text-left middle"><strong>King/Queen Bed Bag or Boxes:</strong></label></div>
            <div class="small-4 columns"><input type="number" name="KingQueenBedBoxes" id="KingQueenBedBoxes" style="width: 60px;" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.king_queen_bed_boxes#</cfif>"></div>
          </div>
          <div class="row">
            <div class="small-7 columns"><label class="text-left middle"><strong>Other material needed:</strong></label></div>
            <div class="small-5 columns"><input type="text" name="OtherMaterialNeeded" id="OtherMaterialNeeded" style="width: 100%;" placeholder="Other material" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.other_material_needed#</cfif>"></div>
          </div>
        </div>
        <div class="small-7 columns">
          <div class="row">
            <div class="small-2 columns">
              <label for="Accessorial" class="text-left"><strong>Accessorial</strong></label>
            </div>
            <div class="small-10 columns">
              <textarea name="Accessorial" id="Accessorial" rows="8" placeholder="Accessorial" style="resize: vertical;"><cfif getMoveJobForm.RecordCount>#getMoveJobForm.accessorial#</cfif></textarea>
            </div>
          </div>
          <div class="row">
            <div class="small-2 columns">
              <label for="ExtraInfo" class="text-left"><strong>Extra info</strong></label>
            </div>
            <div class="small-10 columns">
              <textarea name="ExtraInfo" id="ExtraInfo" rows="8" placeholder="Extra Info" style="resize: vertical;"><cfif getMoveJobForm.RecordCount>#getMoveJobForm.extra_info#</cfif></textarea>
            </div>
          </div>
          <div class="row">
            <div class="small-3 columns">
              <label for="VirtualSurvey" class="text-left middle"><strong>VIRTUAL SURVEY:</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="VirtualSurvey" id="VirtualSurvey" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.virtual_survey#</cfif>">
            </div>
            <div class="small-3 columns">
              <label for="OtherEstimate" class="text-left middle"><strong>OTHER:</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="OtherEstimate" id="OtherEstimate" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.other_estimate#</cfif>">
            </div>
          </div>
          <div class="row">
            <div class="small-3 columns">
              <label for="BindingEstimate" class="text-left middle"><strong>BINDING ESTIMATE:</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="BindingEstimate" id="BindingEstimate" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.binding_estimate#</cfif>">
            </div>
            <div class="small-3 columns">
              <label for="NonBindingEstimate" class="text-left middle"><strong>NON-BINDING ESTIMATE</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="NonBindingEstimate" id="NonBindingEstimate" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.non_binding_estimate#</cfif>">
            </div>
          </div>
          <div class="row">
            <div class="small-3 columns">
              <label for="NotToExceed" class="text-left middle"><strong>NOT TO EXCEED</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="NotToExceed" id="NotToExceed" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.not_to_exceed#</cfif>">
            </div>
            <div class="small-3 columns">
              <label for="FlatRate" class="text-left middle"><strong>FLAT RATE:</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="FlatRate" id="FlatRate" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.flat_rate#</cfif>">
            </div>
          </div>
          <div class="row">
            <div class="small-3 columns">
              <label for="HourlyEstimate" class="text-left middle"><strong>HOURLY ESTIMATE:</strong></label>
            </div>
            <div class="small-3 columns">
              <input type="text" name="HourlyEstimate" id="HourlyEstimate" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.hourly_estimate#</cfif>">
            </div>
            <div class="small-6 columns">
            </div>
          </div>
          <div class="row">
            <div class="small-4 columns" style="margin-right: 0px; padding-right: 0px;">
              <label for="AmountPaidToCarrier" class="text-left middle"><strong>Amount Paid to Carrier:</strong></label>
            </div>
            <div class="small-4 columns" style=" margin-right: 225px; padding-left: 0px;">
              <input class="text-left" type="text" name="AmountPaidToCarrier" id="AmountPaidToCarrier" value="<cfif getMoveJobForm.RecordCount>#getMoveJobForm.amount_paid_to_carrier#</cfif>">
            </div>
          </div>
          <div class="row">
            <div class="small-2 columns">
              <label for="Addendum" class="text-left"><strong>Addendum:</strong></label>
            </div>
            <div class="small-10 columns">
              <textarea name="Addendum" id="Addendum" rows="5" placeholder="Addendum" style="resize: vertical;"><cfif getMoveJobForm.RecordCount>#getMoveJobForm.addendum#</cfif></textarea>
            </div>
          </div>
        </div>
      </div>
    
    </cfoutput>
    </fieldset>
    <div class="row">
      <div class="small-12 columns">
        <input type="submit" value="Save Changes" name="SaveMoveJobForm" class="button">
      </div>
    </div>
    </form>

    <!--- Display list of saved Move Job Agreement forms --->
    <cfquery name="getAllMoveJobForms" datasource="aaalh3x_onestep">
    SELECT id, customer_name, customer_phone, move_from, move_to, packing_loading_date, delivery_date,
           docusign_status, docusign_envelope_id, docusign_sent_date, docusign_completed_date
    FROM carrier_move_job_agreements
    WHERE carrier_id = #clientid#
    ORDER BY id DESC
    </cfquery>
    
    <cfif getAllMoveJobForms.RecordCount GT 0>
    <fieldset class="fieldset">
    <legend><strong>Saved Move Job Agreement Forms</strong></legend>
    <table width="100%" border="1" cellspacing="0" cellpadding="5">
      <thead>
        <tr style="background-color: ##f0f0f0;">
          <th>Customer Name</th>
          <th>Phone</th>
          <th>Move From</th>
          <th>Move To</th>
          <th>Packing Date</th>
          <th>Delivery Date</th>
          <th>DocuSign Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <cfoutput query="getAllMoveJobForms">
        <tr>
          <td>#getAllMoveJobForms.customer_name#</td>
          <td>#getAllMoveJobForms.customer_phone#</td>
          <td>#getAllMoveJobForms.move_from#</td>
          <td>#getAllMoveJobForms.move_to#</td>
          <td><cfif IsDate(getAllMoveJobForms.packing_loading_date)>#DateFormat(getAllMoveJobForms.packing_loading_date, "mm/dd/yyyy")#</cfif></td>
          <td><cfif IsDate(getAllMoveJobForms.delivery_date)>#DateFormat(getAllMoveJobForms.delivery_date, "mm/dd/yyyy")#</cfif></td>
          <td>
            <cfif Len(getAllMoveJobForms.docusign_status)>
              <cfif getAllMoveJobForms.docusign_status EQ "completed">
                <span style="color: green; font-weight: bold;">
                  <i class="fa fa-check-circle"></i> Signed
                  <cfif IsDate(getAllMoveJobForms.docusign_completed_date)>
                    <br><small>#DateFormat(getAllMoveJobForms.docusign_completed_date, "mm/dd/yyyy")#</small>
                  </cfif>
                </span>
              <cfelseif getAllMoveJobForms.docusign_status EQ "sent">
                <span style="color: orange; font-weight: bold;">
                  <i class="fa fa-clock-o"></i> Awaiting Signature
                  <cfif IsDate(getAllMoveJobForms.docusign_sent_date)>
                    <br><small>Sent: #DateFormat(getAllMoveJobForms.docusign_sent_date, "mm/dd/yyyy")#</small>
                  </cfif>
                </span>
              <cfelseif getAllMoveJobForms.docusign_status EQ "declined">
                <span style="color: red; font-weight: bold;">
                  <i class="fa fa-times-circle"></i> Declined
                </span>
              <cfelse>
                <span style="color: gray;">
                  #getAllMoveJobForms.docusign_status#
                </span>
              </cfif>
            <cfelse>
              <span style="color: gray;">Not Sent</span>
            </cfif>
          </td>
          <td style="white-space: nowrap;">
            <a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&formID=#getAllMoveJobForms.id#" class="button small" title="Edit">
              <i class="fa fa-pencil"></i>
            </a>
            
            <!--- View PDF Button --->
            <a href="letters/move_job_agreement.cfm?clientid=#ClientID#&formid=#getAllMoveJobForms.id#" target="_blank" class="button small secondary" title="View PDF" style="margin-left:5px;">
              <i class="fa fa-file-pdf-o"></i>
            </a>
            
            <!--- DocuSign Button --->
            <cfif NOT Len(getAllMoveJobForms.docusign_status) OR getAllMoveJobForms.docusign_status NEQ "completed">
              <form method="post" action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&formID=#getAllMoveJobForms.id#" style="display:inline;">
                <button type="submit" name="SendToDocuSign" class="button small success" title="Send to DocuSign for Signature" style="margin-left:5px;">
                  <i class="fa fa-envelope"></i> DocuSign
                </button>
              </form>
            </cfif>
            
            <!--- Check Status Button (if sent but not completed) --->
            <cfif Len(getAllMoveJobForms.docusign_envelope_id) AND getAllMoveJobForms.docusign_status NEQ "completed">
              <a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&checkDocuSignStatus=true&envelopeId=#getAllMoveJobForms.docusign_envelope_id#" class="button small warning" title="Check DocuSign Status" style="margin-left:5px;">
                <i class="fa fa-refresh"></i>
              </a>
            </cfif>
            
            <a href="##" onclick="confirmDelete(#getAllMoveJobForms.id#, '#JSStringFormat(getAllMoveJobForms.customer_name)#'); return false;" class="button small alert" title="Delete" style="margin-left:5px;">
              <i class="fa fa-trash"></i>
            </a>
          </td>
        </tr>
        </cfoutput>
      </tbody>
    </table>
    </fieldset>
    </cfif>

    <fieldset class="fieldset">
    <legend><strong>Packing Rates</strong></legend>
    <cfquery name="getBoxes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_packingBoxes
    </cfquery>
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addBoxRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-4 columns">
          <label for="Boxes" class="text-left middle"><strong>Boxes</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Material</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Labor</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Total</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Unpacking</strong></label>
        </div>
      </div>
    <cfoutput query="getBoxes">
    <cfquery name="getBoxRates" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_packingRates
    WHERE ClientID = #ClientID# and
    	BoxID = #getBoxes.ID#
    </cfquery>
    <div class="row">
        <div class="small-4 columns">
          <label for="PackingMaterial#getBoxes.ID#" class="text-left middle">#getBoxes.BoxType#</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingMaterial#getBoxes.ID#" size="20" id="PackingMaterial#getBoxes.ID#" placeholder="Packing Material" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingMaterial#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingLabor#getBoxes.ID#" size="20" id="PackingLabor#getBoxes.ID#" placeholder="Packing Labor" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingLabor#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingTotal#getBoxes.ID#" size="20" id="PackingTotal#getBoxes.ID#" placeholder="Packing Total" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingTotal#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="Unpacking#getBoxes.ID#" size="20" id="Unpacking#getBoxes.ID#" placeholder="Unpacking" value="<cfif getBoxRates.RecordCount>#getBoxRates.Unpacking#</cfif>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>Comments</strong></label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="packingComments" size="20" id="packingComments" placeholder="Packing Comments" value="<cfif getcomments.RecordCount><cfoutput>#getcomments.packingComments#</cfoutput></cfif>">
        </div>
      </div>
    
    </fieldset>
    
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Packing Boxes" name="UpdateBoxRateButton" class="button">
        </div>
      </div>
    </form>
    
    <fieldset class="fieldset">
    <legend><strong>Local & Storage Rates</strong></legend>
    <cfquery name="getRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_localratetypes
    </cfquery>
    <cfquery name="getStorageRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_storageratetypes
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
        <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addLocalRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Local Rates</strong></label>
        </div>
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Rates $/hr</strong></label>
        </div>
      </div>
    <cfoutput query="getRateTypes">
    <cfquery name="getBoxRates" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_localRates
    WHERE ClientID = #ClientID# and
    	RateTypeID = #getRateTypes.ID#
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
          <label for="rateValue#getRateTypes.ID#" class="text-left middle">#getRateTypes.RateType#</label>
        </div>
        <div class="small-6 columns">
          <input type="text" name="rateValue#getRateTypes.ID#" size="20" id="rateValue#getRateTypes.ID#" placeholder="Rate" value="<cfif getBoxRates.RecordCount>#getBoxRates.Rate#</cfif>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>Comments</strong></label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="MiscComments" size="20" id="MiscComments" placeholder="Misc Comments" value="<cfif getcomments.RecordCount><cfoutput>#getcomments.MiscChargeComments#</cfoutput></cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Local Rates" name="UpdateLocalRatesButton" class="button">
        </div>
      </div>
    </form>
        </div>
        <div class="small-6 columns">
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addStorageRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Storage Rates</strong></label>
        </div>
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Cost $</strong></label>
        </div>
      </div>
    <cfoutput query="getStorageRateTypes">
    <cfquery name="getStorageRate" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_storagerates
    WHERE ClientID = #ClientID# and
    	StorageRateID = #getStorageRateTypes.ID#
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
          <label for="StorageRateValue#getStorageRateTypes.ID#" class="text-left middle">#getStorageRateTypes.RateType#</label>
        </div>
        <div class="small-6 columns">
          <input type="text" name="StorageRateValue#getStorageRateTypes.ID#" size="20" id="StorageRateValue#getStorageRateTypes.ID#" placeholder="Rate" value="<CFIF getStorageRate.RecordCount>#getStorageRate.Rate#</CFIF>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>General Comments</strong></label>
        </div>
        <div class="small-9 columns">
        <textarea name="GeneralComments" id="GeneralComments" cols="50" rows="10" placeholder="General Comments"><cfif getcomments.RecordCount><cfoutput>#getcomments.GeneralComments#</cfoutput></cfif></textarea>
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Storage Rates" name="UpdateStorageRatesButton" class="button">
        </div>
      </div>
    </form>
        </div>
      </div>
    
    </fieldset>
    
    <div class="row">
        <div class="small-4 columns" style="text-align:center;">
        <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="compDataForm"></cfoutput>
         <input type="submit" value="Mark Record Complete" name="markThisRecordComplete" class="button"> 
        </form>
        </div>
        <div class="small-4 columns" style="text-align:center;">
        <cfoutput><form action="carrier_client_info_Print.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="printDataForm" target="_blank"></cfoutput>
        <input type="submit" value="Print Carrier Record" name="printCarrierRecord" class="button">
        </form>
        </div>
        <div class="small-4 columns" style="text-align:center;">
        <cfoutput><form action="carrier_search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=uall" method="post" name="printDataForm"></cfoutput>
        <input type="submit" value="Back To Carrier Main Page" name="mainCarrierPage" class="button">
        </form>
        </div>
      </div>
 	
    </div>
</div>

<script src="foundation-6.2.4/js/vendor/foundation.js"></script>
<script>

  $(document).foundation();
  
  function confirmDelete(formID, customerName) {
    Swal.fire({
      title: 'Are you sure?',
      text: 'Do you want to delete the Move Job Agreement form for "' + customerName + '"? You won\'t be able to revert this!',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!',
      cancelButtonText: 'Cancel'
    }).then((result) => {
      if (result.isConfirmed) {
          window.location.href = 'carrier_client_info.cfm?un=<cfoutput>#un#</cfoutput>&pw=<cfoutput>#pw#</cfoutput>&ClientID=<cfoutput>#ClientID#</cfoutput>&deleteMoveJobForm=true&formID=' + formID;
      }
    });
  }

  <cfif IsDefined("session.deleteSuccess") AND session.deleteSuccess>
    Swal.fire({
      title: 'Deleted!',
      text: 'Move Job Agreement has been successfully deleted.',
      icon: 'success',
      confirmButtonColor: '#3085d6'
    });
    <cfset StructDelete(session, "deleteSuccess")>
  </cfif>
</script>
</body>
</html>