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

<cfset datenow=#dateformat(now(), "YYYY-MM-DD")#>
<CFIF IsDefined("AddNewRecordButton")>
        <cfset closingDate=#dateformat('#closing_date#', "YYYY-MM-DD")#>
        <cfset contractDate=#dateformat('#contract_date#', "YYYY-MM-DD")#>
        <cfset underContractDate=#dateformat('#under_contract_date#', "YYYY-MM-DD")#>
        <cfset appointmentDate=#dateformat('#appointment_date#', "YYYY-MM-DD")#>

        <cfquery name="add_client" datasource="aaalh3x_onestep">
                insert into CLIENTS
                (entry_date,active,first_name,last_name,from_address,from_address2,from_city,from_state,from_zip,<cfif #closing_date# is not ''>closing_date,</cfif><cfif #contract_date# is not ''>contract_date,</cfif><cfif #under_contract_date# is not ''>under_contract_date,</cfif>realty_company,realtor_name,<cfif #appointment_date# is not ''>appointment_date,</cfif>home_price,comments,discountCode, memberId)
                values ('#datenow#','0','#first_name#','#last_name#','#address#','#address2#','#city#','#state#','#zip#',<cfif #closing_date# is not ''>'#closingDate#',</cfif><cfif #contract_date# is not ''>'#contractDate#',</cfif><cfif #under_contract_date# is not ''>'#underContractDate#',</cfif>'#new_realty_company#','#realtor_name#',<cfif #appointment_date# is not ''>'#appointmentDate#',</cfif>'#home_price#','#comments#','#realtor_discount_code#',#verify.id#)
        </cfquery>
        <cfquery name="add_client" datasource="aaalh3x_onestep">
                select max(id) AS newID 
                from Clients
        </cfquery>

        <cfif  isdefined('form.noQueueFU') >            
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
        </cfif>

        <cfif not isdefined('form.queueHangerClosing') and not isdefined('form.queueHangerAppt') and not isdefined('form.queueHangerOffer') and not isdefined('form.queueHangerUnited')>
            
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
            <cfif #under_contract_date# is not ''  and not isdefined('form.noQueue') >
                    <cfquery datasource="aaalh3x_onestep">
                            insert into printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'underContract',0,#verify.id#,0)
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
        </cfif>

        <cfif  isdefined('form.queueHangerClosing') >            
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
<!---                  <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'MayflowerFollowup',0,#verify.id#,0,0)
                </cfquery> --->
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
<!---                 <cfquery name="q" datasource="aaalh3x_onestep">
                        insert into LETTER_SENDS
                        (send_type,active,cust_hook,user_hook)
                        values ('998','1','#add_client.newID#','#verify.id#')
                </cfquery> --->
         </CFIF>
<!---          <CFIF IsDefined("queueMayflowerFlyer")>
                <!--- mayflower flyer --->
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'MayflowerFlyer',0,#verify.id#,0,0)
                </cfquery>
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('302','1','#add_client.newID#','#verify.id#')
                </cfquery>
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    UPDATE clients
                    set skipFollowUp = 1
                    WHERE id = #add_client.newID#
                </cfquery>
         </CFIF> --->
         
         <!--- Automatically queue:
                                    * follow up letter 7 days before the Appointment Date
                                    * follow up letters and labels for every two weeks after the Appointment Date
         --->
         <cfif NOT structKeyExists(FORM,'noQueueFU') AND appointment_date NEQ ''>
         	<!--- check if the follow up letter 7 days before the Appointment Date is already there. If not then queue it automatically as well --->
         	<cfquery name="checkFollowUpDateBeforeAppointmentDate" datasource="aaalh3x_onestep">
         		select *
         		from printQueue
         		where clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         		and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
         	</cfquery>
         	
         	<cfif checkFollowUpDateBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpDateBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
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
         		from LETTER_SENDS
         		where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
         		and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         	</cfquery>
         	
         	<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD')#">)
	         	</cfquery>
         	</cfif>
         	
         	<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,appointmentDate)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,appointmentDate)>
			
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfquery name="insertFollowUpLetterAfterAppointmentDate" datasource="aaalh3x_onestep">
					insert into printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
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
					insert into LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
				
			</cfloop>
			
			<!--- Send email to Anthony and Maria to let them know that a new follow-up letter and label is queued AND that the first Date of the follow up is now --->
			<cfif dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD') EQ datenow>
				<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Letters and Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
					#first_name# #last_name#<br />
					#address# #address2#<br />
					#city# #state# #zip#
				</cfmail>
			</cfif>
         </cfif>
         
