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
<html>
<head>
	<title>Search</title>
</head>
<cfset datenow=#dateformat(now(), "MM/DD/YYYY")#>
<cfset dateweeka=#dateadd("D", 7, datenow)#>
<cfset dateweek=#dateformat(dateweeka, "MM/DD/YYYY")#>
<cfset datemontha=#dateadd("M", 1, datenow)#>
<cfset datemonth=#dateformat(datemontha, "MM/DD/YYYY")#>
<body>
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="admintop.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - 
<cfif #type# is 'vweek'>
Verified Appointments - Week
<cfelseif #type# is 'vmonth'>
Verified Appointments - Month
<cfelseif #type# is 'vall'>
Verified Appointments - All
<cfelseif #type# is 'uweek'>
Unverified Appointments - Week
<cfelseif #type# is 'umonth'>
Unverified Appointments - Month
<cfelseif #type# is 'uall'>
Unverified Appointments - All
</cfif>
</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif #type# is 'vweek'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'vmonth'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'vall'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>

<cfelseif #type# is 'uweek'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">)
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'umonth'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">)
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'uall'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= #dateformat(now(), "MM/DD/YYYY")# OR appointment_date = '' or appointment_date is NULL)
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
</cfif>
<div align="center">
<cfif #type# is 'vweek'>
<font face="arial" size="3"><b>Verified Appointments this Week</b></font><br><Br>
<cfelseif #type# is 'vmonth'>
<font face="arial" size="3"><b>Verified Appointments Upcoming Month</b></font><br><Br>
<cfelseif #type# is 'vall'>
<font face="arial" size="3"><b>Verified Appointments - All</b></font><br><Br>
<cfelseif #type# is 'uweek'>
<font face="arial" size="3"><b>Unverified Appointments this Week</b></font><br><Br>
<cfelseif #type# is 'umonth'>
<font face="arial" size="3"><b>Unverified Appointments Upcoming Month</b></font><br><Br>
<cfelseif #type# is 'uall'>
<font face="arial" size="3"><b>Unverified Appointments - All</b></font><br><Br>
</cfif>
<cfif #searchit.recordcount# is 0>
 <font face="arial" size="3">No Matches Found</b><br><br>
 <cfelse><font face="arial" size="2">
 <table border="1" cellspacing="0" cellpadding="3">
 <tr bgcolor="navy">
 <td><font face="arial" size="2" color="white"><b>Customer
 <td><div align="center"><font face="arial" size="2" color="white"><b>Send Follow Up</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Appt Date</b></font></div></td>
