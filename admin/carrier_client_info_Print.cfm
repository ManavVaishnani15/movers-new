
<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Administration - Edit Record</title>
<link rel="stylesheet" href="foundation-6.2.4/css/foundation.css">
<link rel="stylesheet" type="text/css" href="font-awesome-4.7.0/css/font-awesome.css">
<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="https://top12movingbiz.com/admin/scripts/script.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/typeahead.jquery.min.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/jquery-ui.css"/>

<style type="text/css">
        .tt-menu {
          margin: -5px 0;
          padding: 5px;
          background-color: #fff;
          border: 1px solid #ccc;
          border: 1px solid rgba(0, 0, 0, 0.2);
        }
        .tt-input{
            vertical-align: baseline !important;
        }
    </style>
</head>



<body>
	
	
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


<cfset fulldatenow = now()>
<cfset datenow = dateformat(fulldatenow, "YYYY-MM-DD")>


<cfquery name="getInfo" datasource="aaalh3x_onestep">
SELECT *
FROM carrier_records
WHERE ID = #ClientID#
</cfquery>
<cfquery name="getcomments" datasource="aaalh3x_onestep">
SELECT *
FROM carrier_comments
WHERE ClientID = #ClientID#
</cfquery>

<cfquery name="get_initial" datasource="aaalh3x_onestep">
select * from carrier_LETTER_SENDS
where send_type=1 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfquery name="get_booked" datasource="aaalh3x_onestep">
	SELECT * FROM carrier_printqueue pq left join carrier_LETTER_SENDS ls on pq.id = ls.printqueueId
	where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
    and pq.memberID = #verify.ID#
	order by pq.followup_date
</cfquery>



