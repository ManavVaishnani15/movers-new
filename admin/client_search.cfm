<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Administration - Client Search</title>
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
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Client Search</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif parameterexists(keyword) is 'no'>
<form action="client_search.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
Search for: <input type="text" name="keyword" size="15"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Completed Records <input type="radio" name="searchacct" value="closed"><bR>
Search Cancelled Records <input type="radio" name="searchacct" value="canx"><br>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" value="Search Now"></form><br>
<cfelse><!--- keyword exists ---> 
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where
(first_name LIKE '%#keyword#%' OR last_name LIKE '%#keyword#%' OR from_address LIKE '%#keyword#%' OR from_city LIKE '%#keyword#%' OR discountCode LIKE '%#keyword#%')
<cfif #searchacct# is not 'all'><cfif #searchacct# is 'open'> and (active=0 or active=1 or active=2)<cfelseif #searchacct# is 'closed'> and active=3<cfelseif #searchacct# is 'canx'> and active=4</cfif></cfif>
order by last_name, first_name
</cfquery>
 <cfif #searchit.recordcount# is 0>
 <font face="arial" size="3">No Matches Found</b><br><br>
 <cfelse><font face="arial" size="2">
 <table border="1" cellspacing="0" cellpadding="3">
 <tr bgcolor="navy">
  <td><font face="arial" size="2" color="white"><b>Customer</b></font></td>
  
 <td><div align="center"><font face="arial" size="2" color="white"><b>Discount Code</b></font></div></td>
<!--- <td><div align="center"><font face="arial" size="2" color="white"><b>Follow Up</b></font></div></td>--->
 <td><div align="center"><font face="arial" size="2" color="white"><b>Confirmed Appt Date</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Status</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Origin City</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Destination City</b></font></div></td>
 </tr><cfset url1 ='client_search'>
 <cfloop query="searchit">
 <tr>

 <cfoutput>
 <td><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#&url1=#url1#<cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif>"><font face="arial" size="2" color="blue"><b>#searchit.last_name#, #searchit.first_name#</b></font></a></td>
 <td><div align="center"><font face="arial" size="2">#searchit.discountCode#</font></div></td>
 <!---<td><div align="center"><font face="arial" size="2"></font></div></td>--->
 <td><div align="center"><font face="arial" size="2"><cfif #searchit.appt_confirmed# is 1>#dateformat(searchit.appointment_date, "MM/DD/YYYY")#<cfelse>No</cfif></div></td>
 <td><div align="center"><font face="arial" size="2">
  <cfif #searchit.active# is 0>No Reply Yet  
  <cfelseif #searchit.active# is 1>
  Pending Data
  <cfelseif #searchit.active# is 2>
  In Progress
  (figure out mailing stage here)
  <cfelseif #searchit.active# is 3>
  Completed
  <cfelseif #searchit.active# is 4>
  Cancelled
  </cfif>
 </font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.from_city#, #searchit.from_state#</font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.to_city#, #searchit.to_state#</font></div></td>

 </cfoutput>
 </tr>
 </cfloop>
</table>
</cfif><!--- ends searchit.recordcount is 0 --->
<br>
<b>Search Again</b><br>
<form action="client_search.cfm?requestTimeout=6000" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
Search for: <input type="text" name="keyword" size="15"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Completed Records <input type="radio" name="searchacct" value="closed"><bR>
Search Cancelled Records <input type="radio" name="searchacct" value="canx"><br>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" value="Search Now"></form><br>
</cfif>
<br><br>
<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
