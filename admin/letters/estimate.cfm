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
    <cfset emailList = getinfo.email>
    <cfif parameterexists(sendEmailToAll) and sendEmailToAll eq '1'>
        <cfif len(trim(getinfo.email2))>
            <cfset emailList = emailList & "," & trim(getinfo.email2)>
        </cfif>
    </cfif>
    <cfmail
     server="vps.affordableusamovers.com"
      username="customercare@nationwideusamovers.com" 
      password="Temp1707!" 
      port="587" 
      useSSL="false"
    TO="#emailList#"
    FROM="move-quotes@nationwideusamovers.com"
    SUBJECT="Your Moving Quote"
    TYPE="HTML">
            <style>
            body {
                height: 842px;
                width: 700px;
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                margin-top: 0px;
            }
    ##initialInTable {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: ##000;
}
            </style>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td width="104" valign="Middle"><img src="http://top12movingbiz.com/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>NATIONWIDE USA MOVERS</b></font><font size="1"><br></font><font face="arial" size="5" color="silver"><b>MOVING<br>ESTIMATES</b></font></div></td>
<td align="right" width="104" valign="middle"><font face="arial" size="4"><cfoutput><strong>#dateformat(now(), "MM/DD/YYYY")#</strong></cfoutput></font></td>
</tr>
</table>
<cfoutput>
<table border="1" cellspacing="0" cellpadding="3" width="100%">
<tr>
<td bgcolor="silver" valign="middle" width="50%" height="40"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
<td bgcolor="silver" valign="middle" height="40"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
</tr>
<tr>
<td valign="top">
<font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br><br>
<b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>, #getinfo.from_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br><br>
<b>ORIGIN PHONE</b>: #getinfo.phone#<br><br>
<b>EMAIL ADDRESS</b>: #getinfo.email#<br><br>
<b>SECOND EMAIL ADDRESS</b>: #getinfo.email2#<br><br>
<b>CELL</b>: #getinfo.cell#<br><br>
<b>SECOND CELL</b>: #getinfo.cell2#<br>
</td>

<td valign="top">
<font face="arial" size="2">
<b>STREET ADDRESS</b>: #getinfo.to_address#<cfif #getinfo.to_address2# is not ''>, #getinfo.to_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>

</td>
</tr>
</table>
</cfoutput>
      
            <table cellspacing="5" cellpadding="3" width="100%">
            	<tr>
            		<td style="font-family:Arial; font-size:12px; font-weight:bold;">DEPENDING ON THE MOVING COMPANY, OUT OF STATE ESTIMATES CAN BE BINDING, NON-BINDING, NOT TO EXCEED OR BY CUBIC FEET, LOCAL, INTRASTATE AND STORAGE ESTIMATES CAN BE FLAT RATE, HOURLY OR NOT TO EXCEED.<br>
						ASK YOUR MOVING CONSULTANT FOR CLARIFICATION ON THE TYPE OF ESTIMATE FOR EACH COMPANY.</td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;">The following quotes represent the carrier's estimated bottom-line price conveyed to us by each of the listed service
					providers and are valid when accepted and signed within 30 days or 15 days if in peak season period, from the date
					the estimate is issued. The estimated price is valid only if the Order For Service is signed with the selected carrier.<br>
					<u>Changes to the loading date could result in a price change.</u></td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;"><u>Please select and initial
next to the carrier you are choosing for your move, then sign, date
the Moving Estimates form and email back to customercare@nationwideusamovers.com.<br>
Notify immediately the selection to your Moving Consultant to lock in your date and pricing.
Once you select the Mover, your Moving Consultant will explain and help you understand
what type of Estimate & Services you will receive.</u></td>
            	</tr>
            </table>
        
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
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td><div align="center"><font face="arial" size="2"><b>Cargo Specifics / Storage</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Estimated Weight: Under #getinfo.weight# lbs. or Under #getinfo.CubicFeet# Cubic Feet</font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">Valuation Included: <cfif getinfo.valuation_included eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.valuation_Comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.valuation_Comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">3rd Party Moving Insurance: <cfif getinfo.thirdPartyInsurance eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.thirdPartyIns_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.thirdPartyIns_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">Auto Shipping: <cfif getinfo.autoShipping eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.autoShipping_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.autoShipping_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Storage Included: <cfif getinfo.storage_included eq 1>YES<cfelse>NO</cfif> <cfif getinfo.storage_included eq 1> - Days/Months of storage included in quote: #getinfo.days_in_storage#</cfif></font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.StorageType#</font></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.WarehouseType#</font></td>
	        </tr>
        </table>
   </cfoutput>
        <br>
        
<cfif getinfo.OtherServices neq "">
<cfquery name="getOtherServices" datasource="aaalh3x_onestep">
SELECT *
FROM other_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getOtherServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Other Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.OtherServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getOtherServicesTempTotal = 0>
                    <cfloop query="getOtherServices">
                    <cfset getOtherServicesTempTotal = getOtherServicesTempTotal + getOtherServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getOtherServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Other Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>

<cfif getinfo.thirdPartyServices neq "">
<cfquery name="getThirdpartyServices" datasource="aaalh3x_onestep">
SELECT *
FROM thirdparty_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getThirdpartyServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Third Party Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.thirdPartyServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getThirdpartyServicesTempTotal = 0>
                    <cfloop query="getThirdpartyServices">
                    <cfset getThirdpartyServicesTempTotal = getThirdpartyServicesTempTotal + getThirdpartyServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getThirdpartyServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Third Party Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>
        
