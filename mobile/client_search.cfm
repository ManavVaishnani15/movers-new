<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Client Search</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="description" content="Admin area for Top12MovingBiz.com"/>
    <meta name="keywords" content="moving companies, moving company, moving rates, moving quotes, full service movers, full service moving companies, nationwide moving companies"/>
    <meta name="robots" content="noodp" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="css/colorswap.css" />
	<link rel="stylesheet" href="css/main.css" />
    <script src="https://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <!-- Load SCRIPT.JS which will create datepicker for input field  -->
    <script src="scripts/script.js"></script>
  </head>
<body bgcolor="#f0f0f0">
<div align="center"><table border="1" cellspacing="0" cellpadding="2" width="98%" bgcolor="ffffff">
<tr>
<td width="100%" valign="top">
<cfif parameterexists(un) is 'no'>
<b>Log In</b><br>
<form action="main.cfm" method="post">
username <input type="text" name="username" size="15"><br>
password <input type="password" name="password" size="15"><br>
<input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Log In">
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
 <input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Log In">
 </form>
 <cfabort>
 </cfif>
</cfif>
<table border="0" cellspacing="0" cellpadding="2" width="100%"><tr><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Client Search</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="3" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif parameterexists(keyword) is 'no'>
<form action="client_search.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput><input class="remindmedropdown" id="keyword" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Search for':this.value;" value="Search For" Placeholder="Keyword"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Completed Records <input type="radio" name="searchacct" value="closed"><bR>
Search Cancelled Records <input type="radio" name="searchacct" value="canx"><br>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Search Now"></form><br>
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
 <table border="1" cellspacing="0" cellpadding="2" width="100%">
 <tr bgcolor="navy">
 <td width="100%"><font face="arial" size="2" color="white"><b>Customer
<!--- <td><div align="center"><font face="arial" size="2" color="white"><b>Follow Up</b></font></div></td>--->
 <td><div align="center"><font face="arial" size="2" color="white"><b>Appt</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Origin</b></font></div></td>
 </tr><cfset url1 ='client_search'>
 <cfloop query="searchit">
 <tr>

 <cfoutput>
 <td><a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#&url1=#url1#<cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif>"><font face="arial" size="3" color="blue"><b>#searchit.last_name#, #searchit.first_name#</b></font></a></td>
 <!---<td><div align="center"><font face="arial" size="2"></font></div></td>--->
 <td><div align="center"><font face="arial" size="2"><cfif #searchit.appt_confirmed# is 1><font color="green"><b></cfif>#dateformat(searchit.appointment_date, "M/D/YY")#<cfif #searchit.appt_confirmed# is 1></b></font></cfif></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.from_city#, #searchit.from_state#</font></div></td>
 </cfoutput>
 </tr>
 </cfloop>
</table>
</cfif><!--- ends searchit.recordcount is 0 --->
<br><font size="4">
<b>Search Again</b><br>
<form action="client_search.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput><font size="3">
<input class="remindmedropdown" id="keyword" name="keyword" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Search for':this.value;" value="Search For" Placeholder="Keyword"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Completed Records <input type="radio" name="searchacct" value="closed"><bR>
Search Cancelled Records <input type="radio" name="searchacct" value="canx"><br>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Search Now"></form><br>
</cfif>
<br>
<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</td></tr></table></div>
</body>
</html>
