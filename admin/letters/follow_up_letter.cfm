<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <html>
<head>
        <cfif parameterexists(clientid) is 'yes'>
            <cfquery name="getinfo" datasource="aaalh3x_onestep">
                select * from CLIENTS
where id=#clientid#
            </cfquery>
        </cfif>
        <html>
<head>
            <title><cfif parameterexists(clientid) is 'yes'>
                    <cfoutput>#getinfo.first_name# #getinfo.last_name# Follow Up Letter</cfoutput>
                </cfif></title> 
            <style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        font-size:14px;
    }
    .redHighlight {
        font-weight:bold;
        color:red;
        font-size:16px;
        text-decoration: underline;
    }
    .redHighlightDate {
        font-weight:bold;
        color:red;
        font-size:1.7em;
    }
    .blueHighlight {
        font-weight:bold;
        color:#489cdf;
        font-size:16px;
    }
    div{
        padding-top:10px;
    }
    .highlight {
        font-weight:bold;
        text-decoration: underline;
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
                    <input type="submit" value="Log In"></form>
                <cfabort>
                    <cfelse>
                        <cfquery name="verify" datasource="aaalh3x_onestep">
                            select * from MEMBERS
where username='#un#' and temp_pw=#pw# and active=1
                        </cfquery>
                        <cfif #verify.recordcount# is 0> <b>Log In</b>
                            <br>
                            <form action="main.cfm" method="post">
                                username
                                <input type="text" name="username" size="15">
                                <br>
                                password
                                <input type="password" name="password" size="15">
                                <br>
                                <input type="submit" value="Log In"></form>
                            <cfabort></cfif>
                        </cfif>
                        <cfquery name="getinfo" datasource="aaalh3x_onestep">
                            select * from CLIENTS
where id=#clientid#
                        </cfquery>
<body>
                        <cfif parameterexists(sendmail) is 'yes'>
                            <cfmail
TO="#getinfo.email#"
FROM="admin@top12movers.com"
SUBJECT="NEED A SUBJECT"
TYPE="HTML"
>
                                <style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        font-size:14px;
    }
    .redHighlight {
        font-weight:bold;
        color:red;
        font-size:16px;
        text-decoration: underline;
    }
    .redHighlightDate {
        font-weight:bold;
        color:red;
        font-size:1.7em;
    }
    .blueHighlight {
        font-weight:bold;
        color:##489cdf;
        font-size:16px;
    }
    .highlight {
        font-weight:bold;
        text-decoration: underline;
    }
    div{
        padding-top:10px;
    }
    </style>
                                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td valign="Middle">
                                            <div align="center">
                                                <img src="http://www.top12movingbiz.com/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0">
                                                <br>
                                                <img src="http://www.top12movingbiz.com/admin/letters/top12top.jpg" width="148" alt="" border="0">
                                                <br> <font size="2" face="arial"><b>Nationwide&nbsp;Moving&nbsp;Services</b></font> 
                                            </div>
                                        </td>
                                        <td align="right" width="100%" valign="middle"> <font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-weight:bold; font-family:arial; font-size:13px; padding-top:15px">
                                            "We get you the lowest price out of the Top 12 Nationwide Moving Carriers"
                                        </td>
                                    </tr>
                                </table>
                                <br>
                                <cfoutput>
                                    <div>Dear #getinfo.first_name# #getinfo.last_name#,
                                    </div>
                                    <div style="font-weight:bold;font-size:15px;">
                                    &nbsp;&nbsp;&nbsp;Don't forget that we have an appointment scheduled for you on
                                    <span class="redHighlight">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    We will be sending out a Certified Moving Consultant/Estimator that will be providing you with a
                                    free in home estimate and up to 12 free move quotes where we guarantee to get you up to 
                                    <span style="font-weight:bold;font-style: italic;">70% discount</span> on your
                                    State-to-State move from the Top 12 Nationwide Moving Carriers.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    The estimate normally takes 30 minutes <span style="font-style: italic">(just in and out no pressure selling)</span> 
                                    and your quotes will be emailed to you the same day.
                                </div>
                                <div >
                                    &nbsp;&nbsp;&nbsp;
                                    <span style="font-weight:bold">Don't miss this opportunity! Call our appointment line as soon as possible to lock in your
                                    discount and to provide us the best time for your free in home estimate.
                                </div>
                                <div>
                                     &nbsp;&nbsp;&nbsp;
                                    We look forward to assisting you with your move and providing you with the best and lowest priced move quotes.
                                </div>
                                    <div align="center" style="font-weight:bold;font-size:15px; line-height:23px; padding-top:0px;">
                                        
                                            <b>Your Free in Home Estimate for home selling at
                                                <br/> 
                                                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for
                                            </b><br/>
                                         <div class="redHighlightDate" style="padding: 5px 0">
                                            <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>
                                            <br>
                                        </div>
                                    </div>
                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <tr>
                                            <td valign="middle" width="100%">
                                                <div align="center" style="padding-top:0px; line-height:25px">
                                                    <div align="center" style="padding-top:0px;">
                                                        <b>Please Call Our Appointment Line
                                                            <br>
                                                            Monday Thru Saturday 7am-7pm
                                                            <br>
                                                            At
                                                            <span style="font-size:15px"><span class="blueHighlight" style="font-size:20px">1-800-289-5329</span></span><br />
                                                           to confirm and give us the best time for your FREE No Obligation Estimate!!!
                                                            <br><span style="font-size:15px">To Lock in Your Discount don't forget to mention your<br /></span>
                                                        </b>
                                                        <span class="redHighlight">Personal Discount Code #getInfo.discountCode#</span>
                                                    </div>
                                                    
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:25px">
                                            <tr>
                                                <td valign="top" width="100%">
                                                    <div style="float:right;width:200px; text-align:center;">
                                                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 75px; height:auto;" alt="Top 12 Movers BBB Business Review">
                                                    </div>
                                                    <font size="3">
                                                        <b>Local Offices:</b>
                                                         <div class="blueHighlight">
                                                            Virginia - 703-570-4232
                                                            <br>
                                                            Maryland - 301-235-9070
                                                            <br>
                                                            Washington DC - 202-729-8277
                                                            <br>Monday-Saturday 7am-7pm
                                                        </div>
                                                        <div style="font-weight:bold; padding-top:10px; font-size:12px"> 
                                                            ** Up to 70% discount guaranteed only through Top12Movers<br>
                                                            <span style="font-size:11px">** We get you Discounted Flat Price on local moves and storage (up to 40% savings)</span><br>
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
                                            ** Book through us and receive free box delivery service for self-pack moves
                                        </div>
                                        <div style="text-align:right; font-size: 12px;">
                                            MC ## 945837 USDOT ## 2867211 Authorized Broker
                                        </div>
                                        <br></cfoutput>

                                </cfmail>

                                <cfif parameterexists(altmail) is 'yes'>

                                    <cfmail
