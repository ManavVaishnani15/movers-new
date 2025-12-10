<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
            select * from CLIENTS
            where id=#clientid#
        </cfquery>
    </cfif>

    <style>
        .letterBody {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:21px;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:21px;
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
            font-size:19px;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        .logoImg {
            width: 175px;
        }
        .otherImg { width:185px; }
        @media print {
             .logoImg {
                width: 175px;
            }
            .otherImg {width: 185px;}
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
    select * from CLIENTS
    where id=#clientid#
</cfquery>

<cfsavecontent variable="REQUEST.letter_body">
    <cfoutput>
        <div class="fontsize14" style="padding-left:15px; padding-right:15px; line-height:1.3em;">

            Dear #trim(getinfo.first_name)# #trim(getinfo.last_name)# or Current Occupant,<br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            We've recently been in contact with your Realtor, 
            #trim(getinfo.realtor_name)# at 
            #trim(getinfo.realty_company)# and, since your home at 
            #trim(getinfo.FROM_ADDRESS)#<cfif trim(getinfo.FROM_ADDRESS2) NEQ ''>, #trim(getinfo.FROM_ADDRESS2)#</cfif> 
            just went under contract, we will be offering you huge moving discounts.<br><br>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Get your Quick & Easy Virtual Estimate & lock in your discounts before they expire.<br><br>
            
            <div style="text-align:center;">
                Virtual Walkthroughs are simply & easily done by using your cell phone.<br><br>
            </div>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Call us or go online and don't forget to mention or type in your personal 

            <b>Move Discount Code:</b> <br>
            <span class="fontbold colorred" style="text-decoration:underline;">#getinfo.discountCode#</span>.

        </div>

    </cfoutput>
</cfsavecontent>


<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="88">
		<cfinclude template="letter_templateNew.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="letter_templateNew.cfm">
</cfif>