<cfquery name="checkForPacking" datasource="aaalh3x_onestep">
SELECT *
FROM Packing
WHERE ClientID = #clientid#
</cfquery>
<cfif checkForPacking.RecordCount>
	<cfif checkForPacking.packingType eq "Full Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: FULL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Self Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: SELF PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Partial Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: PARTIAL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
<br>
</cfif>
        
<cfset hideHoursColumn = true>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
    <cfloop query="getmovers">
    <cfquery name="getqt" datasource="aaalh3x_onestep">
    select * from ESTIMATES
    where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
    </cfquery>
    <cfif getqt.MenQty neq "" or getqt.VanQty neq "" or getqt.HoursQty neq "" or getqt.TravelTimeQty neq "">
    	<cfset hideHoursColumn = false>
    </cfif>
</cfloop>
        
<table border="1" cellspacing="0" cellpadding="2" width="100%">
<tr>
<td colspan="6"><div align="center"><font face="arial" size="2"><b>YOUR MOVE COST QUOTES</b></font></div></td>
</tr>
<tr>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER</font></div></td>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">TYPE OF QUOTE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">COMMENTS</font></div></td>
    <cfif hideHoursColumn eq false><td bgcolor="silver"><div align="center"><font face="arial" size="2">HOURS</font></div></td></cfif>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">PRICE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER SELECTED</font></div></td>
</tr>
<!--- check for 'other carrier' --->
<cfif #getinfo.other_carrier# is not '' and #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not '0'>
<tr><cfoutput>
	<td valign="middle"><font face="arial" size="2">#getinfo.other_carrier#</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2">&nbsp;</font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getinfo.other_carrier_amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr>
</cfif>

<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
<cfloop query="getmovers">
	<cfquery name="getqt" datasource="aaalh3x_onestep">
	select * from ESTIMATES
	where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
	</cfquery>
    <cfif getqt.MenQty neq "" or getqt.VanQty neq "" or getqt.HoursQty neq "" or getqt.TravelTimeQty neq "">
    	<cfset hideHoursColumn = false>
    </cfif>
<cfif #getqt.recordcount# is not 0>
<tr><cfoutput>
	<td valign="middle">
        <cfif getmovers.Rating neq "">
        <cfif getmovers.Rating eq "5">
        	<cfset starText = "Excellent Moving Services">
        <cfelseif getmovers.Rating eq "4.5">
        	<cfset starText = "Very Good Moving Services">
        <cfelseif getmovers.Rating eq "4">
        	<cfset starText = "Good Moving Services">
        <cfelseif getmovers.Rating eq "3.5">
        	<cfset starText = "Satisfactory Moving Services">
        <cfelseif getmovers.Rating eq "3">
        	<cfset starText = "Acceptable Moving Services">
        <cfelseif getmovers.Rating eq "2.5">
        	<cfset starText = "Reasonable Moving Services">
        <cfelseif getmovers.Rating eq "2">
        	<cfset starText = "Adequate Moving Services">
        <cfelseif getmovers.Rating eq "1.5">
        	<cfset starText = "Fair Moving Services">
        <cfelseif getmovers.Rating eq "1">
        	<cfset starText = "Sufficient Moving Services">
        <cfelse>
        	<cfset starText = "">
        </cfif>
        <img src="http://top12movingbiz.com/images/#getmovers.Rating#star.jpg" width="75"> <span style="color:blue; font-family:Arial; font-size:11px; font-weight:bold;">#starText#</span><br></cfif>
    <font face="arial" size="2">#getmovers.company#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.TypeOfQuote#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.QuoteComment#</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2"><cfif getqt.MenQty neq ""> #getqt.MenQty# Men; </cfif><cfif getqt.VanQty neq ""> #getqt.VanQty# Vans; </cfif><cfif getqt.HoursQty neq ""> #getqt.HoursQty# Hours; </cfif><cfif getqt.TravelTimeQty neq ""> #getqt.TravelTimeQty# hours Travel Time; </cfif></font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getqt.amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr></cfif></cfloop>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="2" width="100%" style="font-family:arial; font-size:13px;">
<tr>
	<td>
	<p>I request the above selected carrier to provide the services described in the above move estimates.</p>
    <p style="text-decoration:underline; font-weight:bold;">
I understand that if I choose to go around and sign up directly with the selected carrier, or any other carrier,
before or after booking and signing this agreement with Nationwide USA Movers, Nationwide USA Movers will
not be held responsible for the quality of the moving services offered. Moreover, I understand that the move will
not be monitored and managed by Nationwide USA Movers and, this may result in extreme overcharges and poor
quality of moving services and the shipment will lose move protection.
    </p>    
	<p>
		I understand that adding more items or services could result in additional charges because it increases the weight/volume of the shipment, requires more labor and/or trucks, more packing or packing materials, temporary storage or all of the above. I understand also that additional charges could be added for changes in pick-up or delivery dates. There could be additional charges for services not listed.
	</p>
    <p>I acknowledge that I elected to waive a physical survey of the household goods that need to be moved and that the
