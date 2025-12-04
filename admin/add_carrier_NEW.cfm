<!doctype html>
<html class="no-js" lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Administration - Add New Record</title>
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

<cfset datenow = dateformat(now(), "YYYY-MM-DD")>
<CFIF IsDefined("AddNewRecordButton")>
<!---    <cfquery name="usedCodes" datasource="aaalh3x_onestep">
        select distinct discountCode
        from CLIENTS
    </cfquery>
    <cfset codeList = ValueList(usedCodes.discountCode)>
    <cfset discountCodeNumeric = randRange(1000,9999) />

    <cfset strAlpha = "ABCDEFGHIJKLMNOPQRDTUVWXYZ" />
    <cfset discountCode = Mid(strAlpha, RandRange(1, Len(strAlpha) ),1) />
    <cfset discountCode = "#discountCode##Mid(strAlpha, RandRange(1, Len(strAlpha) ),1)#-#discountCodeNumeric#" />--->

    <cfset loopCounter= 1 />

<!---        <cfset closingDate=#dateformat('#closing_date#', "YYYY-MM-DD")#>
        <cfset contractDate=#dateformat('#contract_date#', "YYYY-MM-DD")#>
        --->
        <cfset appointment_date = Now()>
		<cfset appointmentDate = dateformat('#appointment_date#', "YYYY-MM-DD")>
        <cfquery name="add_client" datasource="aaalh3x_onestep">
                insert into Carrier_records
                (repfirstname,replastname,MailingAddress,Mailingaddress2,Mailingcity,Mailingstate,Mailingzip,Mailingcounty,Companyname, comments, MC, USDOT)
                values ('#rep_first_name#','#rep_last_name#','#address#','#address2#','#city#','#state#','#zip#','#county#','#Companyname#','#comments#','#MC#','#USDOT#')
        </cfquery>
        <cfquery name="add_client" datasource="aaalh3x_onestep">
                select max(id) AS newID 
                from Carrier_records
        </cfquery>



