<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from Carrier_Records
    where id = #clientID#
        </cfquery>
    </cfif>

    <style>
    	table{
    		font-family:calibri;
    	}
        .closingLetter {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:16px;
            font-family: arial;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:18px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:navy;
        }
        .fontsize{
        	font-size:28px;
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
    select * from Carrier_Records
    where id = #clientID#
</cfquery>


<cfsavecontent variable="REQUEST.letter_body" >
	<cfoutput>
	<span class="fontsize13">
<strong>BROKER - CARRIER AGREEMENT</strong><br><br>

This Broker - Carrier Agreement (the "Agreement"), is entered into this 11th day of August, 2021, by and
between Nationwide USA Movers, a Delaware Corporation, with its place of business at 1650
Williamsbridge Rd-Suite A6, Bronx NY 10461 which is a household goods broker, properly authorized
and registered with Federal Motor Carrier Safety Administration (FMCSA) of the Department of
Transportation ('DOT'), operating pursuant to MC## 945837 and USDOT## 3558324 (hereinafter referred
to as "BROKER") and (CARRIER NAME) with its place of business at (Physical Address) which is an
household goods motor carrier properly authorized and registered with Federal Motor Carrier Safety
Administration ('FMCSA') of the Department of Transportation ('DOT'), operating pursuant to MC ## --
---and USDOT ## --------(hereinafter referred to as "CARRIER").<br><br>

<strong>RECITALS:</strong><br><br>
    
<strong>WHEREAS "BROKER"</strong> is a household goods broker properly authorized and registered with Federal
Motor Carrier Safety Administration (FMCSA) of the Department of Transportation (DOT) who arranges
with an operator to carry the goods (property) of another person or company (SHIPPER), for
compensation and by commercial motor vehicle.<br>

<strong>WHEREAS "CARRIER"</strong> is a household goods motor carrier properly authorized and registered with
Federal Motor Carrier Safety Administration (FMCSA) of the Department of Transportation (DOT), to
carry the goods (property) of another person or company (SHIPPER) by commercial motor vehicle for
compensation (copies of Operating Authorities are attached hereto as Appendix).<br>

<strong>WHEREAS</strong> the name "SHIPPER" is the customer of the BROKER and is also known but not limited to
the names: consignor, consignee and receiver.<br>

<strong>WHEREAS</strong> the term Household Goods is also referred as Property or Shipment herein.<br>

<strong>NOW, THEREFORE,</strong> in consideration of the terms, condition and covenants contained herein and
intending to be legally bound, the BROKER and CARRIER agree as follows:<br><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>1. CARRIER REPRESENTS AND WARRANTS THAT IT:</strong><br><br><br>

<strong>A.</strong> Is a motor carrier, authorized to provide the transportation of household goods under contracts with
shippers and receivers and/or authorized household goods brokers, and<br><br>

<strong>B.</strong> shall transport the household goods (property), under its own Operating Authority and subject to the
terms of this Agreement, and<br><br>

<strong>C.</strong> will not re-broker, assign or interline the shipments hereunder, without prior written consent of
BROKER, and<br><br>

<strong>D.</strong> is in, and shall maintain compliance during the term of this Agreement, with all applicable federal,
provincial (or state) and local laws relating to the provision of its services including, and<br><br>

<strong>E.</strong> will notify the BROKER immediately if any Operating Authority is revoked, suspended or rendered
inactive for any reason; and/or if it is sold, or if there is a change in control of ownership, and/or any
insurance required hereunder is threatened to be or is terminated, cancelled, suspended, or revoked for
any reason, and<br><br>

<strong>F.</strong> shall defend, indemnify and hold BROKER and its shipper customer harmless from any claims, actions
or damages, arising out of its performance under this Agreement, including shipment loss and damage,
theft, delay, damage to property, and personal injury or death. BROKER shall not be liable to the
CARRIER for any claims, actions or damages due to the negligence of the CARRIER, or the shipper. The
obligation to defend shall include all costs of defense as they accrue, and<br><br>

<strong>G.</strong> does not have an "Unsatisfactory" safety rating issued by the Federal Motor Carrier Safety
Administration (FMCSA), U.S. Department of Transportation, or any provincial regulatory authority and
will notify BROKER in writing immediately if its safety rating is changed to "Unsatisfactory" or
"Conditional", and<br><br>

