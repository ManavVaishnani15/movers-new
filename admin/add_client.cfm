<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Administration - Add New Record</title>
<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
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
<cfif parameterexists(first_name) is 'yes'>
    <cfquery name="usedCodes" datasource="aaalh3x_onestep">
        select distinct discountCode
        from CLIENTS
    </cfquery>
    <cfset codeList = ValueList(usedCodes.discountCode)>
    <cfset discountCodeNumeric = randRange(1000,9999) />

    <cfset strAlpha = "ABCDEFGHIJKLMNOPQRDTUVWXYZ" />
    <cfset discountCode = Mid(strAlpha, RandRange(1, Len(strAlpha) ),1) />
    <cfset discountCode = "#discountCode##Mid(strAlpha, RandRange(1, Len(strAlpha) ),1)#-#discountCodeNumeric#" />

    <cfset loopCounter= 1 />
    <!--- <cfloop condition="listFind('#codeList#',discountCode) gt 0 OR loopCounter lt 9000">
            <cfset discountCode = randRange(1000,9999) />
            <cfset loopCounter = loopCounter + 1 />
        </cfloop> --->
        <cfset closingDate=#dateformat('#closing_date#', "YYYY-MM-DD")#>
        <cfset contractDate=#dateformat('#contract_date#', "YYYY-MM-DD")#>
        <cfset appointmentDate=#dateformat('#appointment_date#', "YYYY-MM-DD")#>

        <cfquery name="add_client" datasource="aaalh3x_onestep">
                insert into CLIENTS
                (entry_date,active,first_name,last_name,from_address,from_address2,from_city,from_state,from_zip,<cfif #closing_date# is not ''>closing_date,</cfif><cfif #contract_date# is not ''>contract_date,</cfif>realty_company,<cfif #appointment_date# is not ''>appointment_date,</cfif>home_price,comments,discountCode, memberId)
                values ('#datenow#','0','#first_name#','#last_name#','#address#','#address2#','#city#','#state#','#zip#',<cfif #closing_date# is not ''>'#closingDate#',</cfif><cfif #contract_date# is not ''>'#contractDate#',</cfif>'#new_realty_company#',<cfif #appointment_date# is not ''>'#appointmentDate#',</cfif>'#home_price#','#comments#','#discountCode#',#verify.id#)
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
            <cfif  not isdefined('form.noQueue') >
                
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
<cfset a='a'>
</cfif>

<table border="0" cellspacing="0" cellpadding="5" width="100%"><tr><td bgcolor="gray" width="106" valign="middle"><img src="letters/images/logo_small.jpg" height="80" alt="" border="0"></td><td bgcolor="gray" valign="middle"><font face="arial" size="4" color="white"><b>Administration - Add Record</b></font></td><td valign="right" bgcolor="gray"><div align="right"><br><cfoutput><font face="arial" size="2" color="white">#verify.name#</font><br></cfoutput><a href="index.cfm"><font face="arial" size="2" color="yellow">Log&nbsp;Out</font></a></div><br></td></tr></table><br>

<cfif parameterexists(a) is 'yes'>
<font face="arial" size="3" color="green"><b>The New Record was Added to the System</b></font><br><br>
</cfif>


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
                    return false;
                  }
                })
            .autocomplete( "instance" )._renderItem = function( ul, item ) {
              return $( "<li>" )
                .append( "<a>" + item.value+ "</a>" )
                .appendTo( ul );
            };
        });
    </script>

<font face="arial" size="3"><b>Add New Record</b><br></font><br>
<font face="arial" size="2">
<form action="add_client.cfm" method="post">
<cfoutput>
<input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#">
</cfoutput>
First Name <input type="text" name="first_name" size="20" id="first_name"> Last Name <input type="text" name="last_name" size="20" id="last_name">
<br><br>
<table border="0" cellspacing="0" cellpadding="0"><tr>
<td valign="middle">
    <font face="arial" size="2">Address </td><td valign="middle">
    <!--- <input type="text" name="address" size="23"> --->
    <input class="typeaheadAddy" type="text" name="address" id="address">
</td>
</tr>
<tr>
<td></td><td><input type="text" name="address2" size="23"></td></tr></table>
<br>
City <input type="text" name="city" size="20"> 

State 
<span>
  <input class="typeahead" type="text" name="state" id="state">
</span>
<!--- <select name="state"><option value="">Select</option>
                 <option value="AL">AL</option>
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
                 </select> ---> Zip <input type="text" name="zip" size="10">
<br>
<br>
<div style="vertical-align:baseline">
Realty Company 

  <input class="realtorTypeahead" type="text" name="new_realty_company" id="new_realty_company" >

<!--- <input type="text" name="realty_company" size="20">  --->
Home Price $<input type="text" name="home_price" size="7"><br>
</div>
Closing Date <input class="remindmedropdowna" name="closing_date" id="datepicker">&nbsp;
Contract Date <input class="remindmedropdown" name="contract_date" id="datepickera">&nbsp;
Appt Date <input class="remindmedropdownc" name="appointment_date" id="datepickerb">
<br><br><Br><Br>
<br><br><br><br><br><br><br><br><br>
Comments<br>
<textarea name="comments" rows="5" cols="50"></textarea>
<br>
Don't Queue Letters: <input type="checkbox" value="1" name="noQueue"><br />
Don't Queue Follow Up Letter and Follow Up Label: <input type="checkbox" value="1" name="noQueueFU"><br />
No realtor Leads Letter: <input type="checkbox" value="1" name="noRealtorLetter"><br />
Queue Door Hanger Residential (No Letters): <input type="checkbox" value="1" name="queueHangerClosing"><br />
Queue Door Hanger Appointment  (No Letters): <input type="checkbox" value="1" name="queueHangerAppt"><br />
Queue Door Hanger Offer  (No Letters): <input type="checkbox" value="1" name="queueHangerOffer"><br />
Queue Door Hanger United-Mayflower  (No Letters): <input type="checkbox" value="1" name="queueHangerUnited"><br />

<input type="submit" value="Add New Record"></form>

<br><br>
<cfoutput>
<cfquery name="printQueue" datasource="aaalh3x_onestep">
        select id
        from printQUeue
        where (memberId=#verify.id# or memberId is null)
        and printType <> 'followUp'
        and printed=0
        and cleared=0
</cfquery>
<font face="arial" size="3">
        Print Queue - <cfoutput>#printQueue.recordcount#</cfoutput> letter<cfif #printQueue.recordcount# is not 1>s</cfif> in queue <br>
       <A href="printQueue.cfm?un=#un#&pw=#pw#">Print Letters</A><br>
</font>
        <a href="main.cfm?un=#un#&pw=#pw#"><font face="arial" size="3" color="navy">Main Menu</font></a></cfoutput><br><br>
</body>
</html>
