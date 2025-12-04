<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
<cfif parameterexists(keyword) is 'no'>
<cfset keyword=''>
</cfif>
<cfif parameterexists(searchacct) is 'no'>
<cfset searchacct=''>
</cfif>
<cfif parameterexists(type) is 'no'>
<cfset type=''>
</cfif>

<cfif parameterexists(un) is 'no'>
    <b>Log In</b><br>
    <form action="main.cfm" method="post">
        username <input type="text" name="username" size="15"><br>
        password <input type="password" name="password" size="15"><br>
        <input type="submit" value="Log In">
    </form>
    <cfabort>
<cfelse>
    <cfquery name="verify" datasource="aaalh3x_onestep">
        select * from MEMBERS
        where username='#un#' and temp_pw=#pw# and active=1
    </cfquery>
     <cfif #verify.recordcount# is 0>
     <b>Log In</b><br>
     <form action="main.cfm" method="post">
     username <input type="text" name="username" size="15"><br>
     password <input type="password" name="password" size="15"><br>
     <input type="submit" value="Log In">
     </form>
     <cfabort>
 </cfif>
</cfif>

        <style>
            .flyerBody {
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                font-size:19px;
                font-family: arial, helvetica;
                font-weight:bold;
            }
        </style>

    <cfquery name="printQueue" datasource="aaalh3x_onestep">
        select *
        from printQueue
         where (memberId is null or memberId=#verify.id#)
         and printed=0
        and cleared=0
        <cfif isDefined('url.type') and url.type is "followUp">
            and (printType='followUp' or printType='Mayflowerfollowup')
        <cfelse>
            and (printType <> 'followUp' and printType <> 'Mayflowerfollowup')
        </cfif>
        <cfif isDefined('url.type') and url.type is "hanger">
            and hanger = 1
        <cfelse>
            and hanger = 0
        </cfif>
    </cfquery>
    
    <cfdocument format="pdf" pagetype="letter" orientation="portrait" scale="95">
    <cfoutput query="printQueue" maxrows="1">
<cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from CLIENTS
    where id=#clientid#
</cfquery>
		<cfdocumentsection>
           <table style="width:99%;">
                <tr>
                    <td>
                        <div style="font-family:arial">
                            <div>
                                <div style="float:right; padding-top: 10px;font-size: 15px">
                                    <span>#dateformat(now(), "MM/DD/YYYY")#</span>
                                </div>
                               <div style="margin-top: -20px">
                                    <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:250px">
                                </div>
                            </div>
                            
                            <div style="padding-top:10px;font-size: 15px">
                                 Dear #getinfo.first_name# #getinfo.last_name# or Current Occupant,
                            </div>

                            <div style="padding-top:10px; font-weight: bold;font-size: 15px">
                                Don't forget that the Affordable USA Movers Certified Moving Consultant will be in your area doing estimates on or after
                                <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>. Call us today for your free estimate.
                            </div>
                            
                            <div style="padding-top:10px;font-size: 15px">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Affordable USA Movers <span style="text-decoration: underline; font-weight: bold;">Move Discount Program</span>
                                will get you a <span style="font-weight: bold; text-decoration: underline">Fixed Flat Price</span> and big discounts off the price of your move and up to 
                                <span style="font-weight: bold;">12 Free Move Quotes from Top Major Brand Moving Companies</span>
                                and a variety of other A+ quality movers to get the price down to where you want it <span style="font-weight: bold; font-style:italic;">(i.e. name your own price!)</span>,
                                while working with just <span style="font-weight: bold">1 Certified Moving Consultant</span>.
                            </div>

                            <div style="margin-left:auto; margin-right:auto; width:100%;  padding-top: 20px;  font-weight: bold; line-height:25px;font-size: 15px">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-weight:normal">Don't forget to mention your </span><span style="font-weight: bold; text-decoration: underline">
                                    Personal Move Discount Code</span> <span style="color: red">#getInfo.discountCode#
                                </span>
                                <span style="font-weight: normal">to</span> <span style="text-decoration: underline">lock in</span> 
                                <span style="font-weight: normal">your discount and to receive your</span> <span style="font-weight:bold; text-decoration: underline">Fixed Flat Price</span>.
                            </div>
                            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size:1.1em; font-weight: bold; line-height:25px">
                                <span style="text-decoration: underline">Affordable USA Movers brings you "High-Quality Movers" at Affordable Prices</span>

                            </div>

                            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 20px; font-size: 1.2em; font-weight: bold;">
                
                                Appointments For A Free In-Home or Virtual Estimate for home selling at<br />
                                #getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
                                
                                are available starting from 
                                
                                <div style="font-size: 1.5em; font-weight: bold; color: red; padding: 15px 0;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</div>

                                <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 20px; font-weight: bold; line-height: 24px;font-size: 15px">
                                    Please Call Our Appointment Line Monday Through Saturday 7am-7pm <br />
                                    <span style="color:##489cdf; font-weight: bold;">At 1-800-289-5329</span> or go to <span style="text-decoration:underline; color:##489cdf; font-weight: bold">www.affordableusamovers.com</span><br />
                                    to confirm, reschedule, or set up an appointment time that works best for you<br />
                                    FREE No Obligation Estimate!!!<br />
                                    Evening and Weekend appointments available<br />
                                     To Lock in Your Discount don't forget to mention your <br /><br />
                                     <span style="color: red; font-size:1.2em;">Personal Move Discount Code&##174; #getInfo.discountCode#</span>
                                </div>

                                <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:10px">
                                    <tr>
                                        <td valign="top" width="100%">
                                            <div style="float:right;width:60px; text-align:center; margin-right:30px">
                                                <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="border: 0;width: 75px; height:auto;" alt="Affordable USA Movers BBB Business Review">
                                            </div>
                                            <span style="font-size: 15px">
                                                <b>Local Offices:</b>
                                                 <div style="color:##489cdf; font-weight: bold; font-size: 16px; line-height: 18px; padding-top: 8px;">
                                                    Virginia - 703-570-4232
                                                    <br>
                                                    Maryland - 301-235-9070
                                                    <br>
                                                    Washington DC - 202-729-8277
                                                    <br>Monday-Saturday 7am-7pm
                                                </div>
                                            </span>
                                        </td>
                                        <td align="right" valign="top">
                                            <div align="center">
                                                 <img src="http://www.top12movingbiz.com/admin/letters/3.jpg" width="220" alt="" border="0"></div>
                                        </td>
                                    </tr>
                                </table>
                                <div style="font-weight:bold; text-align:center; padding-top:5px; font-size: 13px;">
                                    Federally Authorized Moving Company MC ## 60880 USDOT ## 3070716 &amp; Moving Broker MC ## 945837
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>    
         </cfdocumentsection>   
		<cfdocumentsection>
       <table style="width:99%;">
            <tr>
                <td align="center">
                  <div class="closingLetter"  style="font-family:arial">
            <div>
                <div style="margin-top: -20px">
                    <img src="http://www.top12movingbiz.com/admin/letters/images/mayflowerLetterHeader.jpg" alt="" border="0">
                </div>
            </div>
            <div style="padding-bottom:35px; padding-right:50px; text-align:right;">
            
            </div>
            <div style="padding-bottom:15px; padding-right:50px; text-align:right;">
            Date:  #DateFormat(Now(), "MM/DD/YYYY")#
            </div>
            
            <div style="padding-top:15px;  text-align:left;">
                 Dear #getinfo.first_name# #getinfo.last_name# or Current Occupant,</div>

            <div style="padding-top:15px; text-align:left;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Don't forget that Joe Moholland-Mayflower is offering you a FREE In-Home Estimate.</strong></div>
            

            <div style="padding-top:15px; text-align:left;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;One of our Certified Moving Consultants will be in your area doing estimates on or after
                <span style="color: red;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
            </div>

            <div style="padding-top:15px; text-align:left;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call the local Mayflower Moving Consultant to schedule your Free No Obligation Estimate and mention your <strong>Move Offer Code</strong> <span style="color: red; font-weight: bold; ">#getInfo.discountCode#</span>
                to lock in your discount and to receive a <strong><em>Special Incentive</em></strong>.  Even though you may not move right away, your discount will be valid until you are ready to move.

            </div>

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 55px; font-size: 1.2em; font-weight: bold;">
                <span style="text-decoration:underline">TO TAKE FULL ADVANTAGE OF THIS OFFER<br />HAVE YOUR ESTIMATE DONE BY</span>
                <br>
                <div style="font-size: 1.8em; font-weight: bold; color: red; padding: 10px 0 5px 0;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</div>
            </div> 
                

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 35px; font-weight: bold; line-height: 27px;">
            	<p>&nbsp;</p>
            	<p><span style="color:##000000; font-weight: bold;">Call direct Anthony Booker at 202-602-2295<BR>Certified Moving Consultant for Washington DC metro area<BR>
           	    to schedule your FREE Virtual Tour or In-Home Estimate
       	    </span> </p>
            	<p>&nbsp;</p>
            	<p><span style="color: red; font-size:1.2em;">FOR A SPECIAL INCENTIVE DON'T FORGET <br>
           	    TO MENTION YOUR MOVE OFFER CODE<br>
            	</span>
            	  <br>
            	  <span style="color: red; font-size:1.2em;">#getInfo.discountCode#</span></p>
            	<p>&nbsp;</p>
            </div>
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><strong>Anthony Booker</strong><br>
                  AMSA Certified Moving Consultant<br>
                  abooker@move-estimator.com<br></td>
              </tr>
            </table>

            <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:25px">
                <tr>
                    <td valign="top" width="100%">
                        <font size="3">
                            <b>Local Office Numbers:</b>
                             <div style="color:##489cdf; font-weight: bold; font-size: 18px; line-height: 18px; padding-top: 8px;">
                                Virginia - 703-259-9010
                                <br>
                                Maryland - 301-200-3656
                                <br>
                                Washington DC - 202-602-2295
                               <br>Monday-Saturday 7am-7pm
                            </div>
                        </font>
                    </td>
                    <td align="right" valign="top">
                        <div align="center">
                             <img src="http://www.top12movingbiz.com/admin/letters/images/mayflowerLetterIcon.jpg" alt="" border="0"></div>
                    </td>
                </tr>
            </table>
            <div style="font-weight:bold; text-align:center; padding-top:10px; font-size: 12px;">
                THIS OFFER IS VALID ONLY WHEN CALLING THE ABOVE LOCAL CONSULTANT
            </div>
        </div>
                </td>
            </tr>
        </table>  
        </cfdocumentsection>
            </cfoutput>
<!--- <cfoutput query="printQueue" maxrows="2">
		<cfinclude template="letters/followUp.cfm" />
        <cfinclude template="letters/MayflowerfollowUp.cfm" />
</cfoutput> --->
</cfdocument>
<cfabort>
<!--- 
    send_type values:
    1: new listing
    3: reprint new
    6: follow up letter
    7: followUp reprint
    8: estimate
    9: estimate reprint
    10: carrierList
    11: carrierList reprint
    20: nonRealtorLeads
    21: nonRealtorLeads reprint
    100: door hanger
    101: hanger reprint
    200: doorHanger2
    201: hanger2 reprint
    210: hangerOffer
    211: hangerOffer reprint
    220:doorHangerOfferUrgent
    221:doorHangerOfferUrgent reprint
    230:doorHanger_appt
    231:doorHanger_appt reprint
    240:doorHanger_mayflower
    241:doorHanger_mayflower reprint
    250:doorHangerApptUrgent
    251:doorHangerApptUrgent reprint
	300: MayFlower Letter
	301: Mayflower follow up
	302: Mayflower Flyer
    998: follow up labels
    999: labels
 --->

<!--- <cfdocument format="pdf" margintop="0.1" marginbottom="0.1" marginleft="0.1" marginright="0.1" orientation="portrait" scale="95"> --->
<cfdocument format="pdf" orientation="portrait" scale="95">
    <cfoutput query="printQueue">
        <cfif printQueue.printType is "new">
            <!--- <cfinclude template="letters/new_listing_letter.cfm" /> --->
            <cfinclude template="letters/newListing.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(1,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "gotOffer">
            <!--- <cfinclude template="letters/got_offer_letter.cfm" /> --->
            <cfinclude template="letters/offerLetter.cfm" />
        <cfelseif printQueue.printType is "closing">
            <!--- <cfinclude template="letters/close_letter.cfm" /> --->
            <cfinclude template="letters/closingLetter.cfm" />
        <cfelseif printQueue.printType is "followUp">
            <cfinclude template="letters/followUp.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(6,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerfollowUp">
            <cfinclude template="letters/MayflowerfollowUp.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(301,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hanger">
            <cfinclude template="letters/doorHanger_new.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(100,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerApptUrgent">
            <cfinclude template="letters/doorHanger.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(250,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerAppt">
            <cfinclude template="letters/doorHanger_appt.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(230,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hanger2">
            <cfinclude template="letters/doorHanger2.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(200,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerOffer">
            <cfinclude template="letters/doorHangerOffer_new.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(210,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerOfferUrgent">
            <cfinclude template="letters/doorHangerOfferUrgent.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(220,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerMayflower">
            <cfinclude template="letters/doorHanger_mayflowerUnited.cfm" />
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(240,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "estimate">
            <cfinclude template="letters/estimate.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(8,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "carrierList">
            <cfinclude template="letters/carrierList.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(10,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "nonRealtorLeads">
            <!--- <cfinclude template="letters/nonRealtorLeads.cfm" /> --->
            <cfinclude template="letters/noRealtor.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(20,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerLetter">
        	<cfinclude template="letters/mayflowerLetter.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(300,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerFlyer">
        	<cfinclude template="letters/mayFlowerFlyer.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(302,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerFollowup">
        	<cfinclude template="letters/MayflowerFollowup.cfm" />
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(301,1,'#clientid#','#datenow#')
            </cfquery>
        </cfif>

       <cfif (printQueue.printType NEQ "followUp" and printQueue.printType NEQ "mayflowerfollowUp" and printQueue.printType NEQ "mayflowerLetter" and printQueue.printType NEQ "MayflowerFlyer") and not (isDefined('url.type') and url.type is "hanger")>
           <cfdocumentitem type="pagebreak" />
            <cfinclude template="letters/flyer.cfm" />         
       </cfif>

       <cfif printQueue.currentRow is not printQueue.recordcount>
           <cfdocumentitem type="pagebreak" />
       </cfif> 
       <!---  <cfquery datasource="aaalh3x_onestep">
                   update printQueue
                   set printed=1
                   where id=#printQueue.id#
               </cfquery> --->
    </cfoutput>
</cfdocument>