<!---        <cfif not isdefined('form.queueHangerClosing') and not isdefined('form.queueHangerAppt') and not isdefined('form.queueHangerOffer') and not isdefined('form.queueHangerUnited')>
            
            <cfif #closing_date# is '' and #contract_date# is ''  and not isdefined('form.noQueue') >
                    <cfquery  datasource="aaalh3x_onestep">
                            insert into printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'new',0,#verify.id#,0)
                    </cfquery>
            </cfif>
            <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    select * from LETTER_SENDS
                    where send_type=1 and cust_hook=#add_client.newID#
                </cfquery>
             <cfif #check_initial.recordcount# is not 0  and not isdefined('form.noQueue') ><!--- was already sent once --->
                 <cfquery name="set_initial" datasource="aaalh3x_onestep">
                     insert into LETTER_SENDS
                     (send_type,sent,cust_hook,sent_date)
                     values ('3','1','#add_client.newID#','#datenow#')
                 </cfquery>
             <cfelseif  not isdefined('form.noQueue') >
                 <cfquery name="set_initial" datasource="aaalh3x_onestep">
                     insert into LETTER_SENDS
                     (send_type,sent,cust_hook,sent_date)
                     values ('1','1','#add_client.newID#','#datenow#')
                 </cfquery>
             </cfif>

            <cfif #closing_date# is not ''   and not isdefined('form.noQueue') >
                    <cfquery datasource="aaalh3x_onestep">
                            insert into printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'closing',0,#verify.id#,0)
                    </cfquery>
            </cfif>
            <cfif #contract_date# is not ''  and not isdefined('form.noQueue') >
                    <cfquery datasource="aaalh3x_onestep">
                            insert into printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'gotOffer',0,#verify.id#,0)
                    </cfquery>
            </cfif>
            
            <cfif  not (isdefined('form.noQueue') OR IsDefined("queueMayflowerLetter") OR IsDefined("queueMayflowerFlyer") OR isdefined('form.noRealtorLetter'))>
                <cfquery name="q" datasource="aaalh3x_onestep">
                        insert into LETTER_SENDS
                        (send_type,active,cust_hook,user_hook)
                        values ('999','1','#add_client.newID#','#verify.id#')
                </cfquery>
            </cfif>


            <cfif  isdefined('form.noRealtorLetter') >            
               <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared)
                    values(#add_client.newID#,'nonRealtorLeads',0,#verify.id#,0)
                </cfquery>

                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('999','1','#add_client.newID#','#verify.id#')
                </cfquery>
            </cfif>
        </cfif>--->

<!---        <cfif  isdefined('form.queueHangerClosing') >            
                 <!--- hanger/closing urgent --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'hanger',0,#verify.id#,0,1)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('100','1','#add_client.newID#','#verify.id#')
                </cfquery>

                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
        </cfif>
        <cfif  isdefined('form.queueHangerAppt') > 
                <!--- hanger appointment urgent --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'hangerAppt',0,#verify.id#,0,1)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('200','1','#add_client.newID#','#verify.id#')
                </cfquery>

                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
        </cfif>
        <cfif  isdefined('form.queueHangerOffer') > 
                <!--- hanger appointment urgent --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'hangerOffer',0,#verify.id#,0,1)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('210','1','#add_client.newID#','#verify.id#')
                </cfquery>

                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
         </cfif>
         
         <cfif  isdefined('form.queueHangerUnited') > 
                <!--- hanger appointment urgent --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'hangerMayflower',0,#verify.id#,0,1)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('240','1','#add_client.newID#','#verify.id#')
                </cfquery>

                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
         </cfif>
         
         <CFIF IsDefined("queueMayflowerLetter")>
                <!--- mayflower letter --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'MayflowerLetter',0,#verify.id#,0,0)
                </cfquery>
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'MayflowerFlyer',0,#verify.id#,0,0)
                </cfquery>
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('300','1','#add_client.newID#','#verify.id#')
                </cfquery>
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('302','1','#add_client.newID#','#verify.id#')
                </cfquery>
                <cfquery name="q" datasource="aaalh3x_onestep">
                        insert into LETTER_SENDS
                        (send_type,active,cust_hook,user_hook)
                        values ('999','1','#add_client.newID#','#verify.id#')
                </cfquery>

         </CFIF>--->
         
            <cfif not isdefined('form.DontQueueLetter') >
                 <cfquery  datasource="aaalh3x_onestep">
                            insert into carrier_printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'new',0,#verify.id#,0)
                 </cfquery>
                <cfquery name="q" datasource="aaalh3x_onestep">
                        insert into carrier_LETTER_SENDS
                        (send_type,active,cust_hook,user_hook,sent_date,sent)
                        values ('999','1','#add_client.newID#','#verify.id#',#now()#,1)
                </cfquery>
            </cfif>

         
         <!--- Automatically queue:
                                    * follow up letter 7 days before the Appointment Date
                                    * follow up letters and labels for every two weeks after the Appointment Date
         --->
         
         <cfif NOT structKeyExists(FORM,'DontQueueFollowUp')>
         	<!--- check if the follow up letter 7 days before the Appointment Date is already there. If not then queue it automatically as well --->
         	<cfquery name="checkFollowUpDateBeforeAppointmentDate" datasource="aaalh3x_onestep">
         		select *
         		from Carrier_printQueue
         		where clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         		and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
         	</cfquery>
         	
         	<cfif checkFollowUpDateBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpDateBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into Carrier_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
					values(
							<cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">,
							0,
							<cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">,
							0,
							0,
							<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD')#">
						)
	         	</cfquery>
         	</cfif>
         	
         	<!--- check if the follow up label 7 days before the Appointment Date is already there. If not then queue it automatically as well --->
         	<cfquery name="checkFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
         		select *
         		from Carrier_LETTER_SENDS
         		where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
         		and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         	</cfquery>
         	
         	<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into Carrier_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD')#">)
	         	</cfquery>
         	</cfif>
         	
         	<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,appointmentDate)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,appointmentDate)>
			
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfquery name="insertFollowUpLetterAfterAppointmentDate" datasource="aaalh3x_onestep">
					insert into Carrier_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
					values(
							<cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">,
							0,
							<cfqueryparam cfsqltype="cf_sql_bigint" value="#verify.id#">,
							0,
							0,
							<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">
						)
				</cfquery>
				
				<cfquery name="insertLabelAfterAppointmentDate" datasource="aaalh3x_onestep">
					insert into Carrier_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
				
			</cfloop>

         </cfif>
         