<strong>H.</strong> authorizes BROKER to provide an estimate including CARRIER’s shipment charges to shipper,
consignee, or third parties responsible for payment, and I. in respect of 49 CFR 375.409, agrees to adopt
the BROKER’s estimate as its own.<br><br>

<strong>L.</strong> agrees to provide the Broker with a copy of its own published Tariff of Rates.<br><br>

<strong>M.</strong> agrees to be informed of possible move jobs through text messages or emails. (Text messages or data
rates may apply)<br><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>2. BROKER RESPONSIBILITIES:</strong> <br><br><br>

<strong>A.</strong> SHIPMENTS, BILLING & RATES: BROKER agrees to solicit and obtain household goods
transportation business for CARRIER to the mutual benefit of CARRIER and BROKER and, shall offer
CARRIER at least one (1) load/shipment annually. BROKER shall inform CARRIER of (a) place of
origin and destination of all shipments; and (b) if applicable, any special shipping instructions or special
equipment requirements, of which BROKER has been timely notified.<br><br>

<strong>B.</strong> BROKER agrees to provide to shippers, consignees, or third parties responsible for payment a written
estimate of the charges for CARRIER's services.<br><br>

<strong>C.</strong> BROKER agrees that the written estimate to the individual shipper: i. Will be based on the authorized
household goods carrier’s published tariff; ii. Will serve as the authorized household goods motor
carrier’s estimate for purpose of complying with the requirements of 49 CFR Part 375, including the
requirement that the authorized household goods motor carrier relinquish possession of the shipment upon
payment of no more than 110% of a non-binding estimate at the time of delivery.<br><br>

<strong>D. PAYMENT:</strong> Carrier and Broker agree that the Carrier will be paid for its services, directly by shipper
upon delivery with Cash or Certified funds (i.e. Cashier Check or Postal Money Order). The parties agree
also that, as exception to previous rule, payment to the Carrier for its services, could be made by Credit
Card, if requested by shipper and agreed by carrier. Carrier will be notified of method of payment 48hrs
prior packing and/or loading date.<br><br>

<strong>E. BOND:</strong> BROKER shall maintain a surety bond /trust fund on file with the Federal Motor Carrier
Safety Administration (FMCSA) in the form and amount not less than that required by that agency’s
regulations.<br><br>

<strong>F.</strong> BROKER will notify CARRIER immediately if its Operating Authority is revoked, suspended or
rendered inactive for any reason; and/or if it is sold, or if there is a change in control of ownership, and/or
any insurance required hereunder is threatened to be or is terminated, cancelled, suspended, or revoked
for any reason.<br><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>3. CARRIER RESPONSIBILITIES:</strong> <br><br><br>

<strong>A. EQUIPMENT:</strong> Subject to its representations and warranties in Paragraph 1 above, CARRIER agrees
to provide the necessary equipment and qualified personnel for completion of the transportation services
required for BROKER and/or its customers.<br><br>

<strong>B. BILLS OF LADING:</strong> CARRIER shall issue a bill of lading in compliance with 49 U.S.C. §80101 et
seq., 49 C.F.R. §373.101 (and any amendments thereto), for the property it receives for transportation
under this Agreement. The bill of lading shall note that the shipments were transported by CARRIER,
acting as a carrier and that the shipment was arranged by BROKER, acting as broker. The name of the
underlying shipper shall be inserted in the blank for the consignor/shipper. CARRIER shall become fully
responsible/liable for the shipment when it takes/receives possession thereof, and the trailer(s) is loaded,
regardless of whether a bill of lading has been issued, and/or signed, by Shipper, and CARRIER,
responsibility/liability shall continue until delivery of the property to the consignee and the consignee
signs the bill of lading or delivery receipt and nothing remains to be done by CARRIER to deliver the 
shipment to the proper consignee. Failure to issue a Bill of Lading or sign a Bill of Bading acknowledging
receipt of the household goods, by CARRIER, shall not affect the liability of CARRIER.<br><br>

<strong>C. LOSS & DAMAGE CLAIMS:</strong> <br><br>

<div style="padding-left:30px"><strong>i.</strong> CARRIER shall comply with 49 C.F.R. §370.1 et seq. and any amendments and/or any other
applicable regulations adopted by the Federal Motor Carrier Safety Administration, U.S.
Department of Transportation, or any applicable federal, state or provincial regulatory agency, for
processing all loss and damage claims and salvage and<br><br>

