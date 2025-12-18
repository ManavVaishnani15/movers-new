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

<cfif parameterexists(sendmail) is 'yes'>
    <cfset emailList = getinfo.email>
    <cfif parameterexists(sendEmailToAll) and sendEmailToAll eq '1'>
        <cfif len(trim(getinfo.email2))>
            <cfset emailList = emailList & "," & trim(getinfo.email2)>
        </cfif>
    </cfif>
    
    <!--- Set the letter body content for email --->
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
                                
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Virtual Walkthroughs are simply & easily done by using your cell phone.<br><br>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Call us or go online and don't forget to mention or type in your personal 

                <b>Move Discount Code:</b> 
                <span class="fontbold colorred" style="text-decoration:underline;">#getinfo.discountCode#</span>.

            </div>

        </cfoutput>
    </cfsavecontent>
    
    <!--- Generate email content using the template --->
    <cfsavecontent variable="emailContent">
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <body style="margin:0; padding:0; font-family:Calibri, sans-serif;">
            <div style="height:842px; width:700px; margin-left:auto; margin-right:auto; margin-top:0px;">
                <cfinclude template="letter_templateNew.cfm">
            </div>
        </body>
        </html>
    </cfsavecontent>
    
    <cfset finalEmailList = emailList>
    <cfif parameterexists(altmail) is 'yes'>
        <cfset finalEmailList = finalEmailList & "," & "move-quotes@nationwideusamovers.com">
    </cfif>
    
    <cfmail
        server="vps.affordableusamovers.com"
        username="customercare@nationwideusamovers.com" 
        password="Temp1707!" 
        port="587" 
        useSSL="false"
        TO="#finalEmailList#"
        FROM="customercare@nationwideusamovers.com"
        SUBJECT="Under Contract - Moving Discount Available"
        TYPE="HTML">
        #emailContent#
    </cfmail>

    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=1 and cust_hook=#clientid#
    </cfquery>
    <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
            insert into LETTER_SENDS
            (send_type,sent,cust_hook,sent_date)
            values ('2','2','#clientid#','#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
            insert into LETTER_SENDS
            (send_type,sent,cust_hook,sent_date)
            values ('1','2','#clientid#','#datenow#')
        </cfquery>
    </cfif>
    
    <div style="text-align:center; font-family:arial; padding:20px;">
        <h3>Mail Sent - Recorded that it was sent - You may now close this tab</h3>
        <cfif parameterexists(altmail) is 'yes'>
            <br><h3>Sent a copy to administrator</h3><br>
        </cfif>
    </div>
    <cfabort>
</cfif>

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
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Virtual Walkthroughs are simply & easily done by using your cell phone.<br><br>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Call us or go online and don't forget to mention or type in your personal 

            <b>Move Discount Code:</b> 
            <span class="fontbold colorred" style="text-decoration:underline;">#getinfo.discountCode#</span>.

        </div>

    </cfoutput>
</cfsavecontent>

<style>
    body {
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center; /* center horizontally */
    }

    .page-container {
        width: 700px;
        text-align: center;
        margin-top: 20px;
    }

    /* Mobile horizontal scroll */
    @media screen and (max-width: 768px) {
        body {
            overflow-x: auto;
            min-width: 700px;
        }
        
        .page-container {
            min-width: 700px;
        }
    }
</style>
<div class="page-container">
    <cfif parameterexists(emailit) is 'yes'>
        <form action="underContractLetter.cfm" method="post">
            <input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>">
            <input type="hidden" name="sendmail" value="1">
            <cfoutput>
                <input type="hidden" name="un" value="#un#">
                <input type="hidden" name="pw" value="#pw#">
            </cfoutput>
            <div align="center">
                <input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput> Now"><br>
                <input type="checkbox" name="sendEmailToAll" value="1"> Send email to Both<br>
                <input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself
            </div>
            <br>
        </form>
    </cfif>

    <cfif directPrint is 1>
        <cfdocument format="pdf"  orientation="portrait" scale="88">
            <cfinclude template="letter_templateNew.cfm">
        </cfdocument>
    <cfelse>
        <cfinclude template="letter_templateNew.cfm">
    </cfif>
</div>