<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYY-MM-DD")#>
<cfif parameterexists(keyword) is 'no'>
<cfset keyword=''>
</cfif>
<cfif parameterexists(searchacct) is 'no'>
<cfset searchacct=''>
</cfif>
<cfif parameterexists(type) is 'no'>
<cfset type=''>
</cfif>
<head>
<title>Client Information</title>
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
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/colorswap.css" />
<body bgcolor="#f0f0f0">
<div align="center"><table border="1" cellspacing="0" cellpadding="3" width="98%" bgcolor="ffffff">
<tr>
<td width="100%" valign="top">
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

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="https://top12movingbiz.com/admin/scripts/script.js"></script>

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

<!--- systems for marking postal mail for today --->
<cfif parameterexists(mark_initial) is 'yes'>
<cfquery name="check_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=1 and cust_hook=#clientid#
</cfquery>
 <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('3','1','#clientid#','#datenow#')
 </cfquery>
 <cfelse>
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('1','1','#clientid#','#datenow#')
 </cfquery>
 </cfif>
</cfif>
<cfif parameterexists(mark_follow) is 'yes'>
<cfquery name="check_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=6 and cust_hook=#clientid#
</cfquery>
 <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('7','1','#clientid#','#datenow#')
 </cfquery>
 <cfelse>
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('6','1','#clientid#','#datenow#')
 </cfquery>
 </cfif>
</cfif>
<cfif parameterexists(mark_estimate) is 'yes'>
<!--- check to see if this letter has already been sent --->
<cfquery name="check_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=8 and cust_hook=#clientid#
</cfquery>
 <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('9','1','#clientid#','#datenow#')
 </cfquery>
 <cfelse>
 <cfquery name="set_initial" datasource="aaalh3x_onestep">
 insert into LETTER_SENDS
 (send_type,sent,cust_hook,sent_date)
 values ('8','1','#clientid#','#datenow#')
 </cfquery>
 </cfif>
</cfif>


<!--- start lebel queue system --->
<cfif parameterexists(mark_initial) is 'yes' OR parameterexists(mark_follow) is 'yes' or parameterexists(mark_estimate) is 'yes'>
<cfquery name="q" datasource="aaalh3x_onestep">
insert into LETTER_SENDS
(send_type,active,cust_hook,user_hook)
values ('999','1','#clientid#','#verify.id#')
</cfquery>
</cfif>
<!--- end label queue system --->
<!--- end postal mail tracking system --->

<table border="0" cellspacing="0" cellpadding="1" width="100%"><tr><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Client Information</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="3" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="3" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfset datenow=#dateformat(now(), "YYYY-MM-DD")#>
<cfset timenow=#timeformat(now(), "hh:mm tt")#>

<div align="center">

<cfif parameterexists(mark_complete) is 'yes'>
<cfquery name="comp" datasource="aaalh3x_onestep">
update CLIENTS
set active='3'
where id=#clientid#
</cfquery><br><br>
<font face="arial" size="3" color="red"><b>The Record was marked COMPLETED</b></font><br><br>
</cfif>
<cfif parameterexists(mark_canx) is 'yes'>
<cfquery name="canx" datasource="aaalh3x_onestep">
update CLIENTS
set active='4'
where id=#clientid#
</cfquery><br><br>
<font face="arial" size="3" color="red"><b>The Record was marked CANCELLED</b></font><br><br>
</cfif>
<cfif parameterexists(mark_open) is 'yes'>
<cfquery name="canx" datasource="aaalh3x_onestep">
update CLIENTS
set active='1'
where id=#clientid#
</cfquery><br><br>
<font face="arial" size="3" color="green"><b>The Record was Reopened</b></font><br><br>
</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top">

