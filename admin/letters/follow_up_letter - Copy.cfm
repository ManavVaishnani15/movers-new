<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "MM/DD/YYYY")#>
<html>
<head>
<cfif parameterexists(clientid) is 'yes'>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
</cfif>
<html>
<head>
	<title><cfif parameterexists(clientid) is 'yes'><cfoutput>#getinfo.first_name# #getinfo.last_name# Follow Up Letter</cfoutput></cfif></title>
	    <style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
    }
    </style>
</head>
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
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
<body>
<cfif parameterexists(sendmail) is 'yes'>
<cfmail
TO="#getinfo.email#"
FROM="admin@top12movers.com"
SUBJECT="NEED A SUBJECT"
TYPE="HTML"
><style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
    }
    </style>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="Middle"><div align="center"><img src="http://www.top12movingbiz.com/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0"><br><img src="http://www.top12movingbiz.com/admin/letters/top12top.jpg" width="148" alt="" border="0"><br><font size="2" face="arial"><b>Nationwide&nbsp;Moving&nbsp;Services</b></font></div></td>
<td align="right" width="100%" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
</tr>
</table>
<br>
<cfoutput>
Dear #getinfo.first_name# #getinfo.last_name#,<br><br>
&nbsp;&nbsp;&nbsp;This is just a kind reminder that we have an appointment scheduled for you with a Certified Moving Consultant on <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><br>
<br>
&nbsp;&nbsp;&nbsp;Don't forget that since your home is listed with <b>#getinfo.realty_company#</b>, <b>Top12Movers</b> will be providing you <b>12 Free Moving Quotes</b> from the top 12 Nationwide Moving Carriers and you're guaranteed a <b>40% Discount **</b> off the price of your move no matter which one of the top 12 carriers you decide to move with through our network. Remember, in order to <b>take advantage and lock in your discount</b> you need to call us and have your free in-home estimate no later than <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>.<br>
&nbsp;&nbsp;&nbsp;We look forward to assisting you with your move.<Br>
<br>
<div align="center"><font size="5">
<b>Your Free in Home Estimate has been Scheduled</b><br>
<b>To Lock in our #getinfo.realty_company# Discount</b><br>
<b>Have Your Estimate Done NO LATER THAN:</b><br>
<br></font>
<font size="7" color="red"><b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><br></font>
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr>
<td width="130" valign="middle"><img src="http://www.top12movingbiz.com/admin/letters/3.jpg" width="130" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font size="4">
<b>Please Call Our Appointment Line<br>
Monday Thru Saturday 7am-7pm<br>
At <font size="3">1-800-289-5329</font> to confirm<br>
Your FREE No Obligation Estimate!!!</font></div></td>
<td width="130" valign="middle"><img src="http://www.top12movingbiz.com/admin/letters/whitebox.jpg" width="130" alt="" border="0"></td></tr></table>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="top" width="100%">
<font size="4"><b>Local Offices:</b><br>
Virginia - 703-570-4232<br>
Maryland - 301-235-9070<br>
Washington DC - 202-729-8277<br>
Monday-Saturday 7am-7pm</font>
</td>
<td align="right" valign="top"><div align="center"><font size="4" face="arial" color="red"><b>Top 12 Carriers</b></font></div><div align="center"><IMG SRC="http://www.top12movingbiz.com/admin/letters/carriers.jpg" WIDTH=225 HEIGHT=142 ALT="" BORDER="0"></div>
</td>
</tr>
</table><br></cfoutput>
<b>** 40% discounts are only guaranteed through Top12Movers</b>

	
</cfmail>	

<cfif parameterexists(altmail) is 'yes'>

<cfmail
TO="#verify.email#"
FROM="admin@top12movers.com"
SUBJECT="NEED A SUBJECT"
TYPE="HTML"
><style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
    }
    </style>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="Middle"><div align="center"><img src="http://www.top12movingbiz.com/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0"><br><img src="http://www.top12movingbiz.com/admin/letters/top12top.jpg" width="148" alt="" border="0"><br><font size="2" face="arial"><b>Nationwide&nbsp;Moving&nbsp;Services</b></font></div></td>
<td align="right" width="100%" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
</tr>
</table>
<br>
<cfoutput>
Dear #getinfo.first_name# #getinfo.last_name#,<br><br>
&nbsp;&nbsp;&nbsp;This is just a kind reminder that we have an appointment scheduled for you with a Certified Moving Consultant on <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><br>
<br>
&nbsp;&nbsp;&nbsp;Don't forget that since your home is listed with <b>#getinfo.realty_company#</b>, <b>Top12Movers</b> will be providing you <b>12 Free Moving Quotes</b> from the top 12 Nationwide Moving Carriers and you're guaranteed a <b>40% Discount **</b> off the price of your move no matter which one of the top 12 carriers you decide to move with through our network. Remember, in order to <b>take advantage and lock in your discount</b> you need to call us and have your free in-home estimate no later than <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>.<br>
&nbsp;&nbsp;&nbsp;We look forward to assisting you with your move.<Br>
<br>
<div align="center"><font size="5">
<b>Your Free in Home Estimate has been Scheduled</b><br>
<b>To Lock in our #getinfo.realty_company# Discount</b><br>
<b>Have Your Estimate Done NO LATER THAN:</b><br>
<br></font>
<font size="7" color="red"><b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><br></font>
</div>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr>
<td width="130" valign="middle"><img src="http://www.top12movingbiz.com/admin/letters/3.jpg" width="130" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font size="4">
<b>Please Call Our Appointment Line<br>
Monday Thru Saturday 7am-7pm<br>
At <font size="3">1-800-289-5329</font> to confirm<br>
Your FREE No Obligation Estimate!!!</font></div></td>
<td width="130" valign="middle"><img src="http://www.top12movingbiz.com/admin/letters/whitebox.jpg" width="130" alt="" border="0"></td></tr></table>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="top" width="100%">
<font size="4"><b>Local Offices:</b><br>
Virginia - 703-570-4232<br>
Maryland - 301-235-9070<br>
Washington DC - 202-729-8277<br>
Monday-Saturday 7am-7pm</font>
</td>
<td align="right" valign="top"><div align="center"><font size="4" face="arial" color="red"><b>Top 12 Carriers</b></font></div><div align="center"><IMG SRC="http://www.top12movingbiz.com/admin/letters/carriers.jpg" WIDTH=225 HEIGHT=142 ALT="" BORDER="0"></div>
</td>
</tr>
</table><br></cfoutput>
<b>** 40% discounts are only guaranteed through Top12Movers</b>

	
</cfmail>	

