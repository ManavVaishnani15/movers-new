<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
            select * from CLIENTS
            where id=#clientid#
        </cfquery>
    </cfif>



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

<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="95">
        <style>
            .flyerBody {
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                font-size:19px;
                font-family: arial, helvetica;
                font-weight:bold;
            }
            .redHighlightFlyer {
                font-weight:bold;
                color:red;
            }
            .blueHighlightFlyer {
                font-weight:bold;
                color:#489cdf;
            }
            
            .flyerDiv {
                font-weight:bold;
            }
            .flyerTd {
                font-weight: bold;
                font-size:19px;
                width: 50%;
            }
            .rightRotate {
                -ms-transform: rotate(90deg); /* IE 9 */
                -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
                transform: rotate(90deg);
            }
        </style>
    <div class="flyerBody">
    <cfoutput>
        <table style="width:875px">
            <tr>
                <td class="flyerTd">
                    <table>
                <tr>
                    <td class="flyerTd" style="vertical-align: top; line-height:25px;">
                        <div style="float:right; text-align:center; margin-top:40px; margin-right:20px;">
                                <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.jpg" style="border: 0;width: 45px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                        </div>
                        <div>
                            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:250px">
                        </div>
                        <div>
                            At Affordable USA Movers, we make your moving experience simple and easy. 
                        </div>
                        <div style="padding-top: 12px">
                            We find quality movers at affordable prices out of a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured 
                            brand-name&##174; and other quality nationwide moving carriers</span>.
                        </div>
                        <div style="padding-top: 12px">
                            <span style="font-style:italic;">The great thing about Affordable USA Movers is that you only have to interact with one Certified Moving Consultant</span>
                            that will work to find, out of a variety of carriers, an affordable moving company to fit your budget and needs. 
                        </div>
                        <div style="padding-top: 12px">
                            Whether you move locally, state-to-state or internationally, just relax and enjoy: we will take care of all your relocation needs!
                        </div>
                        <div style="padding-top: 20px; text-align:center;">
                            <img src="/admin/letters/images/Attachment-1.jpeg"  border="0" style="width:310px">
                        </div>

                        <div style="border:5px dashed ##223266; padding: 10px; text-align:center; line-height:17px; margin-top:40px" class="flyerDiv">                        
                            #getinfo.first_name# #getinfo.last_name#<br>
                            or Current Resident<br>
                            #getInfo.from_address#
                            <cfif getInfo.from_address2 is not "">
                                , #getInfo.from_address2#
                            </cfif>
                            <br />
                            #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#<br>
                            <div style="padding-top:12px; font-size:15px" class="redHighlightFlyer flyerDiv">
                                Mention Your<br>
                                Realty Discount Code&##174;<br>
                                #getInfo.discountCode#<br>
                                <span style="font-size:13.5px">
                                    For up to a 70% discount off Tariff rates on out of State moves, 40% savings on local moves and storage and Free box delivery service
                                </span>
                            </div>
                            <div class="flyerDiv" style="padding-top: 12px">
                                <span class="blueHighlightFlyer">www.affordableusamovers.com</span><br>
                                <span class="redHighlightFlyer">Call us now 1-800-289-5329</span>
                            </div>
                        </div>

                        <div style="font-size: 0.65em; text-align:center; padding-top:10px;">
                            MC ## 945837 USDOT ## 2867211 Federally Authorized Broker
                        </div>
                    </td>

                    <td class="flyerTd"  style="vertical-align: top; padding-top:20px;">
                        <img src="/admin/letters/images/OJP0023229.jpg"  border="0" style="width:340px; padding-left: 20px">
                        <div style="padding-top: 20px">
                            <ul style="line-height:30px;">
                                <li>
                                    <span class="blueHighlightFlyer">Quality movers at affordable prices</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Up to a 70% discount off Tariff rates on out-of-state moves</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Up to 40% savings on local moves and storage</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Discounted car transport</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Only 1 Professional Certified Moving Consultant</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Free On-site or Virtual tour/estimate available</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Evening and Weekend appointments available</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Free Move Quote emailed the same day</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Packing supplies and box delivery available</span>
                                </li>
                            </ul>
                        </div>
                        <div style="padding-top: 20px">
                            <img src="/admin/letters/images/Attachment-2.jpeg"  border="0" style="width:340px; padding-left:20px">
                        </div>
                        <div class="flyerDiv" style="padding-top:15px; line-height:20px; font-size:0.9em; margin-left: 120px; ">
                            LOCAL OFFICES: <br />
                            <span class="blueHighlightFlyer">
                                Virginia-703-570-4232; <br />
                                Maryland-301-235-9070;  <br />
                                Washington DC-202-729-8277  <br />
                                Monday-Saturday 7am-7pm
                            </span>
                        </div>
                    </td>
                </tr>
                
            </table>


                </td>
            </tr>
        </table>    
    </cfoutput>
    </div>
    </cfdocument>
