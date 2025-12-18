<cfparam name="REQUEST.letter_body" default="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Base styles */
        table { font-family: Calibri, sans-serif; border-spacing: 0; }
        body { font-family: Calibri, sans-serif; margin: 0; padding: 0; }
        div, span, p, a { font-family: Calibri, sans-serif; }
        img { border: 0; display: block; }

        .fontbold { font-weight: bold; }
        .colorred { color: #ff0000; }
        .colorblue { color: #0070C0; }

        /* Font sizes */
        .fontsize9 { font-size: 9px; }
        .fontsize10 { font-size: 10px; }
        .fontsize11 { font-size: 11px; }
        .fontsize12 { font-size: 12px; }
        .fontsize14 { font-size: 14px; }
        .fontsize16 { font-size: 16px; }
        .fontsize18 { font-size: 18px; }
        .fontsize20 { font-size: 20px; }
        .fontsize24 { font-size: 24px; }
        .fontsize28 { font-size: 28px; }

        td { padding: 0px 0px; line-height: 1.15em; }

        /* Discount card desktop */
        .discount-card-container {
            width: 364px;
            height: 195px;
            padding: 4px;
            background: url('https://www.top12movingbiz.com/admin/letters/images/demo2.png') no-repeat center center;
            background-size: 100% 100%;
            display: inline-block;
        }

        .discount-card-inner {
            width: 100%;
            padding: 15px;
            box-sizing: border-box;
        }
        
        @media screen and (min-width: 601px) {
            .discount-section {
                margin-left: 150px;
            }
        }
        
        .desktop-only {
            display: block;
        }
        
        .contact-mobile {
            display: none;
        }
        
        @media screen and (max-width: 600px) {
            .desktop-only {
                display: none !important;
            }
        
            .contact-mobile {
                display: block !important;
            }
        }

        /* Mobile responsive styles */
        @media screen and (max-width: 600px) {
            body {
                width: 100% !important;
                min-width: 100% !important;
            }

            table[class="wrapper"] {
                width: 100% !important;
            }

            /* Hide desktop elements */
            .desktop-only {
                display: none !important;
                max-height: 0 !important;
                overflow: hidden !important;
                visibility: hidden !important;
            }

            /* Mobile padding */
            .mobile-padding {
                padding-left: 10px !important;
                padding-right: 10px !important;
            }

            /* Logo and date header */
            .header-logo {
                width: 80px !important;
            }

            /* Discount section */
            .discount-section {
                padding-left: 0px !important;
                text-align: center !important;
            }

            .fontsize28 {
                font-size: 22px !important;
            }

            .fontsize24 {
                font-size: 18px !important;
            }

            .fontsize18 {
                font-size: 15px !important;
            }

            .fontsize16 {
                font-size: 14px !important;
            }

            .fontsize12 {
                font-size: 11px !important;
            }

            /* QR Code mobile */
            .qr-code-mobile {
                text-align: center !important;
                padding-top: 15px !important;
            }

            .qr-code-mobile img {
                width: 120px !important;
                margin: 0 auto !important;
            }

            /* Discount card mobile - FIXED */
            .discount-card-wrapper {
                padding: 0 10px !important;
            }

            .discount-card-table {
                margin-top: 10px !important;
                margin-bottom: 20px !important;
            }

            .discount-card-container {
                /*width: 100% !important;*/
                /*max-width: 100% !important;*/
                /*height: auto !important;*/
                /*min-height: 180px !important;*/
                /*margin: 0 0 25px !important;*/
                box-sizing: border-box !important;
                height: 180px !important;
            }

            .discount-card-inner {
                padding: 10px !important;
                height:195px;
            }

            .card-logo-mobile {
                width: 65px !important;
            }

            .card-services {
                font-size: 7.5px !important;
                line-height: 1.1 !important;
            }

            .card-services ul {
                padding-left: 12px !important;
            }

            .card-title {
                font-size: 11px !important;
            }

            .card-text {
                font-size: 8.5px !important;
                margin-top: 6px !important;
            }

            .card-code-title {
                font-size: 11px !important;
                margin-top: 6px !important;
            }

            .card-code {
                font-size: 16px !important;
                margin-top: 6px !important;
            }

            .card-contact {
                font-size: 7px !important;
                margin-top: 6px !important;
            }

            /* Contact section mobile */
            .contact-section {
                padding: 15px 10px !important;
                text-align: center !important;
            }

            /* Footer mobile */
            .footer-section {
                padding: 15px 10px !important;
            }

            .social-icons img {
                width: 15px !important;
            }

            .fontsize9 {
                font-size: 8px !important;
            }

            /* Hide desktop contact section on mobile */
            .contact-desktop {
                display: none !important;
                max-height: 0 !important;
                overflow: hidden !important;
                visibility: hidden !important;
            }

            /* Show mobile contact section */
            .contact-mobile {
                display: block !important;
            }
        }

        /* Hide mobile contact section on desktop */
        .contact-mobile {
            display: none;
        }
    </style>
</head>
<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="wrapper">
  <tr>
    <td width="15%" align="left" class="mobile-padding">
        <img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="110" alt="Nationwide USA Movers" class="header-logo">
    </td>
    <td width="70%" class="desktop-only">&nbsp;</td>
    <td width="15%" align="right" valign="bottom" class="mobile-padding">
        <p class="fontsize12 fontbold" style="margin:0; padding-top:8px;">
            <cfoutput>#dateFormat(now(), "MM/DD/YYYY")#</cfoutput>
        </p>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:8px;">
  <tr><td class="mobile-padding"><cfoutput>#trim(REQUEST.letter_body)#</cfoutput></td></tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
        <td width="70%" align="center" valign="center" class="mobile-padding">

            <div class="discount-section desktop-only" style="margin-left:150px; line-height:1.8;">
                <span class="fontsize18 fontbold">Move Discount Code</span><br>

                <span class="fontsize28 colorred fontbold" style="text-decoration:underline;">
                    <cfoutput>#getinfo.discountCode#</cfoutput>
                </span><br>

                <span class="fontsize11 fontbold">LOCK IN AUTOMATIC DISCOUNTS ON YOUR MOVE BY</span><br>

                <span class="fontsize28 colorred fontbold">
                    <cfif len(trim(getinfo.appointment_date))>
                        <cfoutput>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</cfoutput>
                    <cfelse>
                        Appointment Date
                    </cfif>
                </span><br>

                <span class="fontsize16 colorred fontbold">ACTIVATE NOW!</span><br>

                <span class="fontsize12 colorred">HURRY! BEFORE YOUR OFFER EXPIRES</span>
            </div>
            
            <div class="discount-section contact-mobile" style="margin-left:0; text-align:center; line-height:2.1;">
                <span class="fontsize18 fontbold">Move Discount Code</span><br>

                <span class="fontsize28 colorred fontbold" style="text-decoration:underline;">
                    <cfoutput>#getinfo.discountCode#</cfoutput>
                </span><br>

                <span class="fontsize11 fontbold">LOCK IN AUTOMATIC DISCOUNTS ON YOUR MOVE BY</span><br>

                <span class="fontsize28 colorred fontbold">
                    <cfif len(trim(getinfo.appointment_date))>
                        <cfoutput>#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</cfoutput>
                    <cfelse>
                        Appointment Date
                    </cfif>
                </span><br>

                <span class="fontsize16 colorred fontbold">ACTIVATE NOW!</span><br>

                <span class="fontsize12 colorred">HURRY! BEFORE YOUR OFFER EXPIRES</span>
            </div>

        </td>

        <td width="30%" align="right" valign="center" class="qr-code-mobile">
            <img src="http://www.top12movingbiz.com/admin/images/QR.png" width="160" style="margin-top:0px;">
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px; margin-bottom:15px"  class="discount-card-table">
  <tr>

    <td width="55%" valign="top" align="center" class="mobile-padding discount-card-wrapper">

    <div class="discount-card-container">

        <div class="discount-card-inner">

            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>

                    <td width="35%" valign="top" align="left">
                        <img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg"
                             style="width:85px; margin-top:4px; margin-left:15px" class="card-logo-mobile">

                        <div class="card-services" style="font-size:9px; color:#0070C0; margin-top:5px; text-align:left; line-height:1;">
                            <ul style="margin:0; padding-left:10px; list-style-position:inside;">
                                <li>Local Moves</li>
                                <li>Long Distance Moves</li>
                                <li>Storage</li>
                                <li>Moving Help</li>
                            </ul>
                        </div>
                    </td>

                    <td width="65%" valign="top" style="padding-left:7px;">

                        <div class="card-title" style="font-size:14px; font-weight:bold; color:#003087; text-align:center;">
                            MOVE DISCOUNT CARD
                        </div>

                        <div class="card-text" style="font-size:10px; font-weight:bold; color:#003087; text-align:center; margin-top:8px;">
                            FREE MOVING ESTIMATE
                        </div>

                        <div class="card-text" style="font-size:10px; font-weight:bold; color:#003087; text-align:center; margin-top:8px;">
                            UP TO 40% DISCOUNT ON MOVING
                        </div>

                        <div class="card-code-title" style="font-size:14px; font-weight:bold; color:#003087; text-align:center; margin-top:8px;">
                            MOVE DISCOUNT CODE
                        </div>

                        <div class="card-code" style="font-size:20px; font-weight:bold; color:red; text-align:center; margin-top:8px;">
                            <cfoutput>#getinfo.discountCode#</cfoutput>
                        </div>

                    </td>
                </tr>
            </table>
            

            <div class="card-contact" style="font-size:8.5px; margin-top:8px; color:#0070C0; text-align:left;">
                Click to CALL/TEXT:
                <a href="tel:1-800-976-6833" style="color:#0070C0; font-weight:bold; text-decoration:none;">
                    1-800-976-6833
                </a><br>

                Click to CHAT or SET UP APPOINTMENT:
                <a href="https://www.nationwideusamovers.com" style="color:#0070C0; font-weight:bold; text-decoration:none;">
                    www.nationwideusamovers.com
                </a>
            </div>

        </div>
    </div>

</td>

    <!--- Desktop Contact Section --->
    <td width="45%" valign="center" align="center" style="padding-left:15px;" class="contact-desktop">

        <div style="line-height:1.35;">
            <span class="fontsize24 fontbold" style="font-style:italic;">CALL US</span>
            <span class="fontsize14 fontbold"> MON-SUN 7am-9pm</span><br>

            <span class="fontsize18 fontbold">TOLL LINE 1-800-976-6833</span><br><br>

            <span class="fontsize18 fontbold">OR GO ONLINE TO</span><br>
            <a href="https://www.nationwideusamovers.com" style="color:#0070C0; font-weight:bold; font-size:18px; text-decoration:underline;">
                www.nationwideusamovers.com
            </a><br><br>

            <span class="fontsize18 fontbold">OR SCAN THE QR CODE ABOVE</span>
        </div>

    </td>

  </tr>
</table>

<!-- MOBILE CONTACT SECTION – BULLETPROOF iOS CENTERING -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"
       class="contact-mobile"
       align="center"
       style="margin:0px auto;">
  <tr>
    <td align="center">

      <!-- FIXED WIDTH CENTER BLOCK (CRITICAL) -->
      <table width="600" border="0" cellspacing="0" cellpadding="0"
             align="center"
             style="margin:15px auto; text-align:center;">
        <tr>
          <td align="center" style="text-align:center; padding:15px 10px;">

            <span style="display:block; font-size:24px; font-weight:bold; font-style:italic; margin-top:75px">
              CALL US
            </span>

            <span style="display:block; font-size:16px; font-weight:bold; margin-top:10px">
              MON-SUN 7am-9pm
            </span>

            <br>

            <span style="display:block; font-size:18px; font-weight:bold;">
              TOLL LINE 1-800-976-6833
            </span>

            <br>

            <span style="display:block; font-size:18px; font-weight:bold;">
              OR GO ONLINE TO
            </span>

            <!-- CENTER LINK (iOS NEEDS ITS OWN TABLE) -->
            <table border="0" cellspacing="0" cellpadding="0" align="center" style="margin:0 auto;">
              <tr>
                <td align="center">
                  <a href="https://www.nationwideusamovers.com"
                     style="display:block;
                            font-size:18px;
                            font-weight:bold;
                            color:#0070C0;
                            text-decoration:underline;
                            text-align:center;">
                    www.nationwideusamovers.com
                  </a>
                </td>
              </tr>
            </table>

            <br>

            <span style="display:block; font-size:18px; font-weight:bold;">
              OR SCAN THE QR CODE ABOVE
            </span>

          </td>
        </tr>
      </table>
      <!-- END FIXED WIDTH -->

    </td>
  </tr>
</table>



<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
  <tr>
    <td align="center" class="footer-section mobile-padding">

        <div class="fontsize12 fontbold">
            Nationwide Services provided in <span style="text-decoration:underline;">ALL 50 STATES</span>
        </div>
        <div class="fontsize12 fontbold" style="margin:5px 0;">
            Long Distance Moves - Local Moves - Containerized Moves - Storage Moves - Professional Moving Help
        </div>

        <div class="social-icons" style="margin:4px 0;">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/facebook.png" width="17" style="margin:0 2px; display:inline-block;" alt="Facebook">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/instagram.png" width="17" style="margin:0 2px; display:inline-block;" alt="Instagram">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/linkedin.png" width="17" style="margin:0 2px; display:inline-block;" alt="LinkedIn">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/twitter.png" width="17" style="margin:0 2px; display:inline-block;" alt="Twitter">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/google.png" width="17" style="margin:0 2px; display:inline-block;" alt="Google">
        </div>

        <div class="fontsize9" style="color:#555555; margin:4px 0;">
            NATIONWIDE USA MOVERS IS A FEDERALLY LICENSED AND AUTHORIZED MOVE MANAGEMENT COMPANY MC# 945837 USDOT# 3558324
        </div>
    </td>
  </tr>
</table>

</body>
</html>