<cfset a='a'>
</cfif>

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Add Carrier Record</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table>

<cfquery name="addy" datasource="aaalh3x_onestep">
    select distinct streetaddress,repfirstname,replastname,Companyname,MailingAddress
    from Carrier_records
    where MailingAddress <> ''
</cfquery>
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
             

            var realtors = [];

            var addy = [<cfoutput query="addy">{value:'#replace(trim(addy.MailingAddress),"'","\'","all")#',fname: '#replace(trim(addy.repfirstname),"'","\'","all")#',lname: '#replace(trim(addy.replastname),"'","\'","all")#',cname: '#replace(trim(addy.companyname),"'","\'","all")#'}<cfif addy.currentrow lt addy.recordcount>,</cfif></cfoutput>
            ];
             
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

            $('.realtorTypeahead').typeahead({
              hint: false,
              highlight: true,
              minLength: 1
            },
            {
              name: 'realtors',
              source: substringMatcher(realtors)
            });

            $('.typeahead').typeahead({
                  hint: true,
                  highlight: true,
                  minLength: 1
                },
                {
                  name: 'states',
                  source: substringMatcher(states)
            });
            $( "#address" ).autocomplete({
                  minLength: 2,
                  source: addy,
                  select: function( event, ui ) {
                  
                    $('#Rep_first_name').val(ui.item.fname);
                    $('#Rep_last_name').val(ui.item.lname);
					$('#address').val(ui.item.value);
					$('#Companyname').val(ui.item.cname);
                    return false;
                  }
                })
            .autocomplete( "instance" )._renderItem = function( ul, item ) {
              return $( "<li>" )
                .append( "<a>" + item.value+ "</a>" )
                .appendTo( ul );
            };
        });
		
		function clearFormValues()
		{
			document.getElementById('rep_first_name').value = "";
			document.getElementById('rep_last_name').value = "";
			document.getElementById('address').value = "";
			document.getElementById('address2').value = "";
			document.getElementById('city').value = "";
			document.getElementById('state').value = "";
			document.getElementById('zip').value = "";
			document.getElementById('comments').value = "";
		}
    </script>
    
<cfoutput>
<table border="0" cellspacing="0" cellpadding="5" width="100%">
	<tr>
		<td width="80%">&nbsp;</td>
		<td width="20%" align="right" valign="top">
			<table border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td><a href="main.cfm?un=#un#&pw=#pw#"><img src="images/section1.png" width="125"></a></td>
					<td><a href="mainCarrier.cfm?un=#un#&pw=#pw#"><img src="images/section2.png" width="125"></a></td>
					<td><a href="mainRealtor.cfm?un=#un#&pw=#pw#"><img src="images/section3.png" width="125"></a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
    
<CFPARAM NAME="varFirstName" default="">
<CFPARAM NAME="varLastName" default="">
<CFPARAM NAME="varAddress" default="">
<CFPARAM NAME="varCity" default="">
<CFPARAM NAME="varState" default="">
<CFPARAM NAME="varZip" default="">
<CFPARAM NAME="varCounty" default="">
<CFPARAM NAME="varCompanyName" default="">
<CFPARAM NAME="varMC" default="">
<CFPARAM NAME="varUSDOT" default="">
    
<cfif IsDefined("checkAddressButton")>
<CFSET varFirstName = form.rep_first_name>
<CFSET varLastName = form.rep_last_name>
<CFSET varAddress = form.address>
<CFSET varCity = form.City>
<CFSET varState = form.State>
<CFSET varZip = form.zip>
<CFSET varCounty = form.County>
<CFSET varCompanyName = form.Companyname>
<cfset varMC = form.MC>
<cfset varUSDOT = form.USDOT>

