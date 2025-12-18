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

    <style>
        .offerBody {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:20px;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:22px;
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
            font-size:20px;
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
                just received an offer, we will be offering you huge moving discounts.<br><br>
                
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
        <cfset finalEmailList = finalEmailList & "," & 'move-quotes@nationwideusamovers.com'>
    </cfif>
    
    <cfmail
        server="vps.affordableusamovers.com"
        username="customercare@nationwideusamovers.com" 
        password="Temp1707!" 
        port="587" 
        useSSL="false"
        TO="#finalEmailList#"
        FROM="customercare@nationwideusamovers.com"
        SUBJECT="Offer Received - Moving Discount Available"
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
            <br>Sent a copy to administrator<br>
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
            just received an offer, we will be offering you huge moving discounts.<br><br>
            
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

        <form action="offerLetter.cfm" method="post">
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

<!--- <cffunction name="printOfferLetter" returntype="string">
    <cfoutput>
        <div class="offerBody" style="font-family:arial">
            <div>
                <div style="float:right; padding-top: 60px">
                    <span style="font-size: 17px">#dateformat(now(), "MM/DD/YYYY")#</span>
                </div>
                <div >
                    <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:225px">
                </div>
            </div>
            
            <div style="padding-top:15px">
                 Dear #getinfo.first_name# #getinfo.last_name#,
            </div>

            <div style="padding-top:15px; font-style:italic;">
                We see that your home listed with <span style="font-weight:bold">#getinfo.realty_company#</span> just received an offer on 
                #dateformat(getinfo.contract_date, "MM/DD/YYYY")#. Congratulations!
            </div>
            
            <div style="padding-top:15px">
                Since your home is selling so fast, Affordable USA Movers is offering you a move quote! We guarantee to get you up to a 
                <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured brand-name&##174; and other quality nationwide moving carriers</span>. 
            </div>

            <div style="padding-top:15px">
                <span style="font-weight: bold">
                    Just mention your <span style="color: red">Realty Discount Code&##174; #getInfo.discountCode#</span> to get your discount when calling to confirm your appointment. 
                </span>
                Your free in-home or virtual tour/estimate of the household goods that you are planning to move is scheduled for 
                <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                Next, your personal Certified Moving Consultant/Estimator will work to find you, out of a variety of carriers, a quality and affordable moving company that will fit your needs and budget. The estimate normally takes 30 minutes and your quote will be emailed to you the same day.
            </div>

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold; line-height:22px">
                Your Free In-Home or Virtual Estimate for home selling at <br>
                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for <br />
                
                <span style="font-size: 1.4em; font-weight: bold; color: red;line-height: 40px">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
                Please Call Our Appointment Line Monday Thru Saturday 7am-7pm <br />
                At <span style="color:##489cdf; font-weight: bold;">1-800-289-5329</span> <br />
                or go to <span style="text-decoration:underline; color:##489cdf; font-weight: bold">www.affordableusamovers.com</span><br />
                to confirm, reschedule or set up an appointment time that works best for you<br />
                FREE No Obligation Estimate!!!<br />
                Evening and Weekend appointments available<br />
                 To Lock in Your Discount don't forget to mention your <br />
                 <span style="color: red; font-size:1.2em;">Realty Discount Code&##174; #getInfo.discountCode#</span>
            </div>

            <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:25px">
                <tr>
                    <td valign="top" width="100%">
                        <div style="float:right;width:200px; text-align:center;">
                            <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 75px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                        </div>
                        <font size="3">
                            <b>Local Offices:</b>
                             <div style="color:##489cdf; font-weight: bold; font-size: 0.8em">
                                Virginia - 703-570-4232
                                <br>
                                Maryland - 301-235-9070
                                <br>
                                Washington DC - 202-729-8277
                                <br>Monday-Saturday 7am-7pm
                            </div>
                            <div style="font-weight:bold; padding-top:10px; font-size:12px"> 
                                ** Up to a 70% discount off Tariff rates available only through Affordable USA Movers <br>
                                ** Discounts on local moves and storage (up to 40% savings) <br>
                                ** Discounted car transport
                            </div>
                    </td>
                    <td align="right" valign="top">
                        <div align="center">
                             <img src="http://www.top12movingbiz.com/admin/letters/3.jpg" width="185" alt="" border="0"></div>
                    </td>
                </tr>
            </table>
            <div style="font-weight:bold; text-decoration:underline; text-align:center; padding-top:25px;">
                ** Book through us and receive free box delivery service for self-pack moves <br/>
                 MC ## 945837 USDOT ## 2867211 Federally Authorized Broker
            </div>
        </div>
    </cfoutput>
</cffunction> --->