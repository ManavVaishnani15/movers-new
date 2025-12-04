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
	<span class="fontsize13">Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)#.<br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We see that you are a Real Estate Agent at #trim(getinfo.CompanyName)# and you have a listing at #trim(getinfo.ListingAddress)#.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for real estate professionals in your area to create a durable partnership and assist with referring clients that are renting, selling or buying a property and need professional moving services.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We have in place a "Customer Referral Program" just for professionals in your line of work, 
where you can <span style="text-decoration:underline">earn referral fees for each and every referred customer that will be using our services 
for their move. Moreover, you have the opportunity to refer colleagues or friends as referral agents
and earn referral fees for every customer that they refer to us and uses our moving services.</span><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Interested in our "Customer Referral Program"? <br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please visit our website at <span style="color:blue;">www.nationwideusamovers.com</span>. "Click" on "Customer Referral 
Program" inside the blue button and fill out the quick and easy online form to sign up to our referral 
program for absolutely free. When signing up, type in your new assigned Agent Referral Code <span style="color:red;text-decoration:underline">#trim(getinfo.ReferralCode)#</span>
for granting discounts on moving to your referred clients.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is a federally licensed and FMCSA-authorized move manager and 
broker with more than 30 years of experience in the moving industry.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We have partnered with agents from the major Van Lines and 7000 other professionally licensed 
and insured moving companies nationwide to offer your clients that are renting, purchasing or selling a 
home, a variety of moving services all in one stop. All moves are virtually surveyed for accuracy and 
ease.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We will find quality movers at affordable prices and, manage your referred customers and clients' move from start to finish.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thank you for taking the time to read this letter. We look forward to starting a partnership with 
you and your company.<br><br>


Sincerely<br><br>

Anthony L. Booker<br>
Real Estate & Business Development<br>
Nationwide USA Movers<br>
1-800-922-1475<br>

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