<cfquery name="qCheckExisting" datasource="aaalh3x_onestep">
SELECT ID, repFirstname, repLastname, Companyname
FROM Carrier_records
WHERE (1=1
	<CFIF form.rep_first_name NEQ "">AND repFirstname = '#varFirstName#'</CFIF>
    <CFIF form.rep_last_name NEQ "">AND repLastname = '#varLastName#'</CFIF>
	<CFIF form.address NEQ "">AND MailingAddress LIKE '%#varAddress#%'</CFIF>
	<CFIF form.city NEQ "">AND MailingCity = '#varCity#'</CFIF>
    <CFIF form.state NEQ "">AND MailingState = '#varState#'</CFIF>
    <CFIF form.Zip NEQ "">AND Mailingzip = '#varZip#'</CFIF>
    )
</cfquery>
<!-------
send_type=1 mark_initial
send_type=6 mark_follow
send_type=8 mark_estimate
send_type=10 mark_carrierList
send_type=100 mark_hangerClosing
send_type=200 mark_hangerAppt
send_type=210 mark_hangerOffer
send_type=220 mark_hangerOfferUrgent
send_type=20 mark_nonRealtorLead

---------->



    <div class="row">
        <div class="large-12 columns">
            <div class="callout primary">          
              <h5>Existing Records For Submitted Address:</h5>
              <CFIF qCheckExisting.RecordCount>
              <p>
              <CFOUTPUT QUERY="qCheckExisting">
              <cfset nbFollowUpLetterSentForThisClient = 0>

              
<cfquery name="qCheckLetterSend" datasource="aaalh3x_onestep">
	SELECT * FROM Carrier_printqueue pq left join Carrier_LETTER_SENDS ls on pq.id = ls.printqueueId
	where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#id#">
	and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
	order by pq.followup_date
</cfquery>
              
              <strong>CustomerID:</strong> #ID# - <strong>Name:</strong> #repFirstname# #repLastname# <strong>Company:</strong> #Companyname#<BR>
                  <cfquery name="qLettersDate" datasource="aaalh3x_onestep">
                    SELECT ID, repFirstname, repLastname
                    FROM Carrier_records
                     where ID = #ID#
                    </cfquery>
              <CFIF qCheckLetterSend.RecordCount>
              <CFLOOP QUERY="qCheckLetterSend">
                                   
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Follow Up <cfif trim(qCheckLetterSend.printType) EQ 'followup'>
                 														#dateformat(qCheckLetterSend.followup_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq ''>(Not Sent)</cfif>
                 													<cfelse>
                 														#dateformat(qLettersDate.entry_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq ''>(Not Sent)</cfif>
                 													</cfif>
                 	<br />

              </CFLOOP>
              
              
              <CFELSE>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No letters Sent<BR>
              </CFIF>
              </CFOUTPUT>
              </p>
              <CFELSE>
              <p><strong>No existing entries found for this address</strong></p>
              </CFIF>
            </div>
    </div>
    </div>
</cfif>


<CFIF IsDefined("a")>
    <div class="row">
        <div class="large-12 columns">
        	<div class="callout success">
              <h5>New Carrier Record Added Successfully</h5>
              <p>The New Record was Added to the System</p>
            </div>
        </div>
	</div>
</CFIF>


