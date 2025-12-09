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
        .letterBody {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:21px;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:21px;
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
            font-size:19px;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        .logoImg {
            width: 175px;
        }
        .otherImg { width:185px; }
        @media print {
             .logoImg {
                width: 175px;
            }
            .otherImg {width: 185px;}
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

<cfsavecontent variable="REQUEST.letter_body">
    <cfoutput>
        <div class="fontsize14" style="padding-left:15px; padding-right:15px; line-height:1.3em;">

            Dear #trim(getinfo.first_name)# #trim(getinfo.last_name)# or Current Occupant,<br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            We've recently been in contact with your Realtor, 
            #trim(getinfo.realtor_name)# at 
            #trim(getinfo.realty_company)# and, since your home at 
            #trim(getinfo.FROM_ADDRESS)#<cfif trim(getinfo.FROM_ADDRESS2) NEQ ''>, #trim(getinfo.FROM_ADDRESS2)#</cfif> 
            was recentely listed, we will be offering you huge moving discounts.<br><br>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Get your Quick & Easy Virtual Estimate & lock in your discounts before they expire.<br><br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Virtual Walkthroughs are simply & easily done by using your cell phone.<br><br>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            Call us or go online and don’t forget to mention or type in your personal 

            <b>Move Discount Code:</b> 
            
            <span class="fontbold colorred" style="text-decoration:underline;">#getinfo.discountCode#</span>.<br><br>

        </div>

    </cfoutput>
</cfsavecontent>


<cfif directPrint is 1>
	<cfdocument format="pdf"  orientation="portrait" scale="88">
		<cfinclude template="letter_templateNew.cfm">
	</cfdocument>
<cfelse>
	<cfinclude template="letter_templateNew.cfm">
</cfif>
<!--- 
<cffunction name="printNewListLetter" returntype="string">
    <cfoutput>
        <div class="letterBody" style="font-family:arial;">
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
                We see that your home is listed with <span style="font-weight:bold">#getinfo.realty_company#</span>. We wish you a speedy sale! 
            </div>
            
            <div style="padding-top:15px">
                Affordable USA Movers would like to provide you a move quote where we guarantee to get you up to a 
                <span style="font-weight: bold">70% discount</span> off the Tariff rates on out-of-state moves or up to <span style="font-weight: bold">40% savings</span>
                on local moves and storage from a network of <span style="text-decoration: underline">hundreds of federally authorized, licensed, bonded and insured brand-name&##174; and other quality nationwide moving carriers</span>. 
            </div>

            <div style="padding-top:15px">
                <span style="font-weight: bold">
                    Just mention your <span style="color: red">Realty Discount Code&##174; #getInfo.discountCode#</span> to get your discount when calling to confirm your appointment. 
                </span>
                After your appointment, your personal Certified Moving Consultant/Estimator will work to find you, out of a variety of carriers, a quality and affordable 
                moving company that will fit your needs and budget. The in-home or virtual tour/estimate normally takes 30 minutes and your quote will be emailed to you the same day. 
            </div>

            <div style="margin-left:auto; margin-right:auto; width:100%; text-align:center; padding-top: 15px; font-size: 1.2em; font-weight: bold; line-height:25px">
                Your Free In-Home or Virtual Estimate for home selling at <br>
                <span style="text-decoration:underline">#getinfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif></span> is scheduled for <br />
                
                <span style="font-size: 1.4em; font-weight: bold; color: red;line-height: 50px">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span><br />
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
                             <img src="http://www.top12movingbiz.com/admin/letters/3.jpg" style="width:235px" alt="" border="0"></div>
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