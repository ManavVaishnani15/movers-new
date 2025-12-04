<!---<CFQUERY NAME="qCheckLetterSendaaa" datasource="aaalh3x_onestep">
                select *
                from printqueue
                where clientid = 23719<!------>
<!---               SELECT *
              from letter_sends
              WHERE Cust_hook = #ID# AND
              	Sent > 0 --->
              </CFQUERY>
<cfdump var="#qCheckLetterSendaaa#" ><br><br>


<CFQUERY NAME="qCheckLetterSendyyy" datasource="aaalh3x_onestep">
                select *
                from printqueue
                where clientid = 23714<!------>
<!---               SELECT *
              from letter_sends
              WHERE Cust_hook = #ID# AND
              	Sent > 0 --->
              </CFQUERY>
<cfdump var="#qCheckLetterSendyyy#" ><br><br>

<CFQUERY NAME="qCheckLetterSendyyy1" datasource="aaalh3x_onestep">
                select *
                from printqueue
                where clientid = 23718<!------>
<!---               SELECT *
              from letter_sends
              WHERE Cust_hook = #ID# AND
              	Sent > 0 --->
              </CFQUERY>
<cfdump var="#qCheckLetterSendyyy1#" ><br><br>

<CFQUERY NAME="qCheckLetterSend" datasource="aaalh3x_onestep">
                select *
                from printqueue
                where clientid = 23717<!---23714--->
<!---               SELECT *
              from letter_sends
              WHERE Cust_hook = #ID# AND
              	Sent > 0 --->
              </CFQUERY>
<cfdump var="#qCheckLetterSend#" ><br><br>


<CFQUERY NAME="qCheckLetterSend1" datasource="aaalh3x_onestep">
SELECT *
              from letter_sends
              WHERE Cust_hook = 23714
              </CFQUERY>
<cfdump var="#qCheckLetterSend1#" >--->

<!---<CFQUERY NAME="showTriggers" datasource="aaalh3x_onestep">
SHOW TRIGGERS
<!---FROM onestep--->
</CFQUERY>
<cfdump var="#showTriggers#" >--->

<!---<cfset appointmentDate = '2020-06-30'>
<cfset firstFollowUpDate = dateAdd('d',15,appointmentDate)>
<cfset lastFollowUpDate = dateAdd('d',75,appointmentDate)>

<cfoutput>
	<cfloop index="currentFollowUp" from="#firstFollowUpDate#" to="#lastFollowUpDate#" step="#CreateTimeSpan(15,0,0,0)#">
		#dateformat(currentFollowUp, "YYYY-MM-DD")#<br>
	</cfloop>
</cfoutput>--->
<!---<cfset clientid = 23742>
<cfset url.type = 'followUp'>
<cfquery name="getAllFollowUps" datasource="aaalh3x_onestep">
	select * from printQueue
	where clientid= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">
	order by followup_date
</cfquery>--->
<!---<cfloop query="getAllFollowUps">
	<cfquery name="delLetterSend" datasource="aaalh3x_onestep">
		delete 
		from LETTER_SENDS
		where printqueueId= <cfqueryparam cfsqltype="cf_sql_bigint" value="#getAllFollowUps.id#">
	</cfquery>
	
	<cfquery name="delQueue" datasource="aaalh3x_onestep">
		delete 
		from printQueue
		where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#getAllFollowUps.id#">
	</cfquery>
</cfloop>--->

<!---<cfquery name="getPrintQueue" datasource="aaalh3x_onestep">
	select * from printQueue
	where clientid= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.type)#">
	order by followup_date, printed desc
</cfquery>
<cfdump var="#getPrintQueue#" ><br><br>

<cfif getPrintQueue.recordCount gt 0>
	<cfquery name="getLetterSend" datasource="aaalh3x_onestep">
		select * from LETTER_SENDS
		where printqueueId in (#valueList(getPrintQueue.id)#)
	</cfquery>
	<cfdump var="#getLetterSend#" >
</cfif>--->

<!---<cfquery name="verify" datasource="aaalh3x_onestep">
        select * from MEMBERS
        where username='mlv' and temp_pw=27337 and active=1
    </cfquery>
<cfdump var="#verify#" ><br><br>

<cfquery name="printQueue" datasource="aaalh3x_onestep">
        select *
        from printQueue
         where printType = 'followUp'
        order by id desc
       limit 1
    </cfquery>
<cfdump var="#printQueue#" ><br><br>--->

<!---<CFQUERY NAME="qCheckLetterSend" datasource="aaalh3x_onestep">
                <!---select *
                from printqueue
                where clientid = 23745--->
               SELECT *
              from letter_sends
              WHERE Cust_hook = 23745 <!---AND
              	Sent > 0 --->
              </CFQUERY>
              
<cfdump var="#qCheckLetterSend#" ><br><br>--->
<cfset clientid = 23763>
<!---
<cfquery name="checkCustomer" datasource="aaalh3x_onestep">
			select *
			from LETTER_SENDS
			where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
			and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
			order by followup_date
		</cfquery>
<cfdump var="#checkCustomer#" ><br><br>

<cfquery name="getCustomers" datasource="aaalh3x_onestep">
			select *
			from CLIENTS
			where id in(38818,23773)
		</cfquery>
<cfdump var="#getCustomers#" >

<cfquery name="getMembers" datasource="aaalh3x_onestep">
			select *
			from MEMBERS
			limit 1
		</cfquery>
<cfdump var="#getMembers#" > --->

<cfmail server="vps.affordableusamovers.com" from='"Customer Care at Nationwide USA Movers" <customercare@nationwideusamovers.com>' username="customercare@nationwideusamovers.com" password="Temp1707!" port="587" useSSL="false" subject="New Follow-up Letters and Labels are Queued" to="ogroning@gmail.com" type="html">
test
</cfmail>
abooker@nationwideusamovers.com 
customercare@nationwideusamovers.com