<cfquery name="printQueue" datasource="aaalh3x_onestep">
        select id
        from carrier_printQUeue
        where (memberId=#verify.id# or memberId is null)
      and (printType <> 'followUp' and printType <> 'Mayflowerfollowup' and printType <> 'MayflowerFlyer')
        and printed=0
        and cleared=0
</cfquery>


<form action="add_carrier_New.cfm" method="post" name="addDataForm" data-abide novalidate>
<cfoutput><input type="hidden" name="un" value="#un#">
<input type="hidden" name="pw" value="#pw#"></cfoutput>
<div class="row">
    <div class="large-12 columns">
	<fieldset class="fieldset">
    <legend><strong>Tools</strong></legend>
    <div class="row">
        <div class="small-4 columns">
         Print Queue - <cfoutput>#printQueue.recordcount#</cfoutput> letter<cfif #printQueue.recordcount# is not 1>s</cfif> in queue
        </div>
        <div class="small-4 columns">
          <cfoutput><A href="printCarrierQueue.cfm?un=#un#&pw=#pw#" target="_blank">Print Letters</A></cfoutput>
        </div>
        <div class="small-4 columns">
          <cfoutput><a href="mainCarrier.cfm?un=#un#&pw=#pw#">Main Menu</a></cfoutput>
        </div>
      </div>
    </fieldset>
    
	<fieldset class="fieldset">
    <legend><strong>Add New Carrier Record</strong></legend>
    <div class="row">
        <div class="small-3 columns">
          <label for="Companyname" class="text-left middle">Company Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Companyname" size="20" id="Companyname" placeholder="Company Name" value="<cfoutput>#varCompanyName#</cfoutput>" required>
			<span class="form-error">
            Company Name is required
          </span>
        </div>
      </div>
      <div class="row">
        <div class="small-3 columns">
          <label for="MC" class="text-left middle">MC</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="MC" size="20" id="MC" placeholder="MC" value="<cfoutput>#varMC#</cfoutput>">
        </div>
      </div>
      <div class="row">
        <div class="small-3 columns">
          <label for="USDOT" class="text-left middle">USDOT</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="USDOT" size="20" id="USDOT" placeholder="USDOT" value="<cfoutput>#varUSDOT#</cfoutput>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_first_name" class="text-left middle">Rep First Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Rep_first_name" size="20" id="Rep_first_name" placeholder="Rep First Name" value="<cfoutput>#varFirstName#</cfoutput>" required>
			<span class="form-error">
            Rep First Name is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_last_name" class="text-left middle">Rep Last Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Rep_last_name" size="20" id="Rep_last_name" placeholder="Rep Last Name" value="<cfoutput>#varLastName#</cfoutput>" required>
			<span class="form-error">
            Rep last Name is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="address" class="text-left middle">Street Address</label>
        </div>
        <div class="small-9 columns">
          <input class="typeaheadAddy" type="text" name="address" id="address" value="<cfoutput>#varAddress#</cfoutput>" placeholder="Street Address" required>
			<span class="form-error">
            Street Address is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="address2" class="text-left middle">Address (cont.)</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="address2" id="address2" size="23" placeholder="Address (continued)">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="city" class="text-left middle">City</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="city" id="city" size="20" placeholder="City" value="<cfoutput>#varCity#</cfoutput>"> 
			<span class="form-error">
            City is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="state" class="text-left middle">State</label>
        </div>
        <div class="small-9 columns">
         <input class="typeahead" type="text" name="state" id="state" placeholder="State" value="<cfoutput>#varState#</cfoutput>"> 
			<span class="form-error">
            State is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="zip" class="text-left middle">Zip Code</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="zip" id="zip" size="10" placeholder="Zip Code" value="<cfoutput>#varZip#</cfoutput>">
			<span class="form-error">
            Zip Code is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="County" class="text-left middle">County</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="County" id="County" size="10" placeholder="County" value="<cfoutput>#varCounty#</cfoutput>">
			<span class="form-error">
            County is required
          </span>
        </div>
      </div>
	</fieldset>
	
	
	<fieldset class="fieldset">
    <legend><strong>Comments</strong></legend>
    <textarea name="comments" id="comments" rows="5" cols="50"></textarea>
    </fieldset>
    
    <fieldset class="fieldset">
    <legend><strong>Letter Options</strong></legend>
    <div class="row">
        <div class="small-12 columns">
          <input type="checkbox" value="1" name="DontQueueLetter"> Don't Queue Letter and Label
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
          <input type="checkbox" value="1" name="DontQueueFollowUp"> Don't Queue Follow Up Letter and Label
        </div>
      </div>
    </fieldset>
 
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Add New Record" name="AddNewRecordButton" class="button"> <input type="submit" value="Check Address" name="checkAddressButton" class="button"> <input type="reset" value="Reset Form" class="button" onClick="clearFormValues()">
        </div>
      </div>
    </div>
</div>
</form>

<script src="foundation-6.2.4/js/vendor/foundation.js"></script>
<script>
      $(document).foundation();
    </script>
</body>
</html>