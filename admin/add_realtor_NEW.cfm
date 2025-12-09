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

        <cfset appointment_date = Now()>
		<cfset appointmentDate = dateformat('#appointment_date#', "YYYY-MM-DD")>
        <cfquery name="add_client" datasource="aaalh3x_onestep">
                insert into Realtor_records
                (repfirstname,replastname,AgencyAddress,Agencyaddress2,Agencycity,Agencystate,Agencyzip,Companyname, comments, ReferralCode, CellPhone, OfficePhone, OtherPhone, AgentEmail, ListingAddress)
                values ('#rep_first_name#','#rep_last_name#','#address#','#address2#','#city#','#state#','#zip#','#Companyname#','#comments#','#ReferralCode#','#CellPhone#','#OfficePhone#','#OtherPhone#','#AgentEmail#','#ListingAddress#')
        </cfquery>
        <cfquery name="add_client" datasource="aaalh3x_onestep">
                select max(id) AS newID 
                from Realtor_records
        </cfquery>

            <cfif not isdefined('form.DontQueueLetter') and isdefined('form.RealtorLetter')>
                    <cfquery  datasource="aaalh3x_onestep">
                            insert into realtor_printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'new',0,#verify.id#,0)
                    </cfquery>
                 <cfquery name="set_initial" datasource="aaalh3x_onestep">
                        insert into realtor_LETTER_SENDS
                        (send_type,active,cust_hook,user_hook,sent_date,sent)
                        values ('999','1','#add_client.newID#','#verify.id#',#now()#,1)
                 </cfquery>
            </cfif>

<!---			<cfif isdefined('form.RealtorLetter') >            
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'RealtorLetter',0,#verify.id#,0,0)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into realtor_LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('100','1','#add_client.newID#','#verify.id#')
                </cfquery>
			</cfif>--->
            
			<cfif isdefined('form.LeasingManagerLetter') >            
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'LeasingManagerLetter',0,#verify.id#,0,0)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into realtor_LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('101','1','#add_client.newID#','#verify.id#')
                </cfquery>
			</cfif>
            
			<cfif isdefined('form.MortgageProLetter') >            
                 <cfquery name="check_initial" datasource="aaalh3x_onestep">
                    insert into realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger)
                    values(#add_client.newID#,'MortgageProLetter',0,#verify.id#,0,0)
                </cfquery>
        
                <cfquery name="q" datasource="aaalh3x_onestep">
                    insert into realtor_LETTER_SENDS
                    (send_type,active,cust_hook,user_hook)
                    values ('102','1','#add_client.newID#','#verify.id#')
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
         		from Realtor_printQueue
         		where clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         		and printType = <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
         	</cfquery>
         	
         	<cfif checkFollowUpDateBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpDateBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into Realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
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
         		from Realtor_LETTER_SENDS
         		where send_type = <cfqueryparam cfsqltype="cf_sql_integer" value="998">
         		and cust_hook = <cfqueryparam cfsqltype="cf_sql_bigint" value="#add_client.newID#">
         	</cfquery>
         	
         	<cfif checkFollowUpLabelBeforeAppointmentDate.recordCount EQ 0>
         		<cfquery name="insertFollowUpLabelBeforeAppointmentDate" datasource="aaalh3x_onestep">
	         		insert into Realtor_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD')#">)
	         	</cfquery>
         	</cfif>
         	
         	<cfset firstFollowUpDateAfterAppointmentDate = dateAdd('d',14,appointmentDate)>
			<cfset lastFollowUpDateAfterAppointmentDate = dateAdd('d',84,appointmentDate)>
			
			<cfloop index="currentFollowUpDateAfterAppointmentDate" from="#firstFollowUpDateAfterAppointmentDate#" to="#lastFollowUpDateAfterAppointmentDate#" step="#CreateTimeSpan(14,0,0,0)#">
				<cfquery name="insertFollowUpLetterAfterAppointmentDate" datasource="aaalh3x_onestep">
					insert into Realtor_printQueue(clientid,printType,printed,memberId, cleared, hanger,followup_date)
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
					insert into Realtor_LETTER_SENDS(send_type,active,cust_hook,user_hook,followup_date)
					values ('998','1','#add_client.newID#','#verify.id#',<cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(currentFollowUpDateAfterAppointmentDate, 'YYYY-MM-DD')#">)
				</cfquery>
				
			</cfloop>
<!---            
                    <cfquery  datasource="aaalh3x_onestep">
                            insert into Realtor_printQueue(clientid,printType,printed,memberId,cleared)
                            values(#add_client.newID#,'new',0,#verify.id#,0)
                    </cfquery>
                 <cfquery name="set_initial" datasource="aaalh3x_onestep">
                     insert into Realtor_LETTER_SENDS
                     (send_type,sent,cust_hook,sent_date)
                     values ('999','1','#add_client.newID#','#datenow#')
                 </cfquery>
			
			<!--- Send email to Anthony and Maria to let them know that a new follow-up letter and label is queued AND that the first Date of the follow up is now --->
			<cfif dateformat(dateAdd('d',-7,appointmentDate), 'YYYY-MM-DD') EQ datenow>
				<cfmail from="customercare@vanlinequotes.com" subject="New Follow-up Letters and Labels are Queued" to="abooker@vanlinequotes.com;customercare@vanlinequotes.com" type="html">
					#first_name# #last_name#<br />
					#address# #address2#<br />
					#city# #state# #zip#
				</cfmail>
			</cfif>--->
         </cfif>
         
<cfset a='a'>
</cfif>

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Add Realtor Record</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table>

<cfquery name="addy" datasource="aaalh3x_onestep">
    select distinct agencyaddress,repfirstname,replastname, Companyname
    from Realtor_records
    where agencyaddress <> ''
</cfquery>
<cfquery name="addyAgency" datasource="aaalh3x_onestep">
    select distinct listingaddress,repfirstname,replastname, Companyname
    from Realtor_records
    where listingaddress <> ''
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

            var addy = [<cfoutput query="addy">{value:'#replace(trim(addy.agencyaddress),"'","\'","all")#',fname: '#replace(trim(addy.repfirstname),"'","\'","all")#',lname: '#replace(trim(addy.replastname),"'","\'","all")#',cname: '#replace(trim(addy.Companyname),"'","\'","all")#'}<cfif addy.currentrow lt addy.recordcount>,</cfif></cfoutput>
            ];
            
            var addyAgency = [<cfoutput query="addyAgency">{value:'#replace(trim(addyAgency.listingaddress),"'","\'","all")#',fname: '#replace(trim(addyAgency.repfirstname),"'","\'","all")#',lname: '#replace(trim(addyAgency.replastname),"'","\'","all")#',cname: '#replace(trim(addyAgency.Companyname),"'","\'","all")#'}<cfif addyAgency.currentrow lt addyAgency.recordcount>,</cfif></cfoutput>
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
            $( "#ListingAddress" ).autocomplete({
                  minLength: 2,
                  source: addyAgency,
                  select: function( event, ui ) {
                  
                    $('#Rep_first_name').val(ui.item.fname);
                    $('#Rep_last_name').val(ui.item.lname);
					$('#ListingAddress').val(ui.item.value);
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
			document.getElementById('streetaddress').value = "";
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
    
<CFPARAM NAME="varReferralCode" default="">
<CFPARAM NAME="varFirstName" default="">
<CFPARAM NAME="varLastName" default="">
<CFPARAM NAME="varAddress" default="">
<CFPARAM NAME="varCity" default="">
<CFPARAM NAME="varState" default="">
<CFPARAM NAME="varZip" default="">
<CFPARAM NAME="varCounty" default="">
<CFPARAM NAME="varCompanyName" default="">
<CFPARAM NAME="varListingAddress" default="">
<CFPARAM NAME="varCellPhone" default="">
<CFPARAM NAME="varOfficePhone" default="">
<CFPARAM NAME="varOtherPhone" default="">
<CFPARAM NAME="varAgentEmail" default="">
    
<cfif IsDefined("checkAddressButton")>
<CFSET varReferralCode = form.ReferralCode>
<CFSET varCompanyname = form.Companyname>
<CFSET varFirstName = form.rep_first_name>
<CFSET varLastName = form.rep_last_name>
<CFSET varAddress = form.address>
<CFSET varListingAddress = form.Listingaddress>
<CFSET varCity = form.City>
<CFSET varState = form.State>
<CFSET varZip = form.zip>


<cfquery name="qCheckExisting" datasource="aaalh3x_onestep">
SELECT ID, repFirstname, repLastname
FROM Realtor_records
WHERE (1=1
	<CFIF form.rep_first_name NEQ "">AND repFirstname = '#varFirstName#'</CFIF>
    <CFIF form.rep_last_name NEQ "">AND repLastname = '#varLastName#'</CFIF>
	<CFIF form.address NEQ "">AND agencyAddress LIKE '%#varAddress#%'</CFIF>
	<CFIF form.Listingaddress NEQ "">AND ListingAddress LIKE '%#varListingAddress#%'</CFIF>
	<CFIF form.city NEQ "">AND agencyCity = '#varCity#'</CFIF>
    <CFIF form.state NEQ "">AND agencyState = '#varState#'</CFIF>
    <CFIF form.Zip NEQ "">AND agencyzip = '#varZip#'</CFIF>
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

<!---               <cfquery name="qCheckLetterSend" datasource="aaalh3x_onestep">
                  SELECT * FROM Realtor_printqueue pq left join Realtor_LETTER_SENDS ls on pq.id = ls.printqueueId
                  where pq.clientid = <cfqueryparam cfsqltype="cf_sql_bigint" value="#id#">
                  and pq.printType= <cfqueryparam cfsqltype="cf_sql_varchar" value="followUp">
                  order by pq.followup_date
              </cfquery> --->
			<cfquery name="qCheckLetterSend" datasource="aaalh3x_onestep">
  			select * from Realtor_LETTER_SENDS
  			where cust_hook=#id# and 
  				(send_type=7 or send_type=998  or send_type=999  or send_type=101   or send_type=102) 
        		and (sent_date is not null OR followup_date is not null)
            </cfquery>
              
              CustomerID: #ID# - Name: #rep_First_name# #rep_Last_name#<BR>
                  <cfquery name="qLettersDate" datasource="aaalh3x_onestep">
                    SELECT ID, repFirstname, repLastname
                    FROM Realtor_records
                     where ID = #ID#
                    </cfquery>
              <CFIF qCheckLetterSend.RecordCount>
              <CFLOOP QUERY="qCheckLetterSend">
                     <cfif qCheckLetterSend.send_type eq "999">
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Main Realtor Letter - #dateformat(qCheckLetterSend.sent_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq 0>(Not Sent)<cfelseif qCheckLetterSend.sent eq 1>(Sent)</cfif>
                     <br>
					</cfif>
              </CFLOOP>
              <CFLOOP QUERY="qCheckLetterSend">
					 <cfif qCheckLetterSend.send_type eq "998">
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Follow Up - #dateformat(qCheckLetterSend.followup_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq 0>(Not Sent)<cfelseif qCheckLetterSend.sent eq 1>(Sent)</cfif>
                 	<br />
					</cfif>
              </CFLOOP>
              <CFLOOP QUERY="qCheckLetterSend">
                    <cfif qCheckLetterSend.send_type eq "101">
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Leasing Pro - #dateformat(qCheckLetterSend.sent_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq 0>(Not Sent)<cfelseif qCheckLetterSend.sent eq 1>(Sent)</cfif>
                 	<br />
                    <cfbreak>
					</cfif>
              </CFLOOP>
              
              <CFLOOP QUERY="qCheckLetterSend">
                    <cfif qCheckLetterSend.send_type eq "102">
                 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type: Mortgage Pro - #dateformat(qCheckLetterSend.sent_date, "MMM D, YYYY")# <cfif qCheckLetterSend.sent eq 1>(Mailed)<cfelseif qCheckLetterSend.sent eq 2>(Emailed)<cfelseif qCheckLetterSend.sent eq 0>(Not Sent)<cfelseif qCheckLetterSend.sent eq 1>(Sent)</cfif>
                 	<br />
                    <cfbreak>
					</cfif>
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
              <h5>New Realtor Record Added Successfully</h5>
              <p>The New Record was Added to the System</p>
            </div>
        </div>
	</div>
</CFIF>

<cfquery name="printQueue" datasource="aaalh3x_onestep">
        select id
        from Realtor_printQUeue
        where (memberId=#verify.id# or memberId is null)
      and (printType <> 'followUp' and printType <> 'Mayflowerfollowup' and printType <> 'MayflowerFlyer')
        and printed=0
        and cleared=0
</cfquery>

<form action="add_Realtor_New.cfm" method="post" name="addDataForm" data-abide novalidate>
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
          <cfoutput><A href="printRealtorQueue.cfm?un=#un#&pw=#pw#" target="_blank">Print Letters</A></cfoutput>
        </div>
        <div class="small-4 columns">
          <cfoutput><a href="mainRealtor.cfm?un=#un#&pw=#pw#">Main Menu</a></cfoutput>
        </div>
      </div>
    </fieldset>
	<fieldset class="fieldset">
    <legend><strong>Add New Realtor Record</strong></legend>
    <div class="row">
        <div class="small-3 columns">
          <label for="ReferralCode" class="text-left middle">Referral Agent Discount Code</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="ReferralCode" size="20" id="ReferralCode" placeholder="Referral Agent Discount Code" value="<cfoutput>#varReferralCode#</cfoutput>" required>
			<span class="form-error">
            Referral Agent Discount Code is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Companyname" class="text-left middle">Referral Agent Agency</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Companyname" size="20" id="Companyname" placeholder="Referral Agent Agency" value="<cfoutput>#varCompanyName#</cfoutput>">
			<span class="form-error">
            Referral Agent Agency is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_first_name" class="text-left middle">Referral Agent First Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Rep_first_name" size="20" id="Rep_first_name" placeholder="Referral Agent First Name" value="<cfoutput>#varFirstName#</cfoutput>" required>
			<span class="form-error">
            Referral Agent First Name is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="Rep_last_name" class="text-left middle">Referral Agent Last Name</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="Rep_last_name" size="20" id="Rep_last_name" placeholder="Referral Agent Last Name" value="<cfoutput>#varLastName#</cfoutput>" required>
			<span class="form-error">
            Referral Agent last Name is required
          </span>
        </div>
      </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="ListingAddress" class="text-left middle">Listing/Property Address</label>
        </div>
        <div class="small-9 columns">
          <input type="text" name="ListingAddress" size="20" id="ListingAddress" placeholder="Listing/Property Address" value="<cfoutput>#varListingAddress#</cfoutput>">
        </div>
      </div>
      
    <div class="row">
        <div class="small-3 columns">
          <label for="address" class="text-left middle">Referral Agent Street Address</label>
        </div>
        <div class="small-9 columns">
          <input class="typeaheadAddy" type="text" name="address" id="address" value="<cfoutput>#varAddress#</cfoutput>" placeholder="Referral Agent Street Address">
			<span class="form-error">
            Referral Agent Street Address is required
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
          <label for="CellPhone" class="text-left middle">Cell Phone Number</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="CellPhone" id="CellPhone" size="10" placeholder="Cell Phone Number" value="<cfoutput>#varCellPhone#</cfoutput>">
        </div>
    </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="OfficePhone" class="text-left middle">Office Phone Number</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="OfficePhone" id="OfficePhone" size="10" placeholder="Office Phone Number" value="<cfoutput>#varOfficePhone#</cfoutput>">
        </div>
    </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="OtherPhone" class="text-left middle">Additional Contact Number</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="OtherPhone" id="OtherPhone" size="10" placeholder="Additional Contact Number" value="<cfoutput>#varOtherPhone#</cfoutput>">
        </div>
    </div>
    <div class="row">
        <div class="small-3 columns">
          <label for="AgentEmail" class="text-left middle">Referral Agent Email</label>
        </div>
        <div class="small-9 columns">
         <input type="text" name="AgentEmail" id="AgentEmail" size="10" placeholder="Referral Agent Email" value="<cfoutput>#varAgentEmail#</cfoutput>">
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
          <input type="checkbox" value="1" name="RealtorLetter"> Realtor Letter
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
          <input type="checkbox" value="1" name="LeasingManagerLetter"> Leasing Manager or Agent Letter
        </div>
      </div>
    <div class="row">
        <div class="small-12 columns">
          <input type="checkbox" value="1" name="MortgageProLetter"> Mortgage Professional Letter
        </div>
      </div>
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
         <input type="submit" value="Add New Record" name="AddNewRecordButton" class="button"> <input type="submit" value="Check Address" name="checkAddressButton" class="button"> <input type="reset" value="Reset Form" class="button">
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
