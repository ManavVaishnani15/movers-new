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
	<span class="fontsize13">Dear #trim(getinfo.repfirstname)# #trim(getinfo.replastname)# or #trim(getinfo.CompanyName)# Company Representative,<br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nationwide USA Movers is looking for carriers to help with hauling of local and interstate shipments for our Direct Marketing and National Account moves.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At Nationwide USA Movers we find, research and contract with accounts that do moving and relocation (i.e. Real Estate Associations, Corporations, Government Agencies etc). Our mission is to find moving jobs and pass them on to carriers in our network.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At this moment, we have a new account that has more than 200 moves coming out of the #trim(getinfo.MailingCounty)# County area and we are looking for carriers to help with hauling of shipments. These moves are mainly <i>3–4-bedroom homes with weights averaging 18,000 Lbs or 2600 cubic feet in size.</i><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All our moves are surveyed by an AMSA/ATA Certified Moving Consultant (to assure the accuracy of the estimate) and, we provide our carriers with videos of the surveyed homes together with complete moving information to help them pricing out the moves based on their own pricing.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Since your company, #trim(getinfo.CompanyName)#, has an interstate authority in good standing with the <i>FMCSA</i> with low or no complains, we would like to bring you on as one of our preferred carriers.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If interested in joining our network of carriers, please go online to www.carriermoving.jobs and fill out the quick and easy application form or directly call our Carrier Relations & Business Development Department at <strong>1-800-656-3620</strong>.<br><br>

After filling out the form or calling, <span style="text-decoration:underline">ask us to send you a demo video of an actual upcoming move</span>.
<br><br>
Sincerely<br><br><br>

Anthony L. Booker<br>
Carrier Relations & Business Development<br>
Nationwide USA Movers<br>
1-800-656-3620<br>

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