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
    select * from CLIENTS
    where id=#clientid#
</cfquery>
<!--- All CSS classes used here but definitions not found in this file can be found in the "letter_template.cfm" file --->
<cfsavecontent variable="REQUEST.letter_body" >
	<cfoutput>
	<span class="fontsize12">Dear #trim(getinfo.first_name)# #trim(getinfo.last_name)# or Current Occupant,<br><br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We see that the home in which you reside at #trim(getinfo.FROM_ADDRESS)#<cfif trim(getinfo.FROM_ADDRESS2) is not "">, #trim(getinfo.FROM_ADDRESS2)#</cfif>, listed with #trim(getinfo.realty_company)#,
is closing on #dateformat(trim(getinfo.closing_date), "MM/DD/YYYY")# and soon, you will need to start to get moving estimates.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>NATIONWIDE USA MOVERS, your “ONE STOP SHOP” for estimates and moving quotes</strong> would
like to offer you a FREE-NO OBLIGATION MOVE ESTIMATE.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>NATIONWIDE USA MOVERS</strong> has access to over 7000 federally authorized, licensed and, insured
moving companies. We will find you highly reputable professional movers in your area and get you the
lowest and best prices. Also, you will only have to work with just one Certified Moving Consultant that
will perform a virtual walkthrough of your residence in 20 min or less and, will gather and send you a
variety of moving quotes all in one single email, without the bombarding calls from movers.<br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Call us or go online at <span class="colorblue text-underline">www.get-estimates.com</span> to set up your free Virtual Move Estimate as
soon as possible and use your Personal Promo Code: <span class="fontbold colorred text-underline">#getInfo.discountCode#</span> to lock in up to a 40% discount on
moving services.</strong><br><br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We look forward to assisting you with your move and providing you with the best moving
companies and moving services in your area.
</span>
	</cfoutput>
</cfsavecontent>

<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="100">
		<cfinclude template="letter_templateNew.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="letter_templateNew.cfm">
</cfif>

<!--- <cffunction name="printCloseLetter" returntype="string">
    <cfoutput>
        <div class="closingLetter">
            <div>
                <div style="float:right; padding-top: 60px">
                    <span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span>
                </div>
                <div >
                    <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:225px">
                </div>
            </div>
            
            <div style="padding-top:15px">
                 Dear #getinfo.first_name# #getinfo.last_name#,
            </div>

            <div style="padding-top:15px; font-style:italic;">
                We see your home that is listed with <span style="font-weight:bold">#getinfo.realty_company#</span> is expected to close on
                #dateformat(getinfo.closing_date, "MM/DD/YYYY")#.
            </div>
            
            <div style="padding-top:15px">
                Since your home will be closing in the next few weeks, Affordable USA Movers is offering you a move quote! We guarantee to get you up to a 
                <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured brand-name&##174; and other quality nationwide moving carriers</span>. 
            </div>

            <div style="padding-top:15px">
                <span style="font-weight: bold">
                    Just mention your <span style="color: red">Realty Discount Code&##174; #getInfo.discountCode#</span> to get your discount when calling to confirm your appointment. 
                </span>
                Your free in-home or virtual tour/estimate of the household goods that you are planning to move is scheduled for 
                <span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>.
                Next, your personal Certified Moving Consultant/Estimator will work to find you, out of a variety of carriers, a quality and affordable moving company that 
                will fit your needs and budget. The estimate normally takes 30 minutes and your quote will be emailed to you the same day. 
            </div>

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold;">
                Your Free In-Home or Virtual Estimate for home selling at <br>
                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for <br />
                
                <span style="font-size: 1.4em; font-weight: bold; color: red;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
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
                             <img src="http://www.top12movingbiz.com/admin/letters/3.jpg" width="235" alt="" border="0"></div>
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