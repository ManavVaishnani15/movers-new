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
    <title><cfif parameterexists(clientid) is 'yes'><cfoutput>#getinfo.first_name# #getinfo.last_name# Payment Email</cfoutput></cfif></title>
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

<!--- Get global payment link from configuration table --->
<cfquery name="getPaymentConfig" datasource="aaalh3x_onestep">
select config_value from configuration
where config_key='payment_link'
</cfquery>
<cfset paymentLink = getPaymentConfig.config_value>

<cfif parameterexists(sendmail) is 'yes'>
    <!--- Check if payment email was already sent --->
    <cfquery name="check_initial" datasource="aaalh3x_onestep">
    select * from LETTER_SENDS
    where send_type=11 and cust_hook=#clientid#
    </cfquery>
    
    <!--- Always start with primary email --->
    <cfset emailList = trim(getinfo.email)>
    
    <!--- If "Send email to Both" is checked, add secondary email --->
    <cfif parameterexists(sendEmailToAll) and sendEmailToAll eq '1'>
        <cfif len(trim(getinfo.email2))>
            <cfif len(emailList)>
                <cfset emailList = emailList & "," & trim(getinfo.email2)>
            <cfelse>
                <cfset emailList = trim(getinfo.email2)>
            </cfif>
        </cfif>
    </cfif>
    
    <!--- If "Check to send copy to yourself" is checked, add admin email --->
    <cfif parameterexists(altmail) is 'yes'>
        <cfif len(trim(emailList))>
            <cfset emailList = emailList & "," & "customercare@nationwideusamovers.com">
        </cfif>
    </cfif>
    <cfmail
        server="vps.affordableusamovers.com"
        username="customercare@nationwideusamovers.com" 
        password="Temp1707!" 
        port="587"  
        useSSL="false"
    TO="#emailList#"
    FROM="customercare@nationwideusamovers.com"
    SUBJECT="Payment Required - Move Management Fee"
    TYPE="HTML">
        <style>
            body {
                height: 842px;
                width: 700px;
                /* to centre page on screen*/
                margin-left: auto;
                margin-right: auto;
                margin-top: 0px;
                padding:40px 20px;
                font-family: Calibri;
                font-size:18px;
            }
        </style>
        <cfoutput>
            <p>
                Dear #getinfo.first_name# #getinfo.last_name#,
            </p>

            <p>
                This is #getinfo.email_sender_full_name# from Nationwide USA Movers Customer Care and Accounting Department.
                <br>
                In order for Nationwide USA Movers to finalize the registration of your move from #getinfo.from_city#, #getinfo.from_state# to #getinfo.to_city#, #getinfo.to_state# we require the payment of a Move Management Fee in the amount of <strong>$#getinfo.management_fee#.</strong>
            </p>

            <p>
                The payment can be processed safely and securely using the link below:
            </p>

            <p style="text-align:left; margin:25px 0;">
                <a href="#paymentLink#" target="_blank">
                    #paymentLink#
                </a>
            </p>

            <p>
                The total cost for your move is <strong>$#getinfo.total_cost_of_move#</strong> (including Management Fee).
            </p>

            <p>
                After the payment of the management fee, the remaining balance for your move will be <strong>$#getinfo.remaining_balance#</strong> to be paid directly to the selected moving company: #getinfo.moving_company#.
            </p>

            <p>
                Thank you for choosing Nationwide USA Movers for managing your move.
            </p>

            <p>
                Sincerely,
            </p>

            <p>
                #getinfo.email_sender_full_name#<br><br>
                Customer Care and Accounting Department<br>
                Nationwide USA Movers<br>
                1-800-976-6833<br>
                <a href="mailto:customercare@nationwideusamovers.com">customercare@nationwideusamovers.com</a>
            </p>

            <p style="margin:30px 0px;">
                <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg"
                    alt="Nationwide USA Movers" width="150">
            </p>

            <p style="font-size:14px;">
                CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages 
                attached to it, may contain information that is confidential or legally privileged.  If you are not the intended 
                recipient, or a person responsible for delivering it to the intended recipient, you are hereby notified that you 
                must not read this transmission.   This electronic communication and any accompanying document is the 
                property of Nationwide Usa Movers, Inc. Unauthorized use, disclosure or copying of this communication, or 
                any part of it, is strictly prohibited and may be unlawful.
            </p>
        </cfoutput>       
    </cfmail>

    <!--- Track the email send in LETTER_SENDS table --->
    <cfif #check_initial.recordcount# is 0>
        <cfquery name="set_initial" datasource="aaalh3x_onestep">
        insert into LETTER_SENDS
        (send_type, sent, cust_hook, sent_date)
        values ('11', '2', '#clientid#', '#datenow#')
        </cfquery>
    <cfelse>
        <cfquery name="set_resend" datasource="aaalh3x_onestep">
        insert into LETTER_SENDS
        (send_type, sent, cust_hook, sent_date)
        values ('13', '2', '#clientid#', '#datenow#')
        </cfquery>
    </cfif>

    <div align="center">
        <br><br>
        <cfif #check_initial.recordcount# is 0>
            <font face="arial" size="3" color="green"><b>Payment Email Sent Successfully!</b></font><br>
        <cfelse>
            <font face="arial" size="3" color="green"><b>Payment Email Resent Successfully!</b></font><br>
        </cfif>
        <cfif parameterexists(altmail) is 'yes'>
            <font face="arial" size="2">A copy was sent to customercare@nationwideusamovers.com</font><br>
        </cfif>
        <font face="arial" size="2">You may now close this tab</font>
    </div>

