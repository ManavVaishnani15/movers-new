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
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Realtor Search</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif parameterexists(keyword) is 'no'>
<form action="realtor_searchPage.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
Search for: <input type="text" name="keyword" size="15"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Partner Records <input type="radio" name="searchacct" value="partner"><bR>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" value="Search Now"></form><br>
<cfelse><!--- keyword exists ---> 
<cfif form.searchacct eq "partner">
<cfquery name="searchit" datasource="aaalh3x_onestep">
SELECT *
FROM realtor_referralAgents
WHERE agentfullname like '%#keyword#%' or
	agentreferralcode like '%#keyword#%' or
    phonenumber like '%#keyword#%' or
    emailaddress like '%#keyword#%'
</cfquery>
<cfelse>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from realtor_records
where
(repfirstname LIKE '%#keyword#%' OR replastname LIKE '%#keyword#%' OR streetaddress LIKE '%#keyword#%' OR city LIKE '%#keyword#%' OR ReferralCode LIKE '%#keyword#%' OR CompanyName LIKE '%#keyword#%')
<cfif #searchacct# is not 'all'><cfif #searchacct# is 'open'> and (active=0 or active=1 or active=2)</cfif></cfif>
order by replastname, repfirstname
</cfquery>
</cfif>

<cfif form.searchacct eq "partner">
<cfif #searchit.recordcount# is 0>
<font face="arial" size="3">No Matches Found</b><br><br>
<cfelse>
<font face="arial" size="2">
 <table border="1" cellspacing="0" cellpadding="3">
 <tr bgcolor="navy">
  <td><font face="arial" size="2" color="white"><b>Partner</b></font></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Agent Referral Code</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Phone Number</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Email</b></font></div></td>
 </tr><cfset url1 ='client_search'>
 <cfloop query="searchit">
 <tr>

 <cfoutput>
 <td><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.realtorid#&url1=#url1#<cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif>"><font face="arial" size="2" color="blue"><b>#searchit.agentfullname#</b></font></a></td>
 <td><div align="center"><font face="arial" size="2">#searchit.AgentReferralCode#</font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.phonenumber#</div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.Emailaddress#</font></div></td>

 </cfoutput>
 </tr>
 </cfloop>
</table>

</cfif>


<cfelse>
 <cfif #searchit.recordcount# is 0>
 <font face="arial" size="3">No Matches Found</b><br><br>
 <cfelse><font face="arial" size="2">
 <table border="1" cellspacing="0" cellpadding="3">
 <tr bgcolor="navy">
  <td><font face="arial" size="2" color="white"><b>Realtor</b></font></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Referral Code</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Agency</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Status</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>City/State</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Email</b></font></div></td>
 </tr><cfset url1 ='client_search'>
 <cfloop query="searchit">
 <tr>

 <cfoutput>
 <td><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#&url1=#url1#<cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif>"><font face="arial" size="2" color="blue"><b>#searchit.replastname#, #searchit.repfirstname#</b></font></a></td>
 <td><div align="center"><font face="arial" size="2">#searchit.ReferralCode#</font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.CompanyName#</div></td>
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
 <td><div align="center"><font face="arial" size="2">#searchit.city#, #searchit.state#</font></div></td>
 <td><div align="center"><font face="arial" size="2">#searchit.AgentEmail#</font></div></td>

 </cfoutput>
 </tr>
 </cfloop>
</table>
</cfif><!--- ends searchit.recordcount is 0 --->
</cfif>


<br>
<b>Search Again</b><br>
<form action="realtor_searchPage.cfm?requestTimeout=6000" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
Search for: <input type="text" name="keyword" size="15"><br>
Search Open Records <input type="radio" name="searchacct" value="open" CHECKED><br>
Search Partner Records <input type="radio" name="searchacct" value="partner"><bR>
Search All Records <input type="radio" name="searchacct" value='all'><Br>
<input type="submit" value="Search Now"></form><br>
</cfif>
<br><br>
<cfoutput><a href="mainRealtor.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