<cfset a='a'>
</cfif>

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Add Record</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>

<cfquery name="realtors" datasource="aaalh3x_onestep">
    select distinct realty_company
    from clients
    where realty_company<>''
</cfquery>
<cfquery name="addy" datasource="aaalh3x_onestep">
    select distinct from_address,first_name,last_name
    from clients
    where from_address<>''
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
             

            var realtors = [<cfoutput query="realtors">'#replace(realtors.realty_company,"'","\'","all")#'<cfif realtors.currentrow lt realtors.recordcount>,</cfif></cfoutput>
            ];

            var addy = [<cfoutput query="addy">{value:'#replace(trim(addy.from_address),"'","\'","all")#',fname: '#replace(trim(addy.first_name),"'","\'","all")#',lname: '#replace(trim(addy.last_name),"'","\'","all")#'}<cfif addy.currentrow lt addy.recordcount>,</cfif></cfoutput>
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
                  
                    $('#first_name').val(ui.item.fname);
                    $('#last_name').val(ui.item.lname);
					$('#address').val(ui.item.value);
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
			document.getElementById('first_name').value = "";
			document.getElementById('last_name').value = "";
			document.getElementById('address').value = "";
			document.getElementById('address2').value = "";
			document.getElementById('city').value = "";
			document.getElementById('state').value = "";
			document.getElementById('zip').value = "";
			document.getElementById('new_realty_company').value = "";
			document.getElementById('home_price').value = "";
			document.getElementById('datepicker').value = "";
			document.getElementById('datepickera').value = "";
			document.getElementById('datepickerb').value = "";
			document.getElementById('datepickerd').value = "";
			document.getElementById('comments').value = "";
		}
    </script>
    
<CFPARAM NAME="varFirstName" default="">
<CFPARAM NAME="varLastName" default="">
<CFPARAM NAME="varAddress" default="">
<CFPARAM NAME="varCity" default="">
<CFPARAM NAME="varState" default="">
<CFPARAM NAME="varZip" default="">
    
<cfif IsDefined("checkAddressButton")>
<CFSET varFirstName = form.first_name>
<CFSET varLastName = form.last_name>
<CFSET varAddress = form.address>
<CFSET varCity = form.City>
<CFSET varState = form.State>
<CFSET varZip = form.zip>

<CFIF form.address NEQ "">
	<CFIF listLen(form.address, " ") GT 1>
		<CFSET addressPartOne = ListGetAt(address, 1, " ")>
        <CFSET addressPartTwo = ListGetAt(address, 2, " ")>
    <CFELSE>
		<CFSET addressPartOne = form.address>
        <CFSET addressPartTwo = form.address>
    </CFIF>
<CFELSE>
	<CFSET addressPartOne = "">
    <CFSET addressPartTwo = "">
