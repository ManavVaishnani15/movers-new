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
<cfsavecontent variable="REQUEST.letter_body">
    <cfoutput>
        <div class="fontsize14" style="padding-left:15px; padding-right:15px; line-height:1.3em;">
            Dear #trim(getinfo.first_name)# #trim(getinfo.last_name)# or Current Occupant,<br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            We've recently been in contact with your Realtor, 
            #trim(getinfo.realtor_name)# at 
            #trim(getinfo.realty_company)#. <br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            We are trying to contact you to set up a Free Virtual Move Estimate and get you moving discounts.  
            <br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Get your Quick & Easy Virtual Estimate & lock in your discounts before they expire.<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <div style="text-align:center;">
                Virtual Walkthroughs are simply & easily done by using your cell phone.<br><br>
            </div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Call us or go online and don't forget to mention or type in your personal 

            <b>Move Discount Code:</b><br> 
            <span class="fontbold colorred" style="text-decoration:underline;">#getinfo.discountCode#</span>.
        </div>

    </cfoutput>
</cfsavecontent>

<body>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="95">
		<cfinclude template="letter_templateNew.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="letter_templateNew.cfm">
</cfif>

</body>
</html>