</cfif>

<!--- check to see if this letter has already been sent --->
<cfquery name="check_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=7 and cust_hook=#clientid#
</cfquery>
<cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
<cfquery name="set_initial" datasource="aaalh3x_onestep">
insert into LETTER_SENDS
(send_type,sent,cust_hook,sent_date)
values ('7','2','#clientid#','#datenow#')
</cfquery>
<cfelse>
<cfquery name="set_initial" datasource="aaalh3x_onestep">
insert into LETTER_SENDS
(send_type,sent,cust_hook,sent_date)
values ('6','2','#clientid#','#datenow#')
</cfquery>
</cfif>
Mail Sent - Recorded - provide a close button
 
 <cfif parameterexists(altmail) is 'yes'>
 <br>Send a copy to administrator<br>
 </cfif>

<cfelse>
<cfif parameterexists(emailit) is 'yes'>
<form action="follow_up_letter.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<div align="center">
<input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput> Now"><br>
<input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>
</cfif>
<cfif #getinfo.appointment_date# is ''>
<br><div align="center"><font face="arial" size="4" color="red"><b>THIS PAGE SHOULD NOT BE PRINTED - THERE IS NO APPOINTMENT DATE SET YET</B></FONT></DIV>
<br><br></cfif>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="Middle"><div align="center"><img src="top12movers-logo.jpg" width="104" height="73" alt="" border="0"><br><img src="top12top.jpg" width="148" alt="" border="0"><br><font size="2" face="arial"><b>Nationwide&nbsp;Moving&nbsp;Services</b></font></div></td>
<td align="right" width="100%" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
</tr>
</table>
<font size="1"><br></font>
<cfoutput>
Dear #getinfo.first_name# #getinfo.last_name#,<font size="1"><br></font><font size="1"><br></font>
&nbsp;&nbsp;&nbsp;This is just a kind reminder that we have an appointment scheduled for you with a Certified Moving Consultant on <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><font size="1"><br></font><font size="1"><br></font>
&nbsp;&nbsp;&nbsp;Don't forget that since your home is listed with <b>#getinfo.realty_company#</b>, <b>Top12Movers</b> will be providing you <b>12 Free Moving Quotes</b> from the top 12 Nationwide Moving Carriers and you're guaranteed a <b>40% Discount **</b> off the price of your move no matter which one of the top 12 carriers you decide to move with through our network. Remember, in order to <b>take advantage and lock in your discount</b> you need to call us and have your free in-home estimate no later than <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>.<font size="1"><br></font><font size="1"><br></font>
&nbsp;&nbsp;&nbsp;We look forward to assisting you with your move.<font size="1"><br></font><font size="1"><br></font>
<div align="center"><font size="4">
<b>Your Free in Home Estimate has been Scheduled</b><font size="1"><br></font>
<b>To Lock in our #getinfo.realty_company# Discount</b><font size="1"><br></font>
<b>Have Your Estimate Done NO LATER THAN:</b><font size="1"><br></font></font><font size="1"><br></font>
<font size="7" color="red"><b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b><font size="1"><br></font></font>
</div><font size="1"><br></font>
<table border="0" cellspacing="0" cellpadding="0" width="100%"><tr>
<td width="130" valign="middle"><img src="3.jpg" width="130" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font size="3">
<b>Please Call Our Appointment Line<br>
Monday Thru Saturday 7am-7pm<br>
At <font size="3">1-800-289-5329</font> to confirm<br>
Your FREE No Obligation Estimate!!!</font></div></td>
<td width="130" valign="middle"><img src="whitebox.jpg" width="130" height="1" alt="" border="0"></td></tr></table><font size="1"><br></font>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="top" width="100%">
<font size="4"><b>Local Offices:</b><br>
Virginia - 703-570-4232<br>
Maryland - 301-235-9070<br>
Washington DC - 202-729-8277<br>
Monday-Saturday 7am-7pm</font>
</td>
<td align="right" valign="top"><div align="center"><font size="3" face="arial" color="red"><b>Top 12 Carriers</b></font></div><div align="center"><IMG SRC="carriers.jpg" WIDTH=225 HEIGHT=142 ALT="" BORDER="0"></div>
</td>
</tr>
</table></cfoutput><font face="arial" size="1"><b>** 40% discounts are only guaranteed through Top12Movers</b></font>

</cfif>
</body>
</html>