</CFIF>
<cfquery name="qCheckExisting" datasource="aaalh3x_onestep">
SELECT ID, First_name, Last_name, enter_date
FROM Clients
WHERE (1=1
	<CFIF form.first_name NEQ "">AND first_name = '#form.first_name#'</CFIF>
    <CFIF form.last_name NEQ "">AND last_name = '#form.last_name#'</CFIF>
	<CFIF addressPartOne NEQ "">AND from_Address LIKE '%#addressPartOne#%'</CFIF>
    <CFIF addressPartTwo NEQ "">AND from_Address LIKE '%#addressPartTwo#%'</CFIF>
	<CFIF form.city NEQ "">AND from_City = '#form.city#'</CFIF>
    <CFIF form.state NEQ "">AND from_State = '#form.state#'</CFIF>
    <CFIF form.Zip NEQ "">AND from_zip = '#form.Zip#'</CFIF>
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
   <!---           <CFQUERY NAME="qCheckLetterSend" datasource="aaalh3x_onestep">
                select *
                from printqueue
                where clientid = #ID#
               <!---SELECT *
              from letter_sends
              WHERE Cust_hook = #ID# AND
              	Sent > 0
              	ORDER BY sent_date--->
              </CFQUERY>  --->
              
<cfquery name="qCheckLetterSend" datasource="aaalh3x_onestep">
	SELECT * FROM printqueue pq left join LETTER_SENDS ls on pq.id = ls.printqueueId
	where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#id#">
	and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
	order by pq.followup_date
</cfquery>

<cfquery name="get_DoorHangerClosingUrgent" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=100 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_DoorHangerClosingUrgentResent" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=101 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_hangerappointment" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=200 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_hangerappointmentResent" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=201 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

 <cfquery name="get_hangerbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=210 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

 <cfquery name="get_booked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=220 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_resbooked" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=221 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_estimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=8 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=9 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_carrierList" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=10 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_reestimate" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=9 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_NonRealtorLead" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=20 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>

<cfquery name="get_NonRealtorLeadResent" datasource="aaalh3x_onestep">
select * from LETTER_SENDS
where send_type=21 and (sent=1 or sent=2) and cust_hook=#id#
</cfquery>
              
              CustomerID: #ID# - Name: #First_name# #Last_name#<BR>
                  <cfquery name="qLettersDate" datasource="aaalh3x_onestep">
                    SELECT ID, First_name, Last_name, enter_date, entry_date, appointment_date, closing_date, contract_date
                    FROM Clients
                     where ID = #ID#
                    </cfquery>
              <CFIF qCheckLetterSend.RecordCount>
              <CFLOOP QUERY="qCheckLetterSend">
                  
                  <!---<cfif #printType# is 'new'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: #printType# (#dateformat(qLettersDate.entry_date, "YYYY-MM-DD")#)<BR></cfif>
      
                  <cfif printType is 'followup'>
                  	<!--- only display followup already sent --->
                  	<cfquery name="checkFollowUpLetterIsSent" datasource="aaalh3x_onestep">
                  		SELECT *
                  		FROM LETTER_SENDS
                  		WHERE printqueueId = <cfqueryparam cfsqltype="cf_sql_bigint" value="#qCheckLetterSend.id#">
                  		AND send_type = 6
                  	</cfquery>
                  	<cfif checkFollowUpLetterIsSent.recordCount GT 0>
                  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: #printType# (#dateformat((isDate(qCheckLetterSend.followup_date)? qCheckLetterSend.followup_date : dateAdd('d', -7, qLettersDate.appointment_date)), "YYYY-MM-DD")#)<BR>
                  </cfif>
                  </cfif>--->
                 
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Follow Up <cfif trim(qCheckLetterSend.printType) EQ 'followup'>
                 														#dateformat(qCheckLetterSend.followup_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq ''>(Not Sent)</cfif>
                 													<cfelse>
                 														#dateformat(qLettersDate.entry_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq ''>(Not Sent)</cfif>
                 													</cfif>
                 	<br />
                 
               
                        
                        
               <!---<CFIF send_Type EQ 1>New Listing
              	<CFELSEIF send_Type EQ 3>Reprint
				<CFELSEIF send_Type EQ 6>
					<cfset nbFollowUpLetterSentForThisClient = nbFollowUpLetterSentForThisClient + 1>
					Followup Letter #nbFollowUpLetterSentForThisClient#
                <CFELSEIF send_Type EQ 7>FollowUp Reprint
                <CFELSEIF send_Type EQ 8>Estimate Letter
                <CFELSEIF send_Type EQ 9>Estimate Reprint
                <CFELSEIF send_Type EQ 10>Carrier List
                <CFELSEIF send_Type EQ 100>Hanger Closing
                <CFELSEIF send_Type EQ 200>Hanger Appointment
                <CFELSEIF send_Type EQ 210>Hanger Offer
                <CFELSEIF send_Type EQ 220>Hanger Offer Urgent
                <CFELSEIF send_Type EQ 240>DoorHanger Mayflower
                <CFELSEIF send_Type EQ 20>Non Realtor Lead
                <CFELSEIF send_Type EQ 999>Labels
                </CFIF>  Sent Date: #DateFormat(sent_date, "MM/DD/YYYY")#<br />--->
              </CFLOOP>
              
              <cfif get_DoorHangerClosingUrgent.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Closing Urgent #dateformat(get_DoorHangerClosingUrgent.sent_date, "MMM D, YYYY")# <cfif #get_DoorHangerClosingUrgent.sent# is 1>(Mailed)<cfelseif #get_DoorHangerClosingUrgent.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_DoorHangerClosingUrgentResent.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Closing Urgent Resent #dateformat(get_DoorHangerClosingUrgentResent.sent_date, "MMM D, YYYY")# <cfif #get_DoorHangerClosingUrgentResent.sent# is 1>(Mailed)<cfelseif #get_DoorHangerClosingUrgentResent.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_hangerappointment.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Appointment #dateformat(get_hangerappointment.sent_date, "MMM D, YYYY")# <cfif #get_hangerappointment.sent# is 1>(Mailed)<cfelseif #get_hangerappointment.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_hangerappointmentResent.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Appointment Resent #dateformat(get_hangerappointmentResent.sent_date, "MMM D, YYYY")# <cfif #get_hangerappointmentResent.sent# is 1>(Mailed)<cfelseif #get_hangerappointmentResent.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_hangerbooked.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Offer #dateformat(get_hangerbooked.sent_date, "MMM D, YYYY")# <cfif #get_hangerbooked.sent# is 1>(Mailed)<cfelseif #get_hangerbooked.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_booked.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Offer Urgent #dateformat(get_booked.sent_date, "MMM D, YYYY")# <cfif #get_booked.sent# is 1>(Mailed)<cfelseif #get_booked.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_resbooked.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Door Hanger Offer Urgent Resent #dateformat(get_resbooked.sent_date, "MMM D, YYYY")# <cfif #get_resbooked.sent# is 1>(Mailed)<cfelseif #get_resbooked.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_estimate.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Estimate #dateformat(get_estimate.sent_date, "MMM D, YYYY")# <cfif #get_estimate.sent# is 1>(Mailed)<cfelseif #get_estimate.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_reestimate.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Estimate Resent #dateformat(get_reestimate.sent_date, "MMM D, YYYY")# <cfif #get_reestimate.sent# is 1>(Mailed)<cfelseif #get_reestimate.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_carrierList.recordcount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Carrier List #dateformat(get_carrierList.sent_date, "MMM D, YYYY")# <cfif #get_carrierList.sent# is 1>(Mailed)<cfelseif #get_carrierList.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_reestimate.RecordCount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Estimate Resent #dateformat(get_reestimate.sent_date, "MMM D, YYYY")# <cfif #get_reestimate.sent# is 1>(Mailed)<cfelseif #get_reestimate.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_NonRealtorLead.RecordCount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Non Realtor Lead #dateformat(get_NonRealtorLead.sent_date, "MMM D, YYYY")# <cfif #get_NonRealtorLead.sent# is 1>(Mailed)<cfelseif #get_NonRealtorLead.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              <cfif get_NonRealtorLeadResent.RecordCount>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Non Realtor Lead Resent #dateformat(get_NonRealtorLeadResent.sent_date, "MMM D, YYYY")# <cfif #get_NonRealtorLeadResent.sent# is 1>(Mailed)<cfelseif #get_NonRealtorLeadResent.sent# is 2>(Emailed)</cfif><br>
              </cfif>
              
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
              <h5>New Record Added Successfully</h5>
              <p>The New Record was Added to the System</p>
            </div>
        </div>
	</div>
</CFIF>

<cfquery name="printQueue" datasource="aaalh3x_onestep">
        select id
        from printQUeue
        where (memberId=#verify.id# or memberId is null)
      and (printType <> 'followUp' and printType <> 'Mayflowerfollowup' and printType <> 'MayflowerFlyer')
        and printed=0
        and cleared=0
</cfquery>




<form action="add_client_New.cfm" method="post" name="addDataForm" data-abide novalidate>
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
          <cfoutput><A href="printQueue.cfm?un=#un#&pw=#pw#">Print Letters</A></cfoutput>
        </div>
        <div class="small-4 columns">
          <cfoutput><a href="main.cfm?un=#un#&pw=#pw#">Main Menu</a></cfoutput>
        </div>
      </div>
    </fieldset>
	<fieldset class="fieldset">
    <legend><strong>Add New Record</strong></legend>
    <div class="row">
        <div class="small-3 columns">
          <label for="realtor_discount_code" class="text-left middle">Realtor Discount Code</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="realtor_discount_code" size="20" id="realtor_discount_code" placeholder="Realtor Discount Code">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="realtor_name" class="text-left middle">Realtor Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="realtor_name" size="20" id="realtor_name" placeholder="Realtor Name">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="first_name" class="text-left middle">First Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="first_name" size="20" id="first_name" placeholder="First Name" value="<cfoutput>#varFirstName#</cfoutput>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="last_name" class="text-left middle">Last Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="last_name" size="20" id="last_name" placeholder="Last Name" value="<cfoutput>#varLastName#</cfoutput>">
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
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="zip" class="text-left middle">Zip Code</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="zip" id="zip" size="10" placeholder="Zip Code" value="<cfoutput>#varZip#</cfoutput>">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="new_realty_company" class="text-left middle">Real Estate Company</label>
        </div>
        <div class="small-9 columns">
         <input class="realtorTypeahead" type="text" name="new_realty_company" id="new_realty_company" placeholder="Real Estate Company">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="home_price" class="text-left middle">Home Price</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="home_price" id="home_price" size="7" placeholder="Home Price">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="closing_date" class="text-left middle">Closing Date</label>
        </div>
        <div class="small-9 columns">
         <input class="remindmedropdowna" name="closing_date" id="datepicker" placeholder="Click to add date">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="contract_date" class="text-left middle">Offer Date</label>
        </div>
        <div class="small-9 columns">
         <input class="remindmedropdown" name="contract_date" id="datepickera" placeholder="Click to add date">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="under_contract_date" class="text-left middle">Under Contract Date</label>
        </div>
        <div class="small-9 columns">
         <input class="remindmedropdown" name="under_contract_date" id="datepickerd" placeholder="Click to add date">
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="appointment_date" class="text-left middle">Appointment Date</label>
        </div>
        <div class="small-9 columns">
         <input class="remindmedropdownc" name="appointment_date" id="datepickerb" placeholder="Click to add date">
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
          <input type="checkbox" value="1" name="noQueue"> Don't Queue Letters
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
          <input type="checkbox" value="1" name="noQueueFU"> Don't Queue Follow Up Letter and Follow Up Label
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="noRealtorLetter"> No realtor Leads Letter
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueHangerClosing"> Queue Door Hanger Residential (No Letters)
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueHangerAppt"> Queue Door Hanger Appointment  (No Letters)
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueHangerOffer"> Queue Door Hanger Offer  (No Letters)
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueHangerUnited"> Queue Door Hanger United-Mayflower  (No Letters)
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueMayflowerLetter"> Van Line Letter / Flyer (For NO AFFORDABLE, Please check 'Don't Queue Letters')
        </div>
      </div>
<!---     <div class="row">
        <div class="small-12 columns">
         <input type="checkbox" value="1" name="queueMayflowerFlyer"> Queue Mayflower Flyer
        </div>
      </div> --->
    </fieldset>
    <div class="row">
        <div class="small-12 columns">
         <input type="submit" value="Add New Record" name="AddNewRecordButton" class="button"> <input type="submit" value="Check Address" name="checkAddressButton" class="button"> <input type="button" value="Reset Form" class="button" onClick="clearFormValues()">
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
