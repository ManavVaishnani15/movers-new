<cfset datenow = #dateformat(now(), "YYY-MM-DD")#>
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


<style type="text/css">
td {font-size: 12px;
font-family: arial;
height: 1.0in;
}
</style>
</head>
<body topmargin="0" leftmargin="0">
<cfquery name="currentcount" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=999 and active=1 and user_hook=#verify.id#
</cfquery>
<cfset COLUMNNBR = 1>
<cfset ROWNBR = 1>
<cfset TOTITEMS = 0>
<cfloop query="currentcount" startrow="1" endrow="1">
<cfset useid = #currentcount.id#>
</cfloop>
<cfquery name="a" datasource="aaalh3x_onestep">select * from CLIENTS
where id=#useid#</cfquery>
<cfloop query="currentcount" startrow="1" endrow="30">
<cfset TOTITEMS = #TOTITEMS# + 1>
</cfloop>
<cfset THENBR = 30 - #used#>
<cfset checkqt = #THENBR#>
<font size="1"><br><br><br><br></font>
<table style="width: 8.5in; height: 10.0in;" border="0" cellspacing="0" cellpadding="0">
<cfif #used# is 1><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 2><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 3><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 2></cfif>
<cfif #used# is 4><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 5><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 6><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 3></cfif>
<cfif #used# is 7><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 8><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 9><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 4></cfif>
<cfif #used# is 10><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 11><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 12><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 5></cfif>
<cfif #used# is 13><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 14><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 15><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 6></cfif>
<cfif #used# is 16><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 17><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 18><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 7></cfif>
<cfif #used# is 19><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 20><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 21><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 8></cfif>
<cfif #used# is 22><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 23><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 24><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 9></cfif>
<cfif #used# is 25><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 26><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfif #used# is 27><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = 10></cfif>
<cfif #used# is 28><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 2></cfif>
<cfif #used# is 29><tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td><cfset COLUMNNBR = 3></cfif>
<cfloop query="currentcount" startrow="1" endrow="#THENBR#"><cfquery name="g" datasource="aaalh3x_onestep">select * from CLIENTS
where id=#currentcount.cust_hook#</cfquery><cfoutput><cfif #COLUMNNBR# is 1 and #ROWNBR# LT 11><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#g.first_name#, #g.last_name#</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address#<br /><cfif #g.from_address2# is not ''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address2#<br/></cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_city#, #g.from_state# #g.from_zip#<br><br></td><cfset COLUMNNBR = 2><cfelseif #COLUMNNBR# is 2><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>#g.first_name#, #g.last_name#</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address#<br /><cfif #g.from_address2# is not ''>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address2#<br/></cfif>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#g.from_city#, #g.from_state# #g.from_zip#<br><br></td><cfset COLUMNNBR = 3><cfelseif #COLUMNNBR# is 3><td>&nbsp;&nbsp;&nbsp;&nbsp;<b>#g.first_name#, #g.last_name#</b><br/>&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address#<br /><cfif #g.from_address2# is not ''>&nbsp;&nbsp;&nbsp;&nbsp;#g.from_address2#<br/></cfif>&nbsp;&nbsp;&nbsp;&nbsp;#g.from_city#, #g.from_state# #g.from_zip#<br><br></td></tr><cfset COLUMNNBR = 1><cfset ROWNBR = #ROWNBR# + 1></cfif></cfoutput></cfloop>
<cfif #checkqt# is 1>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 2>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 3>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 4>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 5>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 6>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 7>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 8>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 9>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 10>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 11>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 12>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 13>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 14>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 15>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 16>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 17>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 18>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 19>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 20>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 21>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 22>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 23>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 24>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 25>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 26>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 27>
<tr><td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 28>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
<cfelseif #checkqt# is 29>
<td><img src="labelbox.jpg" width="200" height="81" border="0" alt=""></td></tr>
</cfif>
</table> 
</div>
</body>
</html>