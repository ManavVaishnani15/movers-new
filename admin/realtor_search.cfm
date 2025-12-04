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
 </cfif>
</cfif>
<cfif #verify.recordcount# is 0>
There is no active Administrator with the username/password you supplied<br><br>
<b>Log In</b><br>
<form action="main.cfm" method="post">
username <input type="text" name="username" size="15"><br>
password <input type="password" name="password" size="15"><br>
<input type="submit" value="Log In">
</form>
<cfabort>
</cfif>


<CFIF IsDefined("form.clearSelected")>
 	<cfquery name="qDisable" datasource="aaalh3x_onestep">
    UPDATE Realtor_records
    SET Active = 4
    WHERE ID IN (#form.theCustomerID#)
    </cfquery>
    <!---- remove from printQueue ---->
    <cfquery name="qKiilFromQueue" datasource="aaalh3x_onestep">
    DELETE
    FROM Realtor_printQueue
    WHERE clientID IN (#form.theCustomerID#)
    </cfquery>
    <!--- remove from label queue ----->
    <cfquery name="qKiilFromLabelQueue" datasource="aaalh3x_onestep">
    DELETE
    FROM Realtor_Letter_sends
    WHERE cust_hook IN (#form.theCustomerID#) and 
      sent = 0 and
      active = 1
    </cfquery>

    <!--- add new items to queue ----->
    <cfset Date1 = dateAdd('d', 7, Now())>
    <cfset Date2 = dateAdd('d', 7, Date1)>
    <cfloop list="#form.theCustomerID#" delimiters="," index="custID">
      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO Realtor_letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#custID#,0,1,#verify.ID#,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO Realtor_letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#custID#,0,1,#verify.ID#,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>

      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO Realtor_printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#custID#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO Realtor_printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#custID#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>
    </cfloop>
</CFIF>

<script language="javascript">
function toggle(source) {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i] != source)
            checkboxes[i].checked = source.checked;
    }
}
</script>


<html>
<head>
	<title>Search</title>
</head>
<cfif IsDefined("url.QueueDate")>
	<cfset datenow=#dateformat(url.QueueDate, "MM/DD/YYYY")#>
	<cfelse>
<cfset datenow=#dateformat(now(), "MM/DD/YYYY")#>
</cfif>
<cfset dateweeka=#dateadd("D", 7, datenow)#>
<cfset dateweek=#dateformat(dateweeka, "MM/DD/YYYY")#>
<cfset datemontha=#dateadd("M", 1, datenow)#>
<cfset datemonth=#dateformat(datemontha, "MM/DD/YYYY")#>
<body>
<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - 
<cfif #type# is 'vweek'>
Verified Appointments - Week
<cfelseif #type# is 'vmonth'>
Verified Appointments - Month
<cfelseif #type# is 'vall'>
Verified Appointments - All
<cfelseif #type# is 'uweek'>
Unverified Appointments - Week
<cfelseif #type# is 'umonth'>
Unverified Appointments - Month
<cfelseif #type# is 'uall'>
Realtors - All
</cfif>
</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfif #type# is 'vweek'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'vmonth'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'vall'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from CLIENTS
where (active=0 or active=1 or active=2) and appt_confirmed=1 and appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date">
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>

<cfelseif #type# is 'uweek'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from Realtor_records
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">)
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'umonth'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from Realtor_records
where (active=0 or active=1 or active=2) and appt_confirmed=0 and (appointment_date >= <cfqueryparam value="#CreateODBCDate(datenow)#" cfsqltype="cf_sql_date"> AND appointment_date <= <cfqueryparam value="#CreateODBCDate(datemonth)#" cfsqltype="cf_sql_date">)
order by <cfif parameterexists(sortby) is 'yes'>last_name, first_name<cfelse>ID desc</cfif>
</cfquery>
<cfelseif #type# is 'uall'>
<cfquery name="searchit" datasource="aaalh3x_onestep">
select * from Realtor_records
where (active=0 or active=1 or active=2)
order by <cfif parameterexists(sortby) is 'yes'>replastname, repfirstname<cfelse>ID desc</cfif>
</cfquery>
</cfif>
<div align="center">
<cfif #type# is 'vweek'>
<font face="arial" size="3"><b>Verified Appointments this Week</b></font><br><Br>
<cfelseif #type# is 'vmonth'>
<font face="arial" size="3"><b>Verified Appointments Upcoming Month</b></font><br><Br>
<cfelseif #type# is 'vall'>
<font face="arial" size="3"><b>Verified Appointments - All</b></font><br><Br>
<cfelseif #type# is 'uweek'>
<font face="arial" size="3"><b>Unverified Appointments this Week</b></font><br><Br>
<cfelseif #type# is 'umonth'>
<font face="arial" size="3"><b>Unverified Appointments Upcoming Month</b></font><br><Br>
<cfelseif #type# is 'uall'>
<font face="arial" size="3"><b>Realtors - All</b></font><br><Br>
</cfif>
<cfif #searchit.recordcount# is 0>
 <font face="arial" size="3">No Matches Found</b><br><br>
 <cfelse><font face="arial" size="2">
 
 <cfif parameterexists(startrow) is 'no'>
 <cfset startrow=1>
 <cfset endrow=50>
 </cfif>
 
 <div align="center">Showing Records <cfoutput><b>#startrow#</b> - <b>#endrow#</b> of <b>#searchit.recordcount#</b></cfoutput></div>
 <cfoutput><FORM ACTION="realtor_Search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=uall" METHOD="Post"></cfoutput>
 <table border="1" cellspacing="0" cellpadding="3">
 <tr bgcolor="navy">
 <td><input name="selectAllRecords" id="selectAllRecords" type="checkbox" value="" onClick="toggle(this);"></td>
 <td><font face="arial" size="2" color="white"><b>Referral Agent Name</b></font></td>
 <cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'><td><div align="center"><font face="arial" size="2" color="white"><b>Letter Sent</b></font></div></td></cfif>
 <td><div align="center"><font face="arial" size="2" color="white"><b>1st Follow Up Sent</b></font></div></td>
 <td><div align="center"><font face="arial" size="2" color="white"><b>Agency</b></font></div></td>
 
 
 <!---<td><div align="center"><font face="arial" size="2" color="white"><b>Appt Date</b></font></div></td>--->