<cfif parameterexists(new_mc_number) is 'yes'>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
 <cfif parameterexists(new_comments) is 'yes'>
  <cfif #new_comments# is not ''>
  <!--- FIXIT needs carriage return system built into comments area --->
  <cfset newcomments = "#getinfo.comments#<br><i>#dateformat(now(), "MMM D")# - #timeformat(now(), "h:mm tt")#</i><br><b>#verify.name#</b><br>#new_comments#<br>"> 
  <cfelse>
  <cfset newcomments = "#getinfo.comments#">
  </cfif>
 </cfif>
 <cfif #new_moving_date# is not 'None Yet' and #new_moving_date# is not ''>
 <cfset movdate = #dateformat(new_moving_date, "MM/DD/YYYY")#>
 <cfelse>
 <cfset movdate = ''>
 </cfif>
 <cfif #new_contract_date# is not 'None Yet' and #new_contract_date# is not ''>
 <cfset contdate = #dateformat(new_contract_date, "MM/DD/YYYY")#>
 <cfelse>
 <cfset contdate = ''>
 </cfif>
 <cfif #new_closing_date# is not 'None Yet' and #new_closing_date# is not ''>
 <cfset closdate = #dateformat(new_closing_date, "MM/DD/YYYY")#>
 <cfelse>
 <cfset closdate = ''>
 </cfif>
 <cfif #new_appointment_date# is not 'None Yet' and #new_appointment_date# is not ''>
 <cfset appdate = #dateformat(new_appointment_date, "MM/DD/YYYY")#>
 <cfelse>
 <cfset appdate = ''>
 </cfif>
 <cfif #new_move_comp_date# is not 'None Yet' and #new_move_comp_date# is not ''>
 <cfset movcompdate = #dateformat(new_move_comp_date, "MM/DD/YYYY")#>
 <cfelse>
 <cfset movcompdate = ''>
 </cfif>
<cfif #new_days_in_storage# is '' or #new_days_in_storage# is 0>
<cfset new_storage_included = 0>
<cfelse>
<cfset new_storage_included = 1>
</cfif>
<cfquery name="update_clients" datasource="aaalh3x_onestep">
update CLIENTS
set
mc_number='#new_mc_number#',
 <cfif #movcompdate# is not ''>move_comp_date='#movcompdate#',<cfelse>move_comp_date=NULL,</cfif>
 <cfif #movdate# is not ''>moving_date='#movdate#',<cfelse>moving_date=NULL,</cfif>
 <cfif #contdate# is not ''>contract_date='#contdate#',<cfelse>contract_date=NULL,</cfif>
 <cfif #appdate# is not ''>appointment_date='#appdate#',<cfelse>appointment_date=NULL,</cfif>
 <cfif #closdate# is not ''>closing_date='#closdate#',<cfelse>closing_date=NULL,</cfif>
first_name='#new_first_name#',
last_name='#new_last_name#',
email='#new_email#',
phone='#new_phone#',
cell='#new_cell#',
fax='#new_fax#',
appt_confirmed='#new_appt_confirmed#',
from_address='#new_from_address#',
from_address2='#new_from_address2#',
from_city='#new_from_city#',
from_state='#new_from_state#',
from_zip='#new_from_zip#',
packing='#new_packing#',
home_price='#new_home_price#',
to_address='#new_to_address#',
to_address2='#new_to_address2#',
to_city='#new_to_city#',
to_state='#new_to_state#',
to_zip='#new_to_zip#',
final_price='#new_final_price#',
carrier_selected='#new_carrier_selected#',
other_carrier='#new_other_carrier#',
move_type='#new_move_type#',
acessorial='#new_acessorial#',
transportation='#new_transportation#',
valuation='#new_valuation#',
realty_company='#new_realty_company#',
weight='#new_weight#',
miles='#new_miles#',
storage_included='#new_storage_included#',
days_in_storage='#new_days_in_storage#',
valuation_included='<cfif parameterexists(new_valuation_included) is 'yes'>1<cfelse>0</cfif>',
estimate_comments='#new_estimate_comments#',
comments='#newcomments#'
where ID=#clientid#
</cfquery>
<br>
<font face="arial" size="3" color="green"><b>The Client Record was Modified</b></font><br><Br>
</cfif>


