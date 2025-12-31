<cfparam name="url.clientid" default="274">
<cfparam name="url.formid" default="1">

<cfdocument format="pdf" margintop="0.3" marginbottom="0.1" marginleft="0.3" marginright="0.3" orientation="portrait" scale="50">
    
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: Calibri, sans-serif;
        font-size: 12px;
        line-height: 1.25;
    }
    div{
        font-family: Calibri, sans-serif;
        font-size: 12px;
        line-height: 1.25;
    }

    .form-line {
        margin: 10px 0;
        font-size: 12px;
        font-family: Calibri, sans-serif;
    }
    .form-line .label {
        font-weight: bold;
    }
    .form-line .line {
        display: inline-block;
        border-bottom: 1px solid #000;
        width: 65%;              /* Adjust length here */
        margin-left: 8px;
    }
    /* Special layout for phone + email row */
    .phone-email .line {
        width: 30%;
    }

    .section-box {
        border: 2px solid #000;
        padding: 6px;
        margin: 0 0 8px 0;
        font-weight: bold;
        font-size: 11px;
    }

    .field-row {
        display:inline-block;
        width:100%;
        white-space:nowrap;
        margin:0 0 8px 0;
    }
    .field {
        display:inline-block;
        vertical-align: top;
        border:2px solid #000;
        padding:6px;
        font-size:11px;
        font-weight:bold;
        margin-right:10px; /* spacing between boxes */
        white-space: nowrap;
        box-sizing:border-box;
    }
    .big-box {
        border: 2px solid #000;
        padding: 12px 18px;
        margin-top: 15px;
        font-family: Calibri, sans-serif;
        font-size: 12px;
        line-height: 1.4;
        width: 100%;
        box-sizing: border-box;
    }
    .big-box-title {
        font-weight: bold;
        font-size: 12px;
        margin-bottom: 10px;
    }
    .accessorial-box {
        border: 2px solid #000;
        padding: 12px 18px;
        margin-top: -3px; /* Connect borders cleanly */
        height: 180px; /* Adjust based on required space */
        font-size: 12px;
        font-weight: bold;
    }
    ul.packing-list {
        margin: 0;
        padding-left: 40px;
        font-size: 12px;
        font-weight: bold;
    }
    ul.packing-list li {
        margin-bottom: 4px;
    }
    .extra-box {
        border: 2px solid #000;
        padding: 12px 18px;
        height: 500px; /* adjust based on space needed */
        box-sizing: border-box;
        font-weight: bold;
        font-size: 12px;
    }
    
</style>

<cfquery name="getMoveJobAgreement" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_move_job_agreements
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formid#">
</cfquery>

<!-- If no record found ? stop -->
<cfif getMoveJobAgreement.RecordCount EQ 0>
    <cfcontent type="text/html">
    <cfoutput><h2>No move job agreement found for ID #url.formid#</h2></cfoutput>
    <cfabort>
</cfif>

<cfquery name="getCarrier" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_records
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.clientid#">
</cfquery>

<!-- If no carrier found ? stop -->
<cfif getCarrier.RecordCount EQ 0>
    <cfcontent type="text/html">
    <cfoutput><h2>No carrier found for ID #url.clientid#</h2></cfoutput>
    <cfabort>
</cfif>

<!-- Assign the row -->
<cfset carrier = getCarrier>


