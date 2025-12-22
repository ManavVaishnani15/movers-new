<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = dateformat(now(), "YYYY-MM-DD")>
<html>
<head>
<cfif parameterexists(clientid) is 'yes'>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from realtor_records
where id=#clientid#
</cfquery>
</cfif>
<html>
<head>
    <title><cfif parameterexists(clientid) is 'yes'><cfoutput>#getinfo.repfirstname# #getinfo.replastname#</cfoutput></cfif></title>
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
<body>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from realtor_records
where id=#clientid#
</cfquery>

<cfif parameterexists(sendmail) is 'yes'>
    <cfmail
     server="vps.affordableusamovers.com"
      username="referral-agents@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#getinfo.agentEmail#"
    FROM="enrollment-team@nationwideusamovers.com"
    SUBJECT="Move Referral Program-Nationwide USA Movers"
    TYPE="HTML">
            <style>
		    body {
		        height: 842px;
		        width: 895px;
		        /* to centre page on screen*/
		        margin-left: auto;
		        margin-right: auto;
		        margin-top: 0px;
		        font-family:calibri;
		    }
		    table{
		    		font-family:calibri;
		    	}
			.fontbold{
				font-weight:bold;
			}
			.fontsize12{
				font-size:12px;
				color:##666;
				font-style:italic;
			}
			.fontsize13{
				font-size:13px;
			}
			.fontsize14{
				font-size:14px;
			}
            </style>
            
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="20%" align="center"><img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="90%"></td>
    <td width="50%">&nbsp;</td>
    <td width="20%" align="right" valign="bottom"><p class="fontsize14 fontbold"><cfoutput>#DateFormat(Now(), "mm/dd/yyyy")#</cfoutput></p></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td><br><br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)#<br><br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thank you for joining Nationwide USA Movers "Realtor Relo Referral Program".<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By joining our network of Real Estate professionals, you have also been automatically enrolled 