<!--- <td><div align="center"><font face="arial" size="2" color="white"><b>Status</b></font></div></td>--->
 <td><div align="center"><font face="arial" size="2" color="white"><b>Referral Agent Code</b></font></div></td>
<!--- <td><div align="center"><font face="arial" size="2" color="white"><b>Destination City</b></font></div></td>--->
 
 </tr>
 
<CFPARAM Name="CurrentPage" Default="1">
<CFIF IsDefined("sortby")>
<CF_PAGETHRU TOTALRECORDS="#searchit.RecordCount#" CURRENTPAGE="#CurrentPage#" DISPLAYCOUNT="50" TEMPLATEURL="#SCRIPT_NAME#" ADDEDPATH="&requestTimeout=6000&un=#un#&pw=#pw#&type=uall&sortby=#sortby#">
<CFELSE>
<CF_PAGETHRU TOTALRECORDS="#searchit.RecordCount#" CURRENTPAGE="#CurrentPage#" DISPLAYCOUNT="50" TEMPLATEURL="#SCRIPT_NAME#" ADDEDPATH="&requestTimeout=6000&un=#un#&pw=#pw#&type=uall">
</CFIF>
 <cfset follow_color='green'>
 <cfset follow_display='#dateformat(now(), "MM/DD/YYYY")#'>
 <cfoutput query="searchit" startrow="#PT_StartRow#" maxrows="50">
  
  <!--- see if this customer has an appointment date 7 days or less from today --->
<!---  <cfquery name="sends" datasource="aaalh3x_onestep">
  select * from CLIENTS
  where appointment_date <= <cfqueryparam value="#CreateODBCDate(dateweek)#" cfsqltype="cf_sql_date">
  </cfquery>--->
  <!--- see if the follow up was sent for this customer --->
  <cfquery name="follow_sent" datasource="aaalh3x_onestep">
  select * from Realtor_LETTER_SENDS
  where cust_hook=#searchit.id# and 
  		(send_type=7 or send_type=998) 
        and sent=1
        and (sent_date is not null OR date_time_to_order_on_sheet is not null)
  </cfquery>

  
<!---   <cfif #searchit.appointment_date# is not ''>   

   <!--- set the date that the follow up letter should be sent , and the background of the cell to white --->
   <cfset appdate=#dateformat(searchit.appointment_date, "MM/DD/YYYY")#>
   <cfset dateweeka=#dateadd("D", -7, appdate)#>
   <cfset dateweekbb=#dateformat(dateweeka, "MM/DD/YYYY")#>
   <cfset follow_color='white'>
   <cfset follow_display='#dateweekbb#'>
   <cfelse><!--- appointment_date is blank --->   
   <cfset follow_color='white'>
   <cfset follow_display='#searchit.appointment_date#'>
   </cfif>--->
   <!--- we now have the date that the follow up letter should be sent (dateweekbb) --->

    <!--- the date the follow up should be sent is less than or equal to today --->
     <cfif #follow_sent.recordcount# is not 0>
     <!--- follow up WAS sent --->
     <cfset follow_color='green'>
     <cfif follow_sent.sent_date neq "">
     	<cfset follow_display='#dateformat(follow_sent.sent_date, "MM/DD/YYYY")#'>
     <cfelseif follow_sent.date_time_to_order_on_sheet neq "">
     	<cfset follow_display='#dateformat(follow_sent.date_time_to_order_on_sheet, "MM/DD/YYYY")#'>
     <cfelse>
     	<cfset follow_display=''>
     </cfif>
     <cfelse>
     <!--- follow up was NOT sent --->
     <cfset follow_color='red'>
