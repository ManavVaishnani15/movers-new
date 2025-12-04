<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
            select * from CLIENTS
            where id=#clientid#
        </cfquery>
    </cfif>
    <html>
<head>
        <title>
            <cfif parameterexists(clientid) is 'yes'>
                <cfoutput>#getinfo.first_name# #getinfo.last_name# Door Hanger</cfoutput>
            </cfif>
        </title> 
    <style>
        body {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:14px;
         /*   font-weight:bold;*/
            font-family:arial
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:19px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:17px;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.4em;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        @media print {
            body {
                font-family:arial;
            }
            .clientName {
                border-bottom: 1px solid black; font-size:1.4em;
            }
        }
    </style>
</head>
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
    select * from CLIENTS
    where id=#clientid#
</cfquery>

<!--- All CSS classes used here but definitions not found in this file can be found in the "letter_template.cfm" file --->
<cfsavecontent variable="REQUEST.letter_body" >
	<cfoutput>
	<span class="fontsize12">Dear #trim(getinfo.first_name)# #trim(getinfo.last_name)# or Current Occupant,<br><br>
    
Recently, we have been trying to reach you by mail to set up your FREE NO OBLIGATION MOVE ESTIMATE.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>NATIONWIDE USA MOVERS, your “ONE STOP SHOP” for estimates and moving quotes</strong> would
like to offer you a FREE-NO OBLIGATION MOVE ESTIMATE.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>NATIONWIDE USA MOVERS</strong> has access to over 7000 federally authorized, licensed and, insured
moving companies. We will find you highly reputable professional movers in your area and get you the
lowest and best prices. Also, you will only have to work with just one Certified Moving Consultant that
will perform a virtual walkthrough of your residence in 20 min or less and, will gather and send you a
variety of moving quotes all in one single email, without the bombarding calls from movers.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Call us or go online at <span class="colorblue text-underline">www.get-estimates.com</span> to set up your free Virtual Move Estimate as
soon as possible and use your Personal Promo Code: <span class="fontbold colorred text-underline">#getInfo.discountCode#</span> to lock in up to a 40% discount on
moving services.</strong><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We look forward to assisting you with your move and providing you with the best moving
companies and moving services in your area.
</span>
	</cfoutput>
</cfsavecontent>

<body>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="95">
		<cfinclude template="letter_templateFollowUp.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="letter_templateFollowUp.cfm">
</cfif>

</body>
</html>