above move estimates are based on a virtual survey of my household goods conducted using a video technology.</p>
<p>I understand that is my responsibility to show all items that are to be shipped so that an accurate survey can be
completed. I also understand that this type of survey does not constitute a physical survey and this waiver indicates
my consent to a virtual survey using video technology.</p>
<p>I acknowledge I have received the electronic version of "Your Rights and Responsibilities when you move" brochure
and "Ready to Move?" pamphlet both also located at <a href="http://www.protectyourmove.gov">www.protectyourmove.gov</a>.</p>
<p>I acknowledge that I have read the Nationwide USA Movers Terms & Conditions and Cancellation Policy and Privacy
Policy located on Nationwide USA Movers website at <a href="http://www.nationwideusamovers.com">www.nationwideusamovers.com</a>.</p>

    <table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <th scope="col" width="40%">Signature</th>
        <th scope="col" width="40%" align="center">Print Name</th>
        <th scope="col" width="20%" align="center">Date</th>
      </tr>
      <tr>
        <td height="50">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    </td>
</tr>
</table>
        
<table border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<td width="60%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top">
		<br>FOR QUESTIONS OR TO BOOK YOUR MOVE<br>
		PLEASE CONTACT YOUR MOVING CONSULTANT	<br><br>
<cfoutput>		
#verify.name#<br>
Direct Line 7 days/wk: #verify.phone#<br>
Email address: #verify.email#</cfoutput>
		</td>
		<td width="40%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top" align="center">
<br>Nationwide USA Movers Inc<br><br>
Phone: 1-800-976-6833<br>
		</td>
	</tr>
</table>
        
<table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;" align="center">
                <span style="font-weight: bold">Nationwide USA Movers Corporate Headquarters: 2319 Third Avenue, Suite 1710 New York, NY 10035 MC ## 945837 USDOT ## 3558324</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
               Nationwide USA Movers, Inc is a federally licensed and FMCSA authorized Household Goods Move Manager and
Broker, that does not own trucks but provides estimates with better pricing for customers and only arranges for
transportation of Household Goods and additional services by an authorized Household Goods Motor Carrier. All
quotes are based on the Household Good Motor Carriers' published tariffs.
            </td>
        </tr>
</table>
    <cfmailparam file="C:\home\top12movingbiz.com\wwwroot\documents\readytomove_pamphlet.pdf">
    <cfmailparam file="C:\home\top12movingbiz.com\wwwroot\documents\your-rights-and-responsibilities-when-you-move.pdf">
    </cfmail>


    <cfif parameterexists(altmail) is 'yes'>

    <cfmail
     server="vps.affordableusamovers.com"
      username="customercare@nationwideusamovers.com" 
      password="Temp1707!" 
      port="587" 
      useSSL="false"
    TO="#verify.email#"
    FROM="move-quotes@nationwideusamovers.com"
    SUBJECT="Your Moving Quote"
    TYPE="HTML">
        <style>
            body {
                height: 842px;
                width: 700px;
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                margin-top: 0px;
            }
    ##initialInTable {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: ##000;
}
            </style>
<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td width="104" valign="Middle"><img src="http://top12movingbiz.com/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>NATIONWIDE USA MOVERS</b></font><font size="1"><br></font><font face="arial" size="5" color="silver"><b>MOVING<br>ESTIMATES</b></font></div></td>
<td align="right" width="104" valign="middle"><font face="arial" size="4"><cfoutput><strong>#dateformat(now(), "MM/DD/YYYY")#</strong></cfoutput></font></td>
</tr>
</table>
        <cfoutput>
<table border="1" cellspacing="0" cellpadding="3" width="100%">
<tr>
<td bgcolor="silver" valign="middle" width="50%" height="40"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
<td bgcolor="silver" valign="middle" height="40"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
</tr>
<tr>
<td valign="top">
<font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br><br>
<b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>, #getinfo.from_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br><br>
<b>ORIGIN PHONE</b>: #getinfo.phone#<br><br>
<b>EMAIL ADDRESS</b>: #getinfo.email#<br><br>
<b>SECOND EMAIL ADDRESS</b>: #getinfo.email2#<br><br>
<b>CELL</b>: #getinfo.cell#<br><br>
<b>SECOND CELL</b>: #getinfo.cell2#<br>
</td>

<td valign="top">
<font face="arial" size="2">
<b>STREET ADDRESS</b>: #getinfo.to_address#<cfif #getinfo.to_address2# is not ''>, #getinfo.to_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>

</td>
</tr>
</table>
</cfoutput>

            <table cellspacing="5" cellpadding="3" width="100%">
            	<tr>
            		<td style="font-family:Arial; font-size:12px; font-weight:bold;">DEPENDING ON THE MOVING COMPANY, OUT OF STATE ESTIMATES CAN BE BINDING, NON-BINDING, NOT TO EXCEED OR BY CUBIC FEET, LOCAL, INTRASTATE AND STORAGE ESTIMATES CAN BE FLAT RATE, HOURLY OR NOT TO EXCEED.<br>
						ASK YOUR MOVING CONSULTANT FOR CLARIFICATION ON THE TYPE OF ESTIMATE FOR EACH COMPANY.</td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;">The following quotes represent the carrier's estimated bottom-line price conveyed to us by each of the listed service
					providers and are valid when accepted and signed within 30 days or 15 days if in peak season period, from the date
					the estimate is issued. The estimated price is valid only if the Order For Service is signed with the selected carrier.<br>
					<u>Changes to the loading date could result in a price change.</u></td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;"><u>Please select and initial
