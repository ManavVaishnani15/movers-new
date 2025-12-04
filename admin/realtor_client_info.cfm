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

<cfif isDefined("url.DeleteRealtorImage")>
	<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\#url.DeleteRealtorImage#"> 
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE realtor_records
	SET ProfilePhoto = ''
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("url.DeleteRealtorCardImage")>
	<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\#url.DeleteRealtorCardImage#"> 
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE realtor_records
	SET BusinessCardPhoto = ''
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("form.submitheadshot")>
	<cfif isDefined("form.oldheadshotImage")>
		<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\#form.oldheadshotImage#">
	</cfif>
	<cffile action="upload" destination="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\" filefield="headshotImage" nameconflict="makeunique"> 
	<cfset theFilename = cffile.serverfile>
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE realtor_records
	SET ProfilePhoto = '#theFilename#'
	WHERE ID = #ClientID#
	</cfquery>
</cfif>
<cfif isDefined("form.submitcardimage")>
	<cfif IsDefined("form.oldbusinesscardImage")>
		<cffile action="delete" file="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\#form.oldbusinesscardImage#">
	</cfif>
	<cffile action="upload" destination="C:\home\top12movingbiz.com\wwwroot\admin\images\RealtorImages\" filefield="cardImage" nameconflict="makeunique"> 
	<cfset theFilename = cffile.serverfile>
	<cfquery name="logimagefile" datasource="aaalh3x_onestep">
	UPDATE realtor_records
	SET BusinessCardPhoto = '#theFilename#'
	WHERE ID = #ClientID#
	</cfquery>
</cfif>


<cfset fulldatenow = now()>
<cfset datenow = #dateformat(fulldatenow, "YYYY-MM-DD")#>

<!--- systems for marking postal mail for today --->
<cfif parameterexists(mark_initial) is 'yes'>
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from realtor_LETTER_SENDS
        where send_type=999 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('999','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('999','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_LeasingAgent) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from realtor_LETTER_SENDS
        where send_type=101 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('101','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('101','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_MorgageOfficer) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from realtor_LETTER_SENDS
        where send_type=102 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('102','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into realtor_LETTER_SENDS
             (send_type,sent,cust_hook,sent_date,active,user_hook)
             values ('102','1','#clientid#','#datenow#',1,#verify.ID#)
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_follow) is 'yes'>
	
	<cfquery name="getinfo" datasource="aaalh3x_onestep">
		select * from realtor_records
		where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	</cfquery>
	
    <cfset appointment_date = Now()>
	<cfif appointment_date neq ''>
		
		<cfquery name="checkFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
			select *
			from realtor_LETTER_SENDS
			where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
			and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
            and user_hook = #verify.ID#
            and sent = 0
			order by followup_date
		</cfquery>
        
		
		<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
			<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
				insert into realtor_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date,date_time_to_order_on_sheet)
				values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">)
			</cfquery>
			
			<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,appointment_date)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,appointment_date)>
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfif currentFollowUpDateAfterAppointmentDate eq 14>
                <cfquery name="q" datasource="aaalh3x_onestep">
					insert into realtor_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date,date_time_to_order_on_sheet)
					values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">,#now()#)
				</cfquery>
                <cfelse>
                <cfquery name="q" datasource="aaalh3x_onestep">
					insert into realtor_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
                </cfif>
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
				update realtor_LETTER_SENDS
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

<cfif IsDefined("markAsComplete")>
<cfquery name="comp" datasource="aaalh3x_onestep">
update realtor_records
set active='3'
where id=#clientid#
</cfquery>
    <!---- remove from printQueue ---->
    <cfquery name="qKillFromQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM realtor_printQueue
        WHERE clientID = #clientid#
        </cfquery>
    <!--- remove from label queue ----->
    <cfquery name="qKillFromLabelQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM realtor_Letter_sends
        WHERE cust_hook = #clientid# and 
          sent = 0 and
          active = 1
     </cfquery>	
</cfif>


