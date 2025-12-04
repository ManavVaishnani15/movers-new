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
<form action="main.cfm" method="post">
username <input type="text" name="username" size="15"><br>
password <input type="password" name="password" size="15"><br>
<input type="submit" value="Log In">
</form>
<cfabort>
</cfif>
<cfset datenow='#dateformat(now(), "MM/DD/YYYY")#'>
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
<cfif #sentyet.recordcount# is 0>SENTYET IS ZERO<br>
<cfset datenow=#dateformat(now(), "MM/DD/YYYY")#>
<cfset dateweeka=#dateadd("D", 7, datenow)#>
<cfset dateweek=#dateformat(dateweeka, "MM/DD/YYYY")#>
<cfquery name="sends" datasource="aaalh3x_onestep">
select * from CLIENTS
where appt_confirmed=1 and appointment_date = <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
</cfquery>
 <cfif #sends.recordcount# is not 0>
 <cfmail
 TO="abooker@affordableusamovers.com"
 FROM="admin@affordableusamovers.com"
 SUBJECT="7 Day Alerts for Appointments"
 TYPE="HTML"
 >
 <B>The following clients have appointments in 7 days (#dateformat(dateweek, "MM/DD/YYY")#)</b><br><br>
 <cfloop query="sends">
 #sends.first_name# #sends.last_name# - #sends.from_city#, #sends.from_state#<br><Br>
 </cfloop>
 </cfmail>
 </cfif>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Administration - Main Menu</title>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="admintop.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Main Menu</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfoutput>
<a href="add_client.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Enter New Record</font></a> Done - Tested - Working
<br><br>
<a href="client_search.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Search Clients</font></a> Search Works - Data Manipulation Works - Print Formatting and Email System Works - Email &amp; Postal Mail Tracking works - Cancel/Complete/Reopen Works
<br><br>
 <cfif #verify.type# is 1>
 <a href="users.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">User Administration</font></a> Done - Tested - Working
 <br><br>
 <!---<a href="?un=#un#&pw=#pw#">Letter Format Administration</a>
 <br><br>--->
 <a href="carriers.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="blue">Carrier Administration</font></a> Done - Tested - Working
 </cfif>
</cfoutput>
<br><br>
<cfset datenow=#dateformat(now(), "MM/DD/YYYY")#>
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
<td><div align="center"><cfif #v_week.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#v_week.id#"></cfoutput><cfelseif #v_week.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=vweek"></cfoutput></cfif><font face="arial" size="7" color="green"><b><cfoutput>#v_week.recordcount#</cfoutput></b></font></a></td>
<cfquery name="v_month" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">
</cfquery>
<td><div align="center"><cfif #v_month.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#v_month.id#"></cfoutput><cfelseif #v_month.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=vmonth"></cfoutput></cfif><font face="arial" size="7" color="navy"><b><cfoutput>#v_month.recordcount#</cfoutput></b></font></a></td>
<cfquery name="v_all" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date">
</cfquery>
<td><div align="center"><cfif #v_all.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#v_all.id#"></cfoutput><cfelseif #v_all.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=vall"></cfoutput></cfif><font face="arial" size="7" color="gray"><b><cfoutput>#v_all.recordcount#</cfoutput></b></font></a></td>
<cfquery name="u_week" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">)
</cfquery>
<td><div align="center"><cfif #u_week.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#u_week.id#"></cfoutput><cfelseif #u_week.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=uweek"></cfoutput></cfif><font face="arial" size="7" color="green"><b><cfoutput>#u_week.recordcount#</cfoutput></b></font></a></td>
<cfquery name="u_month" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">)
</cfquery>
<td><div align="center"><cfif #u_month.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#u_month.id#"></cfoutput><cfelseif #u_month.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=umonth"></cfoutput></cfif><font face="arial" size="7" color="navy"><b><cfoutput>#u_month.recordcount#</cfoutput></b></font></a></td>
<cfquery name="u_all" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= #dateformat(now(), "MM/DD/YYYY")# OR appointment_date='' OR appointment_date is NULL)
</cfquery>
<td><div align="center"><cfif #u_all.recordcount# is 1><cfoutput><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#u_all.id#"></cfoutput><cfelseif #u_all.recordcount# GT 1><cfoutput><a href="search.cfm?un=#un#&pw=#pw#&type=uall"></cfoutput></cfif><font face="arial" size="7" color="gray"><b><cfoutput>#u_all.recordcount#</cfoutput></b></font></a></td>
</tr>
</table>
</div>
<br><br>
<b>Testing</b><br>
<a href="letters/labels.cfm" target="_label">Label Test</a> Not sure how this will be populated<br><Br>
Possibly...<br>
<a href="label_select.cfm" target="_test">Label Select Test</a> Pulls all active clients and allows for 30 to be printed (auto-formats for fewer)<Br><br>
</body>
</html>