<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
<form action="client_info.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
<cfoutput>
<font face="arial" size="4"><b>#getinfo.first_name# #getinfo.last_name#</b></font>&nbsp;- <cfif #getinfo.active# is 3><font color="red" face="arial" size="3">COMPLETED</font><cfelseif #getinfo.active# is 4><font face="arial" size="3" color="red"><b>CANCELLED</b></font><cfelse><font face="arial" size="3" color="green"><b>Open</b></font></cfif><br><BR>
<font face="arial" size="3">
<input type="hidden" name="clientid" value="#clientid#">
<table border="0" cellspacing="0" cellpadding="0"><tr><Td valign="middle">MC Number:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:205px;height:26px;font-size: 120%;" name="new_mc_number" value="#getinfo.mc_number#"></td></tr></table>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><Td valign="middle">Realtor:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:239px;height:26px;font-size: 120%;" name="new_realty_company" value="#getinfo.realty_company#"></td></tr></table>
<br>
<cfif #getinfo.contract_date# is ''>
<cfset contdate = 'None Yet'>
<cfelse>
<cfset contdate = '#dateformat(getinfo.contract_date, "MM/DD/YYYY")#'>
</cfif>
<table border="1" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td valign="middle"><div align="center"><font face="arial" size="3"><b>Contract/Offer Date:</b><br><input class="remindmedropdowna" name="new_contract_date" id="datepicker" value="<cfoutput>#contdate#</cfoutput>" size="10">
<br>
<cfif #getinfo.closing_date# is ''>
<cfset closedate = 'None Yet'>
<cfelse>
<cfset closedate = '#dateformat(getinfo.closing_date, "MM/DD/YYYY")#'>
</cfif>
<font face="arial" size="3"><b>Closing Date:</b><br><input class="remindmedropdowna" name="new_closing_date" id="datepickera" value="<cfoutput>#closedate#</cfoutput>" size="10">
<Br>
<cfif #getinfo.moving_date# is ''>
<cfset movdate = 'None Yet'>
<cfelse>
<cfset movdate = '#dateformat(getinfo.moving_date, "MM/DD/YYYY")#'>
</cfif>
<font face="arial" size="3"><b>Moving Date:</b><br><input class="remindmedropdowna" name="new_moving_date" id="datepickerb" value="<cfoutput>#movdate#</cfoutput>" size="10"></div>
</td>
</tr>
</table>

<Br><BR>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">First Name:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:210px;height:26px;font-size: 120%;" name="new_first_name" value="#getinfo.first_name#" size="12"></td></tr></table>
<Br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Last Name:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:210px;height:26px;font-size: 120%;" name="new_last_name" size="15" value="#getinfo.last_name#"></td></tr></table>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Email:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:247px;height:26px;font-size: 120%;" name="new_email" size="20" value="#getinfo.email#"></td></tr></table>
<a href="mailto:#getinfo.email#"><font face="arial" size="3" color="blue">#getinfo.email#</font></a>
<br><br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Phone:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:210px;height:26px;font-size: 120%;" name="new_phone" size="12" value="#getinfo.phone#"></td></tr>
<cfif #getinfo.phone# is not ''><tr><td></td><td><a href="tel:#getinfo.phone#"><font face="arial" size="3" color="blue"><b>#getinfo.phone#</b></font></a></td></tr></cfif>
<tr><td valign="middle"><font face="arial" size="3">Cell:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:210px;height:26px;font-size: 120%;" name="new_cell" size="12" value="#getinfo.cell#"></td></tr>
<cfif #getinfo.cell# is not ''><tr><td></td><td><a href="tel:#getinfo.cell#"><font face="arial" size="3" color="blue"><b>#getinfo.cell#</b></font></a></td></tr></cfif>
<tr><td valign="middle"><font face="arial" size="3">Fax:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:210px;height:26px;font-size: 120%;" name="new_fax" size="12" value="#getinfo.fax#"></td></tr></table>
<br>
</cfoutput>

<cfif #getinfo.appointment_date# is ''>
<cfset appdate = 'None Yet'>
<cfelse>
<cfset appdate = '#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#'>
</cfif>
<font face="arial" size="3">Appointment Date:<br>
<input class="remindmedropdowna" name="new_appointment_date" id="datepickerc" value="<cfoutput>#appdate#</cfoutput>" size="10">
Confirmed: <select name="new_appt_confirmed"><cfif #getinfo.appt_confirmed# is not 1><option value="0">No<option value="1">Yes<cfelse><option value="1">Yes<option value="0">No</cfif></select>

<cfoutput>
  <br>Discount Code:#getinfo.discountCode#