</cfif>

<cfif parameterexists(emailit) is 'yes'>
    <style>
        body {
            height: 842px;
            width: 700px;
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            margin-top: 0px;
            font-family: Calibri;
            padding:40px 20px;
            font-size:18px;
        }
    </style>
    <form action="paymentEmail.cfm" method="post"><input type="hidden" name="clientid" value="<cfoutput>#clientid#</cfoutput>"><input type="hidden" name="sendmail" value="1"><cfoutput><input type="hidden" name="un" value="#un#"><input type="hidden" name="pw" value="#pw#"></cfoutput>
    <div align="center">
    <input type="submit" value="Email to <cfoutput>#getinfo.email#</cfoutput> Now"><br>
    <input type="checkbox" name="sendEmailToAll" value="1"> Send email to Both<br>
    <input type="checkbox" name="altmail" value="<cfoutput>#verify.id#</cfoutput>"> Check to send copy to yourself</div><br></form>

    <cfoutput>
        <p>
            Dear #getinfo.first_name# #getinfo.last_name#,
        </p>

        <p>
            This is #getinfo.email_sender_full_name# from Nationwide USA Movers Customer Care and Accounting Department.
            <br>
            In order for Nationwide USA Movers to finalize the registration of your move from #getinfo.from_city#, #getinfo.from_state# to #getinfo.to_city#, #getinfo.to_state# we require the payment of a Move Management Fee in the amount of <strong>$#getinfo.management_fee#.</strong>
        </p>

        <p>
            The payment can be processed safely and securely using the link below:
        </p>

        <p style="text-align:left; margin:25px 0;">
            <a href="#paymentLink#" target="_blank">
                #paymentLink#
            </a>
        </p>

        <p>
            The total cost for your move is <strong>$#getinfo.total_cost_of_move#</strong> (including Management Fee).
        </p>

        <p>
            After the payment of the management fee, the remaining balance for your move will be <strong>$#getinfo.remaining_balance#</strong> to be paid directly to the selected moving company: #getinfo.moving_company#.
        </p>

        <p>
            Thank you for choosing Nationwide USA Movers for managing your move.
        </p>

        <p>
            Sincerely,
        </p>

        <p>
            #getinfo.email_sender_full_name#<br><br>
            Customer Care and Accounting Department<br>
            Nationwide USA Movers<br>
            1-800-976-6833<br>
            <a href="mailto:customercare@nationwideusamovers.com">customercare@nationwideusamovers.com</a>
        </p>

        <p style="margin:30px 0px;">
            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg"
                alt="Nationwide USA Movers" width="150">
        </p>

        <p style="font-size:14px;">
            CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages 
            attached to it, may contain information that is confidential or legally privileged.  If you are not the intended 
            recipient, or a person responsible for delivering it to the intended recipient, you are hereby notified that you 
            must not read this transmission.   This electronic communication and any accompanying document is the 
            property of Nationwide Usa Movers, Inc. Unauthorized use, disclosure or copying of this communication, or 
            any part of it, is strictly prohibited and may be unlawful.
        </p>
    </cfoutput>
</cfif>
</body>
</html>