TO="#verify.email#"
FROM="admin@top12movers.com"
SUBJECT="NEED A SUBJECT"
TYPE="HTML"
>
                                        <style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        font-size:14px;
    }
    .redHighlight {
        font-weight:bold;
        color:red;
        font-size:16px;
        text-decoration: underline;
    }
    .redHighlightDate {
        font-weight:bold;
        color:red;
        font-size:1.7em;
    }
    .blueHighlight {
        font-weight:bold;
        color:##489cdf;
        font-size:16px;
    }
    div{
        padding-top:10px;
    }
    </style>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                            <tr>
                                                <td valign="Middle">
                                                    <div align="center">
                                                        <img src="http://www.top12movingbiz.com/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0">
                                                        <br>
                                                        <img src="http://www.top12movingbiz.com/admin/letters/top12top.jpg" width="148" alt="" border="0">
                                                        <br>
                                                        <font size="2" face="arial">
                                                            <b>Nationwide&nbsp;Moving&nbsp;Services</b>
                                                        </font>
                                                    </div>
                                                </td>
                                                <td align="right" width="100%" valign="middle">
                                                    <font face="arial" size="3">
                                                        <cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput>
                                                    </font>
                                                </td>
                                            </tr>
                                    <tr>
                                        <td colspan="2" style="font-weight:bold; font-family:arial; font-size:13px; padding-top:15px">
                                            "We get you the lowest price out of the Top 12 Nationwide Moving Carriers"
                                        </td>
                                    </tr>
                                        </table>
                                        <br>
                                   <cfoutput>
                                    <div>Dear #getinfo.first_name# #getinfo.last_name#,
                                    </div>
                                    <div style="font-weight:bold;font-size:15px;">
                                    &nbsp;&nbsp;&nbsp;Don't forget that we have an appointment scheduled for you on
                                    <span class="redHighlight">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    We will be sending out a Certified Moving Consultant/Estimator that will be providing you with a
                                    free in home estimate and up to 12 free move quotes where we guarantee to get you up to <span style="font-weight:bold;font-style: italic;">70% discount</span> on your
                                    State-to-State move from the Top 12 Nationwide Moving Carriers.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    The estimate normally takes 30 minutes <span style="font-style: italic">(just in and out no pressure selling)</span> 
                                    and your quotes will be emailed to you the same day.
                                </div>
                                <div >
                                    &nbsp;&nbsp;&nbsp;
                                    <span style="font-weight:bold">Don't miss this opportunity! Call our appointment line as soon as possible to lock in your
                                    discount and to provide us the best time for your free in home estimate.
                                </div>
                                <div>
                                     &nbsp;&nbsp;&nbsp;
                                    We look forward to assisting you with your move and providing you with the best and lowest priced move quotes.
                                </div>
                                    <div align="center" style="font-weight:bold;font-size:15px; line-height:23px; padding-top:0px;">
                                        
                                            <b>Your Free in Home Estimate for home selling at
                                                <br/> 
                                                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for
                                            </b><br/>
                                         <div class="redHighlightDate" style="padding: 5px 0">
                                            <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>
                                            <br>
                                        </div>
                                    </div>
                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <tr>
                                            <td valign="middle" width="100%">
                                                <div align="center" style="padding-top:0px; line-height:25px">
                                                    <div align="center" style="padding-top:0px;">
                                                        <b>Please Call Our Appointment Line
                                                            <br>
                                                            Monday Thru Saturday 7am-7pm
                                                            <br>
                                                            At
                                                            <span style="font-size:15px"><span class="blueHighlight" style="font-size:20px">1-800-289-5329</span></span><br />
                                                           to confirm and give us the best time for your FREE No Obligation Estimate!!!
                                                            <br><span style="font-size:15px">To Lock in Your Discount don't forget to mention your<br /></span>
                                                        </b>
