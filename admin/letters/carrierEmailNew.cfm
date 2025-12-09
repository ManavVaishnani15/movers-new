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
    <!--- Build email list based on sendEmailToAll checkbox --->
    <cfset emailList = getinfo.emailAddress>
    <cfif parameterexists(sendEmailToAll) and sendEmailToAll eq '1'>
        <cfif len(trim(getinfo.emailAddress2))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress2)>
        </cfif>
        <cfif len(trim(getinfo.emailAddress3))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress3)>
        </cfif>
        <cfif len(trim(getinfo.emailAddress4))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress4)>
        </cfif>
    </cfif>
    
    <cfmail
     server="vps.affordableusamovers.com"
      username="movingjobs@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#emailList#"
    FROM="movingjobs@nationwideusamovers.com"
    SUBJECT="Move Jobs-Nationwide USA Movers"
    TYPE="HTML">

    <cfmailparam 
      file="C:\home\top12movingbiz.com\wwwroot\admin\CarrierDocuments\CarrierFlyer.pdf"
      disposition="attachment"
      type="application/pdf">

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
	<span class="fontsize14"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for moving carriers to help with the hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i> 3-4-bedroom homes with weights averaging 9000+ Lbs or 1285 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are already surveyed by our experienced Moving Estimators (to assure the accuracy of the estimate) and we provide our carriers with videos of the surveyed homes together with complete moving information to help our carriers price out the moves based on their own pricing and tariffs.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our Network of Carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-976-6833 Ext 4 <br>

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
      username="movingjobs@nationwideusamovers.com" 
      password="Guido1935$" 
      port="587" 
      useSSL="false"
    TO="#verify.email#"
    FROM="movingjobs@nationwideusamovers.com"
    SUBJECT="Move Jobs-Nationwide USA Movers"
    TYPE="HTML">

    <cfmailparam 
      file="C:\home\top12movingbiz.com\wwwroot\admin\CarrierDocuments\CarrierFlyer.pdf"
      disposition="attachment"
      type="application/pdf">

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
		<span class="fontsize14"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for moving carriers to help with the hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i> 3-4-bedroom homes with weights averaging 9000+ Lbs or 1285 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are already surveyed by our experienced Moving Estimators (to assure the accuracy of the estimate) and we provide our carriers with videos of the surveyed homes together with complete moving information to help our carriers price out the moves based on their own pricing and tariffs.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our Network of Carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-976-6833 Ext 4 <br>

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
<input type="checkbox" name="sendEmailToAll" value="1"> Send email to All<br>
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
		<span class="fontsize14"><cfoutput>
                             	Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for moving carriers to help with the hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i> 3-4-bedroom homes with weights averaging 9000+ Lbs or 1285 cubic feet in size.</i><br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are already surveyed by our experienced Moving Estimators (to assure the accuracy of the estimate) and we provide our carriers with videos of the surveyed homes together with complete moving information to help our carriers price out the moves based on their own pricing and tariffs.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our Network of Carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>.<br><br>
	
	After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move
                             </cfoutput></span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-976-6833 Ext 4 <br>

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
MC #945837 USDOT# 3558324</span>
    </td>
  </tr>
</table>

</cfif>
</body>
</html>
