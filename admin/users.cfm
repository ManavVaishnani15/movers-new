<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Administration - Users</title>
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

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Users</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif parameterexists(add_name) is 'yes'>
<cfquery name="adduser" datasource="aaalh3x_onestep">
insert into MEMBERS
(username,password,name,email,cell,fax,type,active,phone)
values ('#add_username#','#add_password#','#add_name#','#add_email#','#add_cell#','#add_fax#','#add_type#','1','#add_phone#')
</cfquery>
<br>
<font face="arial" size="3" color="green"><b>The New User was Added to the System</b></font>
<br><br>
</cfif>
<cfif parameterexists(new_name) is 'yes'><!--- current user being modified --->
<cfquery name="moduser" datasource="aaalh3x_onestep">
update MEMBERS
set
username='#new_username#',
password='#new_password#',
type='#new_type#',
name='#new_name#',
email='#new_email#',
phone='#new_phone#',
cell='#new_cell#',
fax='#new_fax#'
where id=#userid#
</cfquery>
<br>
<font face="arial" size="3" color="green"><b>The User was Modified on the System</b></font><br><br>
</cfif>
<cfif parameterexists(deact) is 'yes'>
<cfquery name="deactuser" datasource="aaalh3x_onestep">
update MEMBERS
set active=0
where id=#userid#
</cfquery>
<font face="arial" size="3" color="green"><b>The User was Deactivated on the System</b></font><br><br>
</cfif>

<cfquery name="getusers" datasource="aaalh3x_onestep">
select * from MEMBERS
where active=1
order by name
</cfquery>

<cfif parameterexists(moduser) is 'no'>
<font face="arial" size="3"><b>Active Users</b><Br></font>
<table border="1" cellspacing="0" cellpadding="2">
<tr bgcolor="navy">
<td><font face="arial" size="2" color="white"><b>Name</b></font></td>
<td><div align="center"><font face="arial" size="2" color="white"><b>Email</b></font></div></td>
<td><div align="center"><font face="arial" size="2" color="white"><b>Type</b></font></div></td>
<td><div align="center"><font face="arial" size="2" color="white"><b>Phone</b></font></div></td>
<td><div align="center"><font face="arial" size="2" color="white"><b>Cell</b></font></div></td>
<td><div align="center"><font face="arial" size="2" color="white"><b>Fax</b></font></div></td>
<td colspan="2"></td>
</tr>
<cfoutput query="getusers">
<form action="users.cfm" method="post">
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
<input type="hidden" name="userid" value="#getusers.id#"><input type="hidden" name="moduser" value="1">
<tr>
<td><font face="arial" size="2"><b>#getusers.name#</b></font></td>
<td><a href="mailto:#email#"><font face="arial" size="2" color="blue">#getusers.email#</font></a></td>
<td><font face="arial" size="2"><cfif #getusers.type# is 1>Admin<cfelseif #getusers.type# is 2>Standard</cfif></font></td>
<td><font face="arial" size="2">#getusers.phone#</font></td>
<td><font face="arial" size="2">#getusers.cell#</font></td>
<td><font face="arial" size="2">#getusers.fax#</font></td>
<Td><input type="submit" value="Modify"></td></form>
<form action="users.cfm" method="post"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
<input type="hidden" name="userid" value="#getusers.id#"><input type="hidden" name="deact" value="1">
<td><input type="submit" value="Deactivate"></td></form>
</tr>
</cfoutput>
</table>
<br><br>

<form action="users.cfm" method="post"><cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<font face="arial" size="2"><b>Add New User</b><br>
Type <select name="add_type"><option value="2">Standard<option value="1">Admin</select><br>
Name <input type="text" name="add_name" size="15"><Br>
Username <input type="text" name="add_username" size="20"><Br>
Password <input type="text" name="add_password" size="15"><Br>
Email <input type="text" name="add_email" size="20"><Br>
Phone <input type="text" name="add_phone" size="10"><Br>
Cell <input type="text" name="add_cell" size="10"><Br>
Fax <input type="text" name="add_fax" size="10"><Br>
<input type="submit" value="Add User Now"></form>
<br><br>

<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>


<cfelse><!--- moduser exists --->
<cfquery name="getuser" datasource="aaalh3x_onestep">
select * from MEMBERS
where id=#userid#
</cfquery>

<form action="users.cfm" method="post"><cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
<input type="hidden" name="userid" value="#getuser.id#">
<b>Modify User</b><br>
User Type <select name="new_type"><cfif #getuser.type# is 1><option value="1">Admin<option value="2">Standard<cfelse><option value="2">Standard<option value="1">Admin</cfif></select><br>
Name <input type="text" name="new_name" size="20" value="#getuser.name#"><br>
Username <input type="text" name="new_username" size="15" value="#getuser.username#"><br>
Password <input type="text" name="new_password" size="15" value="#getuser.password#"><br>
Email <input type="text" name="new_email" size="20" value="#getuser.email#"><br>
Phone <input type="text" name="new_phone" size="10" value="#getuser.phone#"><br>
Cell <input type="text" name="new_cell" size="10" value="#getuser.cell#"><br>
Fax <input type="text" name="new_fax" size="10" value="#getuser.fax#"><br>
<input type="submit" value="Modify User Now"></form>
</cfoutput>
<br><Br>
<cfoutput><a href="users.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy"><- Back</font></a><br><Br></cfoutput>
<cfoutput><a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</cfif>


</body>
</html>