into our "Customer Referral Program". This program will bring you <span style="text-decoration:underline">Incoming Relocation Business </span> from 
our clients that are moving into your service areas. Our program will also allow you to earn "<span style="text-decoration:underline">Referral 
Fees</span>" every time you refer a client or anyone that needs moving services. In addition, you can refer other 
agents to join our network and earn referral fees from their ongoing customers referrals. - <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Earning referral fees is easy! <span style="text-decoration:underline">Just refer us to your clients for a free quick & easy Virtual Estimate</span>. 
If your customers decide to use our moving services for their move, you will automatically receive 
"Referral Fees" added directly to a personal <span style="text-decoration:underline">Referral Agent Debit Mastercard</span> that will be issued in the 
next 24-48hrs and, either emailed or mailed out via USPS or both. This Mastercard/Bank card will be 
used to deposit all your future move referral commissions. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our "Customer Referral Program" has advantages also for your clients & customers: Free Virtual 
Moving Estimate, move discounts, highly professional moving services, and a certified move coordinator 
available to the customers 7 days a week. All moves coordinated & managed from start to finish. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For all your referrals, use your "Realtor Discount Code" <span style="color: red">[#getinfo.ReferralCode#]</span> that is on your Digital 
Move Discount card that was texted or emailed to you. This will also allow clients/customers to receive 
up to 40% Discounts on our moving services. <br><br><br><br>



Sincerely - <br><br>

Realtor Enrollment Team <br>
Nationwide USA Movers<br>
1-800-976-6833-Ext 3 <br>

</span>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="90%">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
    <span class="fontsize12">Nationwide USA Movers Inc<br />
2319 Third Avenue, Suite 1710<br />
New York, NY 10035<br />
MC ##945837 USDOT## 3558324</span>
    </td>
  </tr>
</table>      
    </cfmail>


    <cfif parameterexists(altmail) is 'yes'>

    <cfmail
     server="vps.affordableusamovers.com"
      username="referral-agents@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#verify.email#"
    FROM="enrollment-team@nationwideusamovers.com"
    SUBJECT="Move Referral Program-Nationwide USA Movers"
    TYPE="HTML">
        <style>
		    body {
		        height: 842px;
		        width: 895px;
		        /* to centre page on screen*/
		        margin-left: auto;
		        margin-right: auto;
		        margin-top: 0px;
		        font-family:calibri;
		    }
		    table{
		    		font-family:calibri;
		    	}
			.fontbold{
				font-weight:bold;
			}
			.fontsize12{
				font-size:12px;
				color:##666;
				font-style:italic;
			}
			.fontsize13{
				font-size:13px;
			}
			.fontsize14{
				font-size:14px;
			}
            </style>
            
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="20%" align="center"><img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="90%"></td>
    <td width="50%">&nbsp;</td>
    <td width="20%" align="right" valign="bottom"><p class="fontsize14 fontbold"><cfoutput>#DateFormat(Now(), "mm/dd/yyyy")#</cfoutput></p></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td><br><br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)#<br><br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thank you for joining Nationwide USA Movers "Realtor Relo Referral Program".<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By joining our network of Real Estate professionals, you have also been automatically enrolled 
into our "Customer Referral Program". This program will bring you <span style="text-decoration:underline">Incoming Relocation Business </span> from 
our clients that are moving into your service areas. Our program will also allow you to earn "<span style="text-decoration:underline">Referral 
Fees</span>" every time you refer a client or anyone that needs moving services. In addition, you can refer other 
agents to join our network and earn referral fees from their ongoing customers referrals. - <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Earning referral fees is easy! <span style="text-decoration:underline">Just refer us to your clients for a free quick & easy Virtual Estimate</span>. 
If your customers decide to use our moving services for their move, you will automatically receive 
"Referral Fees" added directly to a personal <span style="text-decoration:underline">Referral Agent Debit Mastercard</span> that will be issued in the 
next 24-48hrs and, either emailed or mailed out via USPS or both. This Mastercard/Bank card will be 
used to deposit all your future move referral commissions. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our "Customer Referral Program" has advantages also for your clients & customers: Free Virtual 
Moving Estimate, move discounts, highly professional moving services, and a certified move coordinator 
available to the customers 7 days a week. All moves coordinated & managed from start to finish. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For all your referrals, use your "Realtor Discount Code" <span style="color: red">[#getinfo.ReferralCode#]</span> that is on your Digital 
Move Discount card that was texted or emailed to you. This will also allow clients/customers to receive 
up to 40% Discounts on our moving services. <br><br><br><br>



Sincerely - <br><br>

Realtor Enrollment Team <br>
Nationwide USA Movers<br>
1-800-976-6833-Ext 3 <br>

</span>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="90%">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
    <span class="fontsize12">Nationwide USA Movers Inc<br />
2319 Third Avenue, Suite 1710<br />
New York, NY 10035<br />
MC ##945837 USDOT## 3558324</span>
    </td>
  </tr>
</table>
            
    </cfmail>

    </cfif>

    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
    select * from realtor_LETTER_SENDS
    where send_type=8 and cust_hook=#clientid#
    </cfquery>
    <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into realtor_LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('9','2','#clientid#','#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into realtor_LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('8','2','#clientid#','#datenow#')
        </cfquery>
    </cfif>
    	Mail Sent - Recorded that it was sent - You may now close this tab
     
     <cfif parameterexists(altmail) is 'yes'>
     <br>Send a copy to administrator<br>
     </cfif>

<cfelse>
<style>
    body {
        height: 842px;
        width: 895px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        margin-top: 0px;
        font-family:calibri;
    }
    table{
    		font-family:calibri;
    	}
	.fontbold{
		font-weight:bold;
	}
	.fontsize12{
		font-size:12px;
		color:#666;
		font-style:italic;
	}
	.fontsize13{
		font-size:13px;
	}
	.fontsize14{
		font-size:14px;
	}
    </style>
<cfif parameterexists(emailit) is 'yes' and getinfo.agentEmail neq "">
<form action="realtorEmailNew.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<div align="center">
<input type="submit" value="Email to <cfoutput>#getinfo.agentEmail#</cfoutput> Now"><br>
<input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>
<cfelseif getinfo.agentEmail eq "">
<div align="center">You must back up and fill in the email address field</div>
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="20%" align="center"><img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="90%"></td>
    <td width="50%">&nbsp;</td>
    <td width="20%" align="right" valign="bottom"><p class="fontsize14 fontbold"><cfoutput>#DateFormat(Now(), "mm/dd/yyyy")#</cfoutput></p></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td>
<cfoutput>	
<br><br>
<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)#<br><br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thank you for joining Nationwide USA Movers "Realtor Relo Referral Program".<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By joining our network of Real Estate professionals, you have also been automatically enrolled 
into our "Customer Referral Program". This program will bring you <span style="text-decoration:underline">Incoming Relocation Business </span> from 
our clients that are moving into your service areas. Our program will also allow you to earn "<span style="text-decoration:underline">Referral 
Fees</span>" every time you refer a client or anyone that needs moving services. In addition, you can refer other 
agents to join our network and earn referral fees from their ongoing customers referrals. - <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Earning referral fees is easy! <span style="text-decoration:underline">Just refer us to your clients for a free quick & easy Virtual Estimate</span>. 
If your customers decide to use our moving services for their move, you will automatically receive 
"Referral Fees" added directly to a personal <span style="text-decoration:underline">Referral Agent Debit Mastercard</span> that will be issued in the 
next 24-48hrs and, either emailed or mailed out via USPS or both. This Mastercard/Bank card will be 
used to deposit all your future move referral commissions. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our "Customer Referral Program" has advantages also for your clients & customers: Free Virtual 
Moving Estimate, move discounts, highly professional moving services, and a certified move coordinator 
available to the customers 7 days a week. All moves coordinated & managed from start to finish. <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For all your referrals, use your "Realtor Discount Code" <span style="color: red">[#getinfo.ReferralCode#]</span> that is on your Digital 
Move Discount card that was texted or emailed to you. This will also allow clients/customers to receive 
up to 40% Discounts on our moving services. <br><br><br><br>



Sincerely - <br><br>

Realtor Enrollment Team <br>
Nationwide USA Movers<br>
1-800-976-6833-Ext 3 <br>

</span></cfoutput>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="90%">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
    <span class="fontsize12">Nationwide USA Movers Inc<br />
2319 Third Avenue, Suite 1710<br />
New York, NY 10035<br />
MC #945837 USDOT# 3558324</span>
    </td>
  </tr>
</table>

</cfif>
</body>
</html>