next to the carrier you are choosing for your move, then sign, date
the Moving Estimates form and email back to customercare@nationwideusamovers.com.<br>
Notify immediately the selection to your Moving Consultant to lock in your date and pricing.
Once you select the Mover, your Moving Consultant will explain and help you understand
what type of Estimate & Services you will receive.</u></td>
            	</tr>
            </table>
        
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
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td><div align="center"><font face="arial" size="2"><b>Cargo Specifics / Storage</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Estimated Weight: Under #getinfo.weight# lbs. or Under #getinfo.CubicFeet# Cubic Feet</font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">Valuation Included: <cfif getinfo.valuation_included eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.valuation_Comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.valuation_Comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">3rd Party Moving Insurance: <cfif getinfo.thirdPartyInsurance eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.thirdPartyIns_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.thirdPartyIns_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">Auto Shipping: <cfif getinfo.autoShipping eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.autoShipping_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.autoShipping_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Storage Included: <cfif getinfo.storage_included eq 1>YES<cfelse>NO</cfif> <cfif getinfo.storage_included eq 1> - Days/Months of storage included in quote: #getinfo.days_in_storage#</cfif></font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.StorageType#</font></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.WarehouseType#</font></td>
	        </tr>
        </table>
   </cfoutput>
        <br>
        
<cfif getinfo.OtherServices neq "">
<cfquery name="getOtherServices" datasource="aaalh3x_onestep">
SELECT *
FROM other_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getOtherServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Other Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.OtherServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getOtherServicesTempTotal = 0>
                    <cfloop query="getOtherServices">
                    <cfset getOtherServicesTempTotal = getOtherServicesTempTotal + getOtherServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getOtherServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Other Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>

<cfif getinfo.thirdPartyServices neq "">
<cfquery name="getThirdpartyServices" datasource="aaalh3x_onestep">
SELECT *
FROM thirdparty_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getThirdpartyServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Third Party Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.thirdPartyServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getThirdpartyServicesTempTotal = 0>
                    <cfloop query="getThirdpartyServices">
                    <cfset getThirdpartyServicesTempTotal = getThirdpartyServicesTempTotal + getThirdpartyServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getThirdpartyServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Third Party Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>
        
<cfquery name="checkForPacking" datasource="aaalh3x_onestep">
SELECT *
FROM Packing
WHERE ClientID = #clientid#
</cfquery>
<cfif checkForPacking.RecordCount>
	<cfif checkForPacking.packingType eq "Full Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: FULL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Self Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: SELF PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Partial Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: PARTIAL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
<br>
</cfif>
        
<cfset hideHoursColumn = true>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
    <cfloop query="getmovers">
    <cfquery name="getqt" datasource="aaalh3x_onestep">
    select * from ESTIMATES
    where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
    </cfquery>
    <cfif getqt.MenQty neq "" or getqt.VanQty neq "" or getqt.HoursQty neq "" or getqt.TravelTimeQty neq "">
    	<cfset hideHoursColumn = false>
    </cfif>
</cfloop>
        
<table border="1" cellspacing="0" cellpadding="2" width="100%">
<tr>
<td colspan="6"><div align="center"><font face="arial" size="2"><b>YOUR MOVE COST QUOTES</b></font></div></td>
</tr>
<tr>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER</font></div></td>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">TYPE OF QUOTE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">COMMENTS</font></div></td>
    <cfif hideHoursColumn eq false><td bgcolor="silver"><div align="center"><font face="arial" size="2">HOURS</font></div></td></cfif>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">PRICE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER SELECTED</font></div></td>
</tr>
<!--- check for 'other carrier' --->
<cfif #getinfo.other_carrier# is not '' and #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not '0'>
<tr><cfoutput>
	<td valign="middle"><font face="arial" size="2">#getinfo.other_carrier#</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2">&nbsp;</font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getinfo.other_carrier_amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr>
</cfif>

<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
<cfloop query="getmovers">
	<cfquery name="getqt" datasource="aaalh3x_onestep">
	select * from ESTIMATES
	where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
	</cfquery>
<cfif #getqt.recordcount# is not 0>
<tr><cfoutput>
	<td valign="middle">
        <cfif getmovers.Rating neq "">
        <cfif getmovers.Rating eq "5">
        	<cfset starText = "Excellent Moving Services">
        <cfelseif getmovers.Rating eq "4.5">
        	<cfset starText = "Very Good Moving Services">
        <cfelseif getmovers.Rating eq "4">
        	<cfset starText = "Good Moving Services">
        <cfelseif getmovers.Rating eq "3.5">
        	<cfset starText = "Satisfactory Moving Services">
        <cfelseif getmovers.Rating eq "3">
        	<cfset starText = "Acceptable Moving Services">
        <cfelseif getmovers.Rating eq "2.5">
        	<cfset starText = "Reasonable Moving Services">
        <cfelseif getmovers.Rating eq "2">
        	<cfset starText = "Adequate Moving Services">
        <cfelseif getmovers.Rating eq "1.5">
        	<cfset starText = "Fair Moving Services">
        <cfelseif getmovers.Rating eq "1">
        	<cfset starText = "Sufficient Moving Services">
        <cfelse>
        	<cfset starText = "">
        </cfif>
        <img src="http://top12movingbiz.com/images/#getmovers.Rating#star.jpg" width="75"> <span style="color:blue; font-family:Arial; font-size:11px; font-weight:bold;">#starText#</span><br></cfif>
    <font face="arial" size="2">#getmovers.company#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.TypeOfQuote#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.QuoteComment#</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2"><cfif getqt.MenQty neq ""> #getqt.MenQty# Men; </cfif><cfif getqt.VanQty neq ""> #getqt.VanQty# Vans; </cfif><cfif getqt.HoursQty neq ""> #getqt.HoursQty# Hours; </cfif><cfif getqt.TravelTimeQty neq ""> #getqt.TravelTimeQty# hours Travel Time; </cfif></font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getqt.amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr></cfif></cfloop>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="2" width="100%" style="font-family:arial; font-size:13px;">