<br><br>
<table border="1" cellpadding="3" cellspacing="0"><tr><td bgcolor="cbf6f9">
<font face="arial" size="4"><b>Moving From</b><Br>
<font face="arial" size="3">Address:<br>
<input type="text" name="new_from_address" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:290px;height:26px;font-size: 120%;" value="#getinfo.from_address#">
<input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:290px;height:26px;font-size: 120%;" name="new_from_address2" size="20" value="#getinfo.from_address2#">
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3"><font face="arial" size="3">City:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:252px;height:26px;font-size: 120%;" name="new_from_city" size="20" value="#getinfo.from_city#"></td></tr></table>
<font face="arial" size="3">State: <select name="new_from_state"><cfif #getinfo.from_state# is not ''><option value="#getinfo.from_state#">#getinfo.from_state#</option><cfelse><option value="">Select</option></cfif><option value="AL">AL</option>
                <option value="AK">AK</option>
                <option value="AZ">AZ</option>
                <option value="AR">AR</option>
                <option value="CA">CA</option>
                <option value="CO">CO</option>
                <option value="CT">CT</option>
				<option value="DC">DC</option>
                <option value="DE">DE</option>
                <option value="FL">FL</option>
                <option value="GA">GA</option>
                <option value="HI">HI</option>
                <option value="ID">ID</option>
                <option value="IL">IL</option>
                <option value="IN">IN</option>
                <option value="IA">IA</option>
                <option value="KS">KS</option>
                <option value="KY">KY</option>
                <option value="LA">LA</option>
                <option value="ME">ME</option>
                <option value="MD">MD</option>
                <option value="MA">MA</option>
                <option value="MI">MI</option>
                <option value="MN">MN</option>
                <option value="MS">MS</option>
                <option value="MO">MO</option>
                <option value="MT">MT</option>
                <option value="NE">NE</option>
                <option value="NV">NV</option>
                <option value="NH">NH</option>
                <option value="NJ">NJ</option>
                <option value="NM">NM</option>
                <option value="NY">NY</option>
                <option value="NC">NC</option>
                <option value="ND">ND</option>
                <option value="OH">OH</option>
                <option value="OK">OK</option>
                <option value="OR">OR</option>
                <option value="PA">PA</option>
                <option value="RI">RI</option>
                <option value="SC">SC</option>
                <option value="SD">SD</option>
                <option value="TN">TN</option>
                <option value="TX">TX</option>
                <option value="UT">UT</option>
                <option value="VT">VT</option>
                <option value="VA">VA</option>
                <option value="WA">WA</option>
                <option value="WV">WV</option>
                <option value="WI">WI</option>
                <option value="WY">WY</option>
</select>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Zip:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:130px;height:26px;font-size: 120%;" name="new_from_zip" size="10" value="#getinfo.from_zip#"></td></tr></table>
<br>
</cfoutput>

<cfif #getinfo.packing# is not 0>

<cfquery name="getpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where ID=#getinfo.packing#
</cfquery>
<cfquery name="getallpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where active=1 and ID <> #getinfo.packing#
order by type
</cfquery>

<cfelse>

<cfquery name="getallpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where active=1
order by type
</cfquery>

</cfif>

<font face="arial" size="3">Packing <select name="new_packing"><cfif #getinfo.packing# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.packing#">#getpacking.type#</cfoutput></cfif><cfoutput query="getallpacking"><option value="#getallpacking.id#">#getallpacking.type#</cfoutput><cfif #getinfo.packing# is not 0><option value="0">None</cfif></select>
<br>
<cfif #getinfo.move_type# is not 0>

<cfquery name="getmovetype" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where ID=#getinfo.move_type#
</cfquery>
<cfquery name="getallmovetypes" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where active=1 and ID <> #getinfo.move_type#
order by type
</cfquery>

<cfelse>

<cfquery name="getallmovetypes" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where active=1
order by type
</cfquery>

</cfif>
<font face="arial" size="3">Move Type <select name="new_move_type"><cfif #getinfo.move_type# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.move_type#">#getmovetype.type#</cfoutput></cfif><cfoutput query="getallmovetypes"><option value="#getallmovetypes.id#">#getallmovetypes.type#</cfoutput><cfif #getinfo.move_type# is not 0><option value="0">None</cfif></select>

<cfoutput>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Home Price $</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:150px;height:26px;font-size: 120%;" name="new_home_price" size="7" value="#getinfo.home_price#"></td></tr></table>
</cfoutput>
<cfif #getinfo.carrier_selected# is not '0'>

<cfquery name="getcarrier" datasource="aaalh3x_onestep">
select * from CARRIERS
where id=#getinfo.carrier_selected#
</cfquery>

<cfquery name="getallcarriers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1
order by company
</cfquery>

<cfelse>

