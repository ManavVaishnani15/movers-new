<cfif parameterexists(username) is 'yes'>
	<cfquery name="verify" datasource="aaalh3x_onestep">
	select * from MEMBERS
	where username='#username#' and password='#password#' and active=1
	</cfquery>
	 <cfif #verify.recordcount# is not 0>
		 <cfset un='#username#'>
		 <cfset pw=#randrange(11111,99999)#>
		 <cfquery name="setpw" datasource="aaalh3x_onestep">
			 update MEMBERS
			 set temp_pw='#pw#'
			 where id=#verify.id#
		 </cfquery>
	 </cfif>
<cfelse>
	 <cfif parameterexists(un) is 'yes'>
		 <cfquery name="verify" datasource="aaalh3x_onestep">
			 select * from MEMBERS
			 where username='#un#' and temp_pw=#pw# and active=1
		 </cfquery>
	 </cfif>
</cfif>
<cfif #verify.recordcount# is 0>
There is no active Administrator with the username/password you supplied<br><br>
<b>Log In</b><br>
<form action="main.cfm?requestTimeout=6000" method="post">
username <input type="text" name="username" size="15"><br>
password <input type="password" name="password" size="15"><br>
<input type="submit" value="Log In">
</form>
<cfabort>
</cfif>


<cfset memberLastLoginBeforeToday = 0>
<cfset fulldatenow = form.QueueDate>
<cfset datenow='#dateformat(fulldatenow, "YYYY-MM-DD")#'>
<cfif NOT isDate(verify.last_login) OR (isDate(verify.last_login) AND dateDiff('d',dateformat(verify.last_login, "YYYY-MM-DD"),datenow) NEQ 0)>
	<cfset memberLastLoginBeforeToday = 1>
</cfif>

<cfquery name="updLastLogin" datasource="aaalh3x_onestep">
	update MEMBERS
	set last_login= <cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">
	where id=#verify.id#
</cfquery>

<!--- Check here if there are any queued followup letters or followup labels --->

