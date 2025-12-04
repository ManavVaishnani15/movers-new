<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Adminstration - Carriers</title>
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

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Carriers</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif parameterexists(remcar) is 'yes'>
<cfquery name="remove" datasource="aaalh3x_onestep">
update CARRIERS
set active='0'
where id=#remcar#
</cfquery>
<font face="arial" size="3" color="green"><b>The Carrier was Deactivated on the System</b></font><br><Br>
</cfif>


<cfif parameterexists(new_company) is 'yes'>
<cfquery name="checkdup" datasource="aaalh3x_onestep">
select * from CARRIERS
where company='#new_company#'
</cfquery>
 <cfif #checkdup.recordcount# is not 0>
  <cfif #checkdup.active# is 1>
  <font face="arial" size="3" color="gray"><b>The Carrier '<cfoutput>#new_company#</cfoutput>' already exists on the system</b></font><br><br>
  <cfelse>
  <cfquery name="react" datasource="aaalh3x_onestep">
  update CARRIERS
  set active='1',
      carrier_info = '#carrierInfo#'
  where id=#checkdup.id#
  </cfquery>
  <font face="arial" size="3" color="green"><b>The Carrier '<cfoutput>#new_company#</cfoutput>' already existed in the system, but was in a deactivated state.  Instead of creating a duplicate active record, the original record has now been reactivated.</b></font>
  <br><br>
  </cfif>
 <cfelse>
 <cfquery name="addnew" datasource="aaalh3x_onestep">
 insert into CARRIERS
 (company,active, carrier_info)
 values ('#new_company#','1','#carrierInfo#')
 </cfquery>
 <font face="arial" size="3" color="green"><b>The New Carrier was Added to the System</b></font><br><br>
 </cfif>
</cfif>


<cfquery name="carriers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1
order by company
</cfquery>
<font face="arial" size="3"><b>Currently Active Carriers</b><br></font>
<table border="1" cellspacing="0" cellpadding="3">
<cfoutput query="carriers">
    <tr>
      <Td valign="middle">
        <font face="arial" size="2" color="black">#company# </font>
      </td>
      <Td valign="middle">
        <font face="arial" size="2" color="black">#carrier_info# </font>
      </td>
      <td valign="middle">
        (<a href="carriers.cfm?un=#un#&pw=#pw#&remcar=#carriers.id#"><font face="arial" size="2" color="red">Remove Carrier from System</font></a>)
      </td>
</tr>
</cfoutput>
</table>
<br>
<form action="carriers.cfm" method="post">
  <cfoutput>
    <input type="hidden" name="un" value="#un#">
    <input type="hidden" name="pw" value="#pw#">
  </cfoutput>
  <font face="arial" size="3"><b>Add New Carrier</b><br></font>
  <font face="arial" size="2">Company Name </font>
  <input type="text" name="new_company" size="20"><br />
  <font face="arial" size="2">Company Info </font><br/>
  <textarea name="carrierInfo" rows="10" cols="50"></textarea><br />
  <input type="submit" value="Add Now">
</form>
<br>

<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>

</body>
</html>