<cfquery name="getallcarriers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 and ID <> #getinfo.carrier_selected#
order by company
</cfquery>

</cfif>
<font face="arial" size="3">Carrier Selected: <select name="new_carrier_selected"><cfif #getinfo.carrier_selected# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.carrier_selected#">#getcarrier.company#</cfoutput></cfif><cfoutput query="getallcarriers"><option value="#getallcarriers.id#">#getallcarriers.company#</cfoutput><cfif #getinfo.carrier_selected# is not 0><option value="0">None</cfif></select>
<br>
<cfoutput>
<font face="arial" size="3">Other Carrier: <input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:285px;height:26px;font-size: 120%;" name="new_other_carrier" size="15" value="#getinfo.other_carrier#">
</td></tr></table>

<br><br>
<table border="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="e2e2e2">
<font face="arial" size="4"><b>Moving To</b></font><br>
<font face="arial" size="3">Address:<Br>
<input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:290px;height:26px;font-size: 120%;" name="new_to_address" size="20" value="#getinfo.to_address#">
<input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:290px;height:26px;font-size: 120%;" name="new_to_address2" size="20" value="#getinfo.to_address#">
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">City:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:252px;height:26px;font-size: 120%;" name="new_to_city" size="20" value="#getinfo.to_city#"></td></tr></table>
<font face="arial" size="3">State: <select name="new_to_state"><cfif #getinfo.to_state# is not ''><option value="#getinfo.to_state#">#getinfo.to_state#</option><cfelse><option value="">Select</option></cfif><option value="AL">AL</option>
                <option value="AK">AK</option>
                <option value="AZ">AZ</option>
                <option value="AR">AR</option>
                <option value="CA">CA</option>
                <option value="CO">CO</option>
                <option value="CT">CT</option>
				<option value="DC">DC</option>
                <option value="DE">DE</option>
                <option value="FL">FL</option>
                <option value="GA">GA</option>
                <option value="HI">HI</option>
                <option value="ID">ID</option>
                <option value="IL">IL</option>
                <option value="IN">IN</option>
                <option value="IA">IA</option>
                <option value="KS">KS</option>
                <option value="KY">KY</option>
                <option value="LA">LA</option>
                <option value="ME">ME</option>
                <option value="MD">MD</option>
                <option value="MA">MA</option>
                <option value="MI">MI</option>
                <option value="MN">MN</option>
                <option value="MS">MS</option>
                <option value="MO">MO</option>
                <option value="MT">MT</option>
                <option value="NE">NE</option>
                <option value="NV">NV</option>
                <option value="NH">NH</option>
                <option value="NJ">NJ</option>
                <option value="NM">NM</option>
                <option value="NY">NY</option>
                <option value="NC">NC</option>
                <option value="ND">ND</option>
                <option value="OH">OH</option>
                <option value="OK">OK</option>
                <option value="OR">OR</option>
                <option value="PA">PA</option>
                <option value="RI">RI</option>
                <option value="SC">SC</option>
                <option value="SD">SD</option>
                <option value="TN">TN</option>
                <option value="TX">TX</option>
                <option value="UT">UT</option>
                <option value="VT">VT</option>
                <option value="VA">VA</option>
                <option value="WA">WA</option>
                <option value="WV">WV</option>
                <option value="WI">WI</option>
                <option value="WY">WY</option>
</select>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Zip:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:130px;height:26px;font-size: 120%;" name="new_to_zip" size="10" value="#getinfo.to_zip#"></td></tr></table>
</td></tr></table>