<cfquery name="followUpPrintQueue" datasource="aaalh3x_onestep">
	select pq.id, pq.clientid, c.first_name, c.last_name, c.from_address, c.from_address2, c.from_city, c.from_state, c.from_zip, c.discountCode
	from printQUeue pq inner join Clients c on pq.clientid = c.id
	where pq.printed=0
	and (pq.memberId=#verify.id# or pq.memberId is null)
	and pq.printType = 'Mayflowerfollowup'
	and pq.cleared=0
</cfquery>

<!--- Count separately followUp as this is a special case --->
<cfquery name="countFollowUpPrintQueue" datasource="aaalh3x_onestep">
	select pq.id, pq.clientid, c.first_name, c.last_name, c.from_address, c.from_address2, c.from_city, c.from_state, c.from_zip, c.discountCode
	from printQUeue pq inner join Clients c on pq.clientid = c.id
	where pq.printed=0
	and pq.printType = 'followUp'
	and pq.cleared=0
	and (pq.memberId=#verify.id# or pq.memberId is null)
	and pq.followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
	order by pq.followup_date
</cfquery>

<cfset totalFollowUpPrintQueue = followUpPrintQueue.recordCount + countFollowUpPrintQueue.recordCount>

<cfquery name="countCurrentFollowUpLabelsInQueue" datasource="aaalh3x_onestep">
	select ls.id, ls.cust_hook, c.first_name, c.last_name, c.from_address, c.from_address2, c.from_city, c.from_state, c.from_zip, c.discountCode
	from LETTER_SENDS ls inner join Clients c on ls.cust_hook = c.id
	where ls.send_type=998 and ls.active=1 and ls.user_hook=#verify.id#
	and coalesce(ls.followup_date,'#datenow#') =  <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
</cfquery>

<cfif memberLastLoginBeforeToday EQ 1><!--- If the Member's last login was before today, then sends email containing the list of Customers having queued follow up letters and labels scheduled today --->
	<cfif totalFollowUpPrintQueue GT 0 OR countCurrentFollowUpLabelsInQueue.recordCount GT 0>
		<cfset listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels = ''>
		<cfmail server="vps.affordableusamovers.com" from='"Customer Care at Nationwide USA Movers" <customercare@nationwideusamovers.com>' username="customercare@nationwideusamovers.com" password="Temp1707!" port="587" useSSL="false" subject="New Follow-up Letters and Labels are Queued" to="abooker@nationwideusamovers.com,customercare@nationwideusamovers.com" type="html">
			<cfloop query="followUpPrintQueue">
				<cfif NOT listFind(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,followUpPrintQueue.clientid)>
					<cfset listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels = listAppend(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,followUpPrintQueue.clientid)>
					#trim(followUpPrintQueue.first_name)# #trim(followUpPrintQueue.last_name)#<br />
					#trim(followUpPrintQueue.from_address)# #trim(followUpPrintQueue.from_address2)#<br />
					#trim(followUpPrintQueue.from_city)# #trim(followUpPrintQueue.from_state)# #trim(followUpPrintQueue.from_zip)#<br />
					Discount Code: #trim(followUpPrintQueue.discountCode)#<br /><br />
				</cfif>
			</cfloop>
			
			<cfloop query="countFollowUpPrintQueue">
				<cfif NOT listFind(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,countFollowUpPrintQueue.clientid)>
					<cfset listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels = listAppend(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,countFollowUpPrintQueue.clientid)>
					#trim(countFollowUpPrintQueue.first_name)# #trim(countFollowUpPrintQueue.last_name)#<br />
					#trim(countFollowUpPrintQueue.from_address)# #trim(countFollowUpPrintQueue.from_address2)#<br />
					#trim(countFollowUpPrintQueue.from_city)# #trim(countFollowUpPrintQueue.from_state)# #trim(countFollowUpPrintQueue.from_zip)#<br />
					Discount Code: #trim(countFollowUpPrintQueue.discountCode)#<br /><br />
				</cfif>
			</cfloop>
			
			<cfloop query="countCurrentFollowUpLabelsInQueue">
				<cfif NOT listFind(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,countCurrentFollowUpLabelsInQueue.cust_hook)>
					<cfset listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels = listAppend(listClientIdsHavingQueuedFollowUpLettersAndFollowUpLabels,countCurrentFollowUpLabelsInQueue.cust_hook)>
					#trim(countCurrentFollowUpLabelsInQueue.first_name)# #trim(countCurrentFollowUpLabelsInQueue.last_name)#<br />
					#trim(countCurrentFollowUpLabelsInQueue.from_address)# #trim(countCurrentFollowUpLabelsInQueue.from_address2)#<br />
					#trim(countCurrentFollowUpLabelsInQueue.from_city)# #trim(countCurrentFollowUpLabelsInQueue.from_state)# #trim(countCurrentFollowUpLabelsInQueue.from_zip)#<br />
					Discount Code: #trim(countCurrentFollowUpLabelsInQueue.discountCode)#<br /><br />
				</cfif>
			</cfloop>
		</cfmail>
	</cfif>
</cfif>

<!--- here is where we check to see if any appointments (verified) are happening in EXACTLY 7 days --->
<cfquery name="sentyet" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=99 and company='#datenow#'
</cfquery>
<cfquery name="setsent" datasource="aaalh3x_onestep">
insert into CARRIERS
(active,company)
values ('99','#datenow#')
</cfquery>

	<cfset datenow='#dateformat(fulldatenow, "YYYY-MM-DD")#'>
	<cfset dateweeka=#dateadd("D", 7, datenow)#>
	<cfset dateweek=#dateformat(dateweeka, "MM/DD/YYYY")#>
	
	<cfquery name="sends" datasource="aaalh3x_onestep">
		select * from CLIENTS
		where appointment_date = <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
		and (memberId=#verify.id#
			or memberId is null)
		and (skipFollowUp <> 1 or skipFollowUp is null)
	</cfquery>
	<cfset notFollowedUp=queryNew("first_name,last_name,from_city,from_state","VarChar,VarChar,VarChar,VarChar") />

<!--- queue follow up letters 7 days before --->
	 <cfif #sends.recordcount# is not 0>
	 	<cfloop query="sends">
	 		<cfquery  datasource="aaalh3x_onestep" name="exists">
		 		select *
		 		from printQueue
		 		where clientId=#sends.id#
		 		and printType='followUp'
		 		and memberId=#verify.id#
	 		</cfquery>
 	 		<cfquery  datasource="aaalh3x_onestep" name="existsInitial">
		 		select *
		 		from printQueue
		 		where clientId=#sends.id#
		 		and (printType='new' or printType='closing' or printType='gotOffer' or printType='nonRealtorLeads')
		 		and memberId=#verify.id#
	 		</cfquery>
	 		<cfquery  datasource="aaalh3x_onestep" name="existsMayflower">
		 		select *
		 		from printQueue
		 		where clientId=#sends.id#
		 		and printType='mayFlowerfollowUp'
		 		and memberId=#verify.id#
	 		</cfquery>
	 		<cfquery  datasource="aaalh3x_onestep" name="existsMayflowerLetter">
		 		select *
		 		from printQueue
		 		where clientId=#sends.id#
		 		and printType='mayFlowerLetter'
		 		and memberId=#verify.id#
	 		</cfquery>
            
	 		<cfif existsInitial.RecordCount AND exists.recordcount is 0>
	 			<cfif isDate(sends.appointment_date)>
			 		<cfquery  datasource="aaalh3x_onestep">
			                insert into printQueue(clientid,printType,printed,cleared,memberId,followup_date)
			                values(#sends.id#,'followUp',0,0,'#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,sends.appointment_date), 'YYYY-MM-DD')#">)
			        </cfquery>
			        <cfquery name="q" datasource="aaalh3x_onestep">
						insert into LETTER_SENDS
						(send_type,active,cust_hook,user_hook,followup_date)
						values ('998','1','#sends.id#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,sends.appointment_date), 'YYYY-MM-DD')#">)
					</cfquery>
					
					<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,sends.appointment_date)>
					<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,sends.appointment_date)>
					
					<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
						<cfquery name="insertFollowUpLetterAfterAppointmentDate" datasource="aaalh3x_onestep">
							insert into printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
							values(
									<cfqueryparam cfsqltype="cf_sql_bigint" value="#sends.id#">,
									<cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">,
									0,
									<cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">,
									0,
									0,
									<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">
								)
						</cfquery>
						
						<cfquery name="insertLabelAfterAppointmentDate" datasource="aaalh3x_onestep">
							insert into LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
							values ('998','1','#sends.id#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
						</cfquery>
						
					</cfloop>
					
					<cfset queryAddRow(notFollowedUp) />
					<cfset QuerySetCell(notFollowedUp, "first_name",  "#sends.first_name#") /> 
					<cfset QuerySetCell(notFollowedUp, "last_name",  "#sends.last_name#") /> 
					<cfset QuerySetCell(notFollowedUp, "from_city",  "#sends.from_city#") /> 
					<cfset QuerySetCell(notFollowedUp, "from_state",  "#sends.from_state#") />
				</cfif>
	 		</cfif>	
            <cfif existsMayflowerLetter.RecordCount AND existsMayflower.recordcount is 0>
		 		<cfquery  datasource="aaalh3x_onestep">
		                insert into printQueue(clientid,printType,printed,cleared,memberId)
		                values(#sends.id#,'MayflowerfollowUp',0,0,'#verify.id#')
		        </cfquery>
		        <cfquery name="q" datasource="aaalh3x_onestep">
					insert into LETTER_SENDS
					(send_type,active,cust_hook,user_hook)
					values ('998','1','#sends.id#','#verify.id#')
				</cfquery>
				<cfset queryAddRow(notFollowedUp) />
				<cfset QuerySetCell(notFollowedUp, "first_name",  "#sends.first_name#") /> 
				<cfset QuerySetCell(notFollowedUp, "last_name",  "#sends.last_name#") /> 
				<cfset QuerySetCell(notFollowedUp, "from_city",  "#sends.from_city#") /> 
				<cfset QuerySetCell(notFollowedUp, "from_state",  "#sends.from_state#") /> 
	 		</cfif>
    	</cfloop>
		<cfif #notFollowedUp.recordcount# gt 0 >
			<cfmail server="vps.affordableusamovers.com" from='"Customer Care at Nationwide USA Movers" <customercare@nationwideusamovers.com>' username="customercare@nationwideusamovers.com" password="Temp1707!" port="587" useSSL="false" subject="7 Day Alerts for Appointments" to="abooker@nationwideusamovers.com,customercare@nationwideusamovers.com" type="html">
			 <!---<cfmail
			 TO="abooker@affordableusamovers.com"
			 CC="Mvisciano@affordableusamovers.com"
			 FROM="admin@affordableusamovers.com"
			 SUBJECT="7 Day Alerts for Appointments"
			 TYPE="HTML"
			 > --->
			 <B>The following clients have appointments in 7 days (#dateformat(dateweek, "MM/DD/YYY")#)</b><br><br>
			 <cfloop query="notFollowedUp">
			 #notFollowedUp.first_name# #notFollowedUp.last_name# - #notFollowedUp.from_city#, #notFollowedUp.from_state#<br><Br>
			 </cfloop>
			 </cfmail>
		 </cfif>
	</cfif>


<cfif parameterexists(clear_queue) is 'yes'><!--- clearing the mail queue --->
	<cfquery name="currentcount" datasource="aaalh3x_onestep">
		select * from LETTER_SENDS
		where send_type=999 and active=1 and user_hook=#verify.id#
			followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
	</cfquery>
	<cfset THENBR = 30 - #used#>
	<cfloop query="currentcount" startrow="1" endrow="#THENBR#">
		<cfquery name="update1" datasource="aaalh3x_onestep">
		update LETTER_SENDS
		set active='0'
		where id=#currentcount.id#
		</cfquery>a
	</cfloop>
</cfif>
<cfif parameterexists(clear_fuqueue) is 'yes'><!--- clearing the mail queue --->
	<cfquery name="currentcount" datasource="aaalh3x_onestep">
		select * from LETTER_SENDS
		where send_type=998 and active=1 and user_hook=#verify.id#
		and followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
	</cfquery>
	<cfset THENBR = 30 - #used#>
	<cfloop query="currentcount" startrow="1" endrow="#THENBR#">
		<cfquery name="update1" datasource="aaalh3x_onestep">
		update LETTER_SENDS
		set active='0'
		where id=#currentcount.id#
		</cfquery>a
	</cfloop>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Administration - Main Menu</title>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Main Menu</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfoutput>
<a href="add_client.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Enter New Record</font></a>
<br><br>
<a href="add_client_New.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Enter New Record (NEW)</font></a>
<br><br>
<a href="client_search.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Search Clients</font></a>
<br><br>
<a href="searchCode.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Search Code</font></a>
<br><br>
 <cfif #verify.type# is 1>
 <a href="users.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">User Administration</font></a>
 <br><br>
 <!---<a href="?un=#un#&pw=#pw#">Letter Format Administration</a>
 <br><br>--->
 <a href="carriers.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Carrier Administration</font></a>
 </cfif>
</cfoutput>
<br>
<!-------  adding form for date loading ------->
<form action="mainDate.cfm" method="post">
	<cfoutput>
		<input type="hidden" name="un" value="#un#">
		<input type="hidden" name="pw" value="#pw#">
		<input type="hidden" name="userid" value="#verify.id#">
	</cfoutput>
<table>
	<tr style="font-family:Arial; font-size:15px;">
		<td><strong>Load Queue Using Date</strong></td>
		<td><cfoutput><input type="date" name="QueueDate" value="#dateFormat(form.QueueDate, "yyyy-mm-dd")#"></cfoutput></td>
		<td><input type="submit" value="Load Queue By Date"></td>
	</tr>
</table>
</form>
<br>
<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Back To Main Dashboard</font></a></cfoutput>

<br><br>
<cfset datenow='#dateformat(form.QueueDate, "YYYY-MM-DD")#'>
<cfset dateweeka=#dateadd("D", 7, datenow)#>
<cfset dateweek=#dateformat(dateweeka, "MM/DD/YYYY")#>
<cfset datemontha=#dateadd("M", 1, datenow)#>
<cfset datemonth=#dateformat(datemontha, "MM/DD/YYYY")#>
<div align="center">
<table border="1" cellspacing="0" cellpadding="4">
<tr>
<Td colspan="3" bgcolor="gray"><div align="center"><font face="arial" size="3" color="white"><b>Verified Appointments</b></font></div></td>
<Td colspan="3" bgcolor="silver"><div align="center"><font face="arial" size="3" color="white"><b>Unverified Appointments</b></font></div></td>
</tr>
<tr>
<Td><div align="Center"><font face="arial" size="2"><b>This Week</b></font></div></td>
<Td><div align="Center"><font face="arial" size="2"><b>This Month</b></font></div></td>
<Td><div align="Center"><font face="arial" size="2"><b>All</b></font></div></td>
<Td><div align="Center"><font face="arial" size="2"><b>This Week</b></font></div></td>
<Td><div align="Center"><font face="arial" size="2"><b>This Month</b></font></div></td>
<Td><div align="Center"><font face="arial" size="2"><b>All</b></font></div></td>
</tr>
<tr>
<cfquery name="v_week" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
</cfquery>

<cfset url1 ='main'>

<td><div align="center"><cfif #v_week.recordcount# is 1><cfoutput><a href="client_info.cfm?requestTimeout=6000&un=#un#&pw=#pw#&clientid=#v_week.id#&url1=#url1#"></cfoutput><cfelseif #v_week.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=vweek&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="green"><b><cfoutput>#v_week.recordcount#</cfoutput></b></font></a></td>
<cfquery name="v_month" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">
</cfquery>
<td><div align="center"><cfif #v_month.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#v_month.id#&url1=#url1#"></cfoutput><cfelseif #v_month.recordcount# GT 1><cfoutput><a href="search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=vmonth&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="navy"><b><cfoutput>#v_month.recordcount#</cfoutput></b></font></a></td>
<cfquery name="v_all" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date">
</cfquery>
<td><div align="center"><cfif #v_all.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#v_all.id#&url1=#url1#"></cfoutput><cfelseif #v_all.recordcount# GT 1><cfoutput><a href="search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=vall&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="gray"><b><cfoutput>#v_all.recordcount#</cfoutput></b></font></a></td>

<cfquery name="u_week" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">)
</cfquery>
<td><div align="center"><cfif #u_week.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#u_week.id#&url1=#url1#"></cfoutput><cfelseif #u_week.recordcount# GT 1><cfoutput><a href="search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=uweek&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="green"><b><cfoutput>#u_week.recordcount#</cfoutput></b></font></a></td>
<cfquery name="u_month" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">)
</cfquery>
<td><div align="center"><cfif #u_month.recordcount# is 1><cfoutput><a href="client_info.cfm?requestTimeout=6000&un=#un#&pw=#pw#&clientid=#u_month.id#&url1=#url1#"></cfoutput><cfelseif #u_month.recordcount# GT 1><cfoutput><a href="search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=umonth&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="navy"><b><cfoutput>#u_month.recordcount#</cfoutput></b></font></a></td>
<cfquery name="u_all" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= #dateformat(now(), "MM/DD/YYYY")# OR appointment_date='' OR appointment_date is NULL)
</cfquery>
<td><div align="center"><cfif #u_all.recordcount# is 1><cfoutput><a href="client_info.cfm?requestTimeout=6000&un=#un#&pw=#pw#&clientid=#u_all.id#&url1=#url1#"></cfoutput><cfelseif #u_all.recordcount# GT 1><cfoutput><a href="search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=uall&QueueDate=#datenow#"></cfoutput></cfif><font face="arial" size="7" color="gray"><b><cfoutput>#u_all.recordcount#</cfoutput></b></font></a></td>
</tr>
</table>
</div>
<br><br>

<cfquery name="currentcount" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=999 and 
	active=1 and 
	user_hook=#verify.id# and
	followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
</cfquery>


<cfif #currentcount.recordcount# LT 30>
<cfset ACOUNT = 1>
<cfelseif #currentcount.recordcount# GT 29 and #currentcount.recordcount# LT 60>
<cfset ACOUNT = 2>
<cfelseif #currentcount.recordcount# GT 59 and #currentcount.recordcount# LT 90>
<cfset ACOUNT = 3>
<cfelseif #currentcount.recordcount# GT 89 and #currentcount.recordcount# LT 120>
<cfset ACOUNT = 4>
<cfelseif #currentcount.recordcount# GT 119 and #currentcount.recordcount# LT 150>
<cfset ACOUNT = 5>
<cfelse>
<cfset ACOUNT = 6>
</cfif>

<font face="arial" size="3">
	<b>Label System</b> - <cfoutput>#currentcount.recordcount#</cfoutput> label<cfif #currentcount.recordcount# is not 1>s</cfif> in queue <br>
	<form action="label_print4.cfm" method="post" target="_queue2">
		<cfoutput>
			<input type="hidden" name="un" value="#un#">
				<input type="hidden" name="pw" value="#pw#">
					<imput type="hidden" name="userid" value="#verify.id#">
						<input type="hidden" name="QueueDate" value="#dateNow#">
		</cfoutput> <br>
<b>Print Labels:</b><br>
How many labels are already used on the sheet you are about to print? <select name="used"><option>0<option>1<option>2<option>3<option>4<option>5<option>6<option>7<option>8<option>9<option>10<option>11<option>12<option>13<option>14<option>15<option>16<option>17<option>18<option>19<option>20<option>21<option>22<option>23<option>24<option>25<option>26<option>27<option>28<option>29</select><input type="submit" value="Create Label Sheet"></form>
<br><br>

<cfquery name="currentcount" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=998 and active=1 and user_hook=#verify.id#
and followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
</cfquery>
<b>Follow Up Label System</b> - <cfoutput>#currentcount.recordcount#</cfoutput> label<cfif #currentcount.recordcount# is not 1>s</cfif> in queue <br>
<form action="label_print4.cfm" method="post" target="_queue2">
	<cfoutput>
		<input type="hidden" name="un" value="#un#">
		<input type="hidden" name="pw" value="#pw#">
		<input type="hidden" name="userid" value="#verify.id#">
		<input type="hidden" name="labeltype" value="followup">
			<input type="hidden" name="QueueDate" value="#dateNow#">
	</cfoutput>
	 <br>
	<b>Print Follow Up Labels:</b><br>
	How many labels are already used on the sheet you are about to print? 
	<select name="used">
		<option>0<option>1<option>2<option>3<option>4<option>5<option>6<option>7<option>8<option>9<option>10<option>11<option>12<option>13<option>14<option>15<option>16<option>17<option>18<option>19<option>20<option>21<option>22<option>23<option>24<option>25<option>26<option>27<option>28<option>29
	</select>
	<input type="submit" value="Create Follow Up Label Sheet">
</form>
<br><br>


<form action="mainDate.cfm" method="post">
	<cfoutput>
		<input type="hidden" name="un" value="#un#">
		<input type="hidden" name="pw" value="#pw#">
		<imput type="hidden" name="userid" value="#verify.id#">
			<input type="hidden" name="QueueDate" value="#dateNow#">
	</cfoutput>
	<input type="hidden" name="clear_queue" value="1">
	<b>Clear Print Queue</b> How many labels were already used on the sheet you printed? 
	<select name="used">
		<option>0<option>1<option>2<option>3<option>4<option>5<option>6<option>7<option>8<option>9<option>10<option>11<option>12<option>13<option>14<option>15<option>16<option>17<option>18<option>19<option>20<option>21<option>22<option>23<option>24<option>25<option>26<option>27<option>28<option>29
	</select>
	<input type="submit" value="Click Here to Clear Queue">
</form>
<br><br />
<form action="mainDate.cfm" method="post">
	<cfoutput>
		<input type="hidden" name="un" value="#un#">
		<input type="hidden" name="pw" value="#pw#">
		<imput type="hidden" name="userid" value="#verify.id#">
			<input type="hidden" name="QueueDate" value="#dateNow#">
	</cfoutput>
	<input type="hidden" name="clear_fuqueue" value="1">
	<b>Clear Followup Print Queue</b> How many labels were already used on the sheet you printed? 
	<select name="used">
		<option>0<option>1<option>2<option>3<option>4<option>5<option>6<option>7<option>8<option>9<option>10<option>11<option>12<option>13<option>14<option>15<option>16<option>17<option>18<option>19<option>20<option>21<option>22<option>23<option>24<option>25<option>26<option>27<option>28<option>29
	</select>
	<input type="submit" value="Click Here to Clear Queue">
</form>
</font>
<Br><Br>

<cfquery name="printQueue" datasource="aaalh3x_onestep">
	select id
	from printQUeue
	where printed=0
	and (memberId=#verify.id# or memberId is null)
	and hanger = 0
 and (printType <> 'followUp' and printType <> 'Mayflowerfollowup' and printType <> 'MayflowerFlyer')
		 		and cleared=0
		 		and followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
</cfquery>

<cfquery name="hangerPrintQueue" datasource="aaalh3x_onestep">
	select id
	from printQUeue
	where printed=0
	and (memberId=#verify.id# or memberId is null)
	and hanger = 1
		 		and cleared=0
		 		and followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
</cfquery>

<cfoutput>
<font face="arial" size="3">
	<b>Print Queue</b> - <cfoutput>#printQueue.recordcount# </cfoutput> letter<cfif #printQueue.recordcount# is not 1>s</cfif> in queue <br>
	<b><A href="printQueue.cfm?un=#un#&pw=#pw#" target="_blank">Print Letters</A></b><br>
	<b><A href="clearPrintQueue.cfm?un=#un#&pw=#pw#&QueueDate=#dateNow#">Clear Letter Queue</A></b>
<Br><Br>
	<b>Follow Up Print Queue</b> - <cfoutput>#totalFollowUpPrintQueue#</cfoutput> letter<cfif totalFollowUpPrintQueue is not 1>s</cfif> in queue <br>
	<b><A href="printQueue.cfm?un=#un#&pw=#pw#&type=followUp" target="_blank">Print Follow Up Letters</A></b><br>
	<b><A href="clearPrintQueue.cfm?un=#un#&pw=#pw#&type=followUp&QueueDate=#dateNow#">Clear Follow Up Letter Queue</A></b><br>
<Br><Br>
	<b>Hanger Print Queue</b> - <cfoutput>#hangerPrintQueue.recordcount#</cfoutput> hanger<cfif #hangerPrintQueue.recordcount# is not 1>s</cfif> in queue <br>
	<b><A href="printQueue.cfm?un=#un#&pw=#pw#&type=hanger" target="_blank">Print Hanger Letters</A></b><br>
	<b><A href="clearPrintQueue.cfm?un=#un#&pw=#pw#&type=hanger&QueueDate=#dateNow#">Clear Hanger Letter Queue</A></b><br>
</font>
</cfoutput>
<Br><Br>
<a href="http://mail.top12movers.com" target="_mail"><font face="arial" size="3" color="blue">Click Here to Open Web-Based Email System</font></a> (opens in new tab)
<Br><br>
<b>Notes from John</b><Br>
I have changed the results page of the searches.  The pages now display 50 records at a time, with a 'Prior' and 'Next' link at the bottom left/right of the resulting table.  This should eliminate any timeout errors that you are seeing, but it does mean that you'll have to click the 'next' or 'prior' links to get to more of the results.<Br>
At the top of each search page (just above the table of results) it will tell you how many results there are, and which one's you are looking at.<br>
For example, if you are on the 2nd page of the results and there are 300 total results, it would say 'Showing Records 51-100 of 300 Records'.<br>
<br>
This will not only eliminate the timeout errors, but will also reduce the waiting time for each set of records down to around 20 seconds. The system processes just over 2 records per second.. so 50 records would take about 20 seconds or so.


<br><br>
I will remove these notes eventually.  They are just here to let you know what I've worked on in case you had a problem with any of these items before I fixed them.<br><Br>


</body>
</html>