<strong>ii.</strong> CARRIER liability for any property damage, loss or theft from any cause shall be determined
under the Carmack Amendment 49 USC 14706 as governing shipments according to its terms,<br><br>

<strong>iii.</strong> Notwithstanding the terms of 49 CFR 370.9, CARRIER shall pay, decline or make settlement
offer in writing on all cargo loss or damage claims within 60 days of receipt of the claim. Failure
of CARRIER to pay, decline or offer settlement within this 60 days period shall be deemed
admission by CARRIER of full liability for the amount claimed and a material breach of this
Agreement.
</div><br><br>

<strong>D.</strong> INSURANCE: CARRIER shall furnish BROKER with Certificate(s) of Insurance, or insurance
policies providing thirty (30) days advance written notice of cancellation or termination. The insurance
policies shall comply with minimum requirements of the Federal Motor Carrier Safety Administration
and any other applicable regulatory state agency. CARRIER agrees to have their insurance company list
BROKER as Certificate Holder on each of their policies, and the insurance company is required to send
via fax/email a copy of all insurance coverages with no limitations/exclusions on each policy.<br><br>

<strong>E.</strong> ASSIGNMENT OF RIGHTS: CARRIER automatically assigns to BROKER rights to collect charges
from Shipper or any responsible third party for BROKER’s services.<br><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>4. MISCELLANEOUS:</strong> <br><br><br>

<strong>A. INDEPENDENT CONTRACTOR:</strong> It is understood and agreed that the relationship between
BROKER and CARRIER is that of independent contractor and that no employer/employee relationship
exists or is intended. BROKER has no control of any kind over CARRIER, including but not limited to
routing of shipment, and nothing contained herein shall be construed to be inconsistent with this
provision.<br><br>

<strong>B. NON-EXCLUSIVE AGREEMENT:</strong> CARRIER and BROKER acknowledge and agree that this
contract does not bind the respective Parties to exclusive services to each other. Either party may enter
into similar agreements with other carriers or brokers.<br><br>

<strong>C. DISPUTES:</strong> In the event of a dispute arising out of this Agreement, including but not limited to
Federal or State statutory claims, the Party’s sole recourse (except as provided below) shall be to
arbitration. Arbitration proceedings shall be started within eighteen (18) months from the date of delivery
or scheduled date of delivery of the shipment, whichever is later. Unless preempted or controlled by federal
transportation law and regulations, the laws of the State of Virginia shall be controlling.<br><br>

<strong>D. NOTIFICATION:</strong> Except for routine communications in the course of performance of this
Agreement which may derive from day to day operations, any notices sent to parties involved in this
Agreement shall be in writing and delivered by email, Fax, or certified mail to the mail address, Fax
phone number and mailing and or/ physical address set forth in this agreement.<br><br>

<strong>E. NO SOLICITATION:</strong> <br><br>

<div style="padding-left:30px">
<strong>i.</strong> Absent specific written Agreement between both the CARRIER AND BROKER, CARRIER
shall not solicit business from any shipper, consignor, consignee or customer of BROKER
where the availability of such business first became known to CARRIER as a result of the
BROKER’s efforts during the term of this agreement.<br><br>

<strong>ii.</strong> CARRIER's acceptance of the shipment(s) will acknowledge that the customer(s) is a
BROKER's customer(s), therefore CARRIER shall never knowingly or unknowingly
perform services of a transportation nature for compensation for any BROKER’s customer(s)
without prior authorization from BROKER or<br><br>

<strong>iii.</strong> offer to the BROKER’s customer(s) a better or lower rate or price<br><br>

<strong>iv.</strong> the foregoing at point E. i., E.ii. and E.iii apply also in the case that the CARRIER is directly
contacted by the shipper or a shipper’s representative,<br><br>

<strong>v.</strong> in the event of violation of this Agreement, CARRIER shall pay BROKER within ten (10)
days of each such violation an amount equal to the Broker commission of not less than
$1.500. Additionally, BROKER may seek injunctive relief and in the event, it is successful,
CARRIER shall be liable for all costs and expenses incurred by BROKER, including, but not
limited to, reasonable attorney's fees.
</div><br><br>