<font face="arial" size="3">
<br>
<table border="0" cellpadding="2" cellspacing="0"><tr><Td valign="middle">Estimated Weight:&nbsp;</td><td valign="middle"><input type="text" name="new_weight" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:80px;height:26px;font-size: 120%;" value="#getinfo.weight#"></td></tr></table>
<br>
<table border="0" cellpadding="2" cellspacing="0"><tr><Td valign="middle">Miles:&nbsp;</td><td valign="middle"><input type="text" name="new_miles" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:80px;height:26px;font-size: 120%;" value="#getinfo.miles#"></td></tr></table>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle">Days in Storage:&nbsp;</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:50px;height:26px;font-size: 120%;" name="new_days_in_storage" size="10" value="#getinfo.days_in_storage#"></td></tr></table>
<br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle">Valuation $</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:150px;height:26px;font-size: 120%;" name="new_valuation" size="8" value="#getinfo.valuation#"></td></tr></table>
<input type="checkbox" name="new_valuation_included" value="1"<cfif #getinfo.valuation_included# is 1> checked</cfif>> <font face="arial" size="2">(Check if Valuation Included)
<br><br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="3">Transportation $</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:150px;height:26px;font-size: 120%;" name="new_transportation" size="8" value="#getinfo.transportation#"></td></tr></table>
<br>
<font face="arial" size="3">Accessorial:<br><textarea name="new_acessorial" rows="3" cols="25" STYLE="font:normal 16px Arial;color:7A8082;font-size: 120%;">#getinfo.acessorial#</textarea>
<br>
<font face="arial" size="3">Comments on Estimate<br><textarea name="new_estimate_comments" rows="3" cols="25" STYLE="font:normal 16px Arial;color:7A8082;font-size: 120%;">#getinfo.estimate_comments#</textarea>
<br>

<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle">Final Price $</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:150px;height:26px;font-size: 120%;" name="new_final_price" size="8" value="#getinfo.final_price#"></td></tr></table>
<br>

<cfif #getinfo.move_comp_date# is ''>
<cfset compdate = 'None Yet'>
<cfelse>
<cfset compdate = '#dateformat(getinfo.move_comp_date, "MM/DD/YYYY")#'>
</cfif>
<font face="arial" size="3">Move Completed Date:<br>
<input class="remindmedropdowna" name="new_move_comp_date" id="datepickerd" value="#compdate#" size="10">
</cfoutput>

<br>

<cfif #getinfo.comments# is not ''>
<font face="arial" size="3"><b>Comments</b><Br></font>
<cfoutput>#getinfo.comments#</cfoutput><br><br>
</cfif>

<b>Add to Comments</b><br>
<textarea name="new_comments" rows="5" cols="25" STYLE="font:normal 16px Arial;color:7A8082;font-size: 120%;"></textarea><Br><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput>


<input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Make Changes"></form>
<BR><BR>



<font face="arial" size="3"><b>Status</b></font>
<font face="arial" size="3">

<cfquery name="cq" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=999 and cust_hook=#clientid# and active=1 and user_hook=#verify.id#
</cfquery>
<cfif #cq.recordcount# is not 0>
<Br>
<font color="green" size="2" face="arial"><b>Client has a Label in the Queue</b><br></font>
</cfif>


