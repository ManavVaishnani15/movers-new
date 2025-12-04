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
    <title><cfif parameterexists(clientid) is 'yes'><cfoutput>#getinfo.first_name# #getinfo.last_name# Estimate</cfoutput></cfif></title>
    <style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
    }
    </style>
</head>
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
<body>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
<cfif parameterexists(sendmail) is 'yes'>
    <cfmail
    TO="#getinfo.email#"
    FROM="admin@affordableusamovers.com"
    SUBJECT="Affordable USA Mover preferred list of carriers"
    TYPE="HTML"
    >
            <style>
            body {
                height: 842px;
                width: 595px;
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                margin-top: 0px;
            }
            </style>
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
        <td width="104" valign="Middle"><img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
        <td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>Affordable USA Movers </b></font><font size="1"><br></font><font face="arial" size="6" color="silver"><b>LIST OF CARRIERS</b></font></div></td>
        <td align="right" width="104" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
        </tr>
        </table>
        <cfoutput>
            <table border="1" cellspacing="0" cellpadding="3" width="100%">
            <tr>
            <td bgcolor="silver" valign="middle" width="50%"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
            <td bgcolor="silver" valign="middle"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
            </tr>
            <tr>
            <td valign="top">
            <font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br>
            <b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>#getinfo.from_address#</cfif><br>
            <b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br>
            <b>ORIGIN PHONE</b>: #getinfo.phone#<br>
            <b>EMAIL ADDRESS</b>: #getinfo.email#<br>

            </td>
            <td valign="top">
            <font face="arial" size="2">
            <b>STREET ADDRESS</b>: #getinfo.to_address# <cfif #getinfo.to_address2# is not ''>#getinfo.to_address#</cfif><br> 
            <b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>


            </td>
            </tr>
            </table>
            <font face="arial" size="2">
                <b>
                    The following is a list of the moving companies from a network of hundreds of federally authorized, licensed, bonded, and insured name brand 
                    and other quality nationwide moving carriers that best fit your moving needs. 
                </b>
            </font>
            <br>
        </cfoutput>
        <cfif (#getinfo.valuation# is not 0 AND #getinfo.valuation# is not '') OR #getinfo.packing# is not 0 OR #getinfo.move_type# is not 0 OR #getinfo.transportation# is not '' OR #getinfo.acessorial# is not ''>
        <table border="1" cellspacing="0" cellpadding="0" width="100%">
        <tr>
        <td>
        <table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
        <td valign="middle" width="100%"><cfif #getinfo.weight# is not ''>
        <font face="arial" size="2"><b>Estimated&nbsp;Weight</b>:&nbsp;<cfoutput>#getinfo.weight#</cfoutput></font></cfif>
        </td>
        <td valign="middle"><cfif #getinfo.miles# is not ''>
        <font face="arial" size="2"><b>Miles</b>:&nbsp;<cfoutput>#getinfo.miles#</cfoutput></font></cfif>
        </td>
        </tr>
        <tr>
        <td valign="middle">
        <cfif #getinfo.move_type# is not 0>
        <cfquery name="getmovetype" datasource="aaalh3x_onestep">
        select * from MOVE_TYPES
        where ID=#getinfo.move_type#
        </cfquery>
        <font face="arial" size="2"><b>Move&nbsp;Type</b>:&nbsp;<cfoutput>#getmovetype.type#</cfoutput></font>
        </cfif>
        </td>
        <td valign="middle">
        <font face="arial" size="2"><b>Valuation&nbsp;Included</b>:&nbsp;<cfif #getinfo.valuation_included# is not 0 AND #getinfo.valuation_included# is not ''>Yes<cfelse>No</cfif><cfif #getinfo.valuation# is not 0 and #getinfo.valuation# is not ''>&nbsp;<b>Avg.&nbsp;Amount</b>:&nbsp;$<cfoutput>#getinfo.valuation#</cfoutput></cfif></font>
        </td>
        </tr>
        <tr>
        <td valign="middle">
        <cfif #getinfo.packing# is not 0>
        <cfquery name="getpacking" datasource="aaalh3x_onestep">
        select * from PACKING_TYPES
        where ID=#getinfo.packing#
        </cfquery>
        <font face="arial" size="2"><b>Packing</b>:&nbsp;<cfoutput>#getpacking.type#</cfoutput></font>
        <cfelse>
        <font face="arial" size="2"><b>Packing</b>:&nbsp;Not&nbsp;Requested</font>
        </cfif>
        </td>
        <td valign="middle"><cfoutput>
        <font face="arial" size="2"><b>Storage&nbsp;Included</b>:<cfif #getinfo.storage_included# is 1>&nbsp;Yes<cfelse>&nbsp;No</cfif>&nbsp;<cfif #getinfo.storage_included# is 1><b>Days&nbsp;in&nbsp;Storage</b>:&nbsp;#getinfo.days_in_storage#</cfif></font>
        </td></cfoutput>
        </tr>
        <cfif #getinfo.acessorial# is not ''>
        <tr>
        <td colspan="2">
        <font face="arial" size="2"><b>Accessorials</b>: <cfoutput>#getinfo.acessorial#</cfoutput>
        </td>
        </tr>
        </cfif>
        <cfif #getinfo.estimate_comments# is not ''>
        <tr>
        <td colspan="2">
        <font face="arial" size="2"><b>Comments</b>: <cfoutput>#getinfo.estimate_comments#</cfoutput>
        </td>
        </tr></cfif>
        </table></td></tr></table></cfif>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
            <tr>
                <td bgcolor="silver" colspan="2"><div align="center"><font face="arial" size="2">SERVICE PROVIDERS (CARRIERS) LIST </font></div></td>
            </tr>
            <cfquery name="getmovers" datasource="aaalh3x_onestep">
                select * from CARRIERS
                where active=1 
                order by company
            </cfquery>

            <cfloop query="getmovers">
                <tr>
                    <td valign="middle">
                        <font face="arial" size="2">
                            #getmovers.company#
                            <cfif getmovers.carrier_info is not "">
                                #getmovers.carrier_info#
                            </cfif>
                        </font>
                    </td>
                </tr>
            </cfloop>
        </table>
        
        <hr>
        <table border="0" cellspacing="0" cellpadding="3" width="100%">
        <tr>
        <td valign="top"><font face="arial" size="1"><b>FOR QUESTIONS OR TO BOOK YOUR MOVE, PLEASE CONTACT YOUR AGENT</b></font><br>
        <font size="2" face="arial"><cfoutput><b>#verify.name#</b><br>
        <cfif #verify.phone# is not ''>#verify.phone#</cfif> <cfif #verify.email# is not ''>#verify.email#</cfif></cfoutput></font>
        </td>
        <td valign="top"><font face="arial" size="2"><b>Affordable USA Movers </b></font><br>
        <font face="arial" size="2">1-800-289-5329<br>
        <cfoutput>#getinfo.mc_number#</cfoutput></font>
        </td>
        </tr>
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;">
                <span style="font-weight: bold">Affordable USA Movers :</span>
                MC ## 945837 USDOT ## 2867211 8000 Towers Crescent Dr Suite 1350 Vienna VA 22182 
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
                Disclaimer: Moving &amp; Relocation Services, Inc (DBA as Affordable USA Movers) is a federally authorized Household Goods Moving Broker and lead generation 
                company that does not transport household goods but arranges for such transportation by an authorized Household Goods Motor Carrier. Moving &amp; Relocation Services, 
                Inc (DBA as Affordable USA Movers) is not a motor carrier, does not own moving trucks and will not act as a carrier in any way during your move. Moving &amp; Relocation 
                Services, Inc. (DBA as Affordable USA Movers) estimates are based either on its own tariff rates or on the tariff rates of contracted household goods motor carriers 
                included in its network. All tariff rates are available for public inspection upon request.
            </td>
        </tr>
        </table>
        
    </cfmail>


    <cfif parameterexists(altmail) is 'yes'>

    <cfmail
    TO="#verify.email#"
    FROM="admin@affordableusamovers.com"
    SUBJECT="Affordable USA Mover preferred list of carriers"
    TYPE="HTML"
    >
        <style>
            body {
                height: 842px;
                width: 595px;
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                margin-top: 0px;
            }
            </style>
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
        <td width="104" valign="Middle"><img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
        <td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>Affordable USA Movers </b></font><font size="1"><br></font><font face="arial" size="6" color="silver"><b>LIST OF CARRIERS</b></font></div></td>
        <td align="right" width="104" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
        </tr>
        </table>
        <cfoutput>
        <table border="1" cellspacing="0" cellpadding="3" width="100%">
        <tr>
        <td bgcolor="silver" valign="middle" width="50%"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
        <td bgcolor="silver" valign="middle"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
        </tr>
        <tr>
        <td valign="top">
        <font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br>
        <b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>#getinfo.from_address#</cfif><br>
        <b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br>
        <b>ORIGIN PHONE</b>: #getinfo.phone#<br>
        <b>EMAIL ADDRESS</b>: #getinfo.email#<br>

        </td>
        <td valign="top">
        <font face="arial" size="2">
        <b>STREET ADDRESS</b>: #getinfo.to_address# <cfif #getinfo.to_address2# is not ''>#getinfo.to_address#</cfif><br> 
        <b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>


        </td>
        </tr>
        </table>
        <font face="arial" size="2">
        <b>
            The following is a list of the moving companies from a network of hundreds of federally authorized, licensed, bonded, and insured name brand 
                    and other quality nationwide moving carriers that best fit your moving needs.  
        </b></font><br></cfoutput>
        <cfif (#getinfo.valuation# is not 0 AND #getinfo.valuation# is not '') OR #getinfo.packing# is not 0 OR #getinfo.move_type# is not 0 OR #getinfo.transportation# is not '' OR #getinfo.acessorial# is not ''>
        <table border="1" cellspacing="0" cellpadding="0" width="100%">
        <tr>
        <td>
        <table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
        <td valign="middle" width="100%"><cfif #getinfo.weight# is not ''>
        <font face="arial" size="2"><b>Estimated&nbsp;Weight</b>:&nbsp;<cfoutput>#getinfo.weight#</cfoutput></font></cfif>
        </td>
        <td valign="middle"><cfif #getinfo.miles# is not ''>
        <font face="arial" size="2"><b>Miles</b>:&nbsp;<cfoutput>#getinfo.miles#</cfoutput></font></cfif>
        </td>
        </tr>
        <tr>
        <td valign="middle">
        <cfif #getinfo.move_type# is not 0>
        <cfquery name="getmovetype" datasource="aaalh3x_onestep">
        select * from MOVE_TYPES
        where ID=#getinfo.move_type#
        </cfquery>
        <font face="arial" size="2"><b>Move&nbsp;Type</b>:&nbsp;<cfoutput>#getmovetype.type#</cfoutput></font>
        </cfif>
        </td>
        <td valign="middle">
        <font face="arial" size="2"><b>Valuation&nbsp;Included</b>:&nbsp;<cfif #getinfo.valuation_included# is not 0 AND #getinfo.valuation_included# is not ''>Yes<cfelse>No</cfif><cfif #getinfo.valuation# is not 0 and #getinfo.valuation# is not ''>&nbsp;<b>Avg.&nbsp;Amount</b>:&nbsp;$<cfoutput>#getinfo.valuation#</cfoutput></cfif></font>
        </td>
        </tr>
        <tr>
        <td valign="middle">
        <cfif #getinfo.packing# is not 0>
        <cfquery name="getpacking" datasource="aaalh3x_onestep">
        select * from PACKING_TYPES
        where ID=#getinfo.packing#
        </cfquery>
        <font face="arial" size="2"><b>Packing</b>:&nbsp;<cfoutput>#getpacking.type#</cfoutput></font>
        <cfelse>
        <font face="arial" size="2"><b>Packing</b>:&nbsp;Not&nbsp;Requested</font>
        </cfif>
        </td>
        <td valign="middle"><cfoutput>
        <font face="arial" size="2"><b>Storage&nbsp;Included</b>:<cfif #getinfo.storage_included# is 1>&nbsp;Yes<cfelse>&nbsp;No</cfif>&nbsp;<cfif #getinfo.storage_included# is 1><b>Days&nbsp;in&nbsp;Storage</b>:&nbsp;#getinfo.days_in_storage#</cfif></font>
        </td></cfoutput>
        </tr>
        <cfif #getinfo.acessorial# is not ''>
        <tr>
        <td colspan="2">
        <font face="arial" size="2"><b>Accessorials</b>: <cfoutput>#getinfo.acessorial#</cfoutput>
        </td>
        </tr>
        </cfif>
        <cfif #getinfo.estimate_comments# is not ''>
        <tr>
        <td colspan="2">
        <font face="arial" size="2"><b>Comments</b>: <cfoutput>#getinfo.estimate_comments#</cfoutput>
        </td>
        </tr></cfif>
        </table></td></tr></table></cfif>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
            <tr>
                <td bgcolor="silver" colspan="2"><div align="center"><font face="arial" size="2">SERVICE PROVIDERS (CARRIERS) LIST </font></div></td>
            </tr>
            <cfquery name="getmovers" datasource="aaalh3x_onestep">
                select * from CARRIERS
                where active=1 
                order by company
            </cfquery>

            <cfloop query="getmovers">
                <tr>
                    <td valign="middle">
                        <font face="arial" size="2">
                            #getmovers.company#
                            <cfif getmovers.carrier_info is not "">
                                #getmovers.carrier_info#
                            </cfif>
                        </font>
                    </td>
                </tr>
            </cfloop>
        </table>
        
        <hr>
        <table border="0" cellspacing="0" cellpadding="3" width="100%">
        <tr>
        <td valign="top"><font face="arial" size="1"><b>FOR QUESTIONS OR TO BOOK YOUR MOVE, PLEASE CONTACT YOUR AGENT</b></font><br>
        <font size="2" face="arial"><cfoutput><b>#verify.name#</b><br>
        <cfif #verify.phone# is not ''>#verify.phone#</cfif> <cfif #verify.email# is not ''>#verify.email#</cfif></cfoutput></font>
        </td>
        <td valign="top"><font face="arial" size="2"><b>Affordable USA Movers </b></font><br>
        <font face="arial" size="2">1-800-289-5329<br>
        <cfoutput>#getinfo.mc_number#</cfoutput></font>
        </td>
        </tr>
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;">
                <span style="font-weight: bold">Affordable USA Movers :</span>
                MC ## 945837 USDOT ## 2867211 8000 Towers Crescent Dr Suite 1350 Vienna VA 22182
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
                Disclaimer: Moving &amp; Relocation Services, Inc (DBA as Affordable USA Movers) is a federally authorized Household Goods Moving Broker and lead generation 
                company that does not transport household goods but arranges for such transportation by an authorized Household Goods Motor Carrier. Moving &amp; Relocation Services, 
                Inc (DBA as Affordable USA Movers) is not a motor carrier, does not own moving trucks and will not act as a carrier in any way during your move. Moving &amp; Relocation 
                Services, Inc. (DBA as Affordable USA Movers) estimates are based either on its own tariff rates or on the tariff rates of contracted household goods motor carriers 
                included in its network. All tariff rates are available for public inspection upon request.
            </td>
        </tr>
        </table>
            
    </cfmail>

    </cfif>

    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=8 and cust_hook=#clientid#
    </cfquery>
    <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('9','2','#clientid#','#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into LETTER_SENDS
        (send_type,sent,cust_hook,sent_date)
        values ('8','2','#clientid#','#datenow#')
        </cfquery>
    </cfif>
    Mail Sent - Recorded that it was sent - You may now close this tab
     
     <cfif parameterexists(altmail) is 'yes'>
     <br>Send a copy to administrator<br>
     </cfif>

<cfelse>
<style>
    body {
        height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        margin-top: 0px;
    }
    </style>
<cfif parameterexists(emailit) is 'yes'>
<form action="carrierList.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<div align="center">
<input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput> Now"><br>
<input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>
</cfif>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td width="104" valign="Middle"><img src="/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>Affordable USA Movers </b></font><font size="1"><br></font><font face="arial" size="6" color="silver"><b>LIST OF CARRIERS</b></font></div></td>
<td align="right" width="104" valign="middle"><font face="arial" size="3"><cfoutput>#dateformat(now(), "MM/DD/YYYY")#</cfoutput></font></td>
</tr>
</table>
<cfoutput>
<table border="1" cellspacing="0" cellpadding="3" width="100%">
<tr>
<td bgcolor="silver" valign="middle" width="50%"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
<td bgcolor="silver" valign="middle"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
</tr>
<tr>
<td valign="top">
<font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br>
<b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>#getinfo.from_address#</cfif><br>
<b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br>
<b>ORIGIN PHONE</b>: #getinfo.phone#<br>
<b>EMAIL ADDRESS</b>: #getinfo.email#<br>

</td>
<td valign="top">
<font face="arial" size="2">
<b>STREET ADDRESS</b>: #getinfo.to_address# <cfif #getinfo.to_address2# is not ''>#getinfo.to_address#</cfif><br> 
<b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>


</td>
</tr>
</table>
<font face="arial" size="2">
<b>
    The following is a list of the moving companies from a network of hundreds of federally authorized, licensed, bonded, and insured name brand 
                    and other quality nationwide moving carriers that best fit your moving needs. 
</b></font><br></cfoutput>
<cfif (#getinfo.valuation# is not 0 AND #getinfo.valuation# is not '') OR #getinfo.packing# is not 0 OR #getinfo.move_type# is not 0 OR #getinfo.transportation# is not '' OR #getinfo.acessorial# is not ''>
<table border="1" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="2" width="100%">
<tr>
<td valign="middle" width="100%"><cfif #getinfo.weight# is not ''>
<font face="arial" size="2"><b>Estimated&nbsp;Weight</b>:&nbsp;<cfoutput>#getinfo.weight#</cfoutput></font></cfif>
</td>
<td valign="middle"><cfif #getinfo.miles# is not ''>
<font face="arial" size="2"><b>Miles</b>:&nbsp;<cfoutput>#getinfo.miles#</cfoutput></font></cfif>
</td>
</tr>
<tr>
<td valign="middle">
<cfif #getinfo.move_type# is not 0>
<cfquery name="getmovetype" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where ID=#getinfo.move_type#
</cfquery>
<font face="arial" size="2"><b>Move&nbsp;Type</b>:&nbsp;<cfoutput>#getmovetype.type#</cfoutput></font>
</cfif>
</td>
<td valign="middle">
<font face="arial" size="2"><b>Valuation&nbsp;Included</b>:&nbsp;<cfif #getinfo.valuation_included# is not 0 AND #getinfo.valuation_included# is not ''>Yes<cfelse>No</cfif><cfif #getinfo.valuation# is not 0 and #getinfo.valuation# is not ''>&nbsp;<b>Avg.&nbsp;Amount</b>:&nbsp;$<cfoutput>#getinfo.valuation#</cfoutput></cfif></font>
</td>
</tr>
<tr>
<td valign="middle">
<cfif #getinfo.packing# is not 0>
<cfquery name="getpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where ID=#getinfo.packing#
</cfquery>
<font face="arial" size="2"><b>Packing</b>:&nbsp;<cfoutput>#getpacking.type#</cfoutput></font>
<cfelse>
<font face="arial" size="2"><b>Packing</b>:&nbsp;Not&nbsp;Requested</font>
</cfif>
</td>
<td valign="middle"><cfoutput>
<font face="arial" size="2"><b>Storage&nbsp;Included</b>:<cfif #getinfo.storage_included# is 1>&nbsp;Yes<cfelse>&nbsp;No</cfif>&nbsp;<cfif #getinfo.storage_included# is 1><b>Days&nbsp;in&nbsp;Storage</b>:&nbsp;#getinfo.days_in_storage#</cfif></font>
</td></cfoutput>
</tr>
<cfif #getinfo.acessorial# is not ''>
<tr>
<td colspan="2">
<font face="arial" size="2"><b>Accessorials</b>: <cfoutput>#getinfo.acessorial#</cfoutput>
</td>
</tr>
</cfif>
<cfif #getinfo.estimate_comments# is not ''>
<tr>
<td colspan="2">
<font face="arial" size="2"><b>Comments</b>: <cfoutput>#getinfo.estimate_comments#</cfoutput>
</td>
</tr></cfif>
</table></td></tr></table></cfif>
<table border="1" cellspacing="0" cellpadding="2" width="100%">
            <tr>
                <td bgcolor="silver" colspan="2"><div align="center"><font face="arial" size="2">SERVICE PROVIDERS (CARRIERS) LIST </font></div></td>
            </tr>
            <cfquery name="getmovers" datasource="aaalh3x_onestep">
                select * from CARRIERS
                where active=1 
                order by company
            </cfquery>

            <cfoutput query="getmovers">
                <tr>
                    <td valign="middle">
                        <font face="arial" size="2">
                            #getmovers.company#
                            <cfif getmovers.carrier_info is not "">
                                #getmovers.carrier_info#
                            </cfif>
                        </font>
                    </td>
                </tr>
            </cfoutput>
        </table>
        
        <br />
<table border="0" cellspacing="0" cellpadding="2" width="100%">
<tr><Td colspan="2" height="1" bgcolor="gray"></td></tr>
<tr>
<td valign="top"><font face="arial" size="1"><b>FOR QUESTIONS OR TO BOOK YOUR MOVE, PLEASE CONTACT YOUR AGENT</b></font><font size="1"><br></font>
<font size="2" face="arial"><cfoutput><b>#verify.name#</b><font size="1"><br></font>
<cfif #verify.phone# is not ''>#verify.phone#</cfif> <cfif #verify.email# is not ''>#verify.email#</cfif></cfoutput></font>
</td>
<td valign="top"><font face="arial" size="2"><b>Affordable USA Movers </b></font><font size="1"><br></font>
<font face="arial" size="2">1-800-289-5329<font size="1"><br></font>
<cfoutput>#getinfo.mc_number#</cfoutput></font>
</td>
</tr>
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;">
                <span style="font-weight: bold">Affordable USA Movers :</span>
                MC # 945837 USDOT # 2867211 8000 Towers Crescent Dr Suite 1350 Vienna VA 22182
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
                Disclaimer: Moving &amp; Relocation Services, Inc (DBA as Affordable USA Movers) is a federally authorized Household Goods Moving Broker and lead generation 
                company that does not transport household goods but arranges for such transportation by an authorized Household Goods Motor Carrier. Moving &amp; Relocation Services, 
                Inc (DBA as Affordable USA Movers) is not a motor carrier, does not own moving trucks and will not act as a carrier in any way during your move. Moving &amp; Relocation 
                Services, Inc. (DBA as Affordable USA Movers) estimates are based either on its own tariff rates or on the tariff rates of contracted household goods motor carriers 
                included in its network. All tariff rates are available for public inspection upon request.
            </td>
        </tr>
</table>
</cfif>
</body>
</html>