<cfelse>
        <style>
            .flyerBody {
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                font-size:19px;
                font-family: arial, helvetica;
                font-weight:bold;
            }
            .redHighlightFlyer {
                font-weight:bold;
                color:red;
            }
            .blueHighlightFlyer {
                font-weight:bold;
                color:#489cdf;
            }
            
            .flyerDiv {
                font-weight:bold;
            }
            .flyerTd {
                font-weight: bold;
                font-size:19px;
                width: 50%;
            }
            .rightRotate {
                -ms-transform: rotate(90deg); /* IE 9 */
                -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
                transform: rotate(90deg);
            }
        </style>
    <div class="flyerBody">
    <cfoutput>
        <table style="width:875px">
            <tr>
                <td class="flyerTd" style="vertical-align: top; line-height:25px;">
                        <div style="float:right; text-align:center; margin-top:40px; margin-right:20px;">
                                <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.jpg" style="border: 0;width: 45px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                        </div>
                        <div>
                            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:250px">
                        </div>
                        <div>
                            At Affordable USA Movers, we make your moving experience simple and easy. 
                        </div>
                        <div style="padding-top: 12px">
                            We find quality movers at affordable prices out of a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured 
                            brand-name&##174; and other quality nationwide moving carriers</span>.
                        </div>
                        <div style="padding-top: 12px">
                            <span style="font-style:italic;">The great thing about Affordable USA Movers is that you only have to interact with one Certified Moving Consultant</span>
                            that will work to find, out of a variety of carriers, an affordable moving company to fit your budget and needs. 
                        </div>
                        <div style="padding-top: 12px">
                            Whether you move locally, state-to-state or internationally, just relax and enjoy: we will take care of all your relocation needs!
                        </div>
                         <div style="padding-top: 20px; text-align:center;">
                            <img src="/admin/letters/images/Attachment-1.jpeg"  border="0" style="width:310px">
                        </div>

                        <div style="border:5px dashed ##223266; padding: 10px; text-align:center; line-height:17px; margin-top:40px" class="flyerDiv">                        
                            #getinfo.first_name# #getinfo.last_name#<br>
                            or Current Resident<br>
                            #getInfo.from_address#
                            <cfif getInfo.from_address2 is not "">
                                , #getInfo.from_address2#
                            </cfif>
                            <br />
                            #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#<br>
                            <div style="padding-top:12px; font-size:14px" class="redHighlightFlyer flyerDiv">
                                Mention Your<br>
                                Realty Discount Code&##174;<br>
                                #getInfo.discountCode#<br>
                                <span style="font-size:11.5px">
                                    For up to a 70% discount off Tariff rates on out of State moves, 40% savings on local moves and storage and Free box delivery service
                                </span>
                            </div>
                            <div class="flyerDiv" style="padding-top: 12px">
                                <span class="blueHighlightFlyer">www.affordableusamovers.com</span><br>
                                <span class="redHighlightFlyer">Call us now 1-800-289-5329</span>
                            </div>
                        </div>

                        <div style="font-size: 0.65em; text-align:center; padding-top:10px;">
                            MC ## 945837 USDOT ## 2867211 Federally Authorized Broker
                        </div>
                    </td>

                    <td class="flyerTd"  style="vertical-align: top; padding-top:20px;">
                        <img src="/admin/letters/images/OJP0023229.jpg"  border="0" style="width:340px; padding-left: 20px">
                        <div style="padding-top: 20px">
                            <ul style="line-height:30px;">
                                <li>
                                    <span class="blueHighlightFlyer">Quality movers at affordable prices</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Up to a 70% discount off Tariff rates on out-of-state moves</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Up to 40% savings on local moves and storage</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Discounted car transport</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Only 1 Professional Certified Moving Consultant</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Free On-site or Virtual tour/estimate available</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Evening and Weekend appointments available</span>
                                </li>
                                <li>
                                    <span class="redHighlightFlyer">Free Move Quote emailed the same day</span>
                                </li>
                                <li>
                                    <span class="blueHighlightFlyer">Packing supplies and box delivery available</span>
                                </li>
                            </ul>
                        </div>
                        <div style="padding-top: 20px">
                            <img src="/admin/letters/images/Attachment-2.jpeg"  border="0" style="width:340px; padding-left:20px">
                        </div>
                        <div class="flyerDiv" style="padding-top:15px; line-height:20px; font-size:0.9em; margin-left: 120px; ">
                            LOCAL OFFICES: <br />
                            <span class="blueHighlightFlyer">
                                Virginia-703-570-4232; <br />
                                Maryland-301-235-9070;  <br />
                                Washington DC-202-729-8277  <br />
                                Monday-Saturday 7am-7pm
                            </span>
                        </div>
                    </td>
                </tr>
                
            </table>

  
    </cfoutput>
    </div>
</cfif>