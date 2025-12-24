<cfif parameterexists(altmail) is 'yes'>

    <cfmail
        server="sandbox.smtp.mailtrap.io"
        username="7b6d0e2d44a4fb" 
        password="6a608c432d1dae"
        port="2525" 
        useSSL="false"
    TO="#verify.email#"
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
                font-family: Arial;
                padding:40px 20px;
            }
            </style>
    <cfoutput>
        <p>
        Dear #getinfo.first_name# #getinfo.last_name#,
        </p>

        <p>
        This is #getinfo.email_sender_full_name# from Nationwide USA Movers Customer Care and Accounting Department.
        </p>
        
        <p>
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
        </p><br>

        <p>
        Sincerely,
        </p><br>

        <p>
        #getinfo.email_sender_full_name#<br><br>
        Customer Care and Accounting Department<br>
        Nationwide USA Movers<br>
        1-800-976-6833<br>
        <a href="mailto:customercare@nationwideusamovers.com">customercare@nationwideusamovers.com</a>
        </p>

        <p style="margin-top:30px;">
        <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg"
            alt="Nationwide USA Movers" width="150">
        </p><br>

        <p style="font-size:12px;color:##555;">
            CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential or legally privileged. If you are not the intended recipient, or person or persons responsible for delivering this to the intended recipient, you are hereby notified that you must not read this transmission. This electronic communication and any accompanying document is the property of Nationwide Usa Movers, Inc. Unauthorized use, disclosure or copying of this communication, or any part of it, is strictly prohibited and may be unlawful.
        </p>
    </cfoutput>           
    </cfmail>

    </cfif>