<cfquery name="get_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=1 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_initial.recordcount# is 0>
 Initial Letter Not Sent<br>

 <cfelse>
 Initial Letter Sent (<cfif #get_initial.sent# is 1>Mailed<cfelseif #get_initial.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_initial.sent_date, "M/D/YY")#)<br></cfoutput>
 
 </cfif>
<cfquery name="get_resinitial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=3 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resinitial.recordcount# is not 0>
 <cfoutput query="get_resinitial">
 - Initial Letter Resent <cfif #get_resinitial.sent# is 1>(Mailed<cfelseif #get_resinitial.sent# is 2>(Emailed </cfif> #dateformat(get_resinitial.sent_date, "M/D/YY")#)<br>
 </cfoutput>
 </cfif>
<!---
<cfquery name="get_tent" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=2 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_tent.recordcount# is 0>
 Tentative Letter Not Sent<br>
 
 <cfelse>
 Tentative Letter Sent <cfoutput>(#dateformat(get_tent.sent_date, "MMM D, YYYY")#)</cfoutput><br>

 </cfif>
<cfquery name="get_restent" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=4 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_restent.recordcount# is not 0>
 <cfoutput query="get_restent">
 - Tentative Letter Resent (#dateformat(get_restent.sent_date, "MMM D, YYYY")#</cfoutput><br>
 </cfif>
--->
<cfquery name="get_booked" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=6 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_booked.recordcount# is 0>
 Follow Up Not Sent<br>
 
 <cfelse>
 Follow Up Sent <cfif #get_booked.sent# is 1>(Mailed<cfelseif #get_booked.sent# is 2>(Emailed </cfif><cfoutput> #dateformat(get_booked.sent_date, "M/D/YY")#)<br></cfoutput>

 </cfif>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=7 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 - Follow Up Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "M/D/YY")#)<br></cfoutput>
 
 </cfif>

<cfquery name="get_estimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=8 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_estimate.recordcount# is 0>
 Estimate Not Sent<br>
 
 <cfelse>
 Estimate Sent <cfif #get_estimate.sent# is 1>(Mailed<cfelseif #get_estimate.sent# is 2>(Emailed </cfif><cfoutput> #dateformat(get_estimate.sent_date, "M/D/YY")#)<br></cfoutput>

 </cfif> 
 
<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=9 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_reestimate.recordcount# is not 0>
 <cfoutput query="get_reestimate">
 - Estimate Resent <cfif #get_reestimate.sent# is 1>(Mailed<cfelseif #get_reestimate.sent# is 2>(Emailed </cfif> #dateformat(get_reestimate.sent_date, "M/D/YY")#)<br></cfoutput>
 
 </cfif>

 <br><br>
 <table border="1" cellspacing="0" cellpadding="1" width="100%">
 <tr><td colspan="3"><div align="center"><font face="arial" size="4"><b>Letter Generation</b></font></div></td></tr>
 <tr><td colspan="3" bgcolor="gray"><div align="center"><font face="arial" size="4" color="white"><b>Initial Letter</b></font></div></td></tr>
 <tr><td valign="middle"><cfoutput><a href="../admin/letters/new_listing_letter.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#"><font face="arial" size="4">New Listing Letter</a></cfoutput></td><td valign="middle"><cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'><cfoutput><a href="../admin/letters/new_listing_letter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_n#clientid#"><font face="arial" size="4">Email Now</a></cfoutput></cfif></td></tr>
<tr><td valign="middle">
<cfoutput><a href="../admin/letters/got_offer_letter.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_g#clientid#"><font face="arial" size="4">Got Offer</a></cfoutput></td><td valign="middle"><cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'><cfoutput><a href="../admin/letters/got_offer_letter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_g#clientid#"><font face="arial" size="4">Email Now</a></cfoutput></cfif></td></tr>
<tr><td valign="middle"><cfoutput><a href="../admin/letters/close_letter.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_c#clientid#"><font face="arial" size="4">Closing</a></cfoutput></td><td valign="middle"><cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'><cfoutput><a href="../admin/letters/close_letter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_c#clientid#"><font face="arial" size="4">Email Now</a></cfoutput></cfif></td></tr>
<tr><td colspan="3" bgcolor="gray"><div align="center"><font face="arial" size="4" color="white"><b>Follow Up Letter</b></font></div></td></tr>
<tr><td valign="middle"><cfoutput><a href="../admin/letters/follow_up_letter.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_f#clientid#"><font face="arial" size="4">Follow Up</a></cfoutput></td><td valign="middle"><cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'><cfoutput><a href="../admin/letters/follow_up_letter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_f#clientid#"><font face="arial" size="4">Email Now</a></cfoutput></cfif></td></tr>
<tr><td colspan="3" bgcolor="gray"><div align="center"><font face="arial" size="4" color="white"><b>Estimate</b><br></font></div></td></tr>
<tr><td valign="middle"><cfoutput><a href="../admin/letters/estimate.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_e#clientid#"><font face="arial" size="4">Estimate</a></cfoutput></td><td valign="middle"><cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'><cfoutput><a href="../admin/letters/estimate.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_e#clientid#"><font face="arial" size="4">Email Now</a></cfoutput></cfif></td></tr>
 </table>
<br>
<br>

<cfset datenow='#dateformat(now(), "YYYY-MM-DD")#'>

<cfif parameterexists(editcarrierquote) is 'yes'><!--- already have a record for this carrier quote.. modifying it --->
<cfquery name="editquote" datasource="aaalh3x_onestep">
update ESTIMATES
set amount='#carrier_amount#'
where id=#editcarrierquote#
</cfquery>
<br>
<font face="arial" size="3" color="green">The quote amount was modified for this record</font><br><br>
</cfif>
<cfif parameterexists(newcarrierquote) is 'yes'><!--- no previous record for this carrier quote.. adding it --->
<cfquery name="addquote" datasource="aaalh3x_onestep">
insert into ESTIMATES
(carrier,amount,user_hook)
values ('#newcarrierquote#','#carrier_amount#','#clientid#')
</cfquery>
<font face="arial" size="3" color="green">The quote amount was added to this record</font><br><br>
</cfif>
<cfif parameterexists(remcarrierquote) is 'yes'><!--- already have a record for this carrier quote - removing it (set to blank) --->
<cfquery name="delquote" datasource="aaalh3x_onestep">
update ESTIMATES
set user_hook='0'
where id=#remcarrierquote#
</cfquery>
<font face="arial" size="3" color="Green">The quote amount was removed from this record</font><Br><br>
</cfif>

<cfif parameterexists(editothercarrierquote) is 'yes'><!--- already have a record for this carrier quote.. modifying it --->
<cfquery name="editquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='#other_carrier_amount#'
where id=#clientid#
</cfquery>
<br>
<font face="arial" size="3" color="green">The quote amount was modified for this record</font><br><br>
</cfif>
<cfif parameterexists(newothercarrierquote) is 'yes'><!--- no previous record for this carrier quote.. adding it --->
<cfquery name="addquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='#other_carrier_amount#' 
where id=#clientid#
</cfquery>
<font face="arial" size="3" color="green">The quote amount was added to this record</font><br><br>
</cfif>
<cfif parameterexists(remothercarrierquote) is 'yes'><!--- already have a record for this carrier quote - removing it (set to blank) --->
<cfquery name="delquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='0'
where id=#clientid#
</cfquery>
<font face="arial" size="3" color="Green">The quote amount was removed from this record</font><Br><br>
</cfif>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
<table border="1" cellspacing="0" cellpadding="1" width="100%">
<tr><td colspan="3"><div align="center"><font face="arial" size="3"><b>Quotes</b></font></div></td></tr>
<cfif #getinfo.other_carrier# is not ''><cfoutput>
<form action="client_info.cfm" method="post"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="clientid" value="#clientid#">
<tr><td valign="middle" width="100%"><font face="arial" size="3">#getinfo.other_carrier#</td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:80px;height:26px;font-size: 120%;" name="other_carrier_amount" value="<cfif #getinfo.other_carrier_amount# is not '' AND #getinfo.other_carrier_amount# is not '0'>#getinfo.other_carrier_amount#</cfif>"><cfif #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not 0><input type="hidden" name="editothercarrierquote" value="1"><cfelse><input type="hidden" name="newothercarrierquote" value="1"></cfif></td><td valign="middle"><input type="submit" value="<cfif #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not '0'>Chg<cfelse>Add</cfif>"></td><cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></form>
</cfoutput></cfif>

<cfloop query="getmovers">
<cfquery name="getqt" datasource="aaalh3x_onestep">
select * from ESTIMATES
where carrier=#getmovers.id# and user_hook=#clientid#
</cfquery>
<cfoutput><form action="client_info.cfm" method="post"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="clientid" value="#clientid#">
<tr><td valign="middle" width="100%"><font face="arial" size="3">#getmovers.company# </td><td valign="middle"><input type="text" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;width:80px;height:26px;font-size: 120%;" name="carrier_amount" value="<cfif #getqt.amount# is not '' AND #getqt.amount# is not '0'>#getqt.amount#</cfif>"><cfif #getqt.amount# is not '' and #getqt.amount# is not 0><input type="hidden" name="editcarrierquote" value="#getqt.id#"><cfelse><input type="hidden" name="newcarrierquote" value="#getmovers.id#"></cfif></td><td valign="middle"><input type="submit" value="<cfif #getqt.amount# is not '' and #getqt.amount# is not '0'>Chg<cfelse>Add</cfif>"></td><cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></form>
</cfoutput></tr>
</cfloop></table>
<br>
<br>
<cfif #getinfo.active# is not 3 and #getinfo.active# is not 4>
<form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_complete" value="1"></cfoutput>
<div align="center"><input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Mark Record Completed"><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput></form></div>
<br><form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_canx" value="1"></cfoutput>
<div align="center"><input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Mark Record Cancelled"></form></div>
<cfelse>
<form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_open" value="1"></cfoutput>
<div align="center"><input type="submit" STYLE="font:normal 16px Arial;color:7A8082;padding:5px;border:solid 1px ccc;margin:0;height:26px;font-size: 120%;" value="Reactivate Record"><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput></form></div>
</cfif>
</td></tr></table>
</div>
<cfoutput>
<a href="#url1#.cfm?un=#un#&pw=#pw#&keyword=#keyword#&searchacct=#searchacct#&type=#type#"><font face="arial" size="3" color="navy"><-- Back</font></a><br><Br>
<a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