<span class="redHighlight">Personal Discount Code #getInfo.discountCode#</span>
                                                    </div>
                                                    
                                                    
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:25px">
                                            <tr>
                                                <td valign="top" width="100%">
                                                    <div style="float:right;width:200px; text-align:center;">
                                                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 75px; height:auto;" alt="Top 12 Movers BBB Business Review">
                                                    </div>
                                                    <font size="3">
                                                        <b>Local Offices:</b>
                                                         <div class="blueHighlight">
                                                            Virginia - 703-570-4232
                                                            <br>
                                                            Maryland - 301-235-9070
                                                            <br>
                                                            Washington DC - 202-729-8277
                                                            <br>Monday-Saturday 7am-7pm
                                                        </div>
                                                        <div style="font-weight:bold; padding-top:10px; font-size:12px"> 
                                                            ** Up to 70% discount guaranteed only through Top12Movers<br>
                                                            <span style="font-size:11px">** We get you Discounted Flat Price on local moves and storage (up to 40% savings)</span><br>
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
                                            ** Book through us and receive free box delivery service for self-pack moves
                                        </div>

                                        <div style="text-align:right; font-size: 12px;">
                                            MC ## 945837 USDOT ## 2867211 Authorized Broker
                                        </div>
                                        <br></cfoutput>

                                        </cfmail>

                                    </cfif>

                                    <!--- check to see if this letter has already been sent --->
                                    <cfquery name="check_initial" datasource="aaalh3x_onestep">
                                        select * from LETTER_SENDS
where send_type=7 and cust_hook=#clientid#
                                    </cfquery>
                                    <cfif #check_initial.recordcount# is not 0>
                                        <!--- was already sent once --->
                                        <cfquery name="set_initial" datasource="aaalh3x_onestep">
                                            insert into LETTER_SENDS
(send_type,sent,cust_hook,sent_date)
values ('7','2','#clientid#','#datenow#')
                                        </cfquery>
                                        <cfelse>
                                            <cfquery name="set_initial" datasource="aaalh3x_onestep">
                                                insert into LETTER_SENDS
