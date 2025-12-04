<!DOCTYPE html>
<html>
<head>
    <title>Top12 Admin</title>
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
<div align="center"><table border="1" cellspacing="0" cellpadding="3" width="94%" bgcolor="ffffff">
<tr>
<td width="100%" valign="top">
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
 <cfelse>
 <div align="center">
 <form action="main.cfm" method="post">
 <input class="remindmedropdown" id="username" name="username" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Username':this.value;" value="Username" Placeholder="Username"><br>
 <input class="remindmedropdown" id="password" name="password" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Password':this.value;" value="Password" Placeholder="Password"><br>
  <div class="form-field"><input type="submit" id ="cmdSubmit" value="Log In" ></form></div>
 </div>
<cfabort>
 </cfif>
</cfif>
<cfif #verify.recordcount# is 0>
 <div align="center">
 There is no active Administrator with the username/password you supplied<br><br>
 <form action="main.cfm" method="post">
 <input class="remindmedropdown" id="username" name="username" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Username':this.value;" value="Username" Placeholder="Username"><br>
 <input class="remindmedropdown" id="password" name="password" onclick="this.value='';" onfocus="this.select()" onblur="this.value =!this.value?'Password':this.value;" value="Password" Placeholder="Password"><br>
  <div class="form-field"><input type="submit" id ="cmdSubmit" value="Log In" ></form></div>
 </div>
<cfabort>
</cfif>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Administration - Main Menu</title>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="2" width="100%"><tr><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Main Menu</b></font></td><td valign="right" bgcolor="gray"><div align="right"><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="3" color="yellow">Log&nbsp;Out</font></a></div></td></tr></table><br>
<cfoutput><div align="center">
<a href="client_search.cfm?un=#un#&pw=#pw#"><font face="arial" size="5" color="blue"><b>Search Clients</b></font></a>
<br><br><br>
<a href="searchCode.cfm?un=#un#&pw=#pw#"><font face="arial" size="5" color="blue"><b>Search Code</b></font></a>
<br><br><br>
 <cfif #verify.type# is 1>
 <a href="users.cfm?un=#un#&pw=#pw#"><font face="arial" size="5" color="blue"><b>User Administration</b></font></a>
 </cfif></div>
</cfoutput>
<Br><br>
<b>Notes from John</b><Br>

</td></tr></table>
</div>
</body>
</html>

</body>
</html>