<tr>
	<td>
	<p>I request the above selected carrier to provide the services described in the above move estimates.</p>
    <p style="text-decoration:underline; font-weight:bold;">
I understand that if I choose to go around and sign up directly with the selected carrier, or any other carrier,
before or after booking and signing this agreement with Nationwide USA Movers, Nationwide USA Movers will
not be held responsible for the quality of the moving services offered. Moreover, I understand that the move will
not be monitored and managed by Nationwide USA Movers and, this may result in extreme overcharges and poor
quality of moving services and the shipment will lose move protection.
    </p>    
	<p>
		I understand that adding more items or services could result in additional charges because it increases the weight/volume of the shipment, requires more labor and/or trucks, more packing or packing materials, temporary storage or all of the above. I understand also that additional charges could be added for changes in pick-up or delivery dates. There could be additional charges for services not listed.
	</p>
    <p>I acknowledge that I elected to waive a physical survey of the household goods that need to be moved and that the
above move estimates are based on a virtual survey of my household goods conducted using a video technology.</p>
<p>I understand that is my responsibility to show all items that are to be shipped so that an accurate survey can be
completed. I also understand that this type of survey does not constitute a physical survey and this waiver indicates
my consent to a virtual survey using video technology.</p>
<p>I acknowledge I have received the electronic version of "Your Rights and Responsibilities when you move" brochure
and "Ready to Move?" pamphlet both also located at <a href="http://www.protectyourmove.gov">www.protectyourmove.gov</a>.</p>
<p>I acknowledge that I have read the Nationwide USA Movers Terms & Conditions and Cancellation Policy and Privacy
Policy located on Nationwide USA Movers website at <a href="http://www.nationwideusamovers.com">www.nationwideusamovers.com</a>.</p>

    <table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <th scope="col" width="40%">Signature</th>
        <th scope="col" width="40%" align="center">Print Name</th>
        <th scope="col" width="20%" align="center">Date</th>
      </tr>
      <tr>
        <td height="50">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    </td>
</tr>
</table>
        
<table border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<td width="60%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top">
		<br>FOR QUESTIONS OR TO BOOK YOUR MOVE<br>
		PLEASE CONTACT YOUR MOVING CONSULTANT	<br><br>
		
<cfoutput>		
#verify.name#<br>
Direct Line 7 days/wk: #verify.phone#<br>
Email address: #verify.email#</cfoutput>
		</td>
		<td width="40%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top" align="center">
<br>Nationwide USA Movers Inc<br><br>
Phone: 1-800-976-6833<br>
		</td>
	</tr>
</table>
        
<table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;" align="center">
                <span style="font-weight: bold">Nationwide USA Movers Corporate Headquarters: 2319 Third Avenue, Suite 1710 New York, NY 10035 MC ## 945837 USDOT ## 3558324</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
               Nationwide USA Movers, Inc is a federally licensed and FMCSA authorized Household Goods Move Manager and
Broker, that does not own trucks but provides estimates with better pricing for customers and only arranges for
transportation of Household Goods and additional services by an authorized Household Goods Motor Carrier. All
quotes are based on the Household Good Motor Carriers' published tariffs.
            </td>
        </tr>
</table>
    <cfmailparam file="C:\home\top12movingbiz.com\wwwroot\documents\readytomove_pamphlet.pdf">
    <cfmailparam file="C:\home\top12movingbiz.com\wwwroot\documents\your-rights-and-responsibilities-when-you-move.pdf"> 
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
        width: 700px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;
        margin-top: 0px;
    }
    #initialInTable {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000;
}
    </style>
<cfif parameterexists(emailit) is 'yes'>
<form action="estimate.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
<div align="center">
<input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput> Now"><br>
<input type="checkbox" name="sendEmailToAll" value="1"> Send email to Both<br>
<input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>
</cfif>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td width="104" valign="Middle"><img src="/admin/letters/images/logo_small.jpg" width="104" height="73" alt="" border="0"></td>
<td valign="middle" width="100%"><div align="center"><font face="arial" size="3" color="black"><b>NATIONWIDE USA MOVERS</b></font><font size="1"><br></font><font face="arial" size="5" color="silver"><b>MOVING<br>ESTIMATES</b></font></div></td>
<td align="right" width="104" valign="middle"><font face="arial" size="4"><cfoutput><strong>#dateformat(now(), "MM/DD/YYYY")#</strong></cfoutput></font></td>
</tr>
</table>
<cfoutput>
<table border="1" cellspacing="0" cellpadding="3" width="100%">
<tr>
<td bgcolor="silver" valign="middle" width="50%" height="40"><div align="center"><font face="arial" size="2"><b>MOVE FROM</b></font></div></td>
<td bgcolor="silver" valign="middle" height="40"><div align="center"><font face="arial" size="2"><b>MOVE TO</b></font></div></td>
</tr>
<tr>
<td valign="top">
<font face="arial" size="2"><b>CUSTOMER</b>: #getinfo.first_name# #getinfo.last_name#<br><br>
<b>STREET ADDRESS</b>: #getinfo.from_address#<cfif #getinfo.from_address2# is not ''>, #getinfo.from_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.from_city#, #getinfo.from_state# #getinfo.from_zip#<br><br>
<b>ORIGIN PHONE</b>: #getinfo.phone#<br><br>
<b>EMAIL ADDRESS</b>: #getinfo.email#<br><br>
<b>SECOND EMAIL ADDRESS</b>: #getinfo.email2#<br><br>
<b>CELL</b>: #getinfo.cell#<br><br>
<b>SECOND CELL</b>: #getinfo.cell2#<br>
</td>