(send_type,sent,cust_hook,sent_date)
values ('6','2','#clientid#','#datenow#')
                                            </cfquery>
                                        </cfif>
                                        Mail Sent - Recorded - provide a close button
                                        <cfif parameterexists(altmail) is 'yes'>
                                            <br>
                                            Send a copy to administrator
                                            <br></cfif>

                                        <cfelse>
                                            <cfif parameterexists(emailit) is 'yes'>
                                                <form action="follow_up_letter.cfm" method="post">
                                                    <input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>
                                                ">
                                                <input type="hidden" name="sendmail" value="1">
                                                <cfoutput>
                                                    <input type="hidden" name="un" value="#un#">
                                                    <input type="hidden" name="pw" value="#pw#"></cfoutput>
                                                <div align="center">
                                                    <input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput>
                                                Now">
                                                <br>
                                                <input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>
                                            "> Check to send copy to yourself
                                        </div>
                                        <br></form>
                                </cfif>
                                <cfif #getinfo.appointment_date# is ''>
                                    <br>
                                    <div align="center">
                                        <font face="arial" size="4" color="red">
                                            <b>
                                                THIS PAGE SHOULD NOT BE PRINTED - THERE IS NO APPOINTMENT DATE SET YET
                                            </B>
                                        </FONT>
                                    </DIV>
                                    <br>
                                    <br></cfif>
                                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td valign="Middle">
                                            <div align="center">
                                                <img src="/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0">
                                                <br>
                                                <img src="/admin/letters/top12top.jpg" width="148" alt="" border="0">
                                                <br>
                                                <font size="2" face="arial">
                                                    <b>Nationwide&nbsp;Moving&nbsp;Services</b>
                                                </font>
                                            </div>
                                        </td>
                                        <td align="right" width="100%" valign="middle">
                                            <font face="arial" size="3">
                                                <cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput>
                                            </font>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="font-weight:bold; font-family:arial; font-size:13px; padding-top:15px">
                                            "We get you the lowest price out of the Top 12 Nationwide Moving Carriers"
                                        </td>
                                    </tr>
                                </table>
                                <font size="1">
                                    <br></font>
                                <cfoutput>
                                    <div>Dear #getinfo.first_name# #getinfo.last_name#,
                                    </div>
                                    <div style="font-weight:bold;font-size:15px;">
                                    &nbsp;&nbsp;&nbsp;Don't forget that we have an appointment scheduled for you on
                                    <span class="redHighlight">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    We will be sending out a Certified Moving Consultant/Estimator that will be providing you with a
                                    free in home estimate and up to 12 free move quotes where we guarantee to get you up to <span style="font-weight:bold;font-style: italic;">70% discount</span> on your
                                    State-to-State move from the Top 12 Nationwide Moving Carriers.
                                </div>
                                <div>
                                    &nbsp;&nbsp;&nbsp;
                                    The estimate normally takes 30 minutes <span style="font-style: italic">(just in and out no pressure selling)</span> 
                                    and your quotes will be emailed to you the same day.
                                </div>
                                <div >
                                    &nbsp;&nbsp;&nbsp;
                                    <span style="font-weight:bold">Don't miss this opportunity! Call our appointment line as soon as possible to lock in your
                                    discount and to provide us the best time for your free in home estimate.
                                </div>
                                <div>
                                     &nbsp;&nbsp;&nbsp;
                                    We look forward to assisting you with your move and providing you with the best and lowest priced move quotes.
                                </div>
                                    <div align="center" style="font-weight:bold;font-size:15px; line-height:23px; padding-top:0px;">
                                        
                                            <b>Your Free in Home Estimate for home selling at
                                                <br/> 
                                                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for
                                            </b><br/>
                                         <div class="redHighlightDate" style="padding: 5px 0">
                                            <b>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</b>
                                            <br>
                                        </div>
                                    </div>
                                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <tr>
                                            <td valign="middle" width="100%">
                                                <div align="center" style="padding-top:0px; line-height:25px">
                                                    <div align="center" style="padding-top:0px;">
                                                        <b>Please Call Our Appointment Line
                                                            <br>
                                                            Monday Thru Saturday 7am-7pm
                                                            <br>
                                                            At
                                                            <span style="font-size:15px"><span class="blueHighlight" style="font-size:20px">1-800-289-5329</span></span><br />
                                                            to confirm and give us the best time for your FREE No Obligation Estimate!!!
                                                            <br><span style="font-size:15px">To Lock in Your Discount don't forget to mention your<br /></span>
                                                        </b>
                                                        <span class="redHighlight">Personal Discount Code #getInfo.discountCode#</span>
                                                    </div>
                                                    
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:25px">
                                            <tr>
                                                <td valign="top" width="100%">
                                                    <div style="float:right;width:200px; text-align:center;">
                                                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 75px; height:auto;" alt="Top 12 Movers BBB Business Review">
                                                    </div>
                                                    <font size="3">
                                                        <b>Local Offices:</b>
                                                         <div class="blueHighlight">
                                                            Virginia - 703-570-4232
                                                            <br>
                                                            Maryland - 301-235-9070
                                                            <br>
                                                            Washington DC - 202-729-8277
                                                            <br>Monday-Saturday 7am-7pm
                                                        </div>
                                                        <div style="font-weight:bold; padding-top:10px; font-size:12px"> 
                                                            ** Up to 70% discount guaranteed only through Top12Movers<br>
                                                            <span style="font-size:11px">** We get you Discounted Flat Price on local moves and storage (up to 40% savings)</span><br>
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
                                            ** Book through us and receive free box delivery service for self-pack moves
                                        </div>

                                        <div style="text-align:right; font-size: 12px;">
                                            MC ## 945837 USDOT ## 2867211 Authorized Broker
                                        </div>
                                        <br></cfoutput>

                                </cfif>
</body>
                            </html>