<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from Carrier_Records
    where id = #clientID#
        </cfquery>
    </cfif>

    <style>
    	table{
    		font-family:calibri;
    	}
        .closingLetter {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:16px;
            font-family: arial;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:18px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:navy;
        }
        .fontsize{
        	font-size:28px;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.4em;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.4em;
            }
        }
    </style>

<cfif parameterexists(un) is 'no'> <b>Log In</b>
    <br>
    <form action="main.cfm" method="post">
        username
        <input type="text" name="username" size="15">
        <br>
        password
        <input type="password" name="password" size="15">
        <br>
        <input type="submit" value="Log In">
    </form>
    <cfabort>
<cfelse>
    <cfquery name="verify" datasource="aaalh3x_onestep">
        select * from MEMBERS
        where username='#un#' and temp_pw=#pw# and active=1
    </cfquery>
    <cfif #verify.recordcount# is 0>
        <b>Log In</b>
        <br>
        <form action="main.cfm" method="post">
            username
            <input type="text" name="username" size="15">
            <br>
            password
            <input type="password" name="password" size="15">
            <br>
            <input type="submit" value="Log In">
        </form>
        <cfabort>
    </cfif>
</cfif>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from Carrier_Records
    where id = #clientID#
</cfquery>


<cfsavecontent variable="REQUEST.letter_body" >
	<cfoutput>
	<span class="fontsize14">Dear #trim(getinfo.repfirstname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
	    
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Recently we have been trying to reach you to see if your company would be interested in doing business with us.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We are a national Move Management company that has been in business for the last 30 years working with the Agents of major Van Lines and now, we are expanding our network of carriers to include small to midsize moving companies to help us with loading and hauling of medium to large shipments (3 to 5+ bedroom homes) out of the #trim(getinfo.MailingCounty)# area.<br><br></span>
	
	<div style="text-align:center"><strong style="text-decoration:underline" class="fontsize14">All move jobs will be priced out based on your own tariff rates and pricing.</strong></div>
	<br>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)# has an interstate authority in good standing with the <i>FMCSA</i>, with low or no complaints, we would like to bring you on as one of our Preferred Carriers.<br><br>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you are interested in joining our network of carriers, please go online to <a href="http://www.carriermovingjobs.com/">www.carriermovingjobs.com</a> and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-976-6833 Ext 4</strong>, and, we will email you a simple to sign <i>409 Agreement</i>. This agreement is required by the <i>FMCSA</i> in order to do business and receive moves from us.<br><br>
	<br>
	Sincerely<br><br><br>
	
	Anthony L. Booker<br>
	Carrier Relations & Business Development<br>
	Nationwide USA Movers<br>
	1-800-976-6833 Ext 4<br>

</span>
	</cfoutput>
</cfsavecontent>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="100">
		<cfinclude template="carrierletter_template.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="carrierletter_template.cfm">
</cfif>