<strong>F. CONFIDENTIALITY:</strong> In addition to Confidential Information protected by law, statutory or
otherwise, the CARRIER agrees that all of BROKER’S financial information and that of their customers,
including but not limited to brokerage rates, amounts tendered for brokerage services, as well as personal
customer information, customer shipping or other logistics requirements shared or learned between the
Parties and BROKER’S customers, shall be treated as Confidential, and shall not be disclosed or used for
any reason without prior written consent.<br><br>

<strong>G. MODIFICATION OF AGREEMENT:</strong> Any modification to the terms and conditions of this
Agreement must be in writing and signed by authorized representatives of both parties to be enforceable.<br><br>

<strong>H. CONTRACT TERM:</strong> This Agreement shall be effective on the date stated above and shall continue
until terminated by a written notice from one party to the other. Unless otherwise specifically agreed to in
writing, this Agreement shall apply to all services rendered by Carrier to Broker, unless terminated, upon
thirty (30) day's prior written notice, with or without cause, by either Party at any time, including the
initial term. In the event of termination of this Agreement for any reason, the Parties shall be obligated to
complete performance of any work in progress in accordance with the terms of this Agreement.<br><br>

<strong>I. SEVERANCE:</strong> If any part of this Agreement is held unenforceable, the rest of the Agreement will
continue in effect.<br><br>

<strong>J. FORCE MAJEURE:</strong> Neither party will be liable for the failure to tender or timely transport freight
under this agreement if such failure, delay or other omission is caused by strikes, acts of God, war,
accidents, civil disorder, or through compliance with legally constituted order of civil or military
authorities.<br><br>

<strong>K. ELECTRONIC SIGNATURE:</strong> This Agreement and any subsequent amendments may be executed
by facsimile (Fax), portable document format (PDF) or other electronic methods (e.g. Adobe Sign) and a
facsimile, PDF or other electronic signature will be treated as an original signature.<br><br>

<strong>L. AUTHORITY OF EXECUTING PARTY:</strong> CARRIER represents and warrants that the individual
executing this agreement, and each rate confirmation (Appendix A), on CARRIER’S behalf has the
authority to execute this agreement and to bind CARRIER to the terms hereof. BROKER represents and
warrants that the individual executing this agreement on BROKER’S behalf has the authority to execute
this agreement and to bind BROKER to the terms hereof.<br><br>


IN WITNESS WHEREOF, the parties (BROKER AND CARRIER) here to execute this Agreement of 7 pages as
of the date and year first written.<br><br>

<strong>BROKER</strong><br><br>

<table width="100%" style="border-spacing: 30px;">
	<tr>
		<td align="center" width="33%"><strong>Authorized Signature:</strong></td>
		<td align="center" width="33%"><strong>Printed Name:</strong></td>
		<td align="center" width="33%"><strong>Title:</strong></td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid ##000;"></td>
		<td style="border-bottom: 1px solid ##000;"></td>
		<td style="border-bottom: 1px solid ##000;"></td>
	</tr>
</table>
<br><br>
<strong>Company Address:</strong><br>
1650 Williamsbridge Rd, Suite A6, Bronx, NY 10461<br><br>

<strong>Phone:</strong> 1-800-976-6833 <strong>FAX:</strong> 703-552-4542 <strong>email:</strong> customercare@nationwideusamovers.com<br><br>

<strong>CARRIER</strong><br><br>

<table width="100%" style="border-spacing: 30px;">
	<tr>
		<td align="center" width="33%"><strong>Authorized Signature:</strong></td>
		<td align="center" width="33%"><strong>Printed Name:</strong></td>
		<td align="center" width="33%"><strong>Title:</strong></td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid ##000;"></td>
		<td style="border-bottom: 1px solid ##000;"></td>
		<td style="border-bottom: 1px solid ##000;"></td>
	</tr>
</table>
<br><br>
<strong>Company Address:</strong><br>
##<br><br>

<strong>Phone:</strong> ## <strong>FAX:</strong> ## <strong>email:</strong> ##<br><br>

Only an Authorized Representative must sign this document. It will be the CARRIER'S full responsibility to ensure
that the person signing this contract is an authorized representative of the company

</span>
	</cfoutput>
</cfsavecontent>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="100">
			<cfdocumentitem type="footer"> 
			#cfdocument.currentpagenumber# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Broker Initials______ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Carrier Initials_______
			</cfdocumentitem> 
			<cfinclude template="carrierletter_template.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="carrierletter_template.cfm">
</cfif>