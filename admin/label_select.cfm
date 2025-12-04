<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>


Select up to 30 Clients to produce a printable label sheet for:<br><br>
<form action="label_print4.cfm" method="post">
<cfoutput><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="un" value="#un#"></cfoutput>
If you are using a label sheet that already has labels used on it,  how many labels have already been used? <select name="used"><option>0<option>1<option>2<option>3<option>4<option>5<option>6<option>7<option>8<option>9<option>10<option>11<option>12<option>13<option>14<option>15<option>16<option>17<option>18<option>19<option>20<option>21<option>22<option>23<option>24<option>25<option>26<option>27<option>28<option>29</select><Br><Br>

<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=1 or active=0 or active=2) AND from_address <> '' AND from_city <> '' AND from_zip <> ''
order by last_name, first_name
</cfquery>
<table border="0" cellspacing="0" cellpadding="0">
<cfoutput query="getinfo">
<tr>
<Td valign="top"><input type="checkbox" name="labelid" value="#getinfo.id#"> </td><td valign="top"><font face="arial" size="3"><b>#last_name#, #first_name#</b><br>
#from_address#<Br>
<cfif #getinfo.from_address2# is not ''>
#from_address2#<br>
</cfif>
#from_city#, #from_state# #from_zip#</font><br><br></td></tr>
</cfoutput>
</table>
<input type="submit" value="Go"></form><Br>

<cfif parameterexists(labelid) is 'yes'>
<cfset itemlist = '#labelid#'>

<cfloop list="#itemlist#" index="x" delimiters=",">

<cfoutput>#x#<br></cfoutput>

</cfloop>

</cfif>
</body>
</html>