<cfoutput>
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
            
                <p style="font-size:14px; font-weight:bold; margin:20px 0 0 0; text-align:center;">
                    Move Job Acceptance Agreement
                </p>
        
                <p style="font-size:12px; font-style:italic; font-weight:bold; margin:0 0 1px 0; text-align:center;">
                    <u>Read carefully and Initial all pages</u>
                </p>
                <p style="font-size:12px; font-style:italic; font-weight:bold; margin:0 0 1px 0; text-align:center;">
                    <u>Sign and return this agreement as soon as possible</u>
                </p>
                <p style="font-size:12px; font-style:italic; font-weight:bold; margin:0 0 5px 0; text-align:center;">
                    <u>or max within the next 12h to accept the move</u>
                </p>
        
                <div class="form-line" style="margin-top:8px;">
                    <span class="label">CUSTOMER NAME:</span>
                    <div class="line" style="width:64%; font-weight:normal;">#getMoveJobAgreement.customer_name#</div>
                </div>
        
                <div class="form-line phone-email" style="margin-top:8px;">
                    <span class="label">CUSTOMER PHONE NUMBER:</span>
                    <div class="line" style="width:20%; font-weight:normal;">#getMoveJobAgreement.customer_phone#</div>
        
                    <span class="label" style="margin-left:10px;">EMAIL:</span>
                    <div class="line" style="width:37%; font-weight:normal; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">#getMoveJobAgreement.customer_email#</div>
                </div>
        
                <div class="form-line" style="margin-top:8px;">
                    <span class="label">MOVE FROM:</span>
                    <div class="line" style="width:70%; font-weight:normal;">#getMoveJobAgreement.move_from#</div>
                </div>
        
                <div class="form-line" style="margin-top:8px;">
                    <span class="label">MOVE TO:</span>
                    <div class="line" style="width:73%; font-weight:normal;">#getMoveJobAgreement.move_to#</div>
                </div>
        
                <div class="form-line" style="margin-top:8px;">
                    <span class="label">PACKING/LOADING DATE:</span>
                    <div class="line" style="width:57%; font-weight:normal;">#DateFormat(getMoveJobAgreement.packing_loading_date, "mm/dd/yyyy")#</div>
                </div>
        
                <div class="form-line" style="margin-top:8px;">
                    <span class="label">DELIVERY DATE:</span>
                    <div class="line" style="width:66%; font-weight:normal;">#DateFormat(getMoveJobAgreement.delivery_date, "mm/dd/yyyy")#</div>
                </div>
        
                <div class="section-box" style="margin-top:8px;"> 
                    <span>CUSTOMER PREFERRED DELIVERY DATE:</span>
                    <span style="font-weight:normal;">#DateFormat(getMoveJobAgreement.preferred_delivery_date, "mm/dd/yyyy")#</span>
                </div>
        
                <div class="field-row">
                    <div class="field" style="width:48%;">
                        <span>STORAGE NEEDED:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.storage_needed#</span>
                    </div>
                    <div class="field" style="width:48%;">
                        <span>DAYS IN STORAGE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.days_in_storage#</span>
                    </div>
                </div>
        
                <div class="field-row">
                    <div class="field" style="width:48%;">
                        <span>MOVE TYPE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.move_type#</span>
                    </div>
                    <div class="field" style="width:48%;">
                        <span>MILES:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.miles#</span>
                    </div>
                </div>
        
                <div class="field-row">
                    <div class="field" style="flex:1.5;">
                        <span>APPROX TRAVEL TIME:</span> &nbsp;&nbsp;&nbsp; 
                        <span style="font-weight:normal;">#getMoveJobAgreement.approx_travel_time_hours#</span><span>HOURS</span>
                    </div>
                    <div class="field">
                        <span>TOTAL HOURS BILLED:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.total_hours_billed#</span>
                    </div>
                    <div class="field">
                        <span>MEN REQUIRED:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.men_required#</span>
                    </div>
                </div>
        
                <div class="section-box">
                    <span>SUGGESTED TRUCK SIZE & NUMBER TO USE:</span>
                    <span style="font-weight:normal;">#getMoveJobAgreement.suggested_truck_size#</span>
                </div>
        
                <div class="field-row">
                    <div class="field" style="flex:1.5; width:58%;">
                        <span>RESIDENCE TYPE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.residence_type#</span>
                    </div>
                    <div class="field" style="flex:1; width:38%;">
                        <span>ELEVATOR:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.elevator#</span>
                    </div>
                </div>
        
                <div class="field-row">
                    <div class="field">
                        <span>STAIRS INSIDE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.stairs_inside#</span>
                    </div>
                    <div class="field">
                        <span>LONG CARRY:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.long_carry#</span>
                    </div>
                    <div class="field">
                        <span>STAIRS OUTSIDE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.stairs_outside#</span>
                    </div>
                </div>
        
                <div class="field-row">
                    <div class="field">
                        <span>TOTAL ITEMS NUMBER:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.total_items#</span>
                    </div>
                    <div class="field">
                        <span>WEIGHT & CUBIC FEET:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.weight_cubic_feet#</span>
                    </div>
                </div>
        
                <div class="form-line" style="margin-top:15px;">
                    <span class="label">MOVE SIZE:</span>
                    <div class="line" style="width:80%; font-weight:normal;">#getMoveJobAgreement.move_size#</div>
                </div>
        
                <div style="width:100%; margin:25px 0 25px 0; ">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>1</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 30px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <div class="form-line" style="margin:20px 0 0 0;">
                <span class="label">PACKING: </span>
                <div class="line" style="width:80%; font-weight:normal;">#getMoveJobAgreement.packing#</div>
            </div>

            <div class="big-box">
                <div class="big-box-title">Required packing material:</div>

                <ul class="packing-list">
                    <li>5.1 or Dishpacks: <span style="font-weight:normal;">#getMoveJobAgreement.dishpacks#</span></li>
                    <li>1.5 or Small Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.small_boxes#</span></li>
                    <li>Book Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.book_boxes#</span></li>
                    <li>3.0 or Medium Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.medium_boxes#</span></li>
                    <li>4.5 or Large Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.large_boxes#</span></li>
                    <li>5.0 Extra Large Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.extra_large_boxes#</span></li>
                    <li>6.0 Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.boxes_6#</span></li>
                    <li>6.5 Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.boxes_6_5#</span></li>
                    <li>Mirror or picture Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.mirror_picture_boxes#</span></li>
                    <li>Wardrobe (18-24 inches) Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.wardrobe_boxes#</span></li>
                    <li>Flat TV boxes or wrap: <span style="font-weight:normal;">#getMoveJobAgreement.flat_tv_boxes#</span></li>
                    <li>Flat Screen TV ##: <span style="font-weight:normal;">#getMoveJobAgreement.flat_screen_tv_count#</span></li>
                    <li>Crib mattress: <span style="font-weight:normal;">#getMoveJobAgreement.crib_mattress#</span></li>
                    <li>Single Bed Bag or Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.single_bed_boxes#</span></li>
                    <li>Double Bed Bag or Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.double_bed_boxes#</span></li>
                    <li>King/Queen Bed Bag or Boxes: <span style="font-weight:normal;">#getMoveJobAgreement.king_queen_bed_boxes#</span></li>
                    <li>Other material needed: <span style="font-weight:normal;">#getMoveJobAgreement.other_material_needed#</span></li>
                </ul>
            </div>

            <div class="accessorial-box">
                Accessorial: <span style="font-weight:normal;">#getMoveJobAgreement.accessorial#</span>
            </div>

            <div style="width:100%; margin:35px 0 25px 0;">
                <table style="width:100%; border-collapse:collapse;">
                    <tr>
                        <td style="width:20%; text-align:left; font-size:12px;">
                            <cfoutput>2</cfoutput> 
                        </td>

                        <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                            Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                        </td>
                    </tr>
                </table>
            </div>
            </td>
        </tr>
    </table>

    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 30px; vertical-align:top;">
                
                <cfinclude template="header_move_job_agreement.cfm"> 
                <div class="extra-box" style="margin:20px 0px;">
                    Extra info: <span style="font-weight:normal;">#getMoveJobAgreement.extra_info#</span>
                </div>
        
                <div class="field-row">
                    <div class="field" style="width:28%; border:1px solid ##000;">
                        <span>VIRTUAL SURVEY:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.virtual_survey#</span>
                    </div>
                    <div class="field" style="width:28%; border:1px solid ##000;">
                        <span>OTHER:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.other_estimate#</span>
                    </div>
                </div>
        
                <div class="field-row">
                    <div class="field" style="width:28%; border:1px solid ##000;">
                        <span>BINDING ESTIMATE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.binding_estimate#</span>
                    </div>
                    <div class="field" style="width:37%; border:1px solid ##000;">
                        <span>NON-BINDING ESTIMATE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.non_binding_estimate#</span>
                    </div>
                    <div class="field" style="width:28%; border:1px solid ##000; margin:0px">
                        <span>NOT TO EXCEED:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.not_to_exceed#</span>
                    </div>
                </div>
        
                <div class="field-row" style="margin-top:8px;">
                    <div class="field" style="width:28%; border:1px solid ##000;">
                        <span>HOURLY ESTIMATE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.hourly_estimate#</span>
                    </div>
                    <div class="field" style="width:28%; border:1px solid ##000;">
                        <span>FLAT RATE:</span>
                        <span style="font-weight:normal;">#getMoveJobAgreement.flat_rate#</span>
                    </div>
                </div>
        
                <div style="width:100%; margin:55px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>3</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <cfdocumentitem  type="pagebreak" />

    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 30px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <div style="border:2px solid ##000; padding:8px; font-weight:bold; margin-top:20px; font-size:12px;">
                    <span>AMOUNT PAID FOR THE MOVE TO THE CARRIER BY CONSUMER/SHIPPER $#trim(getMoveJobAgreement.amount_paid_to_carrier)#</span>
                </div>

                <br><br>
                <cfif carrier.AddToMoveJobAgreement EQ 1>
                    <cfset repName = carrier.RepFirstName & " " & carrier.RepLastName>
                <cfelseif carrier.AddToMoveJobAgreement2 EQ 1>
                    <cfset repName = carrier.Rep2FirstName & " " & carrier.Rep2LastName>
                <cfelseif carrier.AddToMoveJobAgreement3 EQ 1>  
                    <cfset repName = carrier.Rep3FirstName & " " & carrier.Rep3LastName>
                <cfelse>
                    <cfset repName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">
                </cfif>

                <cfif carrier.AddToMoveJobAgreement EQ 1>
                    <cfset repRole = carrier.CompanyPosition>
                <cfelseif carrier.AddToMoveJobAgreement2 EQ 1>
                    <cfset repRole = carrier.Rep2Position>
                <cfelseif carrier.AddToMoveJobAgreement3 EQ 1>
                    <cfset repRole = carrier.Rep3Position>
                <cfelse>
                    <cfset repRole = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">
                </cfif>
                
                <p style="font-size:12px; line-height:1.4; text-align:justify; font-weight:bold;">
                    I,<u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; font-weight:normal;">
                    #repName#</u>, representative of (#carrier.CompanyName#) accept 
                    to perform the above move brokered by Nationwide USA Movers and I understand and accept 
                    that by signing this agreement I declare that the paid amount is sufficient and fair to cover all 
                    the costs associated with the above move. I also declare that I will not ask for more money 
                    before or after the packing/loading or delivery date, unless a new revised written estimate, 
                    order for service or Bill of Lading is reviewed and authorized by Customer/Shipper and 
                    Nationwide USA Movers and signed by the Customer/Shipper prior to the starting of moving 
                    services 
                </p>

                <p style="font-size:12px; margin-top:30px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>

                <br><br><br>

                <p style="font-size:12px; line-height:1.4; text-align:justify; font-weight:bold;">
                    I,<u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; font-weight:normal;">
                    #repName#</u>, authorized representative of 
                    (<strong>#carrier.CompanyName#</strong>) in agreement with FMCSA regulations, 
                    accept Nationwide USA Movers' estimate as (<strong>#carrier.CompanyName#</strong>) 
                    own estimate.
                </p>

                <p style="font-size:12px; margin-top:30px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>

                <br><br><br>

                <p style="font-size:12px; line-height:1.4; text-align:justify; font-weight:bold;">
                    I, <u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; font-weight:normal;">
                    #repName#</u>, representative of 
                    (<strong>#carrier.CompanyName#</strong>), declare that I have watched and viewed 
                    the entire survey video/s and that the weight/cubic feet, shipper's inventory and requested 
                    moving services are in agreement with what has been recorded on the video survey.
                </p>

                <p style="font-size:12px; margin-top:30px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>

                <div style="width:100%; margin:30px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>4</cfoutput> 
                            </td>

                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <cfdocumentitem  type="pagebreak" />

    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 30px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <p style="font-size:12px; line-height:1.4; text-align:justify; font-weight:bold; margin-top:50px;">
                    I,<u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; font-weight:normal;">
                    #repName#</u>,  authorized representative of
                    (<strong>#carrier.CompanyName#</strong>)
                    understand and accept, that if the move does not match what listed on the Shipper's 
                    Inventory or if there is any additional packing or any extra moving services, I will never 
                    involve or ask directly the shipper for money, but I will notify immediately Nationwide USA 
                    Movers and ask for a re-estimate by video survey before starting packing and/or loading  or 
                    performing any other moving services for said shipper the lack of respecting the above rules 
                    or the lack of informing Nationwide USA Movers will determine that not additional money 
                    will be paid, unless a new revised written estimate or order for service is reviewed and 
                    authorized  by Customer/Shipper and Nationwide USA Movers and signed by the 
                    Customer/Shipper prior to the starting of moving services
                </p>

                <p style="font-size:12px; margin-top:30px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>

                <br><br><br>

                <p style="font-size:12px; line-height:3; text-align:justify; font-weight:bold; ">
                    I,<u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; line-height:1.4; vertical-align:baseline; font-weight:normal;">
                    #repName#</u>,  authorized representative of 
                    (<strong>#carrier.CompanyName#</strong>)
                    declare that I have read, understood and agreed to the rules of this Move Job Acceptance Agreement. 
                </p>

                <p style="font-size:12px; margin-top:30px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>


                <div style="width:100%; margin:200px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>5</cfoutput> 
                            </td>

                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <p style="font-size:12px; line-height:3; text-align:justify; font-weight:bold; margin-top:30px;">
                    I,<u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; line-height:1.4; vertical-align:baseline; font-weight:normal;">
                    #repName#</u>,  authorized representative of 
                    (<strong>#carrier.CompanyName#</strong>)
                    declare that I have read, understood and agreed to the terms of this Move Job Acceptance Agreement 
                </p>

                <p style="font-size:12px; margin-top:20px; font-weight:bold;">
                    INITIALS _________ &nbsp;&nbsp;&nbsp; DATE______________
                </p>

                <br><br><br>

                <div class="extra-box" style="margin-top:10px; height:400px;">
                    ADDENDUM: <span style="font-weight:normal;">#getMoveJobAgreement.addendum#</span>
                </div>

                <div style="width:100%; margin:80px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>6</cfoutput> 
                            </td>

                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>   
            </td>
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <p style="font-size:12px; line-height:3; text-align:justify; font-weight:bold; margin-top:40px;">
                    I, <u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; line-height:1.4; vertical-align:baseline; font-weight:normal;">
                    #repName#</u>, in the role of <u style="display:inline-block; border-bottom:2px solid ##000; min-width:200px; padding:0 5px; line-height:1.4; vertical-align:baseline; font-weight:normal;">
                    #repRole#</u>,
                    declare that I am authorized to sign and accept this agreement for 
                    (<strong>#carrier.CompanyName#</strong>)
                </p>
        
                <div class="form-line" style="margin-top:40px;">
                    <span class="label">Print name</span>
                    <div class="line">
                        #repName#
                    </div>
                </div>
                <div class="form-line" style="margin-top:30px;">
                    <span class="label">Role in the Company</span>
                    <div class="line">
                        #repRole#
                    </div>
                </div>
                <div class="form-line" style="margin-top:30px;">
                    <span class="label">Signature</span>
                    <div class="line" style="width:50%">&nbsp;</div>
        
                    <span class="label" style="margin-left:10px;">Date</span>
                    <div class="line" style="width:15%">&nbsp;</div>
                </div>    
        
                <div style="width:100%; margin:380px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>7</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm"> 
                <p style="font-size:12px; margin-top:10px;">
                    Signing this Move Job Acceptance Agreement, the Carrier understands and agrees that:
                </p>
        
                <ol style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.6;
                    margin-left:45px;
                    margin-top:10px;
                ">
                    <li>Nationwide USA Movers move jobs are paid by weight (weight= cubic feet X 7) and not by cubic space </li>
                    <li>Asking for more money after accepting a job or threatening to walk off an accepted job to get 
                        paid more will determine immediate cancellation of Broker-Carrier agreement since Nationwide 
                        USA Movers have given you all the necessary info to decide on the accepted job</li>
                    <li>Nationwide USA Movers requires a notice of at least 2 weeks, if after accepting the described 
                        move job, the aforementioned job cannot be carried out. This requirement is to allow 
                        Nationwide USA Movers to find another available Carrier to cover the job. Violating this 
                        requirement will determine a probation period between 1 and 2 years or cancellation of the 
                        signed Broker-Carrier Agreement. </li>
                    <li>Not showing up to a customer residence after the move job has been accepted, will determine a 
                        monetary penalty up to 20% of the total cost of the move and cancellation of signed Broker
                        Carrier Agreement </li>
                    <li>Dropping Nationwide USA Movers move job for another job will determine a monetary penalty 
                        up to 20% of the total cost of the move and cancellation of signed Broker-Carrier Agreement </li>
                    <li>Causing a customer request to change Carrier will determine immediate termination of Broker
                        Carrier Agreement  </li>
                    <li>If a customer is not ready to move, it is mandatory to contact Nationwide USA Movers and 
                        prove it with pictures (at least 12) or video taken around the entire residence. </li>
                    <li>It will not re-broker or co-broker, assign, interline, or provide substituted service for the 
                        shipments hereunder tendered to carrier by broker without the advance express written 
                        authorization of broker, and</li>
                    <li>if authorization is granted, carrier agrees not to use an "Unsatisfactory" or "Conditional" rated 
                        carrier, and </li>
                    <li>that violation of the policy in point 8 and 9 may be grounds for immediate termination of the 
                        existing 409 Carrier-Brooker Agreement, and</li>
                    <li>if broker becomes aware of such unauthorized re-brokering activity by carrier prior to payment 
                        of any compensation otherwise due to carrier, broker may withhold payment to carrier and may 
                        instead pay appropriate compensation to the carrier who actually transported the shipment, 
                        and  </li>
                    <li>as per 49 USC 13901(c) any person who knowingly authorizes, consents to, or permits, directly 
                        or indirectly, either alone or in conjunction with any other person, a violation of this warranty, 
                        including but not limited to “double brokering” is liable to broker for liquidated damages of</li>
                </ol>
        
                <div style="width:100%; margin:25px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>8</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm">
                <ol start="13" style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.3;
                    margin-left:45px;
                    margin-top:10px;
                ">
                    <li><u>$10,000</u> for each violation plus all valid charges, or other claims incurred without regard to amount.</li>
                    <li> broker shall also be entitled to its collection and costs of enforcement, interest and attorneys' fees, and</li>
                    <li> the liability for claims under 49 USC 13901(c) for unauthorized, or “double brokering” shall 
                        apply, jointly and severally to any corporate entity or partnership involved; and to the individual 
                        officers, directors, and principals of such entities</li>
                    <li> Carrier accepts Nationwide USA Movers estimate and rates as its own </li>
                    <li> Carrier must have office equipment (printer, fax, computer) to be able to receive and send necessary documents related to the move </li>
                    <li> it is mandatory for carriers to learn and get accustomed to Nationwide USA Movers Shipper's inventory and that</li>
                    <li> 48-24 hours previous scheduled packing and/or moving date, it is mandatory to go over inventory and to discuss upcoming move with a Nationwide USA Movers representative, via phone call or video call</li>
                    <li> Nationwide USA Movers has the right to contact the customer anytime during the entire moving process, and </li>
                    <li> Nationwide USA Movers has the right to check onto the carrier at shipper's residence for quality control </li>
                    <li> All calls or emails from the customer/shipper must be answered. No customer/shipper's phone number or email blocking is tolerated.   </li>
                    <li> Carrier and any of his representatives must be courteous and polite and never engage in any discussion with the customers/shippers    </li>
                    <li> Any complaint calls from customers/shippers to Nationwide USA Movers, will determine a period of probation  </li>
                    <li> 24-48 hours before the scheduled packing and/or move job, customer/shipper must be informed of crew arrival time   </li>
                    <li> Pick-up and delivery dates must be respected unless otherwise agreed upon with the customer/shipper in writing and notified to Nationwide USA Movers in writing as well</li>
                    <li> Arrival time needs to be between 9-11 am, unless it is differently established with customer and if the established arrival time cannot be respected (i.e. traffic), customer/shipper needs to be informed.   </li>
                    <li>  In case of injuries to a customer or altercation with customer/shipper, Nationwide USA Movers will ask for police intervention on job    </li>
                    <li> customer will never be in any way, pressured for tips</li>
                    <li> Payment for carrier services will come directly from customer/shipper at time of delivery by certified funds or in any other modality previously agreed with the customer </li>
                </ol>
        
                <div style="width:100%; margin:25px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>9</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm">
                <ol start="31" style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.45;
                    margin-left:45px;
                    margin-top:10px; ">
        
                    <li>Payment modality must be discussed with customer at least 48hrs before scheduled packing 
                    and/or move date.</li>
        
                    <li>Nationwide USA Movers will not be involved in the process of customer payment to the carrier 
                    and will not be asked to collect money or process credit card on behalf of the carrier, unless 
                    otherwise agreed by Carrier, Broker and Shipper.</li>
        
                    <li>If carriers want to accept credit card payment will do so through their own merchant account 
                    and credit card processing system.</li>
        
                    <li>It is carrier sole responsibility to collect money from customer for its services.</li>
        
                    <li>Nationwide USA Movers will never be responsible monetary or legally for carrier money loss 
                    either in case a customer fails to pay or issues a charge back.</li>
        
                    <li>It's the carrier responsibility to have crew and the right trucks and equipment (i.e. 4- and 2
                    wheels trolley, commercial bin) and tools (i.e. screwdrivers, drill, allen wrench set and more) 
                    ready for the job and that Nationwide USA Movers will never be asked to provide any of them.</li>
        
                    <li>Anything taken apart by carrier needs to be put together at destination (i.e. beds, entertainment 
                    center and more) on any job.</li>
        
                    <li>Trucks used for the packing and/or moving need to be clean outside and inside when pulling up 
                    to customer's.</li>
        
                    <li>Moving blankets, floor protectors need to be clean and in good condition (i.e. not ripped).</li>
        
                    <li>It is carrier responsibility to provide proper material and supplies for each job.</li>
        
                    <li>Before starting the loading process carrier representative must inspect the household goods to 
                    be moved and if any damage is already present, the shipper needs to be informed, and a picture 
                    of the damaged item taken before moving it.</li>
        
                    <li>Crew needs to wear a proper clean uniform attire (i.e. matching shirts and pants) during the 
                    packing and/or move.</li>
        
                    <li>It is carrier responsibility to train the crew to do a good job and have all the crew members 
                    trained to pad wrap, truck load.</li>
        
                    <li>For job that requires packing, it is carrier responsibility to provide trained and skilled people that 
                    know how to pack fragile items and how to properly mark boxes.</li>
        
                    <li>For job that requires packing, it is carrier responsibility to buy all the required packing material 
                    at least 24-48hrs before the job from 3rd party providers. This is required to avoid being late at 
                    customer's residence because of waiting lines to supplier.</li>
        
                    <li>Crew members cannot show up to a customer's smelling of alcohol or marijuana.</li>
        
                    <li>Carrier is fully responsible for each of crew members and Nationwide USA Movers requires that 
                    the carrier run a full background check on all crew members.</li>
        
                    <li>It is carrier sole responsibility to pay crews and rent trucks.</li>
        
                    <li>Carrier must have all the proper paperwork filled out and signed and dated by customer (i.e. 
                    Estimate/Order for Service, Bill of Lading, job completion or any other documents necessary for 
                    the service performed).</li>
        
                </ol>
        
                <div style="width:100%; margin:35px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>10</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>   
        </tr>
    </table>
    
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm">
                <ol start="50" style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.45;
                    margin-left:45px;
                    margin-top:10px; ">
        
                    <li>the move) and a copy of the signed documents need to be sent via email to Nationwide USA 
                    Movers within 21 days of the move completion. Lack in providing a copy of the signed 
                    documents will determine a probation period and/or a cancellation of the Broker-Carrier 
                    Agreement.</li>

                    <li>For each Interstate move the shipper will need to sign and date the required Bill of Lading, both 
                    at origin and destination, and a copy of the aforementioned forms and of Bill of Lading needs to 
                    be sent to Nationwide USA Movers, by the Carrier, within maximum 21 days after completion of 
                    the move. Lack in providing a copy of the signed documents will determine a probation period 
                    and/or a cancellation of the Broker-Carrier Agreement.</li>

                    <li>For local move, the shipper will need to sign and date a job completion form and customer 
                    satisfaction form, and a copy of the aforementioned forms must be sent by email to Nationwide 
                    USA Movers, by the Carrier, within maximum 21 days after completion of the move. Lack in 
                    providing a copy of the signed documents will determine a probation period and/or a 
                    cancellation of the Broker-Carrier Agreement.</li>

                    <li>For all moves it is required to have a job completion form signed by the shipper both at origin 
                    and destination. A copy of this form must be returned to Nationwide USA Movers together with 
                    pictures showing that everything has been removed from house, garage, patio, back and front 
                    yard and shade at origin and pictures of last piece moved and empty truck at destination.</li>

                    <li>In case of damages, pictures need to be taken of the damaged items, and a copy must be sent to 
                    Nationwide USA Movers with a copy of job completion or Bill of Lading signed by the customer.</li>

                    <li>Any damage to shipper's Household Goods, property (walls, floors, driveway, lawn, both at 
                    origin and destination), any missing item or any other issue with shipper, is the carrier sole 
                    responsibility and, Nationwide USA Movers will never be involved.</li>

                    <li>It is carrier sole responsibility, to pay for any repair or damage to the truck/s used for the move 
                    job assigned to the Carrier by Nationwide USA Movers.</li>

                    <li>Pads and blankets must be used for all move jobs to provide the best protection to the shipper's 
                    household goods.</li>

                    <li>Floor protectors should be used, where necessary, to protect shipper's floor (carpet or hardwood 
                    floor) both at origin and destination.</li>

                    <li>If damage occurs, it is forbidden to the carrier or any of its representatives to hide or try to 
                    repair the damage on the spot without notifying it to the shipper.</li>

                    <li>Carrier must provide customer/shipper with a claim form if necessary either via mail or email.</li>

                    <li>Customer/Shipper's claims and complaints need to be addressed in a reasonable time.</li>

                    <li>Nationwide USA Movers suggests hiring a professional Claim Company to handle claims if any.</li>

                    <li>Any issue with customer needs to be resolved with arbitration and without Nationwide USA 
                    Movers involvement in the matter.</li>

        
                </ol>
        
                <div style="width:100%; margin:35px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>11</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>   
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm">
                <ol start="64" style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.45;
                    margin-left:45px;
                    margin-top:10px; ">
        
                    <li>Nationwide USA Movers, will monitor the move and, if necessary, will help customer with filing 
                    complaints with the FMCSA.</li>

                    <li>Nationwide USA Movers, 48 hours before scheduled packing and/or move date, will provide 
                    customer/shipper with Carrier elected representative direct contact info (phone number, email 
                    and mailing address) for any shipper's necessity or to file a claim for damages.</li>

                    <li>In case of damages, Nationwide USA Movers will provide customer carrier insurance contact 
                    information.</li>

                    <li>If Nationwide USA Movers receive more than 2 calls from a customer because carrier is 
                    unreachable (i.e. no answer to customer phone calls or emails), the signed Broker-Carrier 
                    Agreement will be automatically cancelled.</li>

                    <li>No returning calls or not answering emails from Nationwide USA Movers will determine 
                    automatic cancellation of the signed Broker-Carrier Agreement.</li>

                    <li>As required by FMCSA regulations, a supplemental moving insurance with different levels of 
                    deductibles, must be offered to the shipper.</li>

                    <li>The shipper's choice of level of protection (Basic Coverage or Full Value Protection with level of 
                    deductibles) must be reported on the Carrier issued Bill of Lading, as required by FMCSA 
                    regulations.</li>

                    <li>Any bad reviews on Nationwide USA Movers related to a poor move job will determine a period 
                    of probation or cancellation of Broker-Carrier Agreement.</li>

                    <li>Carrier will never represent itself as Nationwide USA Movers and it is absolutely forbidden for 
                    the carrier to use Nationwide USA Movers logo, name or likeness. Carrier represents its own 
                    company.</li>

                    <li>If Nationwide USA Movers will receive too many calls or emails from any Carrier representative 
                    for questions about things a carrier should know and handle itself, the Broker-Carrier 
                    Agreement will be terminated. Carrier needs to run its own company without hassling 
                    Nationwide USA Movers.</li>

                    <li>If Nationwide USA Movers will not receive the signed job agreement within the required time, 
                    the same job will be assigned to another carrier.</li>

                    <li>Calling Nationwide USA Movers more than once a week to ask for jobs will determine a period 
                    of probation during which you will not be given any moving job.</li>

                    <li>Carrier will never ask or try to get information on Broker's profit for the assigned job.</li>

                    <li>Nationwide USA Movers will communicate any available job through Text messaging and in 
                    order to accept the job a text message needs to be sent in response.</li>

                    <li>If Customer/Shipper's Household Goods goes into any storage or public storage facility, Carrier 
                    must provide Nationwide USA Movers and Customer/Shipper with the name of the storage 
                    facility, address of facility, full name of the account holder and unit/s number where the 
                    household goods are stored.</li>

        
                </ol>
        
                <div style="width:100%; margin:35px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>12</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>   
        </tr>
    </table>
    
    <cfdocumentitem  type="pagebreak" />
    
    <table width="100%" height="100%" style="border:1px solid ##000; border-collapse:collapse;">
        <tr>
            <td style="padding:0 40px; vertical-align:top;">
                <cfinclude template="header_move_job_agreement.cfm">
                <ol start="79" style="
                    list-style-type: decimal;
                    padding-left: 0;
                    font-size:12px;
                    line-height:1.45;
                    margin-left:45px;
                    margin-top:10px; ">
        
                    <li>Carrier must maintain full insurance (BIPD and Cargo) throughout the moving process and for 
                    the full period of storage if households goods are in storage.</li>

                    <li>For local and intrastate moves Nationwide USA Movers will act only as Lead Generation source, 
                    Virtual Estimator and Move Coordination services provider and,</li>

                    <li>All charges for local and intrastate are based on carrier's local and intrastate tariff or published 
                    rates.</li>

                    <li>Nationwide USA Movers will collect directly from the shipper for the services provided 
                    described in point 78 in the amount of no more than 15% of the total cost of the move and,</li>

                    <li>Carrier agrees to reduce its local and intrastate rates up to 15% to accommodate the charges 
                    for the services described at point 78.</li>

        
                </ol>
        
                <div style="width:100%; margin:500px 0 25px 0;">
                    <table style="width:100%; border-collapse:collapse;">
                        <tr>
                            <td style="width:20%; text-align:left; font-size:12px;">
                                <cfoutput>13</cfoutput> 
                            </td>
        
                            <td style="width:80%; text-align:right; font-size:12px; padding-right:20px;">
                                Carrier Representative Initials <span style="font-weight:normal;">_________</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>   
        </tr>
    </table>
</cfoutput>
</cfdocument>
