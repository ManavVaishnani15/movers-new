<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
<cfparam name="directPrint" default="0" />

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
        .redHighlightNew {
            font-weight:bold;
            color:red;
            font-size:1.1em;
        }
        .blueHighlight {
            font-weight:bold;
            color:##489cdf;
        }
        .hangerDiv {
                width:50%;
                border:5px solid blue;
            }
        .hangerMainNew {
            padding-top:140px;
            text-align: center;
            font-family: arial;
            font-size: 13px;
        }
            div {
                font-weight:bold;
                font-size: 14px;
            }
        .vertFlip {
            -webkit-transform: rotate(180deg);
            -moz-transform: rotate(180deg);
            -o-transform: rotate(180deg);
            -ms-transform: rotate(180deg);
            transform: rotate(180deg);
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

<cfoutput>
<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="88">
        <style>
            .redHighlightNew {
                font-weight:bold;
                color:red;
                font-size:1.1em;
            }
            .blueHighlight {
                font-weight:bold;
                color:##489cdf;
            }
            .hangerDiv {
                width:50%;
                border:5px solid blue;
            }
            .hangerMainNew {
                padding-top:140px;
                text-align: center;
                font-family: arial;
                font-size: 14px;
            }
            div {
                font-weight:bold;
                font-size: 14px;
            }
            .vertFlip {
                -webkit-transform: rotate(180deg);
                -moz-transform: rotate(180deg);
                -o-transform: rotate(180deg);
                -ms-transform: rotate(180deg);
                transform: rotate(180deg);
            }
        </style>
    <table style="width:99%">
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                <div class="hangerMainNew">
                    <div >
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div style="width:80%; margin-left:auto; margin-right: auto;">
                        <div style="font-size:1.3em; font-weight: bold">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div style="font-size:0.8em">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>
                    <div style="padding-top:10px;font-size:1.2em;font-weight: bold;">
                        We hear you may need a moving company
                    </div>
                    <div>
                        Our Certified Moving Consultant will stop by on :<br>
                    </div>
                    <div style="font-size:1.7em; font-weight: bold;color: red; padding-top:10px;">
                        #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#
                    </div>

                    <div style="padding-top: 10px; line-height: 18px;">
                        Please call or go to <br/>
                        <span style="font-weight: bold; color:##489cdf;">www.affordableusamovers.com</span><br />
                        to confirm, reschedule, or set up<br />
                         an appointment time that works best for you<br />
                         Weekend and Evening appointments available
                    </div>

                    <div style="padding-top: 10px; text-decoration: underline; line-height: 18px;">
                        Fixed Flat Price and big discounts off the price of<br/>
                         your move with our Move Discount Program
                    </div>
                    <div style="padding-top:10px;font-size:1.5em;font-weight: bold;">
                        Name Your Own Price
                    </div>
                    <div style="padding-top:10px; line-height: 18px;">
                        <span style="font-size: 0.9em">Get the price that better suits your needs and budget</span><br/>
                        Mention your <span class="redHighlightNew">Personal Discount Code&##174;</span><br />
                        When calling or go on line to lock in your discount
                    </div>
                    <div style="text-align: left">
                        <div style="padding-top:0; margin-top:0px;">
                            <ul style="margin-bottom:8px;">
                                <li style="margin: 5px;">Up to 12 Free move quotes but only 1 Certified Moving Consultant</li>
                                <li style="margin: 5px;">Top major brand name&##174; moving companies and other A+ quality movers</li>
                                <li style="margin: 5px;">Free on-site and Virtual tour/estimate</li>
                                <li style="margin: 5px;">Discounted boxes and packing material available for pick up or delivery for self pack moves</li>
                                <li style="margin: 5px;">Discounted auto transport available</li>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <span class="redHighlightNew" style="font-size:1.1em;">PERSONAL DISCOUNT CODE&##174;</span>
                    </div>
                    <div class="redHighlightNew" style="font-size:1.7em; padding-top: 6px;">
                        #getInfo.discountCode#
                    </div>
                    
                    <div style="padding-top:15px; padding-bottom:15px; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329
                    </div>
                    <div style="text-decoration: underline; color: blue; padding-bottom: 15px;">
                        www.affordableusamovers.com
                    </div>
                </div>
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv" >
                <!--- #printHangerBack()# --->
                <div class="hangerMainNew" style="text-align:left">
                    <div style="text-align:center">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div >
                        Address:<br />
                        #getInfo.from_address#
                        <cfif getInfo.from_address2 is not "">
                            #getInfo.from_address2#<br>
                        </cfif>
                        #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Realty Company</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">#getinfo.realty_company#</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">% Savings on Local Moves/Storage </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px"> % Discount on State to State Moves </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Discount date</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Contract or offer received on</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Rental</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Initial Letter Mailed</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Follow up letter Mailed </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Representative</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Office Number</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>

                    <div style="width:100%; margin-left:auto; margin-right: auto; padding-top:20px; text-align: center; font-size:0.9em;">
                        Affordable USA Movers is a federally authorized<br />
                        Household Goods Moving Company MC##60880<br />
                         USDOT## 3070716 &amp; Moving Broker MC## 945837
                     </div>
                    
                    <div style="width:20%; margin-left:auto; margin-right: auto; padding-top:4px">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 50px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                    </div>

                    
                    <div style="padding-top:5px; padding-bottom:5px; text-align:center; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329 <br />
                       www.affordableusamovers.com
                    </div>
                    <div style="font-size:0.9em; text-align:center; ">
                        We bring you High-Quality Movers at Affordable Prices
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                <div class="hangerMainNew">
                    <div >
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div style="width:80%; margin-left:auto; margin-right: auto;">
                        <div style="font-size:1.3em; font-weight: bold">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div style="font-size:0.8em">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>
                    <div style="padding-top:10px;font-size:1.2em;font-weight: bold;">
                        We hear you may need a moving company
                    </div>
                    <div>
                        Our Certified Moving Consultant will stop by on :<br>
                    </div>
                    <div style="font-size:1.7em; font-weight: bold;color: red; padding-top:10px;">
                        #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#
                    </div>

                    <div style="padding-top: 10px; line-height: 18px;">
                        Please call or go to <br/>
                        <span style="font-weight: bold; color:##489cdf;">www.affordableusamovers.com</span><br />
                        to confirm, reschedule, or set up<br />
                         an appointment time that works best for you<br />
                         Weekend and Evening appointments available
                    </div>

                    <div style="padding-top: 10px; text-decoration: underline; line-height: 18px;">
                        Fixed Flat Price and big discounts off the price of<br/>
                         your move with our Move Discount Program
                    </div>
                    <div style="padding-top:10px;font-size:1.5em;font-weight: bold;">
                        Name Your Own Price
                    </div>
                    <div style="padding-top:10px; line-height: 18px;">
                        <span style="font-size: 0.9em">Get the price that better suits your needs and budget</span><br/>
                        Mention your <span class="redHighlightNew">Personal Discount Code&##174;</span><br />
                        When calling or go on line to lock in your discount
                    </div>
                    <div style="text-align: left">
                        <div style="padding-top:0; margin-top:0px;">
                            <ul style="margin-bottom:8px;">
                                <li style="margin: 5px;">Up to 12 Free move quotes but only 1 Certified Moving Consultant</li>
                                <li style="margin: 5px;">Top major brand name&##174; moving companies and other A+ quality movers</li>
                                <li style="margin: 5px;">Free on-site and Virtual tour/estimate</li>
                                <li style="margin: 5px;">Discounted boxes and packing material available for pick up or delivery for self pack moves</li>
                                <li style="margin: 5px;">Discounted auto transport available</li>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <span class="redHighlightNew" style="font-size:1.1em;">PERSONAL DISCOUNT CODE&##174;</span>
                    </div>
                    <div class="redHighlightNew" style="font-size:1.7em; padding-top: 6px;">
                        #getInfo.discountCode#
                    </div>
                    
                    <div style="padding-top:15px; padding-bottom:15px; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329
                    </div>
                    <div style="text-decoration: underline; color: blue; padding-bottom: 15px;">
                        www.affordableusamovers.com
                    </div>
                </div>
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv" >
                <!--- #printHangerBack()# --->
                <div class="hangerMainNew" style="text-align:left">
                    <div style="text-align:center">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div >
                        Address:<br />
                        #getInfo.from_address#
                        <cfif getInfo.from_address2 is not "">
                            #getInfo.from_address2#<br>
                        </cfif>
                        #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Realty Company</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">#getinfo.realty_company#</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">% Savings on Local Moves/Storage </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px"> % Discount on State to State Moves </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Discount date</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Contract or offer received on</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Rental</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Initial Letter Mailed</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Follow up letter Mailed </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Representative</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Office Number</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>

                    <div style="width:100%; margin-left:auto; margin-right: auto; padding-top:20px; text-align: center; font-size:0.9em;">
                        Affordable USA Movers is a federally authorized<br />
                        Household Goods Moving Company MC##60880<br />
                         USDOT## 3070716 &amp; Moving Broker MC## 945837
                     </div>
                    
                    <div style="width:20%; margin-left:auto; margin-right: auto; padding-top:4px">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 50px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                    </div>

                    
                    <div style="padding-top:5px; padding-bottom:5px; text-align:center; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329 <br />
                       www.affordableusamovers.com
                    </div>
                    <div style="font-size:0.9em; text-align:center; ">
                        We bring you High-Quality Movers at Affordable Prices
                    </div>
                </div>
            </td>
        </tr>
    </table>
    </cfdocument>
<cfelse>
    <table style="width:99%">
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                <div class="hangerMainNew">
                    <div >
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div style="width:80%; margin-left:auto; margin-right: auto;">
                        <div style="font-size:1.3em; font-weight: bold">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div style="font-size:0.8em">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>
                    <div style="padding-top:10px;font-size:1.2em;font-weight: bold;">
                        We hear you may need a moving company
                    </div>
                    <div>
                        Our Certified Moving Consultant will stop by on :<br>
                    </div>
                    <div style="font-size:1.7em; font-weight: bold;color: red; padding-top:10px;">
                        #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#
                    </div>

                    <div style="padding-top: 10px; line-height: 18px;">
                        Please call or go to <br/>
                        <span style="font-weight: bold; color:##489cdf;">www.affordableusamovers.com</span><br />
                        to confirm, reschedule, or set up<br />
                         an appointment time that works best for you<br />
                         Weekend and Evening appointments available
                    </div>

                    <div style="padding-top: 10px; text-decoration: underline; line-height: 18px;">
                        Fixed Flat Price and big discounts off the price of<br/>
                         your move with our Move Discount Program
                    </div>
                    <div style="padding-top:10px;font-size:1.5em;font-weight: bold;">
                        Name Your Own Price
                    </div>
                    <div style="padding-top:10px; line-height: 18px;">
                        <span style="font-size: 0.9em">Get the price that better suits your needs and budget</span><br/>
                        Mention your <span class="redHighlightNew">Personal Discount Code&##174;</span><br />
                        When calling or go on line to lock in your discount
                    </div>
                    <div style="text-align: left">
                        <div style="padding-top:0; margin-top:0px;">
                            <ul style="margin-bottom:8px;">
                                <li style="margin: 5px;">Up to 12 Free move quotes but only 1 Certified Moving Consultant</li>
                                <li style="margin: 5px;">Top major brand name&##174; moving companies and other A+ quality movers</li>
                                <li style="margin: 5px;">Free on-site and Virtual tour/estimate</li>
                                <li style="margin: 5px;">Discounted boxes and packing material available for pick up or delivery for self pack moves</li>
                                <li style="margin: 5px;">Discounted auto transport available</li>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <span class="redHighlightNew" style="font-size:1.1em;">PERSONAL DISCOUNT CODE&##174;</span>
                    </div>
                    <div class="redHighlightNew" style="font-size:1.7em; padding-top: 6px;">
                        #getInfo.discountCode#
                    </div>
                    
                    <div style="padding-top:8px; padding-bottom:10px; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329
                    </div>
                    <div style="text-decoration: underline; color: blue; padding-bottom: 10px;">
                        www.affordableusamovers.com
                    </div>
                </div>
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv" >
                <!--- #printHangerBack()# --->
                <div class="hangerMainNew" style="text-align:left">
                    <div style="text-align:center">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div >
                        Address:<br />
                        #getInfo.from_address#
                        <cfif getInfo.from_address2 is not "">
                            #getInfo.from_address2#<br>
                        </cfif>
                        #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Realty Company</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">#getinfo.realty_company#</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">% Savings on Local Moves/Storage </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px"> % Discount on State to State Moves </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Discount date</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Contract or offer received on</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Rental</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Initial Letter Mailed</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Follow up letter Mailed </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Representative</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Office Number</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>

                    <div style="width:100%; margin-left:auto; margin-right: auto; padding-top:20px; text-align: center; font-size:0.9em;">
                        Affordable USA Movers is a federally authorized<br />
                        Household Goods Moving Company MC##60880<br />
                         USDOT## 3070716 &amp; Moving Broker MC## 945837
                     </div>
                    
                    <div style="width:20%; margin-left:auto; margin-right: auto; padding-top:4px">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 50px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                    </div>

                    
                    <div style="padding-top:5px; padding-bottom:5px; text-align:center; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329 <br />
                       www.affordableusamovers.com
                    </div>
                    <div style="font-size:0.9em; text-align:center; ">
                        We bring you High-Quality Movers at Affordable Prices
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                <div class="hangerMainNew">
                    <div >
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div style="width:80%; margin-left:auto; margin-right: auto;">
                        <div style="font-size:1.3em; font-weight: bold">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div style="font-size:0.8em">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>
                    <div style="padding-top:10px;font-size:1.2em;font-weight: bold;">
                        We hear you may need a moving company
                    </div>
                    <div>
                        Our Certified Moving Consultant will stop by on :<br>
                    </div>
                    <div style="font-size:1.7em; font-weight: bold;color: red; padding-top:10px;">
                        #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#
                    </div>

                    <div style="padding-top: 10px; line-height: 18px;">
                        Please call or go to <br/>
                        <span style="font-weight: bold; color:##489cdf;">www.affordableusamovers.com</span><br />
                        to confirm, reschedule, or set up<br />
                         an appointment time that works best for you<br />
                         Weekend and Evening appointments available
                    </div>

                    <div style="padding-top: 10px; text-decoration: underline; line-height: 18px;">
                        Fixed Flat Price and big discounts off the price of<br/>
                         your move with our Move Discount Program
                    </div>
                    <div style="padding-top:10px;font-size:1.5em;font-weight: bold;">
                        Name Your Own Price
                    </div>
                    <div style="padding-top:10px; line-height: 18px;">
                        <span style="font-size: 0.9em">Get the price that better suits your needs and budget</span><br/>
                        Mention your <span class="redHighlightNew">Personal Discount Code&##174;</span><br />
                        When calling or go on line to lock in your discount
                    </div>
                    <div style="text-align: left">
                        <div style="padding-top:0; margin-top:0px;">
                            <ul style="margin-bottom:8px;">
                                <li style="margin: 5px;">Up to 12 Free move quotes but only 1 Certified Moving Consultant</li>
                                <li style="margin: 5px;">Top major brand name&##174; moving companies and other A+ quality movers</li>
                                <li style="margin: 5px;">Free on-site and Virtual tour/estimate</li>
                                <li style="margin: 5px;">Discounted boxes and packing material available for pick up or delivery for self pack moves</li>
                                <li style="margin: 5px;">Discounted auto transport available</li>
                            </ul>
                        </div>
                    </div>
                    <div>
                        <span class="redHighlightNew" style="font-size:1.1em;">PERSONAL DISCOUNT CODE&##174;</span>
                    </div>
                    <div class="redHighlightNew" style="font-size:1.7em; padding-top: 6px;">
                        #getInfo.discountCode#
                    </div>
                    
                    <div style="padding-top:8px; padding-bottom:10px; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329
                    </div>
                    <div style="text-decoration: underline; color: blue; padding-bottom: 10px;">
                        www.affordableusamovers.com
                    </div>
                </div>
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv" >
                <!--- #printHangerBack()# --->
                <div class="hangerMainNew" style="text-align:left">
                    <div style="text-align:center">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
                    </div>
                    
                    <div >
                        Address:<br />
                        #getInfo.from_address#
                        <cfif getInfo.from_address2 is not "">
                            #getInfo.from_address2#<br>
                        </cfif>
                        #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Realty Company</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">#getinfo.realty_company#</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">% Savings on Local Moves/Storage </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px"> % Discount on State to State Moves </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Discount date</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Contract or offer received on</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Rental</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Initial Letter Mailed</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Follow up letter Mailed </span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Representative</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>
                    <div style="padding-top:10px">
                        <span style="padding-left:30px">Local Office Number</span>
                        <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
                        <br/>
                        <span style="padding-left:42px">___________________________</span>
                    </div>

                    <div style="width:100%; margin-left:auto; margin-right: auto; padding-top:20px; text-align: center; font-size:0.9em;">
                        Affordable USA Movers is a federally authorized<br />
                        Household Goods Moving Company MC##60880<br />
                         USDOT## 3070716 &amp; Moving Broker MC## 945837
                     </div>
                    
                    <div style="width:20%; margin-left:auto; margin-right: auto; padding-top:4px">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 50px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                    </div>

                    
                    <div style="padding-top:5px; padding-bottom:5px; text-align:center; font-size: 1.4em" class="blueHighlight">
                       PHONE 1-800-289-5329 <br />
                       www.affordableusamovers.com
                    </div>
                    <div style="font-size:0.9em; text-align:center; ">
                        We bring you High-Quality Movers at Affordable Prices
                    </div>
                </div>
            </td>
        </tr>
    </table>
</cfif>
</cfoutput>

</body>
</html>
<!---
<cffunction name="printHangerNew" returntype="string">
    <cfoutput>
    <div class="hangerMainNew">
        <div >
            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
        </div>
        
        <div style="width:80%; margin-left:auto; margin-right: auto;">
            <div style="font-size:1.3em; font-weight: bold">
                #getinfo.first_name# #getinfo.last_name#
            </div>
            <div style="font-size:0.8em">
                OR CURRENT OCCUPANT
            </div>
        </div>
        <div style="padding-top:20px;font-size:1.1em;font-weight: bold;">
            We hear that you may be in need of a moving company
        </div>
        <div>
            We have scheduled an appointment for you with a 
            <br>Certified Moving Consultant on :<br>
            <span style="font-size:1.4em; font-weight: bold">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>
        </div>

        <div>
            Please call or go to <br/>
            <span style="font-weight: bold; color:##489cdf;">www.affordableusamovers.com</span><br />
            to confirm, reschedule or set up an<br />
             appointment time that works best for you<br />
             Weekend and Evening appointments available
        </div>
        <div>
            Mention your <span class="redHighlightNew">Realty Discount Code&##174;</span><br />
            When calling or go on line to lock in your discount**
        </div>
        <div style="text-align: left">
            <div style="font-size:0.8em; padding-top:8px">
                ** Up to a 70% discount on Tariff rates on out of State moves <br />
                ** Up to 40% savings on local moves and storage
            </div>

            <div style="padding-top:0; margin-top:0px">
                <ul style="margin-bottom:5px">
                    <li>Hundreds of federally authorized brand-name&##174; and other quality nationwide moving carriers </li>
                    <li>Free on-site and Virtual tour/estimate </li>
                    <li>Free move quotes emailed to you the same day </li>
                    <li>Only interact with one Professional Certified Moving Consultant </li>
                    <li>Free boxes and packing material delivered on self pack moves when booking through us </li>
                    <li>Walkthroughs only takes 30 minutes </li>
                    <li>Discounted auto transport available</li>
                </ul>
            </div>
        </div>
        <div>
            <span class="redHighlightNew" style="font-size:1em;">REALTY DISCOUNT CODE&##174;</span>
        </div>
        <div style="font-size:1.4em; padding-top:10px">
            #getInfo.discountCode#
        </div>
        
        <div style="padding-top:10px; padding-bottom:10px" class="blueHighlight">
           PHONE 1-800-289-5329 <br />
           www.affordableusamovers.com
        </div>
        <div style="font-size:0.7em">
            We will work to get you a quality moving company <br/>at an affordable price that will fit your needs and budget
        </div>
    </div>
    </cfoutput>
</cffunction>


<cffunction name="printHangerBack" returntype="string">
    <cfoutput>
    <div class="hangerMainNew" style="text-align:left">
        <div style="text-align:center">
            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
        </div>
        
        <div >
            Address:<br />
            #getInfo.from_address#
            <cfif getInfo.from_address2 is not "">
                #getInfo.from_address2#<br>
            </cfif>
            #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Realty Company</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">#getinfo.realty_company#</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">% Savings on Local Moves/Storage </span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px"> % Discount on State to State Moves </span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Discount date</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Contract or offer received on</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Rental</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Initial Letter Mailed</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Follow up letter Mailed </span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Local Representative</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>
        <div style="padding-top:10px">
            <span style="padding-left:30px">Local Office Number</span>
            <img src="http://www.top12movingbiz.com/admin/letters/images/checkbox.png" style="width: 12px; float: left; margin-top:2px; " />
            <br/>
            <span style="padding-left:42px">___________________________</span>
        </div>

        <div style="font-size:0.9em; padding-top:21px">
            Affordable USA Movers is a federally authorized Household Goods Moving Broker<br/>
            MC## 945837 
            USDOT ## 2867211
        </div>
        <div style="width:20%; margin-left:auto; margin-right: auto; padding-top:10px">
            <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 50px; height:auto;" alt="Affordable USA Movers BBB Business Review">
        </div>

        
        <div style="padding-top:20px; padding-bottom:10px; text-align:center;" class="blueHighlight">
           PHONE 1-800-289-5329 <br />
           www.affordableusamovers.com
        </div>
        <div style="font-size:0.7em; text-align:center; ">
            We will work to get you a quality moving company <br/>at an affordable price that will fit your needs and budget
        </div>
    </div>
    </cfoutput>
</cffunction>
--->