<td valign="top">
<font face="arial" size="2">
<b>STREET ADDRESS</b>: #getinfo.to_address#<cfif #getinfo.to_address2# is not ''>, #getinfo.to_address2#</cfif><br><br>
<b>CITY, STATE, ZIP</b>: #getinfo.to_city#, #getinfo.to_state# #getinfo.to_zip#<br>

</td>
</tr>
</table>
</cfoutput>

            <table cellspacing="5" cellpadding="3" width="100%">
            	<tr>
            		<td style="font-family:Arial; font-size:12px; font-weight:bold;">DEPENDING ON THE MOVING COMPANY, OUT OF STATE ESTIMATES CAN BE BINDING, NON-BINDING, NOT TO EXCEED OR BY CUBIC FEET, LOCAL, INTRASTATE AND STORAGE ESTIMATES CAN BE FLAT RATE, HOURLY OR NOT TO EXCEED.<br>
						ASK YOUR MOVING CONSULTANT FOR CLARIFICATION ON THE TYPE OF ESTIMATE FOR EACH COMPANY.</td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;">The following quotes represent the carrier's estimated bottom-line price conveyed to us by each of the listed service
					providers and are valid when accepted and signed within 30 days or 15 days if in peak season period, from the date
					the estimate is issued. The estimated price is valid only if the Order For Service is signed with the selected carrier.<br>
					<u>Changes to the loading date could result in a price change.</u></td>
            	</tr>
            	<tr>
            		<td style="font-family:Arial; font-size:12px;"><u>Please select and initial
next to the carrier you are choosing for your move, then sign, date
the Moving Estimates form and email back to customercare@nationwideusamovers.com.<br>
Notify immediately the selection to your Moving Consultant to lock in your date and pricing.
Once you select the Mover, your Moving Consultant will explain and help you understand
what type of Estimate & Services you will receive.</u></td>
            	</tr>
            </table>

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
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Cargo Specifics / Storage</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Estimated Weight: Under #getinfo.weight# lbs. or Under #getinfo.CubicFeet# Cubic Feet</font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">Valuation Included: <cfif getinfo.valuation_included eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.valuation_Comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.valuation_Comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">3rd Party Moving Insurance: <cfif getinfo.thirdPartyInsurance eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.thirdPartyIns_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.thirdPartyIns_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	         <td><font face="arial" size="2">Auto Shipping: <cfif getinfo.autoShipping eq 1>YES<cfelse>NO</cfif></font></td>
	        </tr>
	        <cfif getinfo.autoShipping_comments NEQ "">
	        <tr>
	         <td><font face="arial" size="2">#getinfo.autoShipping_comments#</font></td>
	        </tr>
	        </cfif>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">Storage Included: <cfif getinfo.storage_included eq 1>YES<cfelse>NO</cfif> <cfif getinfo.storage_included eq 1> - Days/Months of storage included in quote: #getinfo.days_in_storage#</cfif></font></div></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.StorageType#</font></td>
	        </tr>
	        <tr>
	         <td><font face="arial" size="2">#getinfo.WarehouseType#</font></td>
	        </tr>
        </table>
   </cfoutput>
<br>
<cfif getinfo.OtherServices neq "">
<cfquery name="getOtherServices" datasource="aaalh3x_onestep">
SELECT *
FROM other_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getOtherServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Other Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.OtherServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getOtherServicesTempTotal = 0>
                    <cfloop query="getOtherServices">
                    <cfset getOtherServicesTempTotal = getOtherServicesTempTotal + getOtherServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getOtherServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Other Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getOtherServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>

<cfif getinfo.thirdPartyServices neq "">
<cfquery name="getThirdpartyServices" datasource="aaalh3x_onestep">
SELECT *
FROM thirdparty_services
WHERE ClientID = #ClientID#
</cfquery>
<cfif getThirdpartyServices.RecordCount>
<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        <td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Third Party Services</b></font></div></td>
	        </tr>
	        <tr>
	        <td><div align="center"><font face="arial" size="2">#getinfo.thirdPartyServices#</font></div></td>
	        </tr>
            <tr>
            	<td>
                	<table border="1" cellspacing="0" cellpadding="2" width="100%">
                    <cfset getThirdpartyServicesTempTotal = 0>
                    <cfloop query="getThirdpartyServices">
                    <cfset getThirdpartyServicesTempTotal = getThirdpartyServicesTempTotal + getThirdpartyServices.ServiceCost>
                    	<tr>
                        	<td width="80%"><font face="arial" size="2">#getThirdpartyServices.ServiceType#</font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServices.ServiceCost)#</font></td>
                        </tr>
                    </cfloop>
                    	<tr>
                        	<td width="80%" align="right"><font face="arial" size="2"><strong>Third Party Services Total:</strong></font></td>
                            <td width="80%"><font face="arial" size="2">#DollarFormat(getThirdpartyServicesTempTotal)#</font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
</cfoutput>
<br>
</cfif>
</cfif>

