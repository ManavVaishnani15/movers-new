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
            font-size:17px;
            font-weight:bold;
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

<body>

<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="95">
        <cfoutput>
            <table style="width:99%">
                <tr>
                    <td>
                        <div style="font-family:arial">
                            <div>
                                <div style="float:right; padding-top: 60px">
                                    <span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span>
                                </div>
                                <div >
                                    <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:175px">
                                </div>
                            </div>
                            
                            <div style="padding-top:15px">
                                 Dear #getinfo.first_name# #getinfo.last_name#,
                            </div>

                            <div style="padding-top:15px; font-weight: bold">
                                Don't forget that your free in-home or Virtual tour/estimate of the household goods that you are planning to move is scheduled for 
                                <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                            </div>
                            
                            <div style="padding-top:15px">
                                Your assigned Certified Moving Consultant/Estimator will either come out to do an on-site estimate or set up a time to do a 
                                Virtual Walkthrough/Survey. Affordable USA Movers will provide you a move quote guaranteed to get you up to a 
                                <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                                 on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured 
                                 <span style="font-style:italic;">brand-name&##174;</span> and <span style="font-style:italic;">other quality</span> nationwide moving carriers</span>. 
                                 The estimate normally takes only 30 minutes and your quote will be emailed to you the same day.
                            </div>

                            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold; line-height:25px">
                                Your Free In-Home or Virtual Estimate for home selling at
                                <div >
                                    <span style="text-decoration:underline; padding-top:12px">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for 
                                </div>
                                
                                <span style="font-size: 1.5em; font-weight: bold; color: red; line-height: 50px;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
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
                                             <div style="color:##489cdf; font-weight: bold; font-size: 0.9em">
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
                    </td>
                </tr>
            </table>    
        </cfoutput>
    </cfdocument>
    
<cfelse>
    <cfoutput>
        <table style="width:99%">
            <tr>
                <td>
                    <div style="font-family:arial">
                        <div>
                            <div style="float:right; padding-top: 60px">
                                <span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span>
                            </div>
                            <div >
                                <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:175px">
                            </div>
                        </div>
                        
                        <div style="padding-top:15px">
                             Dear #getinfo.first_name# #getinfo.last_name#,
                        </div>

                        <div style="padding-top:15px; font-weight: bold">
                            Don't forget that your free in-home or Virtual tour/estimate of the household goods that you are planning to move is scheduled for 
                            <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                        </div>
                        
                        <div style="padding-top:15px">
                            Your assigned Certified Moving Consultant/Estimator will either come out to do an on-site estimate or set up a time to do a 
                            Virtual Walkthrough/Survey. Affordable USA Movers will provide you a move quote guaranteed to get you up to a 
                            <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                             on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured 
                             <span style="font-style:italic;">brand-name&##174;</span> and <span style="font-style:italic;">other quality</span> nationwide moving carriers</span>. 
                             The estimate normally takes only 30 minutes and your quote will be emailed to you the same day.
                        </div>

                        <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold; line-height:25px">
                            Your Free In-Home or Virtual Estimate for home selling at
                            <div >
                                <span style="text-decoration:underline; padding-top:12px">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for 
                            </div>
                            
                            <span style="font-size: 1.5em; font-weight: bold; color: red; line-height: 50px;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
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
                                         <div style="color:##489cdf; font-weight: bold; font-size: 0.9em">
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
                </td>
            </tr>
        </table>    
    </cfoutput>
</cfif>

</body>
</html>

<!---
<cffunction name="printFULetter" returntype="string">
    <cfoutput>
        <div style="font-family:arial">
            <div>
                <div style="float:right; padding-top: 60px">
                    <span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span>
                </div>
                <div >
                    <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:175px">
                </div>
            </div>
            
            <div style="padding-top:15px">
                 Dear #getinfo.first_name# #getinfo.last_name#,
            </div>

            <div style="padding-top:15px; font-weight: bold">
                Don't forget that your free in-home or Virtual tour/estimate of the household goods that you are planning to move is scheduled for 
                <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
            </div>
            
            <div style="padding-top:15px">
                Your assigned Certified Moving Consultant/Estimator will either come out to do an on-site estimate or set up a time to do a 
                Virtual Walkthrough/Survey. Affordable USA Movers will provide you a move quote guaranteed to get you up to a 
                <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                 on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured 
                 <span style="font-style:italic;">brand-name&##174;</span> and <span style="font-style:italic;">other quality</span> nationwide moving carriers</span>. 
                 The estimate normally takes only 30 minutes and your quote will be emailed to you the same day.
            </div>

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold; line-height:25px">
                Your Free In-Home or Virtual Estimate for home selling at
                <div >
                    <span style="text-decoration:underline; padding-top:12px">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for 
                </div>
                
                <span style="font-size: 1.5em; font-weight: bold; color: red; line-height: 50px;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
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
                             <div style="color:##489cdf; font-weight: bold; font-size: 0.9em">
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
</cffunction>
--->