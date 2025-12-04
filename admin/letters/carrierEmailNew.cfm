<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = dateformat(now(), "YYYY-MM-DD")>
<html>
<head>
<cfif parameterexists(clientid) is 'yes'>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from carrier_records
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
select * from carrier_records
where id=#clientid#
</cfquery>

<cfif parameterexists(sendmail) is 'yes'>
    <cfmail
     server="vps.affordableusamovers.com"
      username="movingjobs@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#getinfo.emailAddress#"
    FROM="movingjobs@nationwideusamovers.com"
    SUBJECT="Move Jobs-Nationwide USA Movers"
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
    <td>
	<span class="fontsize13"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for carriers to help with hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i>3–4-bedroom homes with weights averaging 18,000 Lbs or 2600 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are surveyed by an AMSA/ATA Certified Moving Consultant (to assure the accuracy of the estimate) and, we provide our carriers with videos of the surveyed homes together with complete moving information to help them pricing out the moves based on their own pricing.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our preferred carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our network of carriers, please go online to www.carriermoving.jobs and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-656-3620</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-656-3620<br>

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
244 Fifth Avenue, Suite 1297<br />
New York, NY 10001<br />
MC ##945837 USDOT## 3558324</span>
    </td>
  </tr>
</table>      
    </cfmail>


    <cfif parameterexists(altmail) is 'yes'>

    <cfmail
     server="vps.affordableusamovers.com"
      username="movingjobs@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#verify.email#"
    FROM="movingjobs@nationwideusamovers.com"
    SUBJECT="Move Jobs-Nationwide USA Movers"
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
    <td>
	<span class="fontsize13"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for carriers to help with hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i>3–4-bedroom homes with weights averaging 18,000 Lbs or 2600 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are surveyed by an AMSA/ATA Certified Moving Consultant (to assure the accuracy of the estimate) and, we provide our carriers with videos of the surveyed homes together with complete moving information to help them pricing out the moves based on their own pricing.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our preferred carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our network of carriers, please go online to www.carriermoving.jobs and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-656-3620</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-656-3620<br>

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
244 Fifth Avenue, Suite 1297<br />
New York, NY 10001<br />
MC ##945837 USDOT## 3558324</span>
    </td>
  </tr>
</table>
            
    </cfmail>

    </cfif>

    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
    select * from carrier_LETTER_SENDS
    where send_type=8 and cust_hook=#clientid#
    </cfquery>
    <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into carrier_LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('9','2','#clientid#','#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into carrier_LETTER_SENDS
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
<cfif parameterexists(emailit) is 'yes' and getinfo.emailAddress neq "">
<form action="carrierEmailNew.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<div align="center">
<input type="submit" value="Email to <cfoutput>#getinfo.emailAddress#</cfoutput> Now"><br>
<input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>
<cfelseif getinfo.emailAddress eq "">
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
	<span class="fontsize13"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for carriers to help with hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i>3–4-bedroom homes with weights averaging 18,000 Lbs or 2600 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are surveyed by an AMSA/ATA Certified Moving Consultant (to assure the accuracy of the estimate) and, we provide our carriers with videos of the surveyed homes together with complete moving information to help them pricing out the moves based on their own pricing.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our preferred carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our network of carriers, please go online to www.carriermoving.jobs and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-656-3620</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-656-3620<br>

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
244 Fifth Avenue, Suite 1297<br />
New York, NY 10001<br />
MC #945837 USDOT# 3558324</span>
    </td>
  </tr>
</table>

</cfif>
</body>
</html>