<cfquery name="checkForPacking" datasource="aaalh3x_onestep">
SELECT *
FROM Packing
WHERE ClientID = #clientid#
</cfquery>
<cfif checkForPacking.RecordCount>
	<cfif checkForPacking.packingType eq "Full Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: FULL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Self Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: SELF PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
	<cfif checkForPacking.packingType eq "Partial Pack">
		<cfoutput>
        <table border="1" cellspacing="0" cellpadding="2" width="100%">
	        <tr>
	        	<td bgcolor="silver"><div align="center"><font face="arial" size="2"><b>Packing: PARTIAL PACK</b></font></div></td>
	        </tr>
	        <tr>
	        	<td>
	        		<table border="0" cellspacing="0" cellpadding="2" width="100%">
	        			<tr style="font-family:Arial; font-size:13px;">
	        				<td><b>Carrier Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty1 gt 0>#checkForPacking.BoxQty1# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty3 gt 0>#checkForPacking.BoxQty3# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty5 gt 0>#checkForPacking.BoxQty5# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty7 gt 0>#checkForPacking.BoxQty7# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty9 gt 0>#checkForPacking.BoxQty9# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty11 gt 0>#checkForPacking.BoxQty11# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty2 gt 0>#checkForPacking.BoxQty2# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty4 gt 0>#checkForPacking.BoxQty4# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty6 gt 0>#checkForPacking.BoxQty6# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty8 gt 0>#checkForPacking.BoxQty8# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty10 gt 0>#checkForPacking.BoxQty10# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty12 gt 0>#checkForPacking.BoxQty12# - King mattress carton / bag<br><br></cfif>
	        					<b>Customer Packing:</b><br>
	        					## - Box Type<br>
	        					<cfif checkForPacking.BoxQty13 gt 0>#checkForPacking.BoxQty13# - 1.5 cubic feet, small<br></cfif>
	        					<cfif checkForPacking.BoxQty15 gt 0>#checkForPacking.BoxQty15# - 3.0 cubic feet, medium<br></cfif>
	        					<cfif checkForPacking.BoxQty17 gt 0>#checkForPacking.BoxQty17# - 4.5 cubic feet, large box<br></cfif>
	        					<cfif checkForPacking.BoxQty19 gt 0>#checkForPacking.BoxQty19# - 6.0 cubic feet, extra large<br></cfif>
	        					<cfif checkForPacking.BoxQty21 gt 0>#checkForPacking.BoxQty21# - TV Flat - 32" to 59" box<br></cfif>
	        					<cfif checkForPacking.BoxQty23 gt 0>#checkForPacking.BoxQty23# - Dishpack<br></cfif>
	        					<cfif checkForPacking.BoxQty14 gt 0>#checkForPacking.BoxQty14# - Wardrobe<br></cfif>
	        					<cfif checkForPacking.BoxQty16 gt 0>#checkForPacking.BoxQty16# - Mirror carton<br></cfif>
	        					<cfif checkForPacking.BoxQty18 gt 0>#checkForPacking.BoxQty18# - Single mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty20 gt 0>#checkForPacking.BoxQty20# - Double mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty22 gt 0>#checkForPacking.BoxQty22# - Queen mattress carton / bag<br></cfif>
	        					<cfif checkForPacking.BoxQty24 gt 0>#checkForPacking.BoxQty24# - King mattress carton / bag<br><br></cfif>
	        				</td>
	        				<td valign="top"><cfif checkForPacking.OtherPackingServices neq ""><b>Other Packing Services / Material</b><br>#checkForPacking.OtherPackingServices#</cfif></td>
	        			</tr>
	        		</table>
	        	</td>
	        </tr>
		</table>
		</cfoutput>
	</cfif>
<br>
</cfif>

<cfset hideHoursColumn = true>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
    <cfloop query="getmovers">
    <cfquery name="getqt" datasource="aaalh3x_onestep">
    select * from ESTIMATES
    where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
    </cfquery>
    <cfif getqt.MenQty neq "" or getqt.VanQty neq "" or getqt.HoursQty neq "" or getqt.TravelTimeQty neq "">
    	<cfset hideHoursColumn = false>
    </cfif>
</cfloop>

<table border="1" cellspacing="0" cellpadding="2" width="100%">
<tr>
<td colspan="6"><div align="center"><font face="arial" size="2"><b>YOUR MOVE COST QUOTES</b></font></div></td>
</tr>
<tr>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER</font></div></td>
	<td bgcolor="silver"><div align="center"><font face="arial" size="2">TYPE OF QUOTE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">COMMENTS</font></div></td>
    <cfif hideHoursColumn eq false><td bgcolor="silver"><div align="center"><font face="arial" size="2">HOURS</font></div></td></cfif>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">PRICE</font></div></td>
    <td bgcolor="silver"><div align="center"><font face="arial" size="2">CARRIER SELECTED</font></div></td>
</tr>
<!--- check for 'other carrier' --->
<cfif #getinfo.other_carrier# is not '' and #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not '0'>
<tr><cfoutput>
	<td valign="middle"><font face="arial" size="2">#getinfo.other_carrier#</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <td valign="middle"><font face="arial" size="2">&nbsp;</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2">&nbsp;</font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getinfo.other_carrier_amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr>