<div class="row">
    <div class="large-12 columns">
    <div class="row">
        <div class="small-7 columns">
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="font-size:12px">
  <tr>
    <th scope="col">Letter</th>
    <th scope="col">Date</th>
    <th scope="col">Letter Generation</th>
  </tr>
  <tr>
    <td>Main Letter sent</td>
    <td align="center">(<cfif #get_initial.sent# is 1>Mailed<cfelseif #get_initial.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_initial.sent_date, "MMM D, YYYY")#) </cfoutput></td>
  	<td rowspan="8" valign="top">
    <cfoutput>
    <table width="100%" border="0" cellspacing="2" cellpadding="0">
      <tr>
        <td><strong>Carrier Letter</strong><br>
        	Queue | Mark Mailed | Email</td>
      </tr>
      <tr>
        <td><strong>Follow Up Letter</strong><br>
        Queue | Mark Mailed | Email
        </td>
      </tr>

    </table>
	</cfoutput>
    </td>
  </tr>
  <cfoutput query="get_booked">
  <cfif get_booked.sent eq 0 or get_booked.sent eq ''>
  <tr>
    <td>Follow Up #get_booked.currentRow# Not Sent</td>
    <td align="center">&nbsp;</td>
  </tr>
  <cfelse>
  <tr>
    <td>Follow Up #get_booked.currentRow# Sent</td>
    <td align="center"><cfif get_booked.sent eq 1>(Mailed #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<cfelseif get_booked.sent eq 2>(Emailed #dateformat(get_booked.sent_date, "MMM D, YYYY")#)</cfif> </td>
  </tr>
  </cfif>
  </cfoutput>
</table>

    	</div>
        <div class="small-5 columns">
        <table border="0" cellspacing="0" cellpadding="5" width="50%" align="right">
        	<tr>
        		<td><a data-open="uploadImage"><cfif getInfo.profilePhoto neq ""><cfoutput><img src="images/carrierImages/#getInfo.profilePhoto#" width="142"></cfoutput><cfelse><img src="images/placeholder.png"></cfif></a></td>
        		<td><a data-open="uploadCardImage"><cfif getInfo.BusinessCardPhoto neq ""><cfoutput><img src="images/carrierImages/#getInfo.BusinessCardPhoto#" width="300"></cfoutput><cfelse><img src="images/placeholder2.png"></cfif></a></td>
        	</tr>	
        </table>
        <br>
        <input type="button" value="PRINT PAGE" onClick="window.print();">
    	</div>
    </div>
    </div>
</div>



<div class="row">
    <div class="large-12 columns">
    
	<fieldset class="fieldset">
    <legend><strong>Carrier Documents</strong></legend>
	<cfquery name="getDocuments" datasource="aaalh3x_onestep">
	select * 
	from carrier_supportdocs
	where ClientID = #clientid#
	</cfquery>
    <div class="row">
    	<cfif getDocuments.recordCount eq 0>
    	<div class="small-12 columns">
    		<h5>No Carrier Documents Found</h5>
    	</div>
    	<cfelse>
    	<cfoutput query="getDocuments">
    		<div class="small-4 columns">
    			<strong>#Document#</strong>
    		</div>
    	</cfoutput>
    	</cfif>

    </div>
    </fieldset>
    
    	
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addDataForm" data-abide novalidate></cfoutput>
	<fieldset class="fieldset">
    <legend><strong>Company / Account Status</strong></legend>
    <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="CompanyName" class="text-left middle">Company Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="CompanyName" size="20" id="CompanyName" placeholder="Company Name" value="#CompanyName#">
        </div>
        <div class="small-3 columns">
          <label for="AccountStatus" class="text-left middle">Status</label>
        </div>
        <div class="small-3 columns">
          <select name="AccountStatus" id="AccountStatus">
          	<option value="Open"<cfif AccountStatus eq "Open" or AccountStatus eq ""> selected</cfif>>Open</option>
          	<option value="Under Contract"<cfif AccountStatus eq "Under Contract"> selected</cfif>>Under Contract</option>
          </select>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="MC" class="text-left middle">MC##</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="MC" size="20" id="MC" placeholder="MC Number" value="#MC#">
        </div>
        <div class="small-3 columns">
          <label for="USDOT" class="text-left middle">USDOT##</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="USDOT" size="20" id="USDOT" placeholder="USDOT Number" value="#USDOT#">
        </div>
      </div>
      </cfoutput>
	</fieldset>

	<fieldset class="fieldset">
    <legend><strong>Owner or Company Representative</strong></legend>
  <cfoutput query="getInfo">
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_first_name" class="text-left middle">First Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_first_name" size="20" id="Rep_first_name" placeholder="First Name" value="#repfirstname#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_last_name" class="text-left middle">Last Name</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_last_name" size="20" id="Rep_last_name" placeholder="Last Name" value="#replastname#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_Phone" class="text-left middle">Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_Phone" size="20" id="Rep_Phone" placeholder="Phone" value="#phone#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_email" class="text-left middle">Email</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_email" size="20" id="Rep_email" placeholder="Email" value="#Emailaddress#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_cellPhone" class="text-left middle">Cell Phone</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_cellPhone" size="20" id="Rep_cellPhone" placeholder="Cell Phone" value="#cellphone#">
        </div>
        <div class="small-3 columns">
          <label for="Fax" class="text-left middle">Fax</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Fax" size="20" id="Fax" placeholder="Fax" value="#Fax#">
        </div>
      </div>
      </cfoutput>
	</fieldset>
	
    <fieldset class="fieldset">
    <legend><strong>Physical Address</strong></legend>
  <cfoutput query="getInfo">

    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_address" class="text-left middle">Address</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_address" size="20" id="Rep_address" placeholder="Address" value="#streetaddress#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_city" class="text-left middle">City</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_city" size="20" id="Rep_city" placeholder="City" value="#city#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_State" class="text-left middle">State</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_State" size="20" id="Rep_State" placeholder="Sate" value="#state#">
        </div>
        <div class="small-3 columns">
          <label for="Rep_zip" class="text-left middle">Zip</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="Rep_zip" size="20" id="Rep_zip" placeholder="City" value="#zip#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="County" class="text-left middle">County</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="County" size="20" id="County" placeholder="County" value="#County#">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>
    
    </cfoutput>
    </fieldset>
    
    
    <fieldset class="fieldset">
    <legend><strong>Mailing Address</strong></legend>
  <cfoutput query="getInfo">

    <div class="row">
        <div class="small-3 columns">
          <label for="mailingaddress" class="text-left middle">Address</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingaddress" size="20" id="mailingaddress" placeholder="Address" value="#mailingaddress#">
        </div>
        <div class="small-3 columns">
          <label for="mailingcity" class="text-left middle">City</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingcity" size="20" id="mailingcity" placeholder="City" value="#mailingcity#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="mailingState" class="text-left middle">State</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingState" size="20" id="mailingState" placeholder="Sate" value="#mailingstate#">
        </div>
        <div class="small-3 columns">
          <label for="mailingzip" class="text-left middle">Zip</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingzip" size="20" id="mailingzip" placeholder="Zip Code" value="#mailingzip#">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="mailingCounty" class="text-left middle">County</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="mailingCounty" size="20" id="mailingCounty" placeholder="County" value="#mailingCounty#">
        </div>
        <div class="small-3 columns">
          
        </div>
        <div class="small-3 columns">
          
        </div>
      </div>
    
    </cfoutput>
    </fieldset>
    
    <fieldset class="fieldset">
    <legend><strong>More Info</strong></legend>
    <cfquery name="getMoreInfo" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_moreinfo
    WHERE ClientID = #ClientID#
    </cfquery>
    <cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="trucksNumber" class="text-left middle">Trucks - Number and Size</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="TruckNumberSize" size="20" id="TruckNumberSize" placeholder="Trucks - Number and Size" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TruckNumberSize#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="tractorNumber" class="text-left middle">Tractor Number</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="tractorNumber" size="20" id="tractorNumber" placeholder="Tractor Number" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TractorNumber#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="trailerNumber" class="text-left middle">Trailer Number</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="trailerNumber" size="20" id="trailerNumber" placeholder="Trailer Number" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.TrailerNumber#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="BIPDLevel" class="text-left middle">BIPD Level</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="BIPDLevel" size="20" id="BIPDLevel" placeholder="BIPD Level" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.BIPDLevel#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="cargoLevel" class="text-left middle">Cargo Level</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="cargoLevel" size="20" id="cargoLevel" placeholder="Cargo Level" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.CargoLevel#</cfif>">
        </div>
        <div class="small-3 columns">
          <label for="thirdPartyIns" class="text-left middle">Third Party Moving Ins.</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="ThirdPartyMoveIns" size="20" id="ThirdPartyMoveIns" placeholder="Third Party Moving Ins." value="<cfif getMoreInfo.RecordCount>#getMoreInfo.ThirdPartyMoveIns#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="StorageFacilities" class="text-left middle">Storage Facilities</label>
        </div>
        <div class="small-3 columns">
          No <input type="radio" name="StorageFacilities" id="StorageFacilities" value="0"<cfif getMoreInfo.RecordCount and getMoreInfo.StorageFacilities eq 0 or getMoreInfo.StorageFacilities eq ""> checked="checked"</cfif>> Yes <input type="radio" name="StorageFacilities" id="StorageFacilities" value="1"<cfif getMoreInfo.RecordCount and getMoreInfo.StorageFacilities eq 1> checked="checked"</cfif>>
        </div>
        <div class="small-3 columns">
          <label for="storageComments" class="text-left middle">Comment</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="storageComments" size="20" id="storageComments" placeholder="Storage Comments" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.StorageComments#</cfif>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="publishedTariffRates" class="text-left middle">Published Tariff Rates</label>
        </div>
        <div class="small-3 columns">
          No <input type="radio" name="publishedTariffRates" id="publishedTariffRates" value="0"<cfif getMoreInfo.RecordCount and getMoreInfo.publishedTariffRates eq 0 or getMoreInfo.publishedTariffRates eq ""> checked="checked"</cfif>> Yes <input type="radio" name="publishedTariffRates" id="publishedTariffRates" value="1"<cfif getMoreInfo.RecordCount and getMoreInfo.PublishedTariffRates eq 1> checked="checked"</cfif>>
        </div>
        <div class="small-3 columns">
          <label for="tariffComments" class="text-left middle">Comment</label>
        </div>
        <div class="small-3 columns">
          <input type="text" name="PublishedTariffRateComments" size="20" id="PublishedTariffRateComments" placeholder="Published Tariff Rate Comments" value="<cfif getMoreInfo.RecordCount>#getMoreInfo.PublishedTariffRateComments#</cfif>">
        </div>
      </div>
    </cfoutput>
    </fieldset>
    
      </form>
    
    <fieldset class="fieldset">
    <legend><strong>Packing Rates</strong></legend>
    <cfquery name="getBoxes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_packingBoxes
    </cfquery>
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addBoxRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-4 columns">
          <label for="Boxes" class="text-left middle"><strong>Boxes</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Material</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Labor</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Packing Total</strong></label>
        </div>
        <div class="small-2 columns">
          <label for="Boxes" class="text-left middle"><strong>Unpacking</strong></label>
        </div>
      </div>
    <cfoutput query="getBoxes">
    <cfquery name="getBoxRates" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_packingRates
    WHERE ClientID = #ClientID# and
    	BoxID = #getBoxes.ID#
    </cfquery>
    <div class="row">
        <div class="small-4 columns">
          <label for="PackingMaterial#getBoxes.ID#" class="text-left middle">#getBoxes.BoxType#</label>
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingMaterial#getBoxes.ID#" size="20" id="PackingMaterial#getBoxes.ID#" placeholder="Packing Material" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingMaterial#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingLabor#getBoxes.ID#" size="20" id="PackingLabor#getBoxes.ID#" placeholder="Packing Labor" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingLabor#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="PackingTotal#getBoxes.ID#" size="20" id="PackingTotal#getBoxes.ID#" placeholder="Packing Total" value="<cfif getBoxRates.RecordCount>#getBoxRates.packingTotal#</cfif>">
        </div>
        <div class="small-2 columns">
          <input type="text" name="Unpacking#getBoxes.ID#" size="20" id="Unpacking#getBoxes.ID#" placeholder="Unpacking" value="<cfif getBoxRates.RecordCount>#getBoxRates.Unpacking#</cfif>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>Comments</strong></label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="packingComments" size="20" id="packingComments" placeholder="Packing Comments" value="<cfif getcomments.RecordCount><cfoutput>#getcomments.packingComments#</cfoutput></cfif>">
        </div>
      </div>
    
    </fieldset>
    </form>
    
    <fieldset class="fieldset">
    <legend><strong>Local & Storage Rates</strong></legend>
    <cfquery name="getRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_localratetypes
    </cfquery>
    <cfquery name="getStorageRateTypes" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_storageratetypes
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
        <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addLocalRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Local Rates</strong></label>
        </div>
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Rates $/hr</strong></label>
        </div>
      </div>
    <cfoutput query="getRateTypes">
    <cfquery name="getBoxRates" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_localRates
    WHERE ClientID = #ClientID# and
    	RateTypeID = #getRateTypes.ID#
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
          <label for="rateValue#getRateTypes.ID#" class="text-left middle">#getRateTypes.RateType#</label>
        </div>
        <div class="small-6 columns">
          <input type="text" name="rateValue#getRateTypes.ID#" size="20" id="rateValue#getRateTypes.ID#" placeholder="Rate" value="<cfif getBoxRates.RecordCount>#getBoxRates.Rate#</cfif>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>Comments</strong></label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="MiscComments" size="20" id="MiscComments" placeholder="Misc Comments" value="<cfif getcomments.RecordCount><cfoutput>#getcomments.MiscChargeComments#</cfoutput></cfif>">
        </div>
      </div>
    </form>
        </div>
        <div class="small-6 columns">
    <cfoutput><form action="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" method="post" name="addStorageRateForm" data-abide novalidate></cfoutput>
    <div class="row">
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Storage Rates</strong></label>
        </div>
        <div class="small-6 columns">
          <label for="localRatesTable" class="text-left middle"><strong>Cost $</strong></label>
        </div>
      </div>
    <cfoutput query="getStorageRateTypes">
    <cfquery name="getStorageRate" datasource="aaalh3x_onestep">
    SELECT *
    FROM carrier_storagerates
    WHERE ClientID = #ClientID# and
    	StorageRateID = #getStorageRateTypes.ID#
    </cfquery>
    <div class="row">
        <div class="small-6 columns">
          <label for="StorageRateValue#getStorageRateTypes.ID#" class="text-left middle">#getStorageRateTypes.RateType#</label>
        </div>
        <div class="small-6 columns">
          <input type="text" name="StorageRateValue#getStorageRateTypes.ID#" size="20" id="StorageRateValue#getStorageRateTypes.ID#" placeholder="Rate" value="<CFIF getStorageRate.RecordCount>#getStorageRate.Rate#</CFIF>">
        </div>
      </div>
    </cfoutput>
    <div class="row">
        <div class="small-3 columns">
          <label for="packingComments" class="text-left middle"><strong>General Comments</strong></label>
        </div>
        <div class="small-9 columns">
        <textarea name="GeneralComments" id="GeneralComments" cols="50" rows="10" placeholder="General Comments"><cfif getcomments.RecordCount><cfoutput>#getcomments.GeneralComments#</cfoutput></cfif></textarea>
        </div>
      </div>
    </form>
        </div>
      </div>
    
    </fieldset>
    

    </div>
</div>



<script src="foundation-6.2.4/js/vendor/foundation.js"></script>
<script>

      $(document).foundation();
    </script>
</body>
</html>