<!---      <cfset appdatess=#dateformat(searchit.appointment_date, "MM/DD/YYYY")#>
     <cfset dateweekat=#dateadd("D", -7, appdatess)#> --->
     <cfset follow_display='Not sent'>
     </cfif>


  <cfquery name="get_letters" datasource="aaalh3x_onestep">
  select * from Realtor_LETTER_SENDS
  where cust_hook=#searchit.id# and (send_type=999 or send_type=101 or send_type=102)
  </cfquery>
  <cfquery name="noRealtorSent" datasource="aaalh3x_onestep">
    select * from Realtor_LETTER_SENDS
    where cust_hook=#searchit.id# and send_type=20
  </cfquery>
<cfset url1 ='search'>
 <tr>

 <td><input name="theCustomerID" type="checkbox" value="#searchit.id#"></td>
 <td><font face="arial" size="2" color="blue"><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#&url1=#url1#&type=#type#" target="_#searchit.id#"><b>#searchit.replastname#, #searchit.repfirstname#</b></a></font></td>
  <cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'><td <cfif #get_letters.recordcount# is not 0>bgcolor="green"</cfif>><div align="center"><cfif #get_letters.recordcount# is not 0><font face="arial" size="2" color="white"><b> <cfloop query="get_letters"><cfif #get_letters.sent# is 1>Mailed<cfelseif #get_letters.sent# is 2>Emailed</cfif>  <cfif get_letters.sent_date neq "">#dateformat(get_letters.sent_date, "MM/DD/YYYY")#<cfbreak></cfif></cfloop></b></font><cfelse><font face="arial" size="2">Not Sent Yet</font></cfif></div></td></cfif>
  <td bgcolor="#follow_color#"><div align="center"><font face="arial" size="2" <cfif #follow_color# is 'red' or #follow_color# is 'green'> color="white"</cfif>>#follow_display#</font></div></td>
 <td><a href="realtor_client_info.cfm?un=#un#&pw=#pw#&clientid=#searchit.id#&url1=#url1#&type=#type#" target="_#searchit.id#"><font face="arial" size="2" color="blue"><b>#searchit.Companyname#</b></font></a></td>
 

<!--- <td><div align="center"><font face="arial" size="2" color="green"><b>-</b></font></div></td>--->
 <td><div align="center"><font face="arial" size="2">#searchit.ReferralCode#</font></div></td>
<!--- <td><div align="center"><font face="arial" size="2">#searchit.city#, #searchit.state#</font></div></td>--->


 </tr>
 </cfoutput>
<tr>

<!---
<Cfset a = #searchit.recordcount# - #endrow#>
<cfif #a# LT 50><cfset nextnbr = #a#><cfelse><cfset nextnbr = 50></cfif>
<cfif #searchit.recordcount# GT #endrow#>
<cfset nextstart = #startrow# + 50>
<cfset nextend = #endrow# + 50>
</cfif>
<cfif #startrow# GT 50>
<cfset priorstart = #startrow# - 50>
<cfset priorend = #endrow# - 50>
</cfif> --->

<td colspan="8"></td>
</tr>

<tr>
	<td colspan="8" align="center" height="50"><CFOUTPUT><span>#PT_PageThru#</span></cfoutput></td>
</tr>
</table>
<br>
<div align="center">
<input name="clearSelected" type="submit" value="CLEAR SELECTED REALTORS">
</div>
</FORM>

<br><br>
<cfoutput>
<cfif #type# is 'uweek' or #type# is 'umonth' or #type# is 'uall'>
<div align="center"><cfif parameterexists(sortby) is 'no'><a href="Realtor_search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=#type#&sortby=name"><font face="arial" size="2" color="blue"><b>Click Here to Sort Alphabetically</b></font></a><cfelse><a href="Realtor_search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=#type#"><font face="arial" size="2" color="blue"><b>Click Here to Sort Newest to Oldest Entries</b></font></a></cfif></div>
<cfelse>
<div align="center"><cfif parameterexists(sortby) is 'no'><a href="Realtor_search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=#type#&sortby=name"><font face="arial" size="2" color="blue"><b>Click Here to Sort Alphabetically</b></font></a><cfelse><a href="Realtor_search.cfm?requestTimeout=6000&un=#un#&pw=#pw#&type=#type#"><font face="arial" size="2" color="blue"><b>Click Here to Sort by Appointment Date</b></font></a></cfif></div>
</cfif>
</cfoutput>

</cfif><!--- ends searchit.recordcount is 0 --->
</div>
<br><br>
<cfoutput><a href="mainRealtor.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
