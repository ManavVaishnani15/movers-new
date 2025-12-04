<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Administration - Edit Record</title>
<link rel="stylesheet" href="foundation-6.2.4/css/foundation.css">
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css">
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="https://top12movingbiz.com/admin/scripts/script.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/typeahead.jquery.min.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/jquery-ui.css"/>

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
	<cffile action="upload" destination="C:\home\top12movingbiz.com\wwwroot\admin\CarrierDocuments\" filefield="documentFile" nameconflict="makeunique"> 
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
	<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\CarrierDocuments\#getDocumentfile.Document#">
	<cfquery name="getDocumentfile" datasource="aaalh3x_onestep">
	DELETE
	FROM carrier_supportdocs
	WHERE ID = #ID# and
		ClientID = #ClientID#
	</cfquery>
	</cfif>
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
    CompanyName = '#CompanyName#', AccountStatus = '#AccountStatus#', MC = '#MC#', USDOT = '#USDOT#'
WHERE ID = #ClientID#
</cfquery>
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
	INSERT INTO carrier_moreinfo(ClientID,TruckNumberSize,TractorNumber,TrailerNumber,BIPDLevel,CargoLevel,ThirdPartyMoveIns,StorageFacilities,StorageComments,PublishedTariffRates,PublishedTariffRateComments)
	VALUES(#ClientID#,'#TruckNumberSize#','#TractorNumber#','#TrailerNumber#','#BIPDLevel#','#CargoLevel#','#ThirdPartyMoveIns#','#StorageFacilities#','#StorageComments#','#PublishedTariffRates#','#PublishedTariffRateComments#')
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
    <div class="row">
    	<cfif getDocuments.recordCount eq 0>
    	<div class="small-12 columns">
    		<h5>No Carrier Documents Found</h5>
    	</div>
    	<cfelse>
    	<cfoutput query="getDocuments">
    		<div class="small-4 columns">
    			<a href="CarrierDocuments/#Document#" target="_blank"><strong>#Document#</strong></a> <a href="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&killDocument=true&ID=#ID#" alt="DELETE DOCUMENT" title="DELETE DOCUMENT">[x]</a>
    		</div>
    	</cfoutput>
    	</cfif>
    	<div class="small-12 columns">
    		<br>
    		<a data-open="uploadDocument" class="button tiny">UPLOAD A DOCUMENT</a>
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
          <label for="Fax" class="text-left middle">Fax</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Fax" size="20" id="Fax" placeholder="Fax" value="#Fax#">
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
    <legend><strong>More Info</strong></legend>
    <cfquery name="getMoreInfo" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_moreinfo
    WHERE ClientID = #ClientID#
    </cfquery>
    <cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="trucksNumber" class="text-left middle">Trucks - Number and Size</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="TruckNumberSize" size="20" id="TruckNumberSize" placeholder="Trucks - Number and Size" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TruckNumberSize#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="tractorNumber" class="text-left middle">Tractor Number</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="tractorNumber" size="20" id="tractorNumber" placeholder="Tractor Number" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TractorNumber#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="trailerNumber" class="text-left middle">Trailer Number</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="trailerNumber" size="20" id="trailerNumber" placeholder="Trailer Number" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TrailerNumber#</cfif>">
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
          <label for="cargoLevel" class="text-left middle">Cargo Level</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="cargoLevel" size="20" id="cargoLevel" placeholder="Cargo Level" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.CargoLevel#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="thirdPartyIns" class="text-left middle">Third Party Moving Ins.</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="ThirdPartyMoveIns" size="20" id="ThirdPartyMoveIns" placeholder="Third Party Moving Ins." value="<cfif getMoreInfo.RecordCount>#getMoreInfo.ThirdPartyMoveIns#</cfif>">
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
    </cfoutput>
    </fieldset>
    
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Record" name="UpdateRecordButton" class="button">
        </div>
      </div>
      </form>
    
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
    </script>
</body>
</html>