<cfif isDefined("UpdateRecordButton")>
<cfquery name="updateInfo" datasource="aaalh3x_onestep">
UPDATE realtor_records
SET repfirstname = '#Rep_first_name#', replastname = '#Rep_last_name#', cellphone = '#Rep_cellPhone#', agentemail = '#Rep_email#',
	streetaddress = '#Rep_address#', city = '#Rep_city#', state = '#Rep_State#', zip = '#rep_zip#', referralCode = '#Rep_ReferralCode#',
    CompanyName = '#agencyName#', OfficePhone = '#officePhone#', fax = '#fax#', agencyAddress = '#agency_address#', agencyAddress2 = '#agency_address2#', AgencyCity = '#agency_city#',
    AgencyState = '#agency_State#', AgencyZip = '#agency_zip#', AgencyEmail = '#agency_email#', referredbyfirstname = '#referredfirstname#',
    referredbylastname = '#referredlastname#', referredagentcode = '#referredagentcode#', comments = '#comments#'
WHERE ID = #ClientID#
</cfquery>
<cflocation url="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>

<cfset datenow = dateformat(now(), "YYYY-MM-DD")>
<cfquery name="getInfo" datasource="aaalh3x_onestep">
SELECT *
FROM realtor_records
WHERE ID = #ClientID#
</cfquery>

