<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset fulldatenow = now()>
<cfset datenow = #dateformat(fulldatenow, "YYY-MM-DD")#>
<cfif parameterexists(keyword) is 'no'>
<cfset keyword=''>
</cfif>
<cfif parameterexists(searchacct) is 'no'>
<cfset searchacct=''>
</cfif>
<cfif parameterexists(type) is 'no'>
<cfset type=''>
</cfif>
<html>
<head>
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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/colorswap.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="https://top12movingbiz.com/admin/scripts/script.js"></script>

<title>Administration - Client Information</title>
</head>

			<cfquery name="updateinfo" datasource="aaalh3x_onestep">
				update realtor_records
                set appointment_date = #now()#
				where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
			</cfquery>

<body bgcolor="eceeee">
    <cfif listfindnocase('asdasdasdasdasd',url.type)>
        <cfquery name="check_initial" datasource="aaalh3x_onestep">
            insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger)
            values(#clientid#,'#url.type#',0,#verify.id#,0, 0)
        </cfquery>
    <cfelse>
		<!--- Automatically queue 7 follow-up letters --->
		<cfif trim(url.type) eq 'followUp'>
			<cfquery name="getinfo" datasource="aaalh3x_onestep">
				select * from realtor_records
				where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
			</cfquery>
			
			<!--- Check first if we already have followup for that Client --->
			<cfquery name="checkFollowUp" datasource="aaalh3x_onestep">
				select * from realtor_printQueue
				where clientid= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
				and memberId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">
				and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">
				and printed = <cfqueryparam cfsqltype="cf_sql_int" value="0">
				and cleared = <cfqueryparam cfsqltype="cf_sql_int" value="0">
				order by followup_date, printed desc
			</cfquery>
			
			<!--- If we don't have yet, then queue 7 followUp, the first one being scheduled for now, the others 6 ones each two weeks after the appointment date --->
			<cfif checkFollowUp.recordCount eq 0>
				<!--- Make sure we have the appointment date provided so we can accurately calculate the scheduled --->
				<cfif isDate(getinfo.appointment_date)>
					
					<!--- it's possible that there are already queued followUps and were all printed.
						Since we really want to queue new ones, let's start fresh and remove the old ones. --->
					<cfquery name="getAllFollowUps" datasource="aaalh3x_onestep">
						select * from realtor_printQueue
						where clientid= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
						and memberId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">
						and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">
						order by followup_date, printed desc
					</cfquery>
					<cfloop query="getAllFollowUps">
						<cfquery name="delLetterSend" datasource="aaalh3x_onestep">
							delete 
							from realtor_LETTER_SENDS
							where printqueueId= <cfqueryparam cfsqltype="cf_sql_bigint" value="#getAllFollowUps.id#">
						</cfquery>
						
						<cfquery name="delQueue" datasource="aaalh3x_onestep">
							delete 
							from realtor_printQueue
							where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#getAllFollowUps.id#">
						</cfquery>
					</cfloop>

					<cfquery name="insertFollowUpLetterBeforeAppointmentDate" datasource="aaalh3x_onestep">
						insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date,date_time_to_order_when_printing)
						values(
								<cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">,
								0,
								<cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">,
								0,
								0,
								<cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,
								<cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">
							)
					</cfquery>
					<cfquery name="qLastID" datasource="aaalh3x_onestep">
						SELECT ID 
						FROM realtor_printQueue 
						ORDER BY ID desc
						LIMIT 1
					</cfquery>
					<!--- insert label --->
					<cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
						INSERT INTO realtor_letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date,printqueueID)
						VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(datenow, 'YYYY-MM-DD')#',#qLastID.ID#)
					  </cfquery>
	
					<cfset firstFollowUpLetterAfterAppointmentDate = dateAdd('d',14,getinfo.appointment_date)>
					<cfset lastFollowUpLetterAfterAppointmentDate = dateAdd('d',84,getinfo.appointment_date)>
					
					<cfloop index="currentFollowUpLetterAfterAppointmentDate" from="#firstFollowUpLetterAfterAppointmentDate#" to="#lastFollowUpLetterAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
						<cfquery name="insertFollowUpLetterAfterAppointmentDate" datasource="aaalh3x_onestep">
							insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
							values(
									<cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">,
									0,
									<cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">,
									0,
									0,
									<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpLetterAfterAppointmentDate, 'YYYY-MM-DD')#">
								)
						</cfquery>
					<cfquery name="qLastID" datasource="aaalh3x_onestep">
						SELECT ID 
						FROM realtor_printQueue 
						ORDER BY ID desc
						LIMIT 1
					</cfquery>
						<!--- insert label --->
						<cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
							INSERT INTO realtor_letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date,printqueueID)
							VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(currentFollowUpLetterAfterAppointmentDate, 'YYYY-MM-DD')#',#qLastID.ID#)
						</cfquery>
					</cfloop>
					
					<!--- Send email to Anthony and Maria to let them know that a new follow-up letter and label is queued--->
					<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Letters are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
						#getinfo.first_name# #getinfo.last_name#<br />
						#getinfo.from_address# #getinfo.from_address2#<br />
						#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
					</cfmail>--->
				</cfif>
			<cfelse><!--- There is(are) already queued followup letter(s), update the first one that has not been to be scheduled now so we can print it and don't do anything with the remaining ones that aren't printed yet. --->
				<cfquery name="updPrintQueue" datasource="aaalh3x_onestep">
					update realtor_printQueue
					set followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,
						date_time_to_order_when_printing = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">
					where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#checkFollowUp.id[1]#">
				</cfquery>

				<!--- Send email to Anthony and Maria to let them know that a new follow-up letter and label is queued--->
				<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Letters are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
					#getinfo.first_name# #getinfo.last_name#<br />
					#getinfo.from_address# #getinfo.from_address2#<br />
					#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
				</cfmail>--->
			</cfif>
		<cfelse>
			<cfquery name="check_initial" datasource="aaalh3x_onestep">
				insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger)
				values(#clientid#,'#url.type#',0,#verify.id#,0, 0)
			</cfquery>
		</cfif>
    </cfif>

    <cflocation url="mainRealtor.cfm?un=#un#&pw=#pw#" addtoken="no" />
</body>
</html>
