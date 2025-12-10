<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset fulldatenow = now()>
<cfset datenow = #dateformat(fulldatenow, "YYYY-MM-DD")#>
<cfif parameterexists(keyword) is 'no'>
<cfset keyword=''>
</cfif>
<cfif parameterexists(searchacct) is 'no'>
<cfset searchacct=''>
</cfif>
<cfif parameterexists(type) is 'no'>
<cfset type=''>
</cfif>
<html>
<head>
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
<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
	<link rel="stylesheet" href="https://top12movingbiz.com/admin/css/colorswap.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<!-- Load SCRIPT.JS which will create datepicker for input field  -->
<script src="https://top12movingbiz.com/admin/scripts/script.js"></script>
<script src="https://top12movingbiz.com/admin/scripts/typeahead.jquery.min.js"></script>
<title>Administration - Client Information</title>


    <style type="text/css">
        .tt-menu {
          margin: -5px 0;
          padding: 5px;
          background-color: #fff;
          border: 1px solid #ccc;
          border: 1px solid rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body bgcolor="eceeee">
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

<!--- systems for marking postal mail for today --->
<cfif parameterexists(mark_initial) is 'yes'>
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=1 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('3','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('1','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<!---<cfif parameterexists(mark_follow) is 'yes'>
	<cfquery name="check_initial" datasource="aaalh3x_onestep">
		select * from LETTER_SENDS
		where send_type=6 and cust_hook=#clientid#
	</cfquery>
	<cfif check_initial.recordcount is not 0><!--- was already sent once --->
		<cfloop query="check_initial" >
			<cfquery name="set_initial" datasource="aaalh3x_onestep">
				insert into LETTER_SENDS
				(send_type,sent,cust_hook,sent_date,printqueueId)
				values ('7','1','#clientid#','#datenow#',<cfqueryparam cfsqltype="cf_sql_bigint" value="#check_initial.printqueueId#">)
			</cfquery>
		</cfloop>
	<cfelse>
		<cfquery name="getinfo" datasource="aaalh3x_onestep">
			select * from CLIENTS
			where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
		</cfquery>
		<cfquery name="getFollowUpPrintQueue" datasource="aaalh3x_onestep">
			select *
			from printQueue
			where printed=0
			and cleared=0
			and printType='followUp'
			and hanger = 0
			and clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
			order by followup_date
			limit 1
		</cfquery>
		<cfquery name="set_initial" datasource="aaalh3x_onestep">
			insert into LETTER_SENDS
			(send_type,sent,cust_hook,sent_date,printqueueId)
			values ('6','1','#clientid#','#datenow#',<cfqueryparam cfsqltype="cf_sql_bigint" value="#getFollowUpPrintQueue.id#">)
		</cfquery>
		
		<cfquery name="updPrintQueue" datasource="aaalh3x_onestep">
			update printQueue
			set printed=1
			where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#getFollowUpPrintQueue.id#">
		</cfquery>
		<!--- Send email to Anthony and Maria to let them know that a new follow-up letter and label is queued--->
		<cfmail from="customercare@vanlinequotes.com" subject="A New Follow-up Letter and Label are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
			#getinfo.first_name# #getinfo.last_name#<br />
			#getinfo.from_address# #getinfo.from_address2#<br />
			#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
		</cfmail>
	</cfif>
</cfif>--->

<cfif parameterexists(mark_estimate) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=8 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('9','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('8','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_carrierList) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=10 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('11','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('10','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_hangerClosing) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=100 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('101','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('100','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_hangerAppt) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=200 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('201','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('200','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_hangerOffer) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=210 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('211','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('210','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_hangerOfferUrgent) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=220 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('221','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('220','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_underContract) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=400 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('401','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('400','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>

<cfif parameterexists(mark_nonRealtorLead) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=20 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('21','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('20','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_mayflowerLetter) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=300 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('300','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('300','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>
<cfif parameterexists(mark_mayflowerFollowup) is 'yes'>
    <!--- check to see if this letter has already been sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
        select * from LETTER_SENDS
        where send_type=301 and cust_hook=#clientid#
    </cfquery>
     <cfif #check_initial.recordcount# is not 0><!--- was already sent once --->
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('301','1','#clientid#','#datenow#')
         </cfquery>
     <cfelse>
         <cfquery name="set_initial" datasource="aaalh3x_onestep">
             insert into LETTER_SENDS
             (send_type,sent,cust_hook,sent_date)
             values ('301','1','#clientid#','#datenow#')
         </cfquery>
     </cfif>
</cfif>


<!--- start lebel queue system --->
<cfif parameterexists(mark_initial) is 'yes' OR  
	parameterexists(mark_estimate) is 'yes' or
	parameterexists(mark_nonRealtorLead) is 'yes' or
	parameterexists(mark_underContract) is 'yes' or
	parameterexists(mark_mayflowerLetter) is 'yes'>
<cfquery name="q" datasource="aaalh3x_onestep">
insert into LETTER_SENDS
(send_type,active,cust_hook,user_hook)
values ('999','1','#clientid#','#verify.id#')
</cfquery>
</cfif>

<cfif parameterexists(mark_mayflowerFollowup) is 'yes' OR parameterexists(mark_follow) is 'yes'>
	
	<cfquery name="getinfo" datasource="aaalh3x_onestep">
		select * from CLIENTS
		where id= <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	</cfquery>
	
	<cfif getinfo.appointment_date neq ''>
		
		<cfquery name="checkFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
			select *
			from LETTER_SENDS
			where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
			and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
            and user_hook = #verify.ID#
            and sent = 0
			order by followup_date
		</cfquery>
        
		
		<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
			<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
				insert into LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date,date_time_to_order_on_sheet)
				values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">)
			</cfquery>
			
			<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,getinfo.appointment_date)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,getinfo.appointment_date)>
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfquery name="q" datasource="aaalh3x_onestep">
					insert into LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#clientid#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
			</cfloop>
			
			<!--- Send email to Anthony and Maria to let them know that a new follow-up label is queued--->
			<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
				#getinfo.first_name# #getinfo.last_name#<br />
				#getinfo.from_address# #getinfo.from_address2#<br />
				#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
			</cfmail>--->
		<cfelse>
			<!--- Force the first label in queue to have a follow up date now so it can be printed --->
			<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
				update LETTER_SENDS
				set active = <cfqueryparam cfsqltype="cf_sql_bit" value="1">,
					followup_date = <cfqueryparam cfsqltype="cf_sql_date" value="#datenow#">,
                    sent = 1,
					date_time_to_order_on_sheet = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#fulldatenow#">,
					user_hook = '#verify.id#'<!--- This is important so that the current user can see the customer's follow up label in the front-end even if the current user hasn't entered the customer in the database --->
				where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#checkFollowUpLabelBeforeAppointmentDate.id[1]#">
			</cfquery>
			<!--- Send email to Anthony and Maria to let them know that a new follow-up label is queued--->
			<!---<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
				#getinfo.first_name# #getinfo.last_name#<br />
				#getinfo.from_address# #getinfo.from_address2#<br />
				#getinfo.from_city# #getinfo.from_state# #getinfo.from_zip#
			</cfmail>--->
		</cfif>
	</cfif>
	

</cfif>

<!--- end label queue system --->
<!--- end postal mail tracking system --->

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Client Information</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>
<cfset datenow=#dateformat(now(), "MM/DD/YYYY")#>
<cfset timenow=#timeformat(now(), "hh:mm tt")#>

<div align="center">

<cfif parameterexists(mark_complete) is 'yes'>
<cfquery name="comp" datasource="aaalh3x_onestep">
update CLIENTS
set active='3'
where id=#clientid#
</cfquery>
    <!---- remove from printQueue ---->
    <cfquery name="qKiilFromQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM printQueue
        WHERE clientID IN (#clientid#)
        </cfquery>
    <!--- remove from label queue ----->
    <cfquery name="qKiilFromLabelQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM Letter_sends
        WHERE cust_hook IN (#clientid#) and 
          sent = 0 and
          active = 1
        </cfquery>
    <!--- add new items to queue ----->
    <cfset Date1 = dateAdd('d', 7, Now())>
    <cfset Date2 = dateAdd('d', 7, Date1)>

      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>

      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#clientid#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#clientid#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>


<br><br>
<font face="arial" size="3" color="red"><b>The Record was marked COMPLETED in the System</b></font><br><br>
</cfif>
<cfif parameterexists(mark_canx) is 'yes'>
<cfquery name="canx" datasource="aaalh3x_onestep">
update CLIENTS
set active='4'
where id=#clientid#
</cfquery>
    <!---- remove from printQueue ---->
    <cfquery name="qKiilFromQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM printQueue
        WHERE clientID IN (#clientid#)
        </cfquery>
    <!--- remove from label queue ----->
    <cfquery name="qKiilFromLabelQueue" datasource="aaalh3x_onestep">
        DELETE
        FROM Letter_sends
        WHERE cust_hook IN (#clientid#) and 
          sent = 0 and
          active = 1
        </cfquery>
    <!--- add new items to queue ----->
    <cfset Date1 = dateAdd('d', 7, Now())>
    <cfset Date2 = dateAdd('d', 7, Date1)>

      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertLabel" datasource="aaalh3x_onestep">
        INSERT INTO letter_sends(send_type,cust_hook,sent,active,user_hook,followup_date)
        VALUES(998,#clientid#,0,1,#verify.ID#,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>

      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#clientid#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date1, 'YYYY-MM-DD')#')
      </cfquery>
      <cfquery name="qInsertQueue" datasource="aaalh3x_onestep">
        INSERT INTO printQueue(clientID,printType,printed,memberID,cleared,hanger,followup_date)
        VALUES(#clientid#,'followUp',0,#verify.ID#,0,0,'#dateformat(Date2, 'YYYY-MM-DD')#')
      </cfquery>


<br><br>
<font face="arial" size="3" color="red"><b>The Record was marked CANCELLED in the System</b></font><br><br>
</cfif>
<cfif parameterexists(mark_open) is 'yes'>
<cfquery name="canx" datasource="aaalh3x_onestep">
update CLIENTS
set active='1'
where id=#clientid#
</cfquery><br><br>
<font face="arial" size="3" color="green"><b>The Record was Reopened on the System</b></font><br><br>
</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top">

<cfif parameterexists(new_mc_number) is 'yes'>

    <cfquery name="getinfo" datasource="aaalh3x_onestep">
        select * from CLIENTS
        where id=#clientid#
    </cfquery>

     <cfif parameterexists(new_comments) is 'yes'>
      <cfif #new_comments# is not ''>
          <!--- FIXIT needs carriage return system built into comments area --->
          <cfset newcomments = "#getinfo.comments#<br><i>#dateformat(now(), "MMM D")# - #timeformat(now(), "h:mm tt")#</i><br><b>#verify.name#</b><br>#new_comments#<br>"> 
      <cfelse>
        <cfset newcomments = "#getinfo.comments#">
      </cfif>
     </cfif>
     <cfif #new_moving_date# is not 'None Yet' and #new_moving_date# is not ''>
        <cfset movdate = #dateformat(new_moving_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset movdate = ''>
     </cfif>
     <cfif #new_contract_date# is not 'None Yet' and #new_contract_date# is not ''>
        <cfset contdate = #dateformat(new_contract_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset contdate = ''>
     </cfif>
     <cfif IsDefined("new_under_contract_date") AND #new_under_contract_date# is not 'None Yet' and #new_under_contract_date# is not ''>
        <cfset undercontdate = #dateformat(new_under_contract_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset undercontdate = ''>
     </cfif>
     <!--- Store the old under_contract_date to check if it's newly added --->
     <cfif IsDefined("getinfo.under_contract_date") AND getinfo.under_contract_date NEQ ''>
        <cfset oldUnderContractDate = getinfo.under_contract_date>
     <cfelse>
        <cfset oldUnderContractDate = ''>
     </cfif>
     <cfif #new_closing_date# is not 'None Yet' and #new_closing_date# is not ''>
        <cfset closdate = #dateformat(new_closing_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset closdate = ''>
     </cfif>
     <cfif #new_appointment_date# is not 'None Yet' and #new_appointment_date# is not ''>
        <cfset appdate = #dateformat(new_appointment_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset appdate = ''>
     </cfif>
     <cfif #new_move_comp_date# is not 'None Yet' and #new_move_comp_date# is not ''>
        <cfset movcompdate = #dateformat(new_move_comp_date, "YYYY-MM-DD")#>
     <cfelse>
        <cfset movcompdate = ''>
     </cfif>
    <cfif #new_days_in_storage# is '' or #new_days_in_storage# is 0>
        <cfset new_storage_included = 0>
    <cfelse>
        <cfset new_storage_included = 1>
    </cfif>
   
    <cfif #form.hangerCallDate# is not 'None Yet' and #form.hangerCallDate# is not ''>
        <cfset newhangerCallDate = #dateformat(form.hangerCallDate, "YYYY-MM-DD")#>
     <cfelse>
        <cfset newhangerCallDate = ''>
     </cfif>

<cfif #form.hanger2CallDate# is not 'None Yet' and #form.hanger2CallDate# is not ''>
    <cfset newhanger2CallDate = #dateformat(form.hanger2CallDate, "YYYY-MM-DD")#>
 <cfelse>
    <cfset newhanger2CallDate = ''>
 </cfif>

 <cfif #form.hangerOfferCallDate# is not 'None Yet' and #form.hangerOfferCallDate# is not ''>
    <cfset newhangerOfferCallDate = #dateformat(form.hangerOfferCallDate, "YYYY-MM-DD")#>
 <cfelse>
    <cfset newhangerOfferCallDate = ''>
 </cfif>

<cfif #form.hangerOfferUrgentCallDate# is not 'None Yet' and #form.hangerOfferUrgentCallDate# is not ''>
    <cfset newhangerOfferUrgentCallDate = #dateformat(form.hangerOfferUrgentCallDate, "YYYY-MM-DD")#>
 <cfelse>
    <cfset newhangerOfferUrgentCallDate = ''>
 </cfif>

    <cfquery name="update_clients" datasource="aaalh3x_onestep">
        update CLIENTS
        set
        mc_number='#new_mc_number#',
         <cfif #movcompdate# is not ''>move_comp_date='#movcompdate#',<cfelse>move_comp_date=NULL,</cfif>
         <cfif #movdate# is not ''>moving_date='#movdate#',<cfelse>moving_date=NULL,</cfif>
         <cfif #contdate# is not ''>contract_date='#contdate#',<cfelse>contract_date=NULL,</cfif>
         <cfif #undercontdate# is not ''>under_contract_date='#undercontdate#',<cfelse>under_contract_date=NULL,</cfif>
         <cfif #appdate# is not ''>appointment_date='#appdate#',<cfelse>appointment_date=NULL,</cfif>
         <cfif #closdate# is not ''>closing_date='#closdate#',<cfelse>closing_date=NULL,</cfif>
        first_name='#new_first_name#',
        last_name='#new_last_name#',
        email='#new_email#',
        email2='#new_email2#',
        phone='#new_phone#',
        cell='#new_cell#',
        cell2='#new_cell2#',
        fax='#new_fax#',
        appt_confirmed='#new_appt_confirmed#',
        from_address='#new_from_address#',
        from_address2='#new_from_address2#',
        from_city='#new_from_city#',
        from_state='#new_from_state#',
        from_zip='#new_from_zip#',
        packing='#new_packing#',
        home_price='#new_home_price#',
        to_address='#new_to_address#',
        to_address2='#new_to_address2#',
        to_city='#new_to_city#',
        to_state='#new_to_state#',
        to_zip='#new_to_zip#',
        final_price='#new_final_price#',
        carrier_selected='#new_carrier_selected#',
        other_carrier='#new_other_carrier#',
        move_type='#new_move_type#',
        acessorial='#new_acessorial#',
        transportation='#new_transportation#',
        valuation='#new_valuation#',
        realty_company='#new_realty_company#',
        weight='#new_weight#',
        CubicFeet = '#new_cubicFeet#',
        miles='#new_miles#',
        storage_included='#new_storage_included#',
        <cfif IsDefined("form.StorageType")>
        StorageType = '#StorageType#',
        <cfelse>
        StorageType = '',
        </cfif>
        <cfif IsDefined("form.WarehouseType")>
        WarehouseType = '#WarehouseType#',
        <cfelse>
        WarehouseType = '',
        </cfif>
        days_in_storage='#new_days_in_storage#',
        valuation_included = #valuation_included#,
        valuation_comments = '#valuation_comments#',
        thirdPartyInsurance = #thirdPartyInsurance#,
        thirdPartyIns_comments = '#thirdPartyIns_comments#',
        autoShipping = #autoShipping#,
        autoShipping_comments = '#autoShipping_comments#',
        estimate_comments='#new_estimate_comments#',
        OtherServices = '#OtherServices#',
        thirdPartyServices = '#thirdPartyServices#',
        comments='#newcomments#',
        door_hanger_state='#doorHangerState#'
        <cfif #newhangerCallDate# is not ''>,door_hanger_call_date='#newhangerCallDate#'<cfelse>,door_hanger_call_date=NULL</cfif>
        <cfif #newhanger2CallDate# is not ''>,door_hanger2_call_date='#newhanger2CallDate#'<cfelse>,door_hanger2_call_date=NULL</cfif>
        <cfif #newhangerOfferCallDate# is not ''>,door_hangerOffer_call_date='#newhangerOfferCallDate#'<cfelse>,door_hangerOffer_call_date=NULL</cfif>
        <cfif #newhangerOfferUrgentCallDate# is not ''>,door_hangerOfferUrgent_call_date='#newhangerOfferUrgentCallDate#'<cfelse>,door_hangerOfferUrgent_call_date=NULL</cfif>
        where ID=#clientid#
    </cfquery>
    
    <!--- Automatically queue Under Contract letter if under_contract_date was newly added --->
    <cfif undercontdate NEQ '' AND oldUnderContractDate EQ ''>
        <cfquery name="checkExistingUnderContractQueue" datasource="aaalh3x_onestep">
            select * from printQueue
            where clientid = #clientid# and printType = 'underContract'
        </cfquery>
        <cfif checkExistingUnderContractQueue.recordcount EQ 0>
            <cfquery datasource="aaalh3x_onestep">
                insert into printQueue(clientid,printType,printed,memberId,cleared)
                values(#clientid#,'underContract',0,#verify.id#,0)
            </cfquery>
        </cfif>
    </cfif>
    
    <br>
    <font face="arial" size="3" color="green"><b>The Client Record was Modified</b></font><br><Br>
</cfif>

<cfif IsDefined("form.submitAddService")>
	<cfquery name="update_otherService" datasource="aaalh3x_onestep">
	INSERT INTO other_services(ClientID,ServiceType,ServiceCost)
	VALUES(#clientid#,'#ServiceType#','#ServiceCost#')
	</cfquery>
</cfif>

<cfif IsDefined("form.submitAddthirdpartyService")>
	<cfquery name="update_3rdpartyService" datasource="aaalh3x_onestep">
	INSERT INTO thirdparty_services(ClientID,ServiceType,ServiceCost)
	VALUES(#clientid#,'#thirdPartyServiceType#','#thirdPartyServiceCost#')
	</cfquery>
</cfif>

<cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from CLIENTS
    where id=#clientid#
</cfquery>
<cfquery name="realtors" datasource="aaalh3x_onestep">
    select distinct realty_company
    from clients
    where realty_company<>''
</cfquery>

<cfif isDefined("form.CarrierOrCustomer") and form.CarrierOrCustomer neq "">
<cfquery name="checkForRecord" datasource="aaalh3x_onestep">
SELECT *
FROM Packing
WHERE ClientID = #clientid#
</cfquery>
<cfif checkForRecord.RecordCount eq 0>
	<cfquery name="addRecord" datasource="aaalh3x_onestep">
	INSERT INTO Packing(ClientID)
	VALUES(#clientid#)
	</cfquery>
</cfif>
	<cfquery name="updateRecord" datasource="aaalh3x_onestep">
	UPDATE Packing
	SET PackingType = '#PackingType#',
		CarrierOrCustomer = '#CarrierOrCustomer#',
		<cfif BoxQty1 neq "">BoxQty1 = #BoxQty1#,</cfif>
		<cfif BoxQty2 neq "">BoxQty2 = #BoxQty2#,</cfif>
		<cfif BoxQty3 neq "">BoxQty3 = #BoxQty3#,</cfif>
		<cfif BoxQty4 neq "">BoxQty4 = #BoxQty4#,</cfif>
		<cfif BoxQty5 neq "">BoxQty5 = #BoxQty5#,</cfif>
		<cfif BoxQty6 neq "">BoxQty6 = #BoxQty6#,</cfif>
		<cfif BoxQty7 neq "">BoxQty7 = #BoxQty7#,</cfif>
		<cfif BoxQty8 neq "">BoxQty8 = #BoxQty8#,</cfif>
		<cfif BoxQty9 neq "">BoxQty9 = #BoxQty9#,</cfif>
		<cfif BoxQty10 neq "">BoxQty10 = #BoxQty10#,</cfif>
		<cfif BoxQty11 neq "">BoxQty11 = #BoxQty11#,</cfif>
		<cfif BoxQty12 neq "">BoxQty12 = #BoxQty12#,</cfif>
		<cfif BoxQty13 neq "">BoxQty13 = #BoxQty13#,</cfif>
		<cfif BoxQty14 neq "">BoxQty14 = #BoxQty14#,</cfif>
		<cfif BoxQty15 neq "">BoxQty15 = #BoxQty15#,</cfif>
		<cfif BoxQty16 neq "">BoxQty16 = #BoxQty16#,</cfif>
		<cfif BoxQty17 neq "">BoxQty17 = #BoxQty17#,</cfif>
		<cfif BoxQty18 neq "">BoxQty18 = #BoxQty18#,</cfif>
		<cfif BoxQty19 neq "">BoxQty19 = #BoxQty19#,</cfif>
		<cfif BoxQty20 neq "">BoxQty20 = #BoxQty20#,</cfif>
		<cfif BoxQty21 neq "">BoxQty21 = #BoxQty21#,</cfif>
		<cfif BoxQty22 neq "">BoxQty22 = #BoxQty22#,</cfif>
		<cfif BoxQty23 neq "">BoxQty23 = #BoxQty23#,</cfif>
		<cfif BoxQty24 neq "">BoxQty24 = #BoxQty24#,</cfif>
		OtherPackingServices = '#OtherPackingServices#'
	WHERE ClientID = #clientid#
	</cfquery>
</cfif>

<script>
        $(function() {
            $( "#hangerCallDate" ).datepicker({changeMonth: true,
                changeYear: true});
            var substringMatcher = function(strs) {
              return function findMatches(q, cb) {
                var matches, substringRegex;
             
                // an array that will be populated with substring matches
                matches = [];
                // regex used to determine if a string contains the substring `q`
                substrRegex = new RegExp('^'+q, 'i');
             
                // iterate through the pool of strings and for any string that
                // contains the substring `q`, add it to the `matches` array
                $.each(strs, function(i, str) {
                  if (substrRegex.test(str)) {
                    matches.push(str);
                  }
                });
             
                cb(matches);
              };
            };

            $( "#hanger2CallDate" ).datepicker({changeMonth: true,
                changeYear: true});
            var substringMatcher = function(strs) {
              return function findMatches(q, cb) {
                var matches, substringRegex;
             
                // an array that will be populated with substring matches
                matches = [];
                // regex used to determine if a string contains the substring `q`
                substrRegex = new RegExp('^'+q, 'i');
             
                // iterate through the pool of strings and for any string that
                // contains the substring `q`, add it to the `matches` array
                $.each(strs, function(i, str) {
                  if (substrRegex.test(str)) {
                    matches.push(str);
                  }
                });
             
                cb(matches);
              };
            };

            $( "#hangerOfferCallDate" ).datepicker({changeMonth: true,
                changeYear: true});
            var substringMatcher = function(strs) {
              return function findMatches(q, cb) {
                var matches, substringRegex;
             
                // an array that will be populated with substring matches
                matches = [];
                // regex used to determine if a string contains the substring `q`
                substrRegex = new RegExp('^'+q, 'i');
             
                // iterate through the pool of strings and for any string that
                // contains the substring `q`, add it to the `matches` array
                $.each(strs, function(i, str) {
                  if (substrRegex.test(str)) {
                    matches.push(str);
                  }
                });
             
                cb(matches);
              };
            };

            $( "#hangerOfferUrgentCallDate" ).datepicker({changeMonth: true,
                changeYear: true});
            var substringMatcher = function(strs) {
              return function findMatches(q, cb) {
                var matches, substringRegex;
             
                // an array that will be populated with substring matches
                matches = [];
                // regex used to determine if a string contains the substring `q`
                substrRegex = new RegExp('^'+q, 'i');
             
                // iterate through the pool of strings and for any string that
                // contains the substring `q`, add it to the `matches` array
                $.each(strs, function(i, str) {
                  if (substrRegex.test(str)) {
                    matches.push(str);
                  }
                });
             
                cb(matches);
              };
            };
             
            var states = ['AL', 'AK', 'AZ', 'AR', 'CA',
              'CO', 'CT', 'DC','DE', 'FL', 'GA', 'HI',
              'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA',
              'ME', 'MD', 'MA', 'MI', 'MN',
              'MS', 'MO', 'MT', 'NE', 'NV', 'NH',
              'NJ', 'NM', 'NY', 'NC', 'ND',
              'OH', 'OK', 'OR', 'PA', 'RI',
              'SC', 'SD', 'TN', 'TX', 'UT', 'VT',
              'VA', 'WA', 'WV', 'WI', 'WY'
            ];

            var realtors = [<cfoutput query="realtors">'#replace(realtors.realty_company,"'","\'","all")#'<cfif realtors.currentrow lt realtors.recordcount>,</cfif></cfoutput>
            ];
             
            $('.typeahead').typeahead({
              hint: true,
              highlight: true,
              minLength: 1
            },
            {
              name: 'states',
              source: substringMatcher(states)
            });

            $('.realtorTypeahead').typeahead({
              hint: true,
              highlight: true,
              minLength: 1
            },
            {
              name: 'states',
              source: substringMatcher(realtors)
            });
            <cfoutput>
            $('##new_from_state').typeahead('val', '#getinfo.from_state#');
            $('##new_to_state').typeahead('val', '#getinfo.to_state#');
            $('##new_realty_company').typeahead('val', '#getinfo.realty_company#');
            </cfoutput>
        });

        
    </script>


<form action="client_info.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
<cfoutput>
<font face="arial" size="3"><b>#getinfo.first_name# #getinfo.last_name#</b></font>&nbsp;- <cfif #getinfo.active# is 3><font color="red" face="arial" size="3">COMPLETED</font><cfelseif #getinfo.active# is 4><font face="arial" size="3" color="red"><b>CANCELLED</b></font><cfelse><font face="arial" size="3" color="green"><b>Open</b></font></cfif><br><BR>
<font face="arial" size="2">
<input type="hidden" name="clientid" value="#clientid#">
MC Number <input type="text" name="new_mc_number" size="15" value="#getinfo.mc_number#"><br>

Realtor <!--- <input type="text" name="new_realty_company" size="20" value="#getinfo.realty_company#"> --->
<div>
  <input class="realtorTypeahead" type="text" name="new_realty_company" id="new_realty_company">
</div>
<br>


<cfif #getinfo.contract_date# is ''>
<cfset contdate = 'None Yet'>
<cfelse>
<cfset contdate = '#dateformat(getinfo.contract_date, "MM/DD/YYYY")#'>
</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Offer Date </td><td valign="middle"><input class="remindmedropdowna" name="new_contract_date" id="datepicker" value="<cfoutput>#contdate#</cfoutput>" size="10"></td>
</tr>

<cfif #getinfo.under_contract_date# is ''>
<cfset undercontdate = 'None Yet'>
<cfelse>
<cfset undercontdate = '#dateformat(getinfo.under_contract_date, "MM/DD/YYYY")#'>
</cfif>
<tr>
<td valign="middle"><font face="arial" size="2">Under Contract Date </td><td valign="middle"><input class="remindmedropdowna" name="new_under_contract_date" id="datepickerd" value="<cfoutput>#undercontdate#</cfoutput>" size="10"></td>
</tr>

<cfif #getinfo.closing_date# is ''>
<cfset closedate = 'None Yet'>
<cfelse>
<cfset closedate = '#dateformat(getinfo.closing_date, "MM/DD/YYYY")#'>
</cfif>
<tr>
<td valign="middle"><font face="arial" size="2">Closing Date </td><td valign="middle"><input class="remindmedropdowna" name="new_closing_date" id="datepickera" value="<cfoutput>#closedate#</cfoutput>" size="10"></td>
</tr>

<cfif #getinfo.moving_date# is ''>
<cfset movdate = 'None Yet'>
<cfelse>
<cfset movdate = '#dateformat(getinfo.moving_date, "MM/DD/YYYY")#'>
</cfif>
<tr>
<td valign="middle"><font face="arial" size="2">Moving Date </td><td valign="middle"><input class="remindmedropdowna" name="new_moving_date" id="datepickerb" value="<cfoutput>#movdate#</cfoutput>" size="10"></td>
</tr>
</table>

<Br><BR>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">First Name </td><td valign="middle"><input type="text" name="new_first_name" value="#getinfo.first_name#" size="12"></td>
<td valign="middle"><font face="arial" size="2">&nbsp;Last Name </td><td valign="middle"><input type="text" name="new_last_name" size="15" value="#getinfo.last_name#"></td>
</tr>
<tr>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Email </div></td><td valign="middle"><input type="text" name="new_email" size="20" value="#getinfo.email#"></td>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Phone </div></td><td valign="middle"><input type="text" name="new_phone" size="12" value="#getinfo.phone#"></td>
</tr>
<tr>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Second Email </div></td><td valign="middle"><input type="text" name="new_email2" size="20" value="#getinfo.email2#"></td>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Cell </div></td><td valign="middle"><input type="text" name="new_cell" size="12" value="#getinfo.cell#"></td>
</tr>
<tr>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Fax </div></td><td valign="middle"><input type="text" name="new_fax" size="12" value="#getinfo.fax#"></td>
<td valign="middle"><div align="right"><font face="arial" size="2">&nbsp;Second Cell </div></td><td valign="middle"><input type="text" name="new_cell2" size="12" value="#getinfo.cell2#"></td>
</tr></table>
<br>
</cfoutput>

<cfif #getinfo.appointment_date# is ''>
<cfset appdate = 'None Yet'>
<cfelse>
<cfset appdate = '#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#'>
</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Appointment Date &nbsp;</td><td valign="middle"><input class="remindmedropdowna" name="new_appointment_date" id="datepickerc" value="<cfoutput>#appdate#</cfoutput>" size="10"> <font face="arial" size="2">Confirmed: <select name="new_appt_confirmed"><cfif #getinfo.appt_confirmed# is not 1><option value="0">No<option value="1">Yes<cfelse><option value="1">Yes<option value="0">No</cfif></select></td>
</tr>
<tr>
<td valign="middle">
    <font face="arial" size="2">Discount Code &nbsp;
</td>
<td valign="middle">
    <cfoutput>#getInfo.discountCode#</cfoutput>
</td>
</tr>

</table>

<cfoutput>
<br><br>
<table border="1" cellpadding="3" cellspacing="0"><tr><td bgcolor="cbf6f9">
<b>Moving From</b><Br><br>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Address </td>
<td valign="middle"><input type="text" name="new_from_address" size="20" value="#getinfo.from_address#"></td>
<Td valign="middle"><font face="arial" size="2"><font face="arial" size="2">City </td>
<td valign="middle"><input type="text" name="new_from_city" size="20" value="#getinfo.from_city#"></td>
</tr>
<tr>
<td></td>
<td valign="middle"><input type="text" name="new_from_address2" size="20" value="#getinfo.from_address2#"></td>
<td valign="middle">
<font face="arial" size="2">State </td><td valign="middle">
<div>
  <input class="typeahead" type="text" name="new_from_state" id="new_from_state">
</div>
<!---<select name="new_from_state"><cfif #getinfo.from_state# is not ''><option value="#getinfo.from_state#">#getinfo.from_state#</option><cfelse><option value="">Select</option></cfif><option value="AL">AL</option>
                <option value="AK">AK</option>
                <option value="AZ">AZ</option>
                <option value="AR">AR</option>
                <option value="CA">CA</option>
                <option value="CO">CO</option>
                <option value="CT">CT</option>
				<option value="DC">DC</option>
                <option value="DE">DE</option>
                <option value="FL">FL</option>
                <option value="GA">GA</option>
                <option value="HI">HI</option>
                <option value="ID">ID</option>
                <option value="IL">IL</option>
                <option value="IN">IN</option>
                <option value="IA">IA</option>
                <option value="KS">KS</option>
                <option value="KY">KY</option>
                <option value="LA">LA</option>
                <option value="ME">ME</option>
                <option value="MD">MD</option>
                <option value="MA">MA</option>
                <option value="MI">MI</option>
                <option value="MN">MN</option>
                <option value="MS">MS</option>
                <option value="MO">MO</option>
                <option value="MT">MT</option>
                <option value="NE">NE</option>
                <option value="NV">NV</option>
                <option value="NH">NH</option>
                <option value="NJ">NJ</option>
                <option value="NM">NM</option>
                <option value="NY">NY</option>
                <option value="NC">NC</option>
                <option value="ND">ND</option>
                <option value="OH">OH</option>
                <option value="OK">OK</option>
                <option value="OR">OR</option>
                <option value="PA">PA</option>
                <option value="RI">RI</option>
                <option value="SC">SC</option>
                <option value="SD">SD</option>
                <option value="TN">TN</option>
                <option value="TX">TX</option>
                <option value="UT">UT</option>
                <option value="VT">VT</option>
                <option value="VA">VA</option>
                <option value="WA">WA</option>
                <option value="WV">WV</option>
                <option value="WI">WI</option>
                <option value="WY">WY</option>
</select>---></td>
</tr>
<tr>
<td colspan="2"></td>
<td valign="middle">
<font face="arial" size="2">Zip </td><td width="middle"><input type="text" name="new_from_zip" size="10" value="#getinfo.from_zip#"></td></tr></table>
<br>
</cfoutput>

<cfif #getinfo.packing# is not 0>

<cfquery name="getpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where ID=#getinfo.packing#
</cfquery>
<cfquery name="getallpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where active=1 and ID <> #getinfo.packing#
order by type
</cfquery>

<cfelse>

<cfquery name="getallpacking" datasource="aaalh3x_onestep">
select * from PACKING_TYPES
where active=1
order by type
</cfquery>

</cfif>

<font face="arial" size="2">Packing <select name="new_packing"><cfif #getinfo.packing# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.packing#">#getpacking.type#</cfoutput></cfif><cfoutput query="getallpacking"><option value="#getallpacking.id#">#getallpacking.type#</cfoutput><cfif #getinfo.packing# is not 0><option value="0">None</cfif></select>

<cfif #getinfo.move_type# is not 0>

<cfquery name="getmovetype" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where ID=#getinfo.move_type#
</cfquery>
<cfquery name="getallmovetypes" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where active=1 and ID <> #getinfo.move_type#
order by type
</cfquery>

<cfelse>

<cfquery name="getallmovetypes" datasource="aaalh3x_onestep">
select * from MOVE_TYPES
where active=1
order by type
</cfquery>

</cfif>
&nbsp;&nbsp;<font face="arial" size="2">Move Type <select name="new_move_type"><cfif #getinfo.move_type# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.move_type#">#getmovetype.type#</cfoutput></cfif><cfoutput query="getallmovetypes"><option value="#getallmovetypes.id#">#getallmovetypes.type#</cfoutput><cfif #getinfo.move_type# is not 0><option value="0">None</cfif></select>

<cfoutput>
<br>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Home Price $</td><td valign="middle"><input type="text" name="new_home_price" size="7" value="#getinfo.home_price#"></td>
</tr>
</table>
<br></cfoutput>
<cfif #getinfo.carrier_selected# is not '0'>

<cfquery name="getcarrier" datasource="aaalh3x_onestep">
select * from CARRIERS
where id=#getinfo.carrier_selected#
</cfquery>

<cfquery name="getallcarriers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1
order by company
</cfquery>

<cfelse>

<cfquery name="getallcarriers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 and ID <> #getinfo.carrier_selected#
order by company
</cfquery>

</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Carrier Selected </td><td valign="middle"><select name="new_carrier_selected"><cfif #getinfo.carrier_selected# is 0><option value="0">None<cfelse><cfoutput><option value="#getinfo.carrier_selected#">#getcarrier.company#</cfoutput></cfif><cfoutput query="getallcarriers"><option value="#getallcarriers.id#">#getallcarriers.company#</cfoutput><cfif #getinfo.carrier_selected# is not 0><option value="0">None</cfif></select>
</td>
<td valign="middle">
<cfoutput>
<font face="arial" size="2">Other Carrier </td><td valign="middle"><input type="text" name="new_other_carrier" size="15" value="#getinfo.other_carrier#"></td>
</tr></table>

</td></tr></table>

<br><br>
<table border="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="e2e2e2">
<font face="arial" size="3"><b>Moving To</b></font><br><br>
<table border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle"><font face="arial" size="2">Address </td>
<Td valign="middle"><input type="text" name="new_to_address" size="20" value="#getinfo.to_address#"></td>
<td valign="middle"><font face="arial" size="2">City </td><td valign="middle"><input type="text" name="new_to_city" size="20" value="#getinfo.to_city#"></td>
</tr>
<tr>
<td></td>
<td valign="middle"><input type="text" name="new_to_address2" size="20" value="#getinfo.to_address2#"></td>
<Td valign="middle"><font face="arial" size="2">State </td><td valign="middle">
<div>
  <input class="typeahead" type="text" name="new_to_state" id="new_to_state">
</div>

<!---<select name="new_to_state"><cfif #getinfo.to_state# is not ''><option value="#getinfo.to_state#">#getinfo.to_state#</option><cfelse><option value="">Select</option></cfif><option value="AL">AL</option>
                <option value="AK">AK</option>
                <option value="AZ">AZ</option>
                <option value="AR">AR</option>
                <option value="CA">CA</option>
                <option value="CO">CO</option>
                <option value="CT">CT</option>
				<option value="DC">DC</option>
                <option value="DE">DE</option>
                <option value="FL">FL</option>
                <option value="GA">GA</option>
                <option value="HI">HI</option>
                <option value="ID">ID</option>
                <option value="IL">IL</option>
                <option value="IN">IN</option>
                <option value="IA">IA</option>
                <option value="KS">KS</option>
                <option value="KY">KY</option>
                <option value="LA">LA</option>
                <option value="ME">ME</option>
                <option value="MD">MD</option>
                <option value="MA">MA</option>
                <option value="MI">MI</option>
                <option value="MN">MN</option>
                <option value="MS">MS</option>
                <option value="MO">MO</option>
                <option value="MT">MT</option>
                <option value="NE">NE</option>
                <option value="NV">NV</option>
                <option value="NH">NH</option>
                <option value="NJ">NJ</option>
                <option value="NM">NM</option>
                <option value="NY">NY</option>
                <option value="NC">NC</option>
                <option value="ND">ND</option>
                <option value="OH">OH</option>
                <option value="OK">OK</option>
                <option value="OR">OR</option>
                <option value="PA">PA</option>
                <option value="RI">RI</option>
                <option value="SC">SC</option>
                <option value="SD">SD</option>
                <option value="TN">TN</option>
                <option value="TX">TX</option>
                <option value="UT">UT</option>
                <option value="VT">VT</option>
                <option value="VA">VA</option>
                <option value="WA">WA</option>
                <option value="WV">WV</option>
                <option value="WI">WI</option>
                <option value="WY">WY</option>
</select>---></td>
</tr>
<tr>
<td colspan="2"></td>
<td valign="middle"><font face="arial" size="2">Zip </td><td valign="middle"><input type="text" name="new_to_zip" size="10" value="#getinfo.to_zip#"></td>
</tr>
</td></tr></table>

</td></tr></table>


<br><br>
<table border="1" cellspacing="0" cellpadding="3">
    <tr>
        <td bgcolor="e2e2e2">
            <font face="arial" size="3"><b>Door Hanger Info</b></font><br><br>
            Call State:
            <cfset stateList= "DC,MD,VA" />
            <select name="doorHangerState" style="width:100px">
                <option value=""></option>
                <cfloop list="#stateList#" index="curState">
                    <option value="#curState#" <cfif curState is getInfo.door_hanger_state>SELECTED</cfif> >#curState#</option>
                </cfloop>
            </select>
            <br>
            <cfif #getinfo.door_hanger_call_date# is ''>
                <cfset hangerDate = 'None Yet'>
            <cfelse>
                <cfset hangerDate = '#dateformat(getinfo.door_hanger_call_date, "MM/DD/YYYY")#'>
            </cfif>
            Closing Urgent Call Date: <input type="text" size="10" name="hangerCallDate" id="hangerCallDate" value="#hangerDate#">

            <br>
            <cfif #getinfo.door_hanger2_call_date# is ''>
                <cfset hanger2Date = 'None Yet'>
            <cfelse>
                <cfset hanger2Date = '#dateformat(getinfo.door_hanger2_call_date, "MM/DD/YYYY")#'>
            </cfif>
            Appointment Call Date: <input type="text" size="10" name="hanger2CallDate" id="hanger2CallDate" value="#hanger2Date#">

            <br>
            <cfif #getinfo.door_hangerOffer_call_date# is ''>
                <cfset hangerOfferDate = 'None Yet'>
            <cfelse>
                <cfset hangerOfferDate = '#dateformat(getinfo.door_hangerOffer_call_date, "MM/DD/YYYY")#'>
            </cfif>
            Offer Call Date: <input type="text" size="10" name="hangerOfferCallDate" id="hangerOfferCallDate" value="#hangerOfferDate#">

            <br>
            <cfif #getinfo.door_hangerOfferUrgent_call_date# is ''>
                <cfset hangerOfferUrgentDate = 'None Yet'>
            <cfelse>
                <cfset hangerOfferUrgentDate = '#dateformat(getinfo.door_hangerOfferUrgent_call_date, "MM/DD/YYYY")#'>
            </cfif>
            Offer Urgent Call Date: <input type="text" size="10" name="hangerOfferUrgentCallDate" id="hangerOfferUrgentCallDate" value="#hangerOfferUrgentDate#">
        </td>
    </tr>
</table>
<br><br>


<font face="arial" size="2">
<br><br>
Estimated Weight: Under <input type="text" name="new_weight" size="5" value="#getinfo.weight#"> lbs. or Under <input type="text" name="new_cubicFeet" size="5" value="#getinfo.cubicFeet#"> cuft. <br><Br>
Valuation Included: <input type="radio" name="valuation_included" value="1"<cfif getinfo.valuation_included eq 1> checked</cfif>> Yes <input type="radio" name="valuation_included" value="0"<cfif getinfo.valuation_included eq 0> checked</cfif>> No <br><Br>
Valuation Comments:<br>
<textarea name="valuation_comments" rows="5" cols="60">#getinfo.valuation_comments#</textarea><br><br>

3rd Party Moving Insurance: <input type="radio" name="thirdPartyInsurance" value="1"<cfif getinfo.thirdPartyInsurance eq 1> checked</cfif>> Yes <input type="radio" name="thirdPartyInsurance" value="0"<cfif getinfo.thirdPartyInsurance eq 0> checked</cfif>> No <br><Br>
3rd Party Moving Insurance Comments:<br>
<textarea name="thirdPartyIns_comments" rows="5" cols="60">#getinfo.thirdPartyIns_comments#</textarea><br><br>

Auto Shipping: <input type="radio" name="autoShipping" value="1"<cfif getinfo.autoShipping eq 1> checked</cfif>> Yes <input type="radio" name="autoShipping" value="0"<cfif getinfo.autoShipping eq 0> checked</cfif>> No <br><Br>
Auto Shipping Comments:<br>
<textarea name="autoShipping_comments" rows="5" cols="60">#getinfo.autoShipping_comments#</textarea><br>

<hr>
Storage:  <input type="radio" name="storage_included" value="1"<cfif getinfo.storage_included eq 1> checked</cfif>> Yes <input type="radio" name="storage_included" value="0"<cfif getinfo.storage_included eq 0> checked</cfif>> No &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Days/Months of storage included in quote <input type="text" name="new_days_in_storage" size="5" value="#getinfo.days_in_storage#"><br><Br>
<input type="checkbox" name="StorageType" value="Storage Pick-Up Only"<cfif getinfo.StorageType contains "Storage Pick-Up Only"> checked</cfif>> Storage Pick-Up Only <br>
<input type="checkbox" name="StorageType" value="Storage Delivery Only"<cfif getinfo.StorageType contains "Storage Delivery Only"> checked</cfif>> Storage Delivery Only <br>
<input type="checkbox" name="StorageType" value="Storage Pick-Up and Delivery Both Included"<cfif getinfo.StorageType contains "Storage Pick-Up and Delivery Both Included"> checked</cfif>> Storage Pick-Up and Delivery Both Included <br>
<input type="checkbox" name="WarehouseType" value="Warehouse Handling In Only"<cfif getinfo.WarehouseType contains "Warehouse Handling In Only"> checked</cfif>> Warehouse Handling In Only <br>
<input type="checkbox" name="WarehouseType" value="Warehouse Handling Out Only"<cfif getinfo.WarehouseType contains "Warehouse Handling Out Only"> checked</cfif>> Warehouse Handling Out Only <br>
<input type="checkbox" name="WarehouseType" value="Warehouse Handling In and Out Both Included"<cfif getinfo.WarehouseType contains "Warehouse Handling In and Out Both Included"> checked</cfif>> Warehouse Handling In and Out Both Included <br>
<hr>
<cfif isDefined("deleteOtherService") and deleteOtherService gt 0>
<cfquery name="deleteOtherServices" datasource="aaalh3x_onestep">
DELETE
FROM other_services
WHERE ClientID = #ClientID# and
	ID = #deleteOtherService#
</cfquery>
</cfif>
<cfquery name="getOtherServices" datasource="aaalh3x_onestep">
SELECT *
FROM other_services
WHERE ClientID = #ClientID#
</cfquery>
<b>Other Services:</b> <input type="radio" name="OtherServices" value="Origin and Destination"<cfif getinfo.OtherServices contains "Origin and Destination"> checked</cfif>> Origin and Destination 
				<input type="radio" name="OtherServices" value="Origin Only"<cfif getinfo.OtherServices contains "Origin Only"> checked</cfif>> Origin Only
				<input type="radio" name="OtherServices" value="Destination Only"<cfif getinfo.OtherServices contains "Destination Only"> checked</cfif>> Destination Only
				<input type="radio" name="OtherServices" value=""<cfif getinfo.OtherServices eq ""> checked</cfif>> None
				<br><br>
	
<table border="0" cellspacing="0" cellpadding="0" width="90%" style="font-size:13px;">
	<tr>
		<td><b>ID</b></td>
		<td><b>Service Type</b></td>
		<td><b>Service Cost</b></td>
	</tr>
	<cfloop query="getOtherServices">
	<tr>
		<td><a href="client_info.cfm?un=#un#&pw=#pw#&clientID=#clientID#&deleteOtherService=#getOtherServices.id#">#ID#</a></td>
		<td>#ServiceType#</td>
		<td>#ServiceCost#</td>
	</tr>
	</cfloop>
</table>
	<br><br>
Service Desc: 	<input type="text" name="ServiceType" size="30" value="">  Service Cost: <input type="text" name="ServiceCost" size="10" value=""> <input type="submit" name="submitAddService" value="Add Service">
<hr>
<cfif isDefined("deleteThirdPartyService") AND deleteThirdPartyService gt 0>
<cfquery name="deleteThirdpartyServices" datasource="aaalh3x_onestep">
DELETE
FROM thirdparty_services
WHERE ClientID = #ClientID# and
	ID = #deleteThirdPartyService#
</cfquery>
</cfif>
<cfquery name="getThirdpartyServices" datasource="aaalh3x_onestep">
SELECT *
FROM thirdparty_services
WHERE ClientID = #ClientID#
</cfquery>
<b>3rd Party Services / Crating:</b> <input type="radio" name="thirdPartyServices" value="Origin and Destination"<cfif getinfo.thirdPartyServices contains "Origin and Destination"> checked</cfif>> Origin and Destination 
				<input type="radio" name="thirdPartyServices" value="Origin Only"<cfif getinfo.thirdPartyServices contains "Origin Only"> checked</cfif>> Origin Only
				<input type="radio" name="thirdPartyServices" value="Destination Only"<cfif getinfo.thirdPartyServices contains "Destination Only"> checked</cfif>> Destination Only
				<input type="radio" name="thirdPartyServices" value=""<cfif getinfo.thirdPartyServices eq ""> checked</cfif>> None
				<br><br>
<table border="0" cellspacing="0" cellpadding="0" width="90%" style="font-size:13px;">
	<tr>
		<td><b>ID</b></td>
		<td><b>Service Type</b></td>
		<td><b>Service Cost</b></td>
	</tr>
	<cfloop query="getThirdpartyServices">
	<tr>
		<td><a href="client_info.cfm?un=#un#&pw=#pw#&clientID=#clientID#&deleteThirdPartyService=#getThirdpartyServices.id#">#ID#</a></td>
		<td>#ServiceType#</td>
		<td>#ServiceCost#</td>
	</tr>
	</cfloop>
</table>
<br><br>
Service Desc: 	<input type="text" name="thirdpartyServiceType" size="30" value="">  Service Cost: <input type="text" name="thirdpartyServiceCost" size="10" value=""> <input type="submit" name="submitAddthirdpartyService" value="Add Service">
<hr>
<cfquery name="getPacking" datasource="aaalh3x_onestep">
SELECT *
FROM Packing
WHERE ClientID = #ClientID#
</cfquery>
<strong>Packing Materials:</strong> <select name="packingType">
										<option value=""> - SELECT -</option>
                                        <option value="Self Pack"<cfif getPacking.packingType eq "Self Pack"> selected</cfif>>Self Pack</option>
										<option value="Mini Pack"<cfif getPacking.packingType eq "Mini Pack"> selected</cfif>>Mini Pack</option>
                                        <option value="Partial Pack"<cfif getPacking.packingType eq "Partial Pack"> selected</cfif>>Partial Pack</option>
                                        <option value="Full Pack"<cfif getPacking.packingType eq "Full Pack"> selected</cfif>>Full Pack</option>
                                        </select>
                                        <input type="radio" name="CarrierOrCustomer" value="Carrier Packing Summary"<cfif getPacking.CarrierOrCustomer eq "Carrier Packing Summary"> checked</cfif>> Carrier Packing Summary
                                        <input type="radio" name="CarrierOrCustomer" value="Customer Packing Summary"<cfif getPacking.CarrierOrCustomer eq "Customer Packing Summary"> checked</cfif>> Customer Packing Summary
                                        <input type="radio" name="CarrierOrCustomer" value=""<cfif getPacking.CarrierOrCustomer eq ""> checked</cfif>> None
                                        <br><br>
<cfoutput>
<table width="80%" border="0" cellspacing="0" cellpadding="2">
  <tr style="font-family:Arial; font-weight:bold; font-size:13px;">
    <td>Carrier</td>
    <td>Customer</td>
    <td width="40%">Box Type</td>
    <td>Carrier</td>
    <td>Customer</td>
    <td width="40%">Box Type</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty1" style="width:30px" value="#getPacking.BoxQty1#"></td>
    <td><input type="text" name="BoxQty13" style="width:30px" value="#getPacking.BoxQty13#"></td>
    <td>1.5 cubic feet, small</td>
    <td><input type="text" name="BoxQty2" style="width:30px" value="#getPacking.BoxQty2#"></td>
    <td><input type="text" name="BoxQty14" style="width:30px" value="#getPacking.BoxQty14#"></td>
    <td>Wardrobe</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty3" style="width:30px" value="#getPacking.BoxQty3#"></td>
    <td><input type="text" name="BoxQty15" style="width:30px" value="#getPacking.BoxQty15#"></td>
    <td>3.0 cubic feet, medium</td>
    <td><input type="text" name="BoxQty4" style="width:30px" value="#getPacking.BoxQty4#"></td>
    <td><input type="text" name="BoxQty16" style="width:30px" value="#getPacking.BoxQty16#"></td>
    <td>Mirror carton</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty5" style="width:30px" value="#getPacking.BoxQty5#"></td>
    <td><input type="text" name="BoxQty17" style="width:30px" value="#getPacking.BoxQty17#"></td>
    <td>4.5 cubic feet, large box</td>
    <td><input type="text" name="BoxQty6" style="width:30px" value="#getPacking.BoxQty6#"></td>
    <td><input type="text" name="BoxQty18" style="width:30px" value="#getPacking.BoxQty18#"></td>
    <td>Single mattress carton / bag</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty7" style="width:30px" value="#getPacking.BoxQty7#"></td>
    <td><input type="text" name="BoxQty19" style="width:30px" value="#getPacking.BoxQty19#"></td>
    <td>6.0 cubic feet, extra large</td>
    <td><input type="text" name="BoxQty8" style="width:30px" value="#getPacking.BoxQty8#"></td>
    <td><input type="text" name="BoxQty20" style="width:30px" value="#getPacking.BoxQty20#"></td>
    <td>Double mattress carton / bag</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty9" style="width:30px" value="#getPacking.BoxQty9#"></td>
    <td><input type="text" name="BoxQty21" style="width:30px" value="#getPacking.BoxQty21#"></td>
    <td>TV Flat - 32" to 59" box</td>
    <td><input type="text" name="BoxQty10" style="width:30px" value="#getPacking.BoxQty10#"></td>
    <td><input type="text" name="BoxQty22" style="width:30px" value="#getPacking.BoxQty22#"></td>
    <td>Queen mattress carton / bag</td>
  </tr>
  <tr style="font-family:Arial; font-size:13px;">
    <td><input type="text" name="BoxQty11" style="width:30px" value="#getPacking.BoxQty11#"></td>
    <td><input type="text" name="BoxQty23" style="width:30px" value="#getPacking.BoxQty23#"></td>
    <td>Dishpack</td>
    <td><input type="text" name="BoxQty12" style="width:30px" value="#getPacking.BoxQty12#"></td>
    <td><input type="text" name="BoxQty24" style="width:30px" value="#getPacking.BoxQty24#"></td>
    <td>King mattress carton / bag</td>
  </tr>
</table>
<textarea name="OtherPackingServices" rows="5" cols="60">#getPacking.OtherPackingServices#</textarea><br>
</cfoutput>

	
<br><br>
<br><br>
<br><br>
Miles: <input type="text" name="new_miles" size="10" value="#getinfo.miles#">
<br><br>

<!---Days in Storage: <input type="text" name="new_days_in_storage" size="10" value="#getinfo.days_in_storage#">--->

<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Valuation $</td>
<td valign="middle"><input type="text" name="new_valuation" size="8" value="#getinfo.valuation#"> <!---<input type="checkbox" name="new_valuation_included" value="1"<cfif #getinfo.valuation_included# is 1> checked</cfif>> <font face="arial" size="2">(Check if Valuation is Included)---></td>
</tr>
</table>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Transportation $</td>
<td valign="middle"><input type="text" name="new_transportation" size="8" value="#getinfo.transportation#"></td>
</tr>
</table>
<font face="arial" size="2">Accessorial<br><textarea name="new_acessorial" rows="2" cols="60">#getinfo.acessorial#</textarea>
<br><Br>
<font face="arial" size="2">Comments on Estimate<br><textarea name="new_estimate_comments" rows="2" cols="60">#getinfo.estimate_comments#</textarea>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Final Price $</td>
<td valign="middle"><input type="text" name="new_final_price" size="8" value="#getinfo.final_price#"></td>
</tr>
</table>

<cfif #getinfo.move_comp_date# is ''>
<cfset compdate = 'None Yet'>
<cfelse>
<cfset compdate = '#dateformat(getinfo.move_comp_date, "MM/DD/YYYY")#'>
</cfif>
<table border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="middle"><font face="arial" size="2">Move Completed Date </td><td valign="middle"><input class="remindmedropdowna" name="new_move_comp_date" id="datepickerd" value="#compdate#" size="10"></td>
</tr></table>

</cfoutput>

<br><br>

<cfif #getinfo.comments# is not ''>
<font face="arial" size="2"><b>Comments</b><Br></font>
<cfoutput>#getinfo.comments#</cfoutput><br><br>
</cfif>

<b>Add to Comments</b><br>
<textarea name="new_comments" rows="5" cols="60"></textarea><Br><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput>


<input type="submit" value="Make Changes"></form>
<BR><BR>

</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td valign="top">
<!--- 
    LETTER_SEND send_types:
        initial letter (initial = 1, resend = 3)
        follow up (initial = 6, resend = 7)
        estimate (initial = 8, resend = 9)
        hanger closing (initial = 100, resend = 101)
        hanger appt  (initial = 200, resend = 201)
        hanger offer  (initial = 210, resend = 211)
        hanger offer urgent  (initial = 220, resend = 221)
        non realtor leads (initial = 20, resend = 21) 
--->






<font face="arial" size="3"><b>Status</b><br></font>
<font face="arial" size="2">

<cfquery name="cq" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=999 and cust_hook=#clientid# and active=1 and user_hook=#verify.id#
</cfquery>
<cfif #cq.recordcount# is not 0>
<Br>
<font color="green" size="2" face="arial"><b>This Client already has a Mailing Label in the Queue</b><br></font>
</cfif>


<cfquery name="get_mayFlowerLetter" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=300 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>

 <cfif #get_mayFlowerLetter.recordcount# is 0>
    Van Line Letter Not Sent<br>
 <cfelse>
    Van Line Letter Sent (<cfif #get_mayFlowerLetter.sent# is 1>Mailed<cfelseif #get_mayFlowerLetter.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_mayFlowerLetter.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 </cfif> 
 
 
 <!-- New ccd Y
 <cfquery name="qLettersDate" datasource="aaalh3x_onestep">
SELECT ID, First_name, Last_name, enter_date, entry_date, appointment_date	
FROM Clients
 where ID = #clientid#
</cfquery>
              
         <cfif #qLettersDate.recordcount# is not 0>         
                 <!---    <cfif #printType# is 'new'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: #printType# (#dateformat(qLettersDate.entry_date, "YYYY-MM-DD")#)   </cfif>  --->
         Type: Van Line <cfoutput>(#dateformat(qLettersDate.entry_date, "YYYY-MM-DD")#)</cfoutput> <BR>
         
        Type: Van Line Followup <cfoutput>(#DateFormat(DateAdd('d', -7, qLettersDate.appointment_date),'YYYY-MM-DD')#)</cfoutput>  <br>
 </cfif>
 
-->

<cfquery name="get_mayFlowerFlyer" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=301 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_mayFlowerFlyer.recordcount# is 0>
    Van Line Flyer Not Sent<br>
 <cfelse>
    Van Line Flyer Sent (<cfif #get_mayFlowerFlyer.sent# is 1>Mailed<cfelseif #get_mayFlowerFlyer.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_mayFlowerFlyer.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 </cfif>
 
 <cfquery name="get_mayFlowerFollowup" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=300 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>

 <cfif #get_mayFlowerFollowup.recordcount# is 0>
    Van Line Follow Up Not Sent<br>
 <cfelse>
    Van Line Follow Up Sent (<cfif #get_mayFlowerFollowup.sent# is 1>Mailed<cfelseif #get_mayFlowerFollowup.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_mayFlowerFollowup.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 </cfif> 


<cfquery name="get_initial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=1 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_initial.recordcount# is 0>
    Initial Letter Not Sent<br>

 <cfelse>
    Initial Letter Sent (<cfif #get_initial.sent# is 1>Mailed<cfelseif #get_initial.sent# is 2>Emailed</cfif> <cfoutput> #dateformat(get_initial.sent_date, "MMM D, YYYY")#)<br></cfoutput>

 </cfif>
<cfquery name="get_resinitial" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=3 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resinitial.recordcount# is not 0>
 <cfoutput query="get_resinitial">
 - Initial Letter Resent <cfif #get_resinitial.sent# is 1>(Mailed<cfelseif #get_resinitial.sent# is 2>(Emailed </cfif> #dateformat(get_resinitial.sent_date, "MMM D, YYYY")#)<br>
 </cfoutput>
 </cfif>
<!---
<cfquery name="get_tent" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=2 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_tent.recordcount# is 0>
 Tentative Letter Not Sent<br>
 
 <cfelse>
 Tentative Letter Sent <cfoutput>(#dateformat(get_tent.sent_date, "MMM D, YYYY")#)</cfoutput><br>

 </cfif>
<cfquery name="get_restent" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=4 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_restent.recordcount# is not 0>
 <cfoutput query="get_restent">
 - Tentative Letter Resent (#dateformat(get_restent.sent_date, "MMM D, YYYY")#</cfoutput><br>
 </cfif>
and coalesce(ls.send_type,6) = 6
--->
<cfquery name="get_booked" datasource="aaalh3x_onestep">
	SELECT * FROM printqueue pq left join LETTER_SENDS ls on pq.id = ls.printqueueId
	where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#clientid#">
	and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
    and pq.memberID = #verify.ID#
	order by pq.followup_date
</cfquery>

<cfif get_booked.recordCount gt 0>
	<cfoutput query="get_booked" >
		<cfif get_booked.sent eq 0>
			Follow Up Letter #get_booked.currentRow# Not Sent<br>
		<cfelse>
			Follow Up Letter #get_booked.currentRow# Sent <cfif get_booked.sent eq 1>(Mailed<cfelseif get_booked.sent eq 2>(Emailed </cfif> #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<br>
		</cfif>
	</cfoutput>
<cfelse>
	<cfoutput>
		<cfloop index="indFollowupLetter" from="1" to="7">
			Follow Up Letter #indFollowupLetter# Not Sent<br>
		</cfloop>
	</cfoutput>
</cfif>
<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=7 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 - Follow Up Letter #get_resbooked.currentRow# Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>

<cfquery name="get_booked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=100 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfif #get_booked.recordcount# is 0>
    Door Hanger Closing Urgent Not Sent<br>
<cfelse>
    Door Hanger Closing Urgent Sent 
    <cfif #get_booked.sent# is 1>
        (Mailed
    <cfelseif #get_booked.sent# is 2>
        (Emailed 
    </cfif>
    <cfoutput> #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
        
 </cfif>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=101 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 -  Door Hanger Closing Urgent Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>


<cfquery name="get_booked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=200 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfif #get_booked.recordcount# is 0>
    Door Hanger Appointment Not Sent<br>
<cfelse>
    Door Hanger Appointment Sent 
    <cfif #get_booked.sent# is 1>
        (Mailed
    <cfelseif #get_booked.sent# is 2>
        (Emailed 
    </cfif>
    <cfoutput> #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
        
 </cfif>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=201 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 -  Door Hanger Appointment Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>



 <cfquery name="get_booked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=210 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfif #get_booked.recordcount# is 0>
    Door Hanger Offer Not Sent<br>
<cfelse>
    Door Hanger Offer Sent 
    <cfif #get_booked.sent# is 1>
        (Mailed
    <cfelseif #get_booked.sent# is 2>
        (Emailed 
    </cfif>
    <cfoutput> #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
        
 </cfif>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=211 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 -  Door Hanger Offer Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 </cfif>


 <cfquery name="get_booked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=220 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
<cfif #get_booked.recordcount# is 0>
    Door Hanger Offer Urgent Not Sent<br>
<cfelse>
    Door Hanger Offer Urgent Sent 
    <cfif #get_booked.sent# is 1>
        (Mailed
    <cfelseif #get_booked.sent# is 2>
        (Emailed 
    </cfif>
    <cfoutput> #dateformat(get_booked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
        
 </cfif>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=221 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_resbooked.recordcount# is not 0>
 <cfoutput query="get_resbooked">
 -  Door Hanger Offer Urgent Resent <cfif #get_resbooked.sent# is 1>(Mailed<cfelseif #get_resbooked.sent# is 2>(Emailed </cfif> #dateformat(get_resbooked.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 </cfif>




<cfquery name="get_estimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=8 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_estimate.recordcount# is 0>
 Estimate Not Sent<br>
 
 <cfelse>
 Estimate Sent <cfif #get_estimate.sent# is 1>(Mailed<cfelseif #get_estimate.sent# is 2>(Emailed </cfif><cfoutput> #dateformat(get_estimate.sent_date, "MMM D, YYYY")#)<br></cfoutput>

 </cfif> 
 
<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=9 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_reestimate.recordcount# is not 0>
 <cfoutput query="get_reestimate">
 - Estimate Resent <cfif #get_reestimate.sent# is 1>(Mailed<cfelseif #get_reestimate.sent# is 2>(Emailed </cfif> #dateformat(get_reestimate.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>

<cfquery name="get_carrierList" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=10 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_carrierList.recordcount# is 0>
 Carrier List Not Sent<br>
 
 <cfelse>
  Carrier List Sent <cfif #get_carrierList.sent# is 1>(Mailed<cfelseif #get_estimate.sent# is 2>(Emailed </cfif><cfoutput> #dateformat(get_carrierList.sent_date, "MMM D, YYYY")#)<br></cfoutput>

 </cfif> 
 
<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=9 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_reestimate.recordcount# is not 0>
 <cfoutput query="get_reestimate">
 - Estimate Resent <cfif #get_reestimate.sent# is 1>(Mailed<cfelseif #get_reestimate.sent# is 2>(Emailed </cfif> #dateformat(get_reestimate.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>

 <cfquery name="get_estimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=20 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_estimate.recordcount# is 0>
 Non Realtor Lead Not Sent<br>
 
 <cfelse>
 Non Realtor Lead Sent <cfif #get_estimate.sent# is 1>(Mailed<cfelseif #get_estimate.sent# is 2>(Emailed </cfif><cfoutput> #dateformat(get_estimate.sent_date, "MMM D, YYYY")#)<br></cfoutput>

 </cfif> 
 
<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=21 and (sent=1 or sent=2) and cust_hook=#clientid#
</cfquery>
 <cfif #get_reestimate.recordcount# is not 0>
 <cfoutput query="get_reestimate">
 - Non Realtor Lead Resent <cfif #get_reestimate.sent# is 1>(Mailed<cfelseif #get_reestimate.sent# is 2>(Emailed </cfif> #dateformat(get_reestimate.sent_date, "MMM D, YYYY")#)<br></cfoutput>
 
 </cfif>

 <br><br>
 <table border="1" cellspacing="0" cellpadding="3">
 <tr>
    <td colspan="4">
        <div align="center">
            <font face="arial" size="3"><b>Letter Generation</b></font>
        </div>
    </td>
</tr>
<tr>
    <td colspan="4" bgcolor="gray">
        <div align="center"><font face="arial" size="2" color="white"><b>Initial Letters</b></font></div>
    </td>
</tr>
 <tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/newListing.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_n#clientid#">New Listing Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/newListing.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_n#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_initial=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=new">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/offerLetter.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_g#clientid#">Got Offer Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/offerLetter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_g#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_initial=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=gotOffer">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/closingLetter.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_c#clientid#">Pending/Closing Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/closingLetter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_c#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_initial=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=closing">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/underContractLetter.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_u#clientid#">Under Contract Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/underContractLetter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_u#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_underContract=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=underContract">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/noRealtor.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_c#clientid#">Non Realtor Leads Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/noRealtor.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_c#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_nonRealtorLead=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=nonRealtorLeads">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/mayflowerLetter.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_c#clientid#">Van Line Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/mayflowerLetter.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_c#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_mayflowerLetter=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=MayflowerLetter">Queue</a>
        </cfoutput>
    </td>
</tr>

<tr>
    <td colspan="4" bgcolor="gray">
        <div align="center"><font face="arial" size="2" color="white"><b>Follow Up Letter</b></font></div>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/followup.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_f#clientid#">Follow Up Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/followup.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#&directPrint=1" target="_f#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_follow=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=followUp">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/mayflowerFollowup.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_f#clientid#">Van Line Follow Up Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/mayflowerFollowup.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#&directPrint=1" target="_f#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_mayflowerFollowup=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=MayflowerfollowUp">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle" colspan="4">
        <cfoutput>
            <a href="letters/flyer.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_n#clientid#">Flyer</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle" colspan="4">
        <cfoutput>
            <a href="letters/mayFlowerFlyer.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=1" target="_n#clientid#">Mayflower Flyer</a>
        </cfoutput>
    </td>
</tr>
<!--- Start hangers --->
<tr>
    <td colspan="4" bgcolor="gray">
        <div align="center"><font face="arial" size="2" color="white"><b>Door Hanger</b></font></div>
    </td>
</tr>


<!--- <tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHanger.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Door Hanger Closing Urgent</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerClosing=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> 
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hanger">Queue</a>
        </cfoutput>
    </td>
</tr> --->
<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHanger_new.cfm?clientid=#clientid#&un=#un#&pw=#pw#&directPrint=0" target="_n#clientid#">Door Hanger Residential</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerClosing=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hanger">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHanger_appt.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Door Hanger Appointment</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerAppt=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hangerAppt">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHanger.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Door Hanger Appointment Urgent</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerAppt=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hangerApptUrgent">Queue</a>
        </cfoutput>
    </td>
</tr>

<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHangerOffer_new.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Door Hanger Offer</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerOffer=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hangerOffer">Queue</a>
        </cfoutput>
    </td>
</tr>

<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHangerOfferUrgent.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Door Hanger Offer Urgent</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerOfferUrgent=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hangerOfferUrgent">Queue</a>
        </cfoutput>
    </td>
</tr>

<tr>
    <td valign="middle" colspan="2">
        <cfoutput>
            <a href="letters/doorHanger_mayflowerUnited.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_n#clientid#">Mayflower-United Door Hanger</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <!--- <cfoutput>
                    <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_hangerOfferUrgent=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
                </cfoutput> --->
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=hangerMayflower">Queue</a>
        </cfoutput>
    </td>
</tr>

<!--- end hangers --->



<tr>
    <td colspan="4" bgcolor="gray">
        <div align="center"><font face="arial" size="2" color="white"><b>Estimate</b><br></font></div>
    </td>
</tr>



<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/estimate.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_e#clientid#">Estimate Letter</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/estimate.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_e#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_estimate=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=estimate">Queue</a>
        </cfoutput>
    </td>
</tr>
<tr>
    <td valign="middle">
        <cfoutput>
            <a href="letters/carrierList.cfm?clientid=#clientid#&un=#un#&pw=#pw#" target="_e#clientid#">Carrier List</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfif #getinfo.email# CONTAINS '.' AND #getinfo.email# CONTAINS '@'>
            <cfoutput>
                <a href="letters/carrierList.cfm?clientid=#clientid#&emailit=y&un=#un#&pw=#pw#" target="_e#clientid#">Email Now</a>
            </cfoutput>
        </cfif>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="client_info.cfm?un=#un#&pw=#pw#&clientid=#clientid#&mark_carrierList=y<cfif parameterexists(url1) is 'yes'>&url1=#url1#</cfif><cfif parameterexists(searchacct) is 'yes'>&searchacct=#searchacct#</cfif><cfif parameterexists(type) is 'yes'>&type=#type#</cfif><cfif parameterexists(keyword) is 'yes'>&keyword=#keyword#</cfif>">Mark Mailed Today</a>
        </cfoutput>
    </td>
    <td valign="middle">
        <cfoutput>
            <a href="printQueueAdd.cfm?clientid=#clientid#&un=#un#&pw=#pw#&type=carrierList">Queue</a>
        </cfoutput>
    </td>
</tr>
 </table>
<br>
<br>

<cfset datenow='#dateformat(now(), "YYYY-MM-DD")#'>

<cfif parameterexists(editcarrierquote) is 'yes'><!--- already have a record for this carrier quote.. modifying it --->
<cfquery name="editquote" datasource="aaalh3x_onestep">
update ESTIMATES
set amount='#carrier_amount#', TypeOfQuote = '#TypeOfQuote#', QuoteComment = '#QuoteComment#', MenQty = '#MenQty#', VanQty = '#VanQty#', HoursQty = '#HoursQty#', TravelTimeQty = '#TravelTimeQty#'
where id=#editcarrierquote#
</cfquery>
<!--- edit rating here -----> 
<cfquery name="editRating" datasource="aaalh3x_onestep">
UPDATE Carriers
SET Rating = '#carrierRating#'
WHERE ID = #carrierID#
</cfquery>
<br>
<font face="arial" size="3" color="green">The quote amount was modified for this record</font><br><br>
</cfif>
<cfif IsDefined("form.newcarrierquote")><!--- no previous record for this carrier quote.. adding it --->
<cfquery name="addquote" datasource="aaalh3x_onestep">
insert into ESTIMATES(carrier,amount,user_hook,TypeOfQuote,QuoteComment,MenQty,VanQty,HoursQty,TravelTimeQty)
values('#newcarrierquote#','#carrier_amount#','#clientid#','#TypeOfQuote#','#QuoteComment#','#MenQty#','#VanQty#','#HoursQty#','#TravelTimeQty#')
</cfquery>
<!--- edit rating here -----> 
<cfquery name="editRating" datasource="aaalh3x_onestep">
UPDATE Carriers
SET Rating = '#carrierRating#'
WHERE ID = #carrierID#
</cfquery>
<font face="arial" size="3" color="green">The quote amount was added to this record</font><br><br>
</cfif>
<cfif parameterexists(remcarrierquote) is 'yes'><!--- already have a record for this carrier quote - removing it (set to blank) --->
<cfquery name="delquote" datasource="aaalh3x_onestep">
update ESTIMATES
set user_hook='0'
where id=#remcarrierquote#
</cfquery>
<font face="arial" size="3" color="Green">The quote amount was removed from this record</font><Br><br>
</cfif>

<cfif parameterexists(editothercarrierquote) is 'yes'><!--- already have a record for this carrier quote.. modifying it --->
<cfquery name="editquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='#other_carrier_amount#'
where id=#clientid#
</cfquery>
<br>
<font face="arial" size="3" color="green">The quote amount was modified for this record</font><br><br>
</cfif>
<cfif parameterexists(newothercarrierquote) is 'yes'><!--- no previous record for this carrier quote.. adding it --->
<cfquery name="addquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='#other_carrier_amount#' 
where id=#clientid#
</cfquery>
<font face="arial" size="3" color="green">The quote amount was added to this record</font><br><br>
</cfif>
<cfif parameterexists(remothercarrierquote) is 'yes'><!--- already have a record for this carrier quote - removing it (set to blank) --->
<cfquery name="delquote" datasource="aaalh3x_onestep">
update CLIENTS
set other_carrier_amount='0'
where id=#clientid#
</cfquery>
<font face="arial" size="3" color="Green">The quote amount was removed from this record</font><Br><br>
</cfif>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
select * from CLIENTS
where id=#clientid#
</cfquery>
<cfquery name="getmovers" datasource="aaalh3x_onestep">
select * from CARRIERS
where active=1 
order by company
</cfquery>

<!---
<table border="1" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="4"><div align="center"><font face="arial" size="3"><b>Quotes</b></font></div></td>
	</tr>
<cfif getinfo.other_carrier is not ''>
<cfoutput>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<tr>
		<td valign="middle">#getinfo.other_carrier#</td>
		<td valign="middle">$<input type="text" name="other_carrier_amount" size="6" value="<cfif #getinfo.other_carrier_amount# is not '' AND #getinfo.other_carrier_amount# is not '0'>#getinfo.other_carrier_amount#</cfif>"><cfif #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not 0><input type="hidden" name="editothercarrierquote" value="1"><cfelse><input type="hidden" name="newothercarrierquote" value="1"></cfif></td>
		<td valign="middle"><input type="submit" value="<cfif getinfo.other_carrier_amount is not '' and getinfo.other_carrier_amount is not '0'>Edit<cfelse>Add</cfif>"></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<input type="hidden" name="remothercarrierquote" value="1">
		<Td valign="middle"><cfif getinfo.other_carrier_amount is not '' AND getinfo.other_carrier_amount is not '0'><input type="submit" value="Remove"></cfif></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
</cfoutput>
</cfif>

<cfloop query="getmovers">
<cfquery name="getqt" datasource="aaalh3x_onestep">
select * from ESTIMATES
where carrier=#getmovers.id# and user_hook=#clientid#
</cfquery>
<cfoutput>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<tr>
		<td valign="middle">#getmovers.company#</td>
		<td valign="middle">$<input type="text" name="carrier_amount" size="6" value="<cfif getqt.amount is not '' AND getqt.amount is not '0'>#getqt.amount#</cfif>">
			<cfif getqt.amount is not '' and getqt.amount is not 0><input type="hidden" name="editcarrierquote" value="#getqt.id#">
				<cfelse><input type="hidden" name="newcarrierquote" value="#getmovers.id#">
			</cfif></td>
		<td valign="middle"><input type="submit" value="<cfif getqt.amount is not '' and getqt.amount is not '0'>Edit<cfelse>Add</cfif>"></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<input type="hidden" name="remcarrierquote" value="#getqt.id#">
		<Td valign="middle"><cfif getqt.amount is not '' AND getqt.amount is not '0'><input type="submit" value="Remove"></cfif></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
</cfoutput>
	</tr>
</cfloop>
</table> --->
<table border="1" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="6"><div align="center"><font face="arial" size="3"><b>Quotes</b></font></div></td>
	</tr>
    <tr>
    	<td align="center"><strong>Carrier</strong></td>
        <td align="center"><strong>Type Of Quote / Comments</strong></td>
        <td align="center"><strong>Hourly Values</strong></td>
        <td align="center"><strong>Price</strong></td>
        <td align="center" colspan="2">&nbsp;</td>
    </tr>
<cfif getinfo.other_carrier is not ''>
<cfoutput>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<tr>
		<td valign="middle">#getinfo.other_carrier#</td>
        <td valign="middle">
        <select name="TypeOfQuote">
        	<option value="">- SELECT -</option>
            <option value="Binding-Flat Price">Binding-Flat Price</option>
            <option value="Non Binding">Non Binding</option>
            <option value="Not To Exceed">Not To Exceed</option>
            <option value="Flat Rate">Flat Rate</option>
            <option value="Hourly">Hourly</option>
            <option value="Other">Other</option>
        </select><br>
        <input type="text" name="QuoteComment" size="20" value="">
        </td>
        <td valign="middle">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"><strong style="font-size:10px">MEN</strong></td>
              <td align="center"><strong style="font-size:10px">VANS</strong></td>
              <td align="center"><strong style="font-size:10px">HOURS</strong></td>
              <td align="center"><strong style="font-size:10px">TRAVEL</strong></td>
            </tr>
            <tr>
              <td align="center"><input type="text" name="MenQty" size="2" value=""></td>
              <td align="center"><input type="text" name="VanQty" size="2" value=""></td>
              <td align="center"><input type="text" name="HoursQty" size="2" value=""></td>
              <td align="center"><input type="text" name="TravelTimeQty" size="2" value=""></td>
            </tr>
          </table>
        </td>
		<td valign="middle">$<input type="text" name="other_carrier_amount" size="6" value="<cfif #getinfo.other_carrier_amount# is not '' AND #getinfo.other_carrier_amount# is not '0'>#getinfo.other_carrier_amount#</cfif>"><cfif #getinfo.other_carrier_amount# is not '' and #getinfo.other_carrier_amount# is not 0><input type="hidden" name="editothercarrierquote" value="1"><cfelse><input type="hidden" name="newothercarrierquote" value="1"></cfif></td>
		<td valign="middle"><input type="submit" value="<cfif getinfo.other_carrier_amount is not '' and getinfo.other_carrier_amount is not '0'>Edit<cfelse>Add</cfif>"></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<input type="hidden" name="remothercarrierquote" value="1">
		<Td valign="middle"><cfif getinfo.other_carrier_amount is not '' AND getinfo.other_carrier_amount is not '0'><input type="submit" value="Remove"></cfif></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
</cfoutput>
</cfif>

<cfloop query="getmovers">
<cfquery name="getqt" datasource="aaalh3x_onestep">
select * from ESTIMATES
where carrier=#getmovers.id# and user_hook=#clientid#
</cfquery>
<cfoutput>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
    <input type="hidden" name="carrierid" value="#getmovers.ID#">
	<tr>
		<td valign="middle">
        <select name="carrierRating">
        	<option value=""<cfif getmovers.Rating eq ""> selected</cfif>> - RATING -</option>
            <option value="5"<cfif getmovers.Rating eq "5"> selected</cfif>>5 Stars</option>
            <option value="4.5"<cfif getmovers.Rating eq "4.5"> selected</cfif>>4.5 Stars</option>
            <option value="4"<cfif getmovers.Rating eq "4"> selected</cfif>>4 Stars</option>
            <option value="3.5"<cfif getmovers.Rating eq "3.5"> selected</cfif>>3.5 Stars</option>
            <option value="3"<cfif getmovers.Rating eq "3"> selected</cfif>>3 Stars</option>
            <option value="2.5"<cfif getmovers.Rating eq "2.5"> selected</cfif>>2.5 Stars</option>
            <option value="2"<cfif getmovers.Rating eq "2"> selected</cfif>>2 Stars</option>
            <option value="1.5"<cfif getmovers.Rating eq "1.5"> selected</cfif>>1.5 Stars</option>
            <option value="1"<cfif getmovers.Rating eq "1"> selected</cfif>>1 Star</option>
        </select>
        <br>
        #getmovers.company#</td>
        <td valign="middle">
        <select name="TypeOfQuote">
        	<option value="">- SELECT -</option>
            <option value="Binding-Flat Price"<cfif getqt.TypeOfQuote eq "Binding-Flat Price"> selected</cfif>>Binding-Flat Price</option>
            <option value="Non Binding"<cfif getqt.TypeOfQuote eq "Non Binding"> selected</cfif>>Non Binding</option>
            <option value="Not To Exceed"<cfif getqt.TypeOfQuote eq "Not To Exceed"> selected</cfif>>Not To Exceed</option>
            <option value="Flat Rate"<cfif getqt.TypeOfQuote eq "Flat Rate"> selected</cfif>>Flat Rate</option>
            <option value="Hourly"<cfif getqt.TypeOfQuote eq "Hourly"> selected</cfif>>Hourly</option>
            <option value="Other"<cfif getqt.TypeOfQuote eq "Other"> selected</cfif>>Other</option>
        </select><br>
        <input type="text" name="QuoteComment" size="20" value="#getqt.QuoteComment#">
        </td>
        <td valign="middle">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td align="center"><strong style="font-size:10px">MEN</strong></td>
              <td align="center"><strong style="font-size:10px">VANS</strong></td>
              <td align="center"><strong style="font-size:10px">HOURS</strong></td>
              <td align="center"><strong style="font-size:10px">TRAVEL</strong></td>
            </tr>
            <tr>
              <td align="center"><input type="text" name="MenQty" size="2" value="#getqt.MenQty#"></td>
              <td align="center"><input type="text" name="VanQty" size="2" value="#getqt.VanQty#"></td>
              <td align="center"><input type="text" name="HoursQty" size="2" value="#getqt.HoursQty#"></td>
              <td align="center"><input type="text" name="TravelTimeQty" size="2" value="#getqt.TravelTimeQty#"></td>
            </tr>
          </table>
        </td>
		<td valign="middle">$<input type="text" name="carrier_amount" size="6" value="<cfif getqt.amount is not '' AND getqt.amount is not '0'>#getqt.amount#</cfif>">
			<cfif getqt.amount is not '' and getqt.amount is not 0><input type="hidden" name="editcarrierquote" value="#getqt.id#">
				<cfelse><input type="hidden" name="newcarrierquote" value="#getmovers.id#">
			</cfif></td>
		<td valign="middle"><input type="submit" value="<cfif getqt.amount is not '' and getqt.amount is not '0'>Edit<cfelse>Add</cfif>"></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
<form action="client_info.cfm" method="post">
	<input type="hidden" name="un" value="#un#">
	<input type="hidden" name="pw" value="#pw#">
	<input type="hidden" name="clientid" value="#clientid#">
	<input type="hidden" name="remcarrierquote" value="#getqt.id#">
		<Td valign="middle"><cfif getqt.amount is not '' AND getqt.amount is not '0'><input type="submit" value="Remove"></cfif></td>
		<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif>
		<cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif>
		<cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif>
		<cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif>
</form>
</cfoutput>
	</tr>
</cfloop>
</table>

<br>
<br>
<cfif #getinfo.active# is not 3 and #getinfo.active# is not 4>
<form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_complete" value="1"></cfoutput>
<div align="center"><input type="submit" value="Mark Record Completed"><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput></form></div>
<br><br><form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_canx" value="1"></cfoutput>
<div align="center"><input type="submit" value="Mark Record Cancelled"></form></div>
<cfelse>
<form action="client_info.cfm" method="post"><Cfoutput><input type="hidden" name="clientid" value="#clientid#"><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"><input type="hidden" name="mark_open" value="1"></cfoutput>
<div align="center"><input type="submit" value="Reactivate Record"><cfoutput>
<cfif parameterexists(url1) is 'yes'><input type="hidden" name="url1" value="#url1#"></cfif><cfif parameterexists(searchacct) is 'yes'><input type="hidden" name="searchacct" value="#searchacct#"></cfif><cfif parameterexists(type) is 'yes'><input type="hidden" name="type" value="#type#"></cfif><cfif parameterexists(keyword) is 'yes'><input type="hidden" name="keyword" value="#keyword#"></cfif></cfoutput></form></div>
</cfif>
<br><br>
</td></tr></table>
</div>
<br><br>


<cfoutput>
<cfif parameterexists(url1) is 'yes'>
    <a href="#url1#.cfm?requestTimeout=6000&un=#un#&pw=#pw#&keyword=#keyword#&searchacct=#searchacct#&type=#type#"><font face="arial" size="3" color="navy"><-- Back</font></a><br><Br>
</cfif>
<a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
