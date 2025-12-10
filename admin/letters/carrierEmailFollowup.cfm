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
        <!--- Add Rep 1 additional emails --->
        <cfif len(trim(getinfo.emailAddress2))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress2)>
        </cfif>
        <cfif len(trim(getinfo.emailAddress3))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress3)>
        </cfif>
        <cfif len(trim(getinfo.emailAddress4))>
            <cfset emailList = emailList & "," & trim(getinfo.emailAddress4)>
        </cfif>
        <!--- Add Rep 2 emails --->
        <cfif len(trim(getinfo.Rep2Emailaddress))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep2Emailaddress)>
        </cfif>
        <cfif len(trim(getinfo.Rep2Emailaddress2))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep2Emailaddress2)>
        </cfif>
        <cfif len(trim(getinfo.Rep2Emailaddress3))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep2Emailaddress3)>
        </cfif>
        <cfif len(trim(getinfo.Rep2Emailaddress4))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep2Emailaddress4)>
        </cfif>
        <cfif len(trim(getinfo.Rep3Emailaddress))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep3Emailaddress)>
        </cfif>
        <cfif len(trim(getinfo.Rep3Emailaddress2))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep3Emailaddress2)>
        </cfif>
        <cfif len(trim(getinfo.Rep3Emailaddress3))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep3Emailaddress3)>
        </cfif>
        <cfif len(trim(getinfo.Rep3Emailaddress4))>
            <cfset emailList = emailList & "," & trim(getinfo.Rep3Emailaddress4)>
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
	<span class="fontsize14">Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Recently we have been trying to reach you to see if your company would be interested in doing business with us.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We are a national Move Management company that has been in business for the last 30 years working with the Agents of major Van Lines and now, we are expanding our network of carriers to include small to midsize moving companies to help us with loading and hauling of medium to large shipments (3 to 5+ bedroom homes) out of the #trim(getinfo.MailingCounty)# area.<br><br></span>
	
	<div style="text-align:center"><strong style="text-decoration:underline" class="fontsize14">All move jobs will be priced out based on your own tariff rates and pricing.</strong></div>
	<br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)# has an interstate authority in good standing with the <i>FMCSA</i>, with low or no complaints, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you are interested in joining our network of carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>, and, we will email you a simple to sign <i>409 Agreement</i>. This agreement is required by the <i>FMCSA</i> in order to do business and receive moves from us.<br><br>
	<br><br>
	Sincerely<br><br><br>
	
	Anthony L. Booker<br>
	Carrier Relations & Business Development<br>
	Nationwide USA Movers<br>
	1-800-976-6833 Ext 4<br>
	
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
	<span class="fontsize14">Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Recently we have been trying to reach you to see if your company would be interested in doing business with us.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We are a national Move Management company that has been in business for the last 30 years working with the Agents of major Van Lines and now, we are expanding our network of carriers to include small to midsize moving companies to help us with loading and hauling of medium to large shipments (3 to 5+ bedroom homes) out of the #trim(getinfo.MailingCounty)# area.<br><br></span>
	
	<div style="text-align:center"><strong style="text-decoration:underline" class="fontsize14">All move jobs will be priced out based on your own tariff rates and pricing.</strong></div>
	<br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)# has an interstate authority in good standing with the <i>FMCSA</i>, with low or no complaints, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you are interested in joining our network of carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>, and, we will email you a simple to sign <i>409 Agreement</i>. This agreement is required by the <i>FMCSA</i> in order to do business and receive moves from us.<br><br>
	<br><br>
	Sincerely<br><br><br>
	
	Anthony L. Booker<br>
	Carrier Relations & Business Development<br>
	Nationwide USA Movers<br>
	1-800-976-6833 Ext 4<br>
	

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
    where send_type=10 and cust_hook=#clientid#
    </cfquery>
    <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into carrier_LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('11','2','#clientid#','#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into carrier_LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('10','2','#clientid#','#datenow#')
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
<form action="carrierEmailFollowup.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
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
<cfoutput>
		<span class="fontsize14">Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Recently we have been trying to reach you to see if your company would be interested in doing business with us.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We are a national Move Management company that has been in business for the last 30 years working with the Agents of major Van Lines and now, we are expanding our network of carriers to include small to midsize moving companies to help us with loading and hauling of medium to large shipments (3 to 5+ bedroom homes) out of the #trim(getinfo.MailingCounty)# area.<br><br></span>
	
	<div style="text-align:center"><strong style="text-decoration:underline" class="fontsize14">All move jobs will be priced out based on your own tariff rates and pricing.</strong></div>
	<br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)# has an interstate authority in good standing with the <i>FMCSA</i>, with low or no complaints, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you are interested in joining our network of carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>, and, we will email you a simple to sign <i>409 Agreement</i>. This agreement is required by the <i>FMCSA</i> in order to do business and receive moves from us.<br><br>
	<br><br>
	Sincerely<br><br><br>
	
	Anthony L. Booker<br>
	Carrier Relations & Business Development<br>
	Nationwide USA Movers<br>
	1-800-976-6833 Ext 4<br>
	
	</span>
</cfoutput>
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