<cfquery name="get_initial" datasource="aaalh3x_onestep">
select * from realtor_LETTER_SENDS
where send_type=999 and (sent=1 or sent=2) and cust_hook=#clientid# and sent > 0
</cfquery>
<cfquery name="checkEmailedNew" datasource="aaalh3x_onestep">
select * from realtor_LETTER_SENDS
where (send_type=8 or send_type=9) and sent=2 and cust_hook=#clientid# and sent > 0
</cfquery>
<cfquery name="checkEmailedLeasing" datasource="aaalh3x_onestep">
select * from realtor_LETTER_SENDS
where (send_type=10 or send_type=11 or send_type=101) and cust_hook=#clientid# and sent > 0
</cfquery>
<cfquery name="checkEmailedMortgage" datasource="aaalh3x_onestep">
select * from realtor_LETTER_SENDS
where (send_type=12 or send_type=13 or send_type=102) and cust_hook=#clientid# and sent > 0
</cfquery>
<cfquery name="checkEmailedFollowup" datasource="aaalh3x_onestep">
select * from realtor_LETTER_SENDS
where (send_type=14 or send_type=15) and sent=2 and cust_hook=#clientid# and sent > 0
</cfquery>
<cfquery name="get_booked" datasource="aaalh3x_onestep">
	SELECT * FROM realtor_printqueue pq left join realtor_LETTER_SENDS ls on pq.id = ls.printqueueId
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
        <td><strong>Realtor Letter</strong><br>
        	<a href="realtorPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=new" style="color:blue;">Queue</a> | <a href="realtor_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_initial=y" style="color:blue;">Mark Mailed</a> | <a href="letters/realtorEmailNew.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" style="color:blue;" target="_blank">Email</a></td>
      </tr>
      <tr>
        <td><strong>Leasing Agent Letter</strong><br>
        <a href="realtorPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=leasingManagerLetter" style="color:blue;">Queue</a> | <a href="realtor_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_LeasingAgent=y" style="color:blue;">Mark Mailed</a> | <a href="letters/leasingEmailNew.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" style="color:blue;" target="_blank">Email</a>
        </td>
      </tr>
      <tr>
        <td><strong>Mortgage Officer Letter</strong><br>
        <a href="realtorPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=MortgageProLetter" style="color:blue;">Queue</a> | <a href="realtor_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_MorgageOfficer=y" style="color:blue;">Mark Mailed</a> | <a href="letters/mortgageEmailNew.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" style="color:blue;" target="_blank">Email</a>
        </td>
      </tr>
      <tr>
        <td><strong>Follow Up Letter</strong><br>
        <a href="realtorPrintQueueAdd.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&type=followUp" style="color:blue;">Queue</a> | <a href="realtor_client_info.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&mark_Follow=y" style="color:blue;">Mark Mailed</a> | <a href="letters/realtorEmailFollowup.cfm?clientID=#ClientID#&un=#un#&pw=#pw#&emailit=yes" style="color:blue;" target="_blank">Email</a>
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
  <cfif checkEmailedLeasing.RecordCount>
  <cfoutput query="checkEmailedLeasing">
  <tr>
    <td>Leasing Agent Letter sent</td>
    <td align="center">(<cfif sent eq 1>Mailed<cfelseif sent eq 2>Emailed</cfif> #dateformat(checkEmailedLeasing.sent_date, "MMM D, YYYY")# <cfif checkEmailedLeasing.send_type eq 11> - 2nd</cfif>)</td>
  </tr>
  </cfoutput>
  </cfif>
  <cfif checkEmailedMortgage.RecordCount>
  <cfoutput query="checkEmailedMortgage">
  <tr>
    <td>Mortgage Pro Letter sent</td>
    <td align="center">(<cfif sent eq 1>Mailed<cfelseif sent eq 2>Emailed</cfif> #dateformat(checkEmailedMortgage.sent_date, "MMM D, YYYY")# <cfif checkEmailedMortgage.send_type eq 13> - 2nd</cfif>)</td>
  </tr>
  </cfoutput>
  </cfif>
  <cfif checkEmailedFollowup.RecordCount>
  <cfoutput query="checkEmailedFollowup">
  <tr>
    <td>Follow Up Letter sent</td>
    <td align="center">(Emailed #dateformat(checkEmailedFollowup.sent_date, "MMM D, YYYY")# <cfif checkEmailedFollowup.send_type eq 15> - 2nd</cfif>)</td>
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
    	<h3>Realtor Marked COMPLETE</h3>
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
        		<td><a data-open="uploadImage"><cfif getInfo.profilePhoto neq ""><cfoutput><img src="images/RealtorImages/#getInfo.profilePhoto#" width="142"></cfoutput><cfelse><img src="images/placeholder.png"></cfif></a></td>
        		<td><a data-open="uploadCardImage"><cfif getInfo.BusinessCardPhoto neq ""><cfoutput><img src="images/RealtorImages/#getInfo.BusinessCardPhoto#" width="300"></cfoutput><cfelse><img src="images/placeholder2.png"></cfif></a></td>
        	</tr>	
        </table>
    	</div>
    </div>
    </div>
</div>

<div class="reveal" id="uploadImage" data-reveal data-close-on-click="false" data-close-on-esc="false">
  <h3 style="text-align:center;">Upload Realtor Headshot</h3>
	<cfoutput><form action="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall" method="post" enctype="multipart/form-data">
		<cfif getInfo.profilePhoto neq "">
			<input type="hidden" name="oldheadshotImage" value="#getInfo.profilePhoto#">
			<img src="images/RealtorImages/#getInfo.profilePhoto#" width="75"><br>
				<a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall&DeleteRealtorImage=#getInfo.profilePhoto#">[click here to delete this image]</a>
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
  <h3 style="text-align:center;">Upload Realtor Business Card</h3>
	<cfoutput><form action="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall" method="post" enctype="multipart/form-data">
		<cfif getInfo.BusinessCardPhoto neq "">
			<input type="hidden" name="oldbusinesscardImage" value="#getInfo.BusinessCardPhoto#">
			<img src="images/RealtorImages/#getInfo.BusinessCardPhoto#" width="150"><br>
				<a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&url1=search&type=uall&DeleteRealtorCardImage=#getInfo.BusinessCardPhoto#">[click here to delete this image]</a>
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

<cfoutput><form action="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addDataForm" data-abide novalidate></cfoutput>
<div class="row">
    <div class="large-12 columns">

	<fieldset class="fieldset">
    <legend><strong>Referral Agent's Personal Info</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_first_name" class="text-left middle">Referral Agent First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_first_name" size="20" id="Rep_first_name" placeholder="Referral Agent First Name" value="#repfirstname#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_last_name" class="text-left middle">Referral Agent Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_last_name" size="20" id="Rep_last_name" placeholder="Referral Agent Last Name" value="#replastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone" class="text-left middle">Referral Agent Cell Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone" size="20" id="Rep_cellPhone" placeholder="Referral Agent Cell Phone" value="#cellphone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email" class="text-left middle">Referral Agent Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email" size="20" id="Rep_email" placeholder="Referral Agent Email" value="#agentemail#">
        </div>
      </div>
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
          <label for="Rep_ReferralCode" class="text-left middle">Referral Code</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_ReferralCode" size="20" id="Rep_ReferralCode" placeholder="Sate" value="#referralCode#">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>

      </cfoutput>
	</fieldset>
	
    <fieldset class="fieldset">
    <legend><strong>Real Estate/Leasing/Loan Agency Info</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="agencyName" class="text-left middle">Agency Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="agencyName" size="20" id="agencyName" placeholder="Agency Name" value="#CompanyName#">
        </div>
      </div>
   <div class="row">
        <div class="small-3 columns">
          <label for="officePhone" class="text-left middle">Office Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="officePhone" size="20" id="officePhone" placeholder="Office Phone" value="#officePhone#">
        </div>
        <div class="small-3 columns">
          <label for="fax" class="text-left middle">Fax</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="fax" size="20" id="fax" placeholder="Fax" value="#fax#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="agency_address" class="text-left middle">Address</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="agency_address" size="20" id="agency_address" placeholder="Address" value="#AgencyAddress#">
        </div>
        <div class="small-3 columns">
          <label for="agency_address2" class="text-left middle">Address cont)</label>
        </div>
        <div class="small-3 columns">
           <input type="text" name="agency_address2" size="20" id="agency_address2" placeholder="Address (cont)" value="#AgencyAddress2#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="agency_State" class="text-left middle">State</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="agency_State" size="20" id="agency_State" placeholder="Sate" value="#AgencyState#">
        </div>
        <div class="small-3 columns">
          <label for="agency_city" class="text-left middle">City</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="agency_city" size="20" id="agency_city" placeholder="City" value="#AgencyCity#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="agency_email" class="text-left middle">Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="agency_email" size="20" id="agency_email" placeholder="Email" value="#AgencyEmail#">
        </div>
        <div class="small-3 columns">
          <label for="agency_zip" class="text-left middle">Zip</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="agency_zip" size="20" id="agency_zip" placeholder="Zip" value="#AgencyZip#">
        </div>
      </div>
    </cfoutput>
    
    </fieldset>
    
    <fieldset class="fieldset">
    <legend><strong>Referred By</strong></legend>
    <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="referredfirstname" class="text-left middle">First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="referredfirstname" size="20" id="referredfirstname" placeholder="First Name" value="#referredbyfirstname#">
        </div>
        <div class="small-3 columns">
          <label for="referredlastname" class="text-left middle">Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="referredlastname" size="20" id="referredlastname" placeholder="Last Name" value="#referredbylastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="referredagentcode" class="text-left middle">Referred Agent Code</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="referredagentcode" size="20" id="referredagentcode" placeholder="Referred Agent Code" value="#referredagentcode#">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>
      </cfoutput>
    </fieldset>

    <fieldset class="fieldset">
    <legend><strong>Comments</strong></legend>
    <div class="row">
    <cfoutput query="getInfo">
        <div class="small-12 columns">
          <textarea name="comments" id="comments" rows="5" cols="50">#Comments#</textarea>
        </div>
      </div>
      </cfoutput>
      </div>
    </fieldset>
 
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Update Record" name="UpdateRecordButton" class="button">
        </div>
      </div>
    </div>
</div>
</form>
<cfif isDefined("url.deleteCustomer") and url.deleteCustomer eq "true">
	<cfquery name="addCust" datasource="aaalh3x_onestep">
    DELETE
    FROM realtor_customers
    WHERE ID = #ID#
    </cfquery>
    <cflocation url="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>
<cfif isDefined("form.AddNewCustomer")>
	<cfquery name="addCust" datasource="aaalh3x_onestep">
    INSERT INTO realtor_customers(RealtorID,CustomerName,Address,MLS,ListingDAte,Moved,ReferralFee)
    VALUES(#ClientID#,'#CustomerName#','#Address#','#MLS#',#createODBCDate(ListingDate)#,'#Moved#','#ReferralFee#')
    </cfquery>
    <cflocation url="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>
<cfquery name="getCust" datasource="aaalh3x_onestep">
SELECT *
FROM realtor_customers
WHERE REaltorID = #url.ClientID#
</cfquery>
<cfoutput><form action="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addDataForm" data-abide novalidate></cfoutput>
<div class="row">
    <div class="large-12 columns">
    <fieldset class="fieldset">
    <legend><strong>Referred Customer Info</strong></legend>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <thead>
      <tr>
        <th>Cust Name</th>
        <th>Address</th>
        <th>MLS</th>
        <th>Listing Date</th>
        <th>Moved</th>
        <th>Referral Fee</th>
      </tr>
      </thead>
      <CFOUTPUT QUERY="getCust">
      <tr>
        <td><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&deleteCustomer=true&ID=#ID#" alt="DELETE CUSTOMER" title="DELETE CUSTOMER">[x]</a> - #CustomerName#</td>
        <td>#Address#</td>
        <td>#MLS#</td>
        <td>#DateFOrmat(ListingDate, "MM/DD/YYYY")#</td>
        <td>#Moved#</td>
        <td>#ReferralFee#</td>
      </tr>
      </CFOUTPUT>
      <tr>
        <td><input type="text" name="CustomerName" size="20" id="CustomerName" placeholder="" value=""></td>
        <td><input type="text" name="Address" size="20" id="Address" placeholder="" value=""></td>
        <td><input type="text" name="MLS" size="20" id="MLS" placeholder="" value=""></td>
        <td><input type="text" name="ListingDate" size="20" id="ListingDate" placeholder="" value=""></td>
        <td><input type="text" name="Moved" size="20" id="Moved" placeholder="" value=""></td>
        <td><input type="text" name="ReferralFee" size="20" id="ReferralFee" placeholder="" value=""></td>
      </tr>
    </table>
	</fieldset>
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Add Record" name="AddNewCustomer" class="button">
        </div>
      </div>

	</div>
</div>
</form>
<cfif isDefined("url.deleteReferralAgent") and url.deleteReferralAgent eq "true">
<cfquery name="deleteAgents" datasource="aaalh3x_onestep">
DELETE
FROM realtor_referralAgents
WHERE ID = #ID#
</cfquery>
<cflocation url="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>
<cfif IsDefined("form.AddNewAgent")>
<cfquery name="addAgents" datasource="aaalh3x_onestep">
INSERT INTO realtor_referralAgents(RealtorID,AgentFullName,AgentReferralCode,PhoneNumber,EmailAddress)
VALUES(#ClientID#,'#AgentFullName#','#AgentReferralCode#','#PhoneNumber#','#EmailAddress#')
</cfquery>
 <cflocation url="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no" />
</cfif>
<cfquery name="getAgents" datasource="aaalh3x_onestep">
SELECT *
FROM realtor_referralAgents
WHERE REaltorID = #url.ClientID#
</cfquery>
<cfoutput><form action="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addDataForm" data-abide novalidate></cfoutput>
<div class="row">
    <div class="large-12 columns">
    <fieldset class="fieldset">
    <legend><strong>Referral Agents Referred</strong></legend>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
    <thead>
      <tr>
        <th>Referred Agent Full Name</th>
        <th>Agent Referral Code</th>
        <th>Phone Number</th>
        <th>Email Address</th>
      </tr>
      </thead>
	<cfoutput query="getAgents">
      <tr>
        <td><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&deleteReferralAgent=true&ID=#ID#" alt="DELETE REFERRAL AGENT" title="DELETE REFERRAL AGENT">[x]</a> - #AgentFullName#</td>
        <td>#AgentReferralCode#</td>
        <td>#PhoneNumber#</td>
        <td>#EmailAddress#</td>
      </tr>
    </cfoutput>
      <tr>
        <td><input type="text" name="AgentFullName" size="20" id="AgentFullName" placeholder="" value=""></td>
        <td><input type="text" name="AgentReferralCode" size="20" id="AgentReferralCode" placeholder="" value=""></td>
        <td><input type="text" name="PhoneNumber" size="20" id="PhoneNumber" placeholder="" value=""></td>
        <td><input type="text" name="EmailAddress" size="20" id="EmailAddress" placeholder="" value=""></td>
      </tr>
	</table>
	</fieldset>
    
    <div class="row">
        <div class="small-6 columns">
         <input type="submit" value="Add Record" name="AddNewAgent" class="button">
        </div>
        <div class="small-6 columns" style="text-align:right;">
         <input type="submit" value="Mark As Complete" name="markAsComplete" class="button">
        </div>
      </div>
	</div>
</div>    
</form>
<script src="foundation-6.2.4/js/vendor/foundation.js"></script>
<script>

      $(document).foundation();
    </script>
</body>
</html>
