<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
        <cfif structKeyExists(url,'type') and trim(url.type) eq "followUp">
        	and coalesce(followup_date,'#datenow#') = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">
        	order by date_time_to_order_when_printing
        </cfif>
    </cfquery>

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
<cfdocument format="pdf" pagetype="letter" orientation="portrait" scale="50"> 
    <cfoutput query="printQueue">
        <cfif printQueue.printType is "new">
            <!--- <cfinclude template="letters/new_listing_letter.cfm" /> --->
            <cfdocumentsection><cfinclude template="letters/newListing.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(1,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "gotOffer">
            <!--- <cfinclude template="letters/got_offer_letter.cfm" /> --->
            <cfdocumentsection><cfinclude template="letters/offerLetter.cfm" /></cfdocumentsection>
        <cfelseif printQueue.printType is "closing">
            <!--- <cfinclude template="letters/close_letter.cfm" /> --->
            <cfdocumentsection><cfinclude template="letters/closingLetter.cfm" /></cfdocumentsection>
        <cfelseif printQueue.printType is "followUp">
            <cfdocumentsection><cfinclude template="letters/followUp.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date,printqueueId)
                values(6,1,'#clientid#','#datenow#',<cfqueryparam cfsqltype="cf_sql_bigint" value="#printQueue.id#">)
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerfollowUp">
            <cfdocumentsection><cfinclude template="letters/MayflowerfollowUp.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(301,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hanger">
            <cfdocumentsection><cfinclude template="letters/doorHanger_new.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(100,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerApptUrgent">
            <cfdocumentsection><cfinclude template="letters/doorHanger.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(250,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerAppt">
            <cfdocumentsection><cfinclude template="letters/doorHanger_appt.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(230,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hanger2">
            <cfdocumentsection><cfinclude template="letters/doorHanger2.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(200,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerOffer">
            <cfdocumentsection><cfinclude template="letters/doorHangerOffer_new.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(210,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerOfferUrgent">
            <cfdocumentsection><cfinclude template="letters/doorHangerOfferUrgent.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(220,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "hangerMayflower">
            <cfdocumentsection><cfinclude template="letters/doorHanger_mayflowerUnited.cfm" /></cfdocumentsection>
            <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(240,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "estimate">
            <cfdocumentsection><cfinclude template="letters/estimate.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(8,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "carrierList">
            <cfdocumentsection><cfinclude template="letters/carrierList.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(10,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "nonRealtorLeads">
            <!--- <cfinclude template="letters/nonRealtorLeads.cfm" /> --->
            <cfdocumentsection><cfinclude template="letters/noRealtor.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(20,1,'#clientid#','#datenow#')
            </cfquery>
        <cfelseif printQueue.printType is "MayflowerLetter">
        	<cfdocumentsection><cfinclude template="letters/mayflowerLetter.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(300,1,'#clientid#','#datenow#')
            </cfquery>
            
     <!---    <cfelseif printQueue.printType is "MayflowerFlyer">
        	<cfdocumentsection><cfinclude template="letters/mayFlowerFlyer.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(302,1,'#clientid#','#datenow#')
            </cfquery>
            --->
            
        <cfelseif printQueue.printType is "MayflowerFollowup">
        	<cfdocumentsection><cfinclude template="letters/MayflowerFollowup.cfm" /></cfdocumentsection>
             <cfquery  datasource="aaalh3x_onestep">
                insert into LETTER_SENDS(send_type,sent,cust_hook,sent_date)
                values(301,1,'#clientid#','#datenow#')
            </cfquery>
        </cfif>






<!--- comment_Yasar 
       <cfif (printQueue.printType NEQ "followUp" and printQueue.printType NEQ "mayflowerfollowUp" and printQueue.printType NEQ "mayflowerLetter" and printQueue.printType NEQ "MayflowerFlyer") and not (isDefined('url.type') and url.type is "hanger")>
           <!--- <cfdocumentitem type="pagebreak" /> --->
            <cfdocumentsection><cfinclude template="letters/flyer.cfm" /></cfdocumentsection>
       </cfif>
--->

<!---        <cfif printQueue.currentRow is not printQueue.recordcount>
           <cfdocumentitem type="pagebreak" />
       </cfif>  --->
       <!---  <cfquery datasource="aaalh3x_onestep">
                   update printQueue
                   set printed=1
                   where id=#printQueue.id#
               </cfquery> --->
    </cfoutput>
</cfdocument>