</cfif>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>
<cfloop query="getmovers">
<cfquery name="getqt" datasource="aaalh3x_onestep">
select * from ESTIMATES
where carrier=#getmovers.id# and user_hook=#clientid# and amount <> ''
</cfquery>
<cfif #getqt.recordcount# is not 0>
<tr><cfoutput>
	<td valign="middle">
        <cfif getmovers.Rating neq "">
        <cfif getmovers.Rating eq "5">
        	<cfset starText = "Excellent Moving Services">
        <cfelseif getmovers.Rating eq "4.5">
        	<cfset starText = "Very Good Moving Services">
        <cfelseif getmovers.Rating eq "4">
        	<cfset starText = "Good Moving Services">
        <cfelseif getmovers.Rating eq "3.5">
        	<cfset starText = "Satisfactory Moving Services">
        <cfelseif getmovers.Rating eq "3">
        	<cfset starText = "Acceptable Moving Services">
        <cfelseif getmovers.Rating eq "2.5">
        	<cfset starText = "Reasonable Moving Services">
        <cfelseif getmovers.Rating eq "2">
        	<cfset starText = "Adequate Moving Services">
        <cfelseif getmovers.Rating eq "1.5">
        	<cfset starText = "Fair Moving Services">
        <cfelseif getmovers.Rating eq "1">
        	<cfset starText = "Sufficient Moving Services">
        <cfelse>
        	<cfset starText = "">
        </cfif>
        <img src="http://top12movingbiz.com/images/#getmovers.Rating#star.jpg" width="75"> <span style="color:blue; font-family:Arial; font-size:11px; font-weight:bold;">#starText#</span><br></cfif>
    <font face="arial" size="2">#getmovers.company#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.TypeOfQuote#</font></td>
    <td valign="middle"><font face="arial" size="2">#getqt.QuoteComment#</font></td>
    <cfif hideHoursColumn eq false><td valign="middle"><font face="arial" size="2"><cfif getqt.MenQty neq ""> #getqt.MenQty# Men; </cfif><cfif getqt.VanQty neq ""> #getqt.VanQty# Vans; </cfif><cfif getqt.HoursQty neq ""> #getqt.HoursQty# Hours; </cfif><cfif getqt.TravelTimeQty neq ""> #getqt.TravelTimeQty# hours Travel Time; </cfif></font></td></cfif>
	<td valign="middle"><div align="right"><font face="arial" size="2">$#getqt.amount#</font></div>
    <td valign="middle">
    <table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr>
        <td width="10"><input name="" type="checkbox" value=""></td>
        <td id="initialInTable">&nbsp;</td>
      </tr>
    </table>
    </td>
</td></cfoutput>
</tr></cfif></cfloop>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="2" width="100%" style="font-family:arial; font-size:13px;">
<tr>
	<td>
	<p>I request the above selected carrier to provide the services described in the above move estimates.</p>
    <p style="text-decoration:underline; font-weight:bold;">
I understand that if I choose to go around and sign up directly with the selected carrier, or any other carrier,
before or after booking and signing this agreement with Nationwide USA Movers, Nationwide USA Movers will
not be held responsible for the quality of the moving services offered. Moreover, I understand that the move will
not be monitored and managed by Nationwide USA Movers and, this may result in extreme overcharges and poor
quality of moving services and the shipment will lose move protection.
    </p>    
	<p>
		I understand that adding more items or services could result in additional charges because it increases the weight/volume of the shipment, requires more labor and/or trucks, more packing or packing materials, temporary storage or all of the above. I understand also that additional charges could be added for changes in pick-up or delivery dates. There could be additional charges for services not listed.
	</p>
    <p>I acknowledge that I elected to waive a physical survey of the household goods that need to be moved and that the
above move estimates are based on a virtual survey of my household goods conducted using a video technology.</p>
<p>I understand that is my responsibility to show all items that are to be shipped so that an accurate survey can be
completed. I also understand that this type of survey does not constitute a physical survey and this waiver indicates
my consent to a virtual survey using video technology.</p>
<p>I acknowledge I have received the electronic version of "Your Rights and Responsibilities when you move" brochure
and "Ready to Move?" pamphlet both also located at <a href="http://www.protectyourmove.gov">www.protectyourmove.gov</a>.</p>
<p>I acknowledge that I have read the Nationwide USA Movers Terms & Conditions and Cancellation Policy and Privacy
Policy located on Nationwide USA Movers website at <a href="http://www.nationwideusamovers.com">www.nationwideusamovers.com</a>.</p>

    <table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <th scope="col" width="40%">Signature</th>
        <th scope="col" width="40%" align="center">Print Name</th>
        <th scope="col" width="20%" align="center">Date</th>
      </tr>
      <tr>
        <td height="50">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    </td>
</tr>
</table>

<table border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
		<td width="60%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top">
		<br>FOR QUESTIONS OR TO BOOK YOUR MOVE<br>
		PLEASE CONTACT YOUR MOVING CONSULTANT	<br><br>
		
<cfoutput>		
#verify.name#<br>
Direct Line 7 days/wk: #verify.phone#<br>
Email address: #verify.email#</cfoutput>
		</td>
		<td width="40%" style="font-family:Arial; font-size:12px; font-weight:bold;" valign="top" align="center">
<br>Nationwide USA Movers Inc<br><br>
Phone: 1-800-976-6833<br>
		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="2" width="100%">
        <tr>
            <td colspan="2" style="font-family: arial; font-size: 11px; padding-top: 20px;">
                <span style="font-weight: bold">Nationwide USA Movers Corporate Headquarters: 2319 Third Avenue, Suite 1710 New York, NY 10035 MC # 945837 USDOT # 3558324</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-size:11px; font-family:arial; padding-top: 10px;">
               Nationwide USA Movers, Inc is a federally licensed and FMCSA authorized Household Goods Move Manager and
Broker, that does not own trucks but provides estimates with better pricing for customers and only arranges for
transportation of Household Goods and additional services by an authorized Household Goods Motor Carrier. All
quotes are based on the Household Good Motor Carriers' published tariffs.
            </td>
        </tr>
</table>
</cfif>
</body>
</html>
