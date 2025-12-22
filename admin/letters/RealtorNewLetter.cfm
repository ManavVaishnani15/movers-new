<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from Realtor_Records
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
    select * from Realtor_Records
    where id = #clientID#
</cfquery>


<cfsavecontent variable="REQUEST.letter_body" >
	<cfoutput>
	<span class="fontsize14">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)#<br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thank you for joining Nationwide USA Movers "Realtor Relo Referral Program".<br>
<span style="display: block; margin-top:5px"></span>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;By joining our network of Real Estate professionals, you have also been automatically enrolled 
into our "Customer Referral Program". This program will bring you <span style="text-decoration:underline">Incoming Relocation Business</span> from 
our clients that are moving into your service areas. Our program will also allow you to earn "<span style="text-decoration:underline">Referral Fees</span>" every time you refer a client or anyone that needs moving services. In addition, you can refer other 
agents to join our network and earn referral fees from their ongoing customers referrals. - <br>
<span style="display: block; margin-top:5px"></span>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Earning referral fees is easy! <span style="text-decoration:underline">Just refer us to your clients for a free quick & easy Virtual Estimate</span>. 
If your customers decide to use our moving services for their move, you will automatically receive 
"Referral Fees" added directly to a personal <span style="text-decoration:underline">Referral Agent Debit Mastercard</span> that will be issued in the 
next 24-48hrs and, either emailed or mailed out via USPS or both. This Mastercard/Bank card will be 
used to deposit all your future move referral commissions. <br>
<span style="display: block; margin-top:5px"></span>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Our "Customer Referral Program" has advantages also for your clients & customers: Free Virtual 
Moving Estimate, move discounts, highly professional moving services, and a certified move coordinator 
available to the customers 7 days a week. All moves coordinated & managed from start to finish. <br>
<span style="display: block; margin-top:5px"></span>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For all your referrals, use your "Realtor Discount Code" <span style="color: red">[#getinfo.ReferralCode#]</span> that is on your Digital 
Move Discount card that was texted or emailed to you. This will also allow clients/customers to receive 
up to 40% Discounts on our moving services. <br><br>



Sincerely - <br>
<span style="display: block; margin-top:5px"></span>

Realtor Enrollment Team <br>
Nationwide USA Movers<br>
1-800-976-6833-Ext 3 <br><br>

</span>
	</cfoutput>
</cfsavecontent>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="100">
		<cfinclude template="realtorletter_template.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="realtorletter_template.cfm">
</cfif>