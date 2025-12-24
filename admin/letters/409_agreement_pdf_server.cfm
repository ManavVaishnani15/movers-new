<cfdocument
    format="PDF"
    pagetype="letter" scale="50" >

    <cfdocumentitem type="header">
        <cfinclude template="header.cfm">
    </cfdocumentitem>

    <cfdocumentitem type="footer" evalAtPrint="true">
        <cfinclude template="footer.cfm">
    </cfdocumentitem>

    <style>
        body {
            font-family: "Times New Roman";
            font-size: 13px;
        }

    </style>


    <cfparam name="url.clientid" default="0">

    <cfquery name="getCarrier" datasource="aaalh3x_onestep">
        SELECT *
        FROM carrier_records
        WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.clientid#">
    </cfquery>

    <!-- If no record found ? stop -->
    <cfif getCarrier.RecordCount EQ 0>
        <cfcontent type="text/html">
        <cfoutput><h2>No carrier found for ID #url.clientid#</h2></cfoutput>
        <cfabort>
    </cfif>

    <!-- Assign the row -->
    <cfset carrier = getCarrier>

    <cfset today = Now()>

    <!--- Get date parts --->
    <cfset dayNumber = Day(today)>
    <cfset monthName = DateFormat(today, "mmmm")>
    <cfset yearNumber = DateFormat(today, "yyyy")>

    <!--- Determine ordinal suffix --->
    <cfif ListFind("11,12,13", dayNumber)>
        <cfset suffix = "th">
    <cfelse>
        <cfset lastDigit = Right(dayNumber, 1)>
        <cfif lastDigit EQ "1">
            <cfset suffix = "st">
        <cfelseif lastDigit EQ "2">
            <cfset suffix = "nd">
        <cfelseif lastDigit EQ "3">
            <cfset suffix = "rd">
        <cfelse>
            <cfset suffix = "th">
        </cfif>
    </cfif>

    <!--- Final formatted date --->
    <cfset formattedDate = "#dayNumber#<sup>#suffix#</sup> day of #monthName#, #yearNumber#">


    <!-- Your 8 pages of Agreement HTML go here -->
    <cfoutput>
        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <h4 style="text-align:left; font-weight:bold; margin-top:10px;">
                BROKER - CARRIER AGREEMENT
            </h4>

            <p style="margin-top:10px;">
                This Broker - Carrier Agreement (the "Agreement"), is entered into this 
                #formattedDate#,
                by and between 
                <strong>Nationwide USA Movers</strong>, a Delaware Corporation, with its place of business at 
                <strong>2319 Third Avenue, Suite 1710, New York NY 10035</strong>, which is a household goods broker, properly authorized and
                registered with Federal Motor Carrier Safety Administration (FMCSA) of the Department of Transportation ("DOT"), operating pursuant 
                to <strong>MC## 945837 and USDOT## 3558324</strong> (hereinafter referred to as "BROKER") and 
                <strong>#carrier.CompanyName#</strong>
                with its place of business at 
                <strong>#carrier.StreetAddress#, #carrier.City#, #carrier.State#, #carrier.Zip# </strong>
                which is a household goods motor carrier properly authorized and registered with Federal Motor Carrier Safety Administration
                ("FMCSA") of the Department of Transportation ('DOT'), operating pursuant to 
                <strong>MC## #carrier.MC# </strong>
                and 
                <strong>USDOT## #carrier.USDOT#</strong>
                (hereinafter referred to as "CARRIER").
            </p>

            <h4 style="font-weight:bold; margin-top:15px; margin-bottom:25px;">RECITALS:</h4>

            <p>
                <strong>WHEREAS "BROKER"</strong> is a household goods broker properly authorized and registered with Federal Motor Carrier
                Safety Administration (FMCSA) of the Department of Transportation (DOT) who arranges with an operator to carry the goods
                (property) of another person or company (SHIPPER), for compensation and by commercial motor vehicle.
            </p>

            <p>
                <strong>WHEREAS "CARRIER"</strong> is a household goods motor carrier properly authorized and registered with Federal 
                Motor Carrier Safety Administration (FMCSA) of the Department of Transportation (DOT), to carry the goods (property) of 
                another person or company (SHIPPER) by commercial motor vehicle for compensation (copies of Operating Authorities are attached hereto as Appendix).
            </p>

            <p>
                <strong>WHEREAS</strong> the name "SHIPPER" is the customer of the BROKER and is also known but not limited to the names: consignor, consignee and receiver.
            </p>

            <p>
                <strong>WHEREAS</strong> the term Household Goods is also referred as Property or Shipment herein.
            </p>

            <p>
                <strong>NOW, THEREFORE</strong>, in consideration of the terms, condition and covenants contained herein and intending to be
                legally bound, the BROKER and CARRIER agree as follows:
            </p>

            <h4 style="font-weight:bold; margin-top:15px;">
                1. CARRIER REPRESENTS AND WARRANTS THAT IT:
            </h4>


            <ol start="1" style="
                list-style-type: upper-alpha;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
                
                <li>
                    Is a motor carrier, authorized to provide the transportation of household goods under contracts with shippers and receivers 
                    and/or by arrangement between household goods brokers and,
                </li>
            </ol>

        </div>

        <cfdocumentitem type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <ol start="2" style="
                list-style-type: upper-alpha;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
                <li style="margin-bottom:12px;">
                    shall transport the household goods (property), under its own Operating Authority and subject to 
                    the terms of this Agreement, and
                </li>
    
                <li style="margin-bottom:12px;">
                    agrees not to re-broker or co-broker, assign, interline, or provide substituted service for the 
                    shipments hereunder tendered to CARRIER by BROKER without the advance express written 
                    authorization of BROKER., and
                </li>
    
                <li style="margin-bottom:12px;">
                    if authorization is granted, CARRIER agrees not to use an "Unsatisfactory" or "Conditional" 
                    rated carrier, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that violation of the policy in point C and D may be grounds for 
                    immediate termination of this Agreement, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that if BROKER becomes aware of such unauthorized re-brokering 
                    activity by CARRIER prior to payment of any compensation otherwise due to CARRIER, 
                    BROKER may withhold payment to CARRIER and may instead pay appropriate compensation to 
                    the carrier who actually transported the shipment, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that as per 49 USC 13901(c) any person who knowingly authorizes, 
                    consents to, or permits, directly or indirectly, either alone or in conjunction with any other person, 
                    a violation of this warranty, including but not limited to "double brokering" is liable to BROKER 
                    for liquidated damages of $10,000 for each violation plus all valid charges, or other claims 
                    incurred without regard to amount.
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that BROKER shall also be entitled to its collection and costs of 
                    enforcement, interest and attorneys' fees, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that the liability for claims under 49 USC 13901(c) for unauthorized, or 
                    "double brokering" shall apply, jointly and severally to any corporate entity or partnership 
                    involved; and to the individual officers, directors, and principals of such entities
                </li>
    
                <li style="margin-bottom:12px;">
                    is in, and shall maintain compliance during the term of this Agreement, with all applicable 
                    federal, provincial (or state) and local laws relating to the provision of its services including, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees to notify the BROKER immediately if any Operating Authority is 
                    revoked, suspended or rendered inactive for any reason; and/or if it is sold, or if there is a change 
                    in control of ownership, and/or any insurance required hereunder is threatened to be or is 
                    terminated, cancelled, suspended, or revoked for any reason, and
                </li>
    
                <li style="margin-bottom:12px;">
                    understands and agrees that it shall defend, indemnify and hold BROKER and its shipper 
                    customer harmless from any claims, actions or damages, arising out of its performance under this 
                    Agreement, including shipment loss and damage, theft, delay, damage to property, and personal 
                    injury or death. BROKER shall not be liable to the CARRIER for any claims, actions or damages.
                </li>
            </ol>

        </div>

        <cfdocumentitem type="pagebreak" />

        
        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <p style="margin-left:40px; text-indent:-20px;">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;due to the negligence of the CARRIER, or the shipper. The obligation to defend shall include all 
                costs of defense as they accrue, and
            </p>

            <ol start="13" style="
                list-style-type: upper-alpha;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">

                <li style="margin-bottom:12px;">
                    does not have an "Unsatisfactory" safety rating issued by the Federal Motor Carrier Safety 
                    Administration (FMCSA), U.S. Department of Transportation, or any provincial regulatory 
                    authority and will notify BROKER in writing immediately if its safety rating is changed to 
                    "Unsatisfactory" or "Conditional", and
                </li>

                <li style="margin-bottom:12px;">
                    authorizes BROKER to provide an estimate including CARRIER's shipment charges to shipper, 
                    consignee, or third parties responsible for payment, and
                </li>

                <li style="margin-bottom:12px;">
                    agrees, in respect of 49 CFR 375.409, to adopt the BROKER's estimate as its own.
                </li>

                <li style="margin-bottom:12px;">
                    agrees to provide the Broker with a copy of its own published Tariff of Rates.
                </li>

                <li style="margin-bottom:12px;">
                    understands and agrees that for local and intrastate moves the Broker will act only as Lead 
                    Generation source, Virtual Estimator and Move Coordination services provider and,
                </li>

                <li style="margin-bottom:12px;">
                    agrees that all charges for local and intrastate shall be based on CARRIER's local and intrastate 
                    tariff or published rates. Whichever is applicable
                </li>

                <li style="margin-bottom:12px;">
                    understands and agrees that the Broker will collect directly from the shipper for the provided 
                    services described in point Q in the amount of no more than 15% of the total cost of the move 
                    and,
                </li>

                <li style="margin-bottom:12px;">
                    agrees to a reduction of its local and intrastate rates up to 15% to accommodate the charges for 
                    the services described at point Q
                </li>

                <li style="margin-bottom:5px;">
                    agrees to be informed of possible move jobs through text messages or emails. (Text messages or 
                    data rates may apply)
                </li>
            </ol>

            <h4 style="font-weight:bold;">
                2. BROKER RESPONSIBILITIES:
            </h4>


            <ol start="1" style="
                list-style-type: upper-alpha;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
            
                <li style="margin-bottom:12px;">
                    BROKER shall inform CARRIER of (a) place of origin and destination of all shipments; and (b) 
                    if applicable, any special shipping instructions or special equipment requirements, of which 
                    BROKER has been timely notified.
                </li>

                <li style="margin-bottom:12px;">
                    BROKER will provide to shippers, consignees, or third parties responsible for payment a written 
                    estimate of the charges for CARRIER's services
                </li>

                <li style="margin-bottom:5px;">
                    BROKER agrees that the written estimate to the individual shipper:
                </li>
            </ol>

            <ol start="1" style="
                list-style-type: upper-roman;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
                <li style="margin-left:30px;">
                    Will be based on the authorized household goods carrier's published tariff;
                </li>
            </ol>
        </div>  


        <cfdocumentitem type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <ol start="2" style="
                list-style-type: upper-roman;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
                
                <li style="margin-left:30px;">
                    Will serve as the authorized household goods motor carrier's estimate for purpose of 
                    complying with the requirements of 49 CFR Part 375, including the requirement that the 
                    authorized household goods motor carrier relinquish possession of the shipment upon 
                    payment of no more than 110% of a non-binding estimate at the time of delivery
                </li>
            </ol>


            <ol start="4" style="
                list-style-type: upper-alpha;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">
                    
                <li style="margin-bottom:10px;">
                    BROKER shall maintain a surety bond /trust fund on file with the Federal Motor Carrier Safety 
                    Administration (FMCSA) in the form and amount not less than that required by that agency's 
                    regulations
                </li>
    
                <li style="margin-bottom:10px;">
                    BROKER will notify CARRIER immediately if its Operating Authority is revoked, suspended or 
                    rendered inactive for any reason; and/or if it is sold, or if there is a change in control of 
                    ownership, and/or any insurance required hereunder is threatened to be or is terminated, 
                    cancelled, suspended, or revoked for any reason.
                </li>
    
                <li style="margin-bottom:5px;">
                    <strong>BROKER AND CARRIER</strong> agree that the Carrier will be paid for its services directly by 
                    shipper, unless otherwise agreed by Carrier, Broker and Shipper. Payment will be provided upon 
                    delivery with Cash or Certified funds (i.e. Cashier Check or Postal Money Order). The parties 
                    agree also that, as exception to previous rule, payment to the Carrier for its services, could be 
                    made by Credit Card, if requested by shipper and agreed by carrier. Carrier will be notified of 
                    method of payment 48hrs prior packing and/or loading date.
                </li>
            </ol>

            <h4 style="font-weight:bold; margin-top:15px;">
                3. CARRIER RESPONSIBILITIES:
            </h4>

            
            <p style="margin-left:0px;margin-top:10px;">
                <strong>A.&nbsp;EQUIPMENT:</strong> Subject to its representations and warranties in Paragraph 1 above, CARRIER agrees 
                to provide the necessary equipment and qualified personnel for completion of the transportation services 
                required for BROKER and/or its customers.
            </p>


            <p style="margin-left:0px; margin-top:10px;">
                <strong>B.&nbsp;BILLS OF LADING:</strong>
            </p>


            <ol style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; list-style-type: upper-roman;">

                <li style="margin-bottom:10px;">
                    CARRIER shall issue a bill of lading in compliance with 49 U.S.C. &sect;80101 et seq., 
                    49 C.F.R. &sect;373.101 (and any amendments thereto), for the property it receives for 
                    transportation under this Agreement.
                </li>

                <li style="margin-bottom:10px;">
                    The bill of lading shall note that the shipments were transported by CARRIER, acting as a 
                    carrier and that the shipment was arranged by BROKER, acting as broker. The name of the 
                    underlying shipper shall be inserted in the blank for the consignor/shipper.
                </li>

                <li style="margin-bottom:10px;">
                    CARRIER shall become fully responsible/liable for the shipment when it takes/receives 
                    possession thereof, and
                </li>

            </ol>

        </div>

        <cfdocumentitem type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <ol start="4" style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; list-style-type: upper-roman;">
                <li style="margin-bottom:10px;">
                    CARRIER's responsibility/liability shall continue until delivery of the property to the consignee, 
                    and the consignee signs the bill of lading or delivery receipt and nothing remains to be done by 
                    CARRIER to deliver the shipment to the proper consignee.
                </li>

                <li style="margin-bottom:10px;">
                    Failure by CARRIER to issue a Bill of Lading or have the shippers sign a Bill of Lading 
                    acknowledging receipt of the household goods, shall not affect the liability of CARRIER.
                </li>

                <li style="margin-bottom:10px;">
                    CARRIER shall provide BROKER with a copy of the Bill of Lading no later than 21 days after 
                    Household Goods delivery to consignee.
                </li>

            </ol>
            
            <p style="font-weight:bold; margin-top:0px;">C. LOSS & DAMAGE CLAIMS:</p>


            <ol start="1" style="
                list-style-type: upper-roman;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">

                <li style="margin-bottom:10px; margin-left: 35px">
                    CARRIER shall comply with 49 C.F.R. &sect;370.1 et seq. and any amendments and/or any 
                    other applicable regulations adopted by the Federal Motor Carrier Safety Administration, 
                    U.S. Department of Transportation, or any applicable federal, state or provincial 
                    regulatory agency, for processing all loss and damage claims and salvage and
                </li>

                <li style="margin-bottom:10px; margin-left: 35px">
                    CARRIER liability for any property damage, loss or theft from any cause shall be 
                    determined under the Carmack Amendment 49 USC 14706 as governing shipments 
                    according to its terms,
                </li>

                <li style="margin-bottom:10px; margin-left: 35px">
                    Notwithstanding the terms of 49 CFR 370.9, CARRIER shall pay, decline or make 
                    settlement offer in writing on all cargo loss or damage claims within 60 days of receipt of  
                    the claim. Failure of CARRIER to pay, decline or offer settlement within these 60 days 
                    period shall be deemed admission by CARRIER of full liability for the amount claimed 
                    and a material breach of this Agreement.
                </li>

            </ol>

            <p style="font-weight:bold; margin-top:0px;">D. INSURANCE:</p>

            <ol start="1" style="
                list-style-type: upper-roman;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.25;
            ">

                <li style="margin-bottom:10px; margin-left: 35px">
                    CARRIER shall furnish BROKER with Certificate(s) of Insurance, or insurance policies 
                    providing thirty (30) days advance written notice of cancellation or termination. The 
                    insurance policies shall comply with minimum requirements of the Federal Motor Carrier 
                    Safety Administration and any other applicable regulatory state agency.
                </li>

                <li style="margin-bottom:10px; margin-left: 35px">
                    CARRIER agrees to have their insurance company list BROKER as Certificate Holder on 
                    each of their policies, and the insurance company is required to send via fax/email a copy 
                    of all insurance coverage with no limitations/exclusions on each policy.
                </li>

            </ol>


            <p style="margin-left:0; margin-top: 0px;">
                <strong>E. ASSIGNMENT OF RIGHTS: </strong> CARRIER automatically assigns BROKER rights to collect charges 
                from Shipper or any responsible third party for BROKER's services.
            </p>

            <h4 style="font-weight:bold; margin-top:15px;">4. MISCELLANEOUS:</h4>

        </div>

        <cfdocumentitem type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <p>
                <strong>A. INDEPENDENT CONTRACTOR:</strong> It is understood and agreed that the relationship between 
                BROKER and CARRIER is that of independent contractor and that no employer/employee relationship 
                exists or is intended. BROKER has no control of any kind over CARRIER, including but not limited to 
                routing of shipment, and nothing contained herein shall be construed to be inconsistent with this 
                provision.
            </p>

            <p>
                <strong>B. NON-EXCLUSIVE AGREEMENT:</strong> CARRIER and BROKER acknowledge and agree that this 
                contract does not bind the respective Parties to exclusive services to each other. Either party may enter 
                into similar agreements with other carriers or brokers.
            </p>

            <p>
                <strong>C. DISPUTES:</strong> In the event of a dispute arising out of this Agreement, including but not limited to 
                Federal or State statutory claims, the Party's sole recourse (except as provided below) shall be to 
                arbitration. Arbitration proceedings shall be started within eighteen (18) months from the date of delivery 
                or scheduled date of delivery of the shipment, whichever is later. Unless preempted or controlled by 
                federal transportation law and regulations, the laws of the State of New York shall be controlling.
            </p>

            <p>
                <strong>D. NOTIFICATION:</strong> Except for routine communications in the course of performance of this 
                Agreement which may derive from day-to-day operations, any notices sent to parties involved in this 
                Agreement shall be in writing and delivered by email, Fax, or certified mail to the mail address, Fax 
                phone number and mailing and/or physical address set forth in this agreement.
            </p>

            <p><strong>E. NO SOLICITATION:</strong></p>

            <ol start="1" style="
                list-style-type: upper-roman;
                margin-left:30px;
                font-family:'Times New Roman';
                font-size:13px;
                line-height:1.45;
            ">

                <li style="margin-bottom:10px; margin-left:35px;">
                    Absent specific written Agreement between both the CARRIER AND BROKER, 
                    CARRIER shall not solicit business from any shipper, consignor, consignee or customer 
                    of BROKER where the availability of such business first became known to CARRIER as 
                    a result of the BROKER's efforts during the term of this agreement.
                </li>

                <li style="margin-bottom:10px; margin-left:35px;">
                    CARRIER's acceptance of the shipment(s) will acknowledge that the customer(s) is a 
                    BROKER's customer(s), therefore CARRIER shall never knowingly or unknowingly 
                    perform services of a transportation nature for compensation for any BROKER's 
                    customer(s) without prior authorization from BROKER.
                </li>

                <li style="margin-bottom:10px; margin-left:35px;">
                    offer to the BROKER's customer(s) a better or lower rate or price
                </li>

                <li style="margin-bottom:10px; margin-left:35px;">
                    the foregoing at point E.I., E.II. and E.III apply also in the case that the CARRIER is 
                    directly contacted by the shipper or a shipper's representative
                </li>

                <li style="margin-bottom:20px; margin-left:35px;">
                    in the event of violation of this Agreement, CARRIER shall pay BROKER within ten (10) 
                    days of each such violation an amount equal to the Broker commission of not less than 
                    $1,500. Additionally, BROKER may seek injunctive relief, and, in the event, it is successful, CARRIER shall be liable for all costs and expenses incurred by BROKER, including, but not limited to, reasonable attorney's fees. 
                </li>

            </ol>

        </div>

        <cfdocumentitem type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:10px;">

            <p>
                <strong>F. CONFIDENTIALITY:</strong> In addition to Confidential Information protected by law, statutory or 
                otherwise, the CARRIER agrees that all of BROKER'S financial information and that of their customers, 
                including but not limited to brokerage rates, amounts tendered for brokerage services, as well as personal 
                customer information, customer shipping or other logistics requirements shared or learned between the 
                Parties and BROKER'S customers, shall be treated as Confidential, and shall not be disclosed or used for 
                any reason without prior written consent.
            </p>

            <p>
                <strong>G. MODIFICATION OF AGREEMENT:</strong> Any modification to the terms and conditions of this 
                Agreement must be in writing and signed by authorized representatives of both parties to be enforceable.
            </p>

            <p>
                <strong>H. CONTRACT TERM:</strong> This Agreement shall be effective on the date stated above and shall continue 
                until terminated by a written notice from one party to the other. Unless otherwise specifically agreed to in 
                writing, this Agreement shall apply to all services rendered by Carrier to Broker, unless terminated, upon 
                thirty (30) day's prior written notice, with or without cause, by either Party at any time, including 
                the initial term. In the event of termination of this Agreement for any reason, the Parties shall be obligated 
                to complete performance of any work in progress in accordance with the terms of this Agreement.
            </p>

            <p>
                <strong>I. SEVERANCE:</strong> If any part of this Agreement is held unenforceable, the rest of the Agreement will 
                continue in effect.
            </p>

            <p>
                <strong>L. FORCE MAJEURE:</strong> Neither party will be liable for the failure to tender or timely transport freight 
                under this agreement if such failure, delay or other omission is caused by strikes, acts of God, war, 
                accidents, civil disorder, or through compliance with legally constituted order of civil or military 
                authorities.
            </p>

            <p>
                <strong>M. ELECTRONIC SIGNATURE:</strong> This Agreement and any subsequent amendments may be executed 
                by facsimile (Fax), portable document format (PDF) or other electronic methods (e.g. Adobe Sign) and a 
                facsimile, PDF or other electronic signature will be treated as an original signature.
            </p>

            <p>
                <strong>N. AUTHORITY OF EXECUTING PARTY:</strong> CARRIER represents and warrants that the individual 
                executing this agreement, and each rate confirmation (Appendix A), on CARRIER'S behalf has the 
                authority to execute this agreement and to bind CARRIER to the terms hereof. BROKER represents and 
                warrants that the individual executing this agreement on BROKER'S behalf has the authority to execute 
                this agreement and to bind BROKER to the terms hereof.
            </p>

        </div>

        <cfdocumentitem  type="pagebreak" />

        <div style="font-family:'Times New Roman'; font-size:13px; line-height:1.25; padding:0 20px; padding-top:40px;">

            <p style="margin-bottom:20px;">
                IN WITNESS WHEREOF, the parties (BROKER AND CARRIER) here to execute this Agreement of 
                8 pages as of the date and year first written.
            </p>

            <h4 style="text-align:center; font-weight:bold; margin-bottom:25px; padding-top:30px;">BROKER</h4>

            <table style="width:100%; font-size:14px; line-height:1.45;">

                <tr style="text-align:center;">
                    <td style="width:30%; font-weight:bold;">Authorized Signature</td>
                    <td style="width:20%; font-weight:bold;">Printed Name</td>
                    <td style="width:50%; font-weight:bold;">Title</td>
                </tr>

                <tr style="text-align:center;">
                    <td style="padding-top:15px;">
                        ______________________
                    </td>

                    <td style="padding-top:15px;">
                        Anthony L Booker
                    </td>

                    <td style="padding-top:15px;">
                        Carrier Relations &amp; Business Development
                    </td>
                </tr>

                <tr>
                    <td colspan="3" style="padding-top:20px;">
                        <strong>Company Address:</strong> 2319 Third Avenue, Suite 1710<br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;New York-NY 10035</span>
                    </td>
                </tr>

                <tr>
                    <td style="padding-top:20px;">
                        <strong>Phone:</strong> 1-800-976-6833 Ext 4
                    </td>

                    <td colspan="2" style="padding-top:20px;">
                        <strong>email :</strong> movingjobs@nationwideusamovers.com
                    </td>
                </tr>

            </table>

            <h4 style="text-align:center; font-weight:bold; margin-top:50px; margin-bottom:25px;">CARRIER</h4>

            <table style="width:100%; font-size:13px; line-height:1.45;">

                <tr style="text-align:center;">
                    <td style="width:33%; font-weight:bold;">Authorized Signature*</td>
                    <td style="width:33%; font-weight:bold;">Printed Name</td>
                    <td style="width:33%; font-weight:bold;">Title</td>
                </tr>

                <tr style="text-align:center;">
                    <td style="padding-top:20px;">
                        __________________________
                    </td>

                    <td style="padding-top:20px;">
                        <cfif carrier.AddTo409Agreement EQ 1>
                            <span style="margin-bottom:15px;">
                                #carrier.RepFirstName# #carrier.RepLastName#<br>
                            </span>
                            <cfelseif carrier.AddTo409Agreement2 EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Rep2FirstName# #carrier.Rep2LastName#<br>
                                </span>
                            <cfelseif carrier.AddTo409Agreement3 EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Rep3FirstName# #carrier.Rep3LastName#<br>
                                </span>
                        </cfif>
                    </td>

                    <td style="padding-top:20px;">
                        <cfif carrier.AddTo409Agreement EQ 1>
                            <span style="margin-bottom:15px;">
                                #carrier.CompanyPosition#<br>
                            </span>
                            <cfelseif carrier.AddTo409Agreement2 EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Rep2Position#<br>
                                </span>
                            <cfelseif carrier.AddTo409Agreement3 EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Rep3Position#<br>
                                </span>
                        </cfif>
                    </td>
                </tr>

                <tr>
                    <td colspan="3" style="padding-top:20px;">
                        <strong>Company Address:</strong> <span>#carrier.StreetAddress#, #carrier.City#, #carrier.State#, #carrier.Zip#</span>
                    </td>
                </tr>

                <tr>
                    <td style="padding-top:10px;">
                        <strong>Phone:</strong> 
                        <span>
                            <cfif carrier.AddTo409Agreement EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Phone#<br>
                                </span>
                                <cfelseif carrier.AddTo409Agreement2 EQ 1>
                                    <span style="margin-bottom:15px;">
                                        #carrier.Rep2Phone#<br>
                                    </span>
                                <cfelseif carrier.AddTo409Agreement3 EQ 1>
                                    <span style="margin-bottom:15px;">
                                        #carrier.Rep3Phone#<br>
                                    </span>
                            </cfif>
                        </span>
                    </td>

                    <td colspan="2" style="padding-top:10px;">
                        <strong>email:</strong> 
                        <span>
                            <cfif carrier.AddTo409Agreement EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.EmailAddress#<br>
                                </span>
                                <cfelseif carrier.AddTo409Agreement2 EQ 1>
                                <span style="margin-bottom:15px;">
                                    #carrier.Rep2EmailAddress#<br>
                                </span>
                                <cfelseif carrier.AddTo409Agreement3 EQ 1>
                                    <span style="margin-bottom:15px;">
                                        #carrier.Rep3EmailAddress#<br>
                                    </span>
                            </cfif>
                        </span>
                    </td>
                </tr>

            </table>


            <p style="margin-top:30px; font-size:13px; text-decoration:underline;">
                <strong>*Only an Authorized Representative must sign this document. It will be the CARRIER'S full 
                responsibility to ensure that the person signing this contract is an authorized representative of the 
                company.</strong>
            </p>

        </div>


    </cfoutput>

</cfdocument>