<!--- <td><div align="center"><font face="arial" size="2" color="white"><b>Status</b></font></div></td>--->
 <td><div align="center"><font face="arial" size="2" color="white"><b>Origin City</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Destination City</b></font></div></td>
 <cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'><td><div align="center"><font face="arial" size="2" color="white"><b>Initial Letter</b></font></div></td></cfif>
 </tr>
 <cfloop query="searchit">

  
  <!--- see if this customer has an appointment date 7 days or less from today --->
  <cfquery name="sends" datasource="aaalh3x_onestep">
  select * from CLIENTS
  where appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
  </cfquery>
  <!--- see if the follow up was sent for this customer --->
  <cfquery name="follow_sent" datasource="aaalh3x_onestep">
  select * from LETTER_SENDS
  where cust_hook=#searchit.id# and (send_type=7 or send_type=6)
  </cfquery>
   <cfif #searchit.appointment_date# is not ''>   

   <!--- set the date that the follow up letter should be sent , and the background of the cell to white --->
   <cfset appdate=#dateformat(searchit.appointment_date, "MM/DD/YYYY")#>
   <cfset dateweeka=#dateadd("D", -7, appdate)#>
   <cfset dateweekbb=#dateformat(dateweeka, "MM/DD/YYYY")#>
   <cfset follow_color='white'>
   <cfset follow_display='#dateweekbb#'>
   <cfelse><!--- appointment_date is blank --->   
   <cfset follow_color='white'>
   <cfset follow_display='#searchit.appointment_date#'>
   </cfif>
   <!--- we now have the date that the follow up letter should be sent (dateweekbb) --->
   <cfif parameterexists(dateweekbb) is 'yes' AND #searchit.appointment_date# is not ''>
    <cfif #dateformat(dateweekbb, "MM/DD/YYYY")# LTE #dateformat(now(), "MM/DD/YYYY")#>
    <!--- the date the follow up should be sent is less than or equal to today --->
     <cfif #follow_sent.recordcount# is not 0>
     <!--- follow up WAS sent --->
     <cfset follow_color='green'>
     <cfset follow_display='#dateformat(follow_sent.sent_date, "MM/DD/YYYY")#'>
     <cfelse>
     <!--- follow up was NOT sent --->
     <cfset follow_color='red'>
     <cfset appdatess=#dateformat(searchit.appointment_date, "MM/DD/YYYY")#>
     <cfset dateweekat=#dateadd("D", -7, appdatess)#>
     <cfset follow_display='#dateformat(dateweekat, "MM/DD/YYYY")#'>
     </cfif>
    </cfif>
   </cfif>

  <cfquery name="get_letters" datasource="aaalh3x_onestep">
  select * from LETTER_SENDS
  where cust_hook=#searchit.id# and send_type=1
  </cfquery>

 <tr>
 <cfoutput>
 <td><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#"><font face="arial" size="2" color="blue"><b>#searchit.last_name#, #searchit.first_name#</b></font></a></td>
 <td bgcolor="#follow_color#"><div align="center"><font face="arial" size="2" <cfif #follow_color# is 'red' or #follow_color# is 'green'> color="white"</cfif>>#follow_display#</font></div></td>
 <td><div align="center"><cfif #searchit.appt_confirmed# is 1><font face="arial" size="2" color="green"><b><cfelse><font face="arial" size="2"></cfif><cfif #searchit.appointment_date# is not ''>#dateformat(searchit.appointment_date, "MM/DD/YYYY")#<cfelse>Not Set</cfif></b></font></div></td>
 <!---<td><div align="center"><font face="arial" size="2">
  <cfif #searchit.active# is 0>No Reply Yet  
  <cfelseif #searchit.active# is 1>
  Pending Data
  <cfelseif #searchit.active# is 2>
  In Progress
  <cfelseif #searchit.active# is 3>
  Completed
  <cfelseif #searchit.active# is 4>
  Cancelled
  </cfif>
 </font></div></td>--->
 <td><div align="center"><font face="arial" size="2">#searchit.from_city#, #searchit.from_state#</font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.to_city#, #searchit.to_state#</font></div></td>
 <cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'><td <cfif #get_letters.recordcount# is not 0>bgcolor="green"</cfif>><div align="center"><cfif #get_letters.recordcount# is not 0><font face="arial" size="2" color="white"><b><cfif #get_letters.sent# is 1>Mailed<cfelseif #get_initial.sent# is 2>Emailed</cfif> #dateformat(get_letters.sent_date, "MM/DD/YYYY")#</b></font><cfelse><font face="arial" size="2">Not Sent Yet</font></cfif></div></td></cfif>
 </cfoutput>
 </tr>
 </cfloop>
</table><cfoutput>
<cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'>
<div align="center"><cfif parameterexists(sortby) is 'no'><a href="search2.cfm?un=#un#&pw=#pw#&type=#type#&sortby=name"><font face="arial" size="2" color="blue"><b>Click Here to Sort Alphabetically</b></font></a><cfelse><a href="search.cfm?un=#un#&pw=#pw#&type=#type#"><font face="arial" size="2" color="blue"><b>Click Here to Sort Newest to Oldest Entries</b></font></a></cfif></div>
<cfelse>
<div align="center"><cfif parameterexists(sortby) is 'no'><a href="search2.cfm?un=#un#&pw=#pw#&type=#type#&sortby=name"><font face="arial" size="2" color="blue"><b>Click Here to Sort Alphabetically</b></font></a><cfelse><a href="search.cfm?un=#un#&pw=#pw#&type=#type#"><font face="arial" size="2" color="blue"><b>Click Here to Sort by Appointment Date</b></font></a></cfif></div>
</cfif>
</cfoutput>

</cfif><!--- ends searchit.recordcount is 0 --->
</div>
<br><br>
<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
