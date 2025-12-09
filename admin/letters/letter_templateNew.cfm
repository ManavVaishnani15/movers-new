<cfparam name="REQUEST.letter_body" default="">

<style>
    table { font-family: Calibri, sans-serif; }
    body { font-family: Calibri, sans-serif; }
    div, span, p, a { font-family: Calibri, sans-serif; }

    .fontbold { font-weight: bold; }
    .colorred { color: #ff0000; }
    .colorblue { color: #0070C0; }

    /* Font sizes - optimized for PDF fit */
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

    /* Optimized spacing for PDF */
    table { border-spacing: 0; }
    td { padding: 2px 3px; line-height: 1.15em; }
    
    body { margin: 0; padding: 8px; }

</style>


<!-- HEADER -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="15%" align="left">
        <img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="100px" alt="Nationwide USA Movers">
    </td>
    <td width="70%">&nbsp;</td>
    <td width="15%" align="right" valign="bottom">
        <p class="fontsize12 fontbold" style="margin:0; padding-top:8px;">
            <cfoutput>#dateFormat(now(), "MM/DD/YYYY")#</cfoutput>
        </p>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:8px;">
  <tr><td><cfoutput>#trim(REQUEST.letter_body)#</cfoutput></td></tr>
</table>

<!-- MOVE DISCOUNT CODE SECTION -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
    <tr>
        <!-- LEFT: Discount Code Info -->
        <td width="70%" align="center" valign="center">

            <div style="line-height:1.25; padding-left:150px;">
                <span class="fontsize18 fontbold">Move Discount Code</span><br>

                <span class="fontsize24 colorred fontbold" style="text-decoration:underline;">
                    <cfoutput>#getinfo.discountCode#</cfoutput>
                </span><br>

                <span class="fontsize14 fontbold">LOCK IN AUTOMATIC DISCOUNTS ON YOUR MOVE BY</span><br>

                <span class="fontsize24 colorred fontbold">
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

        <!-- RIGHT: QR Code -->
        <td width="30%" align="right" valign="center">
            <img src="C:\lucee\tomcat\webapps\ROOT\movers\admin\images\QR.png" width="160" style="margin-top:0px;">
        </td>
    </tr>
</table>

<!-- MOVE DISCOUNT CARD + CALL US SECTION -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:18px;">
  <tr>

    <!-- LEFT: MOVE DISCOUNT CARD -->
    <td width="48%" valign="top" align="center">

		<div style="
			width: 280px;
			border: 2px solid #ddd;
			border-radius: 25px;
			padding: 10px;
			background: #f8f9fa;
			box-shadow: 0 2px 6px rgba(0,0,0,0.1);
		">

			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>

					<!-- LEFT: LOGO -->
					<td width="35%" valign="top" align="left">
						<img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg"
							style="width:80px; margin-top:4px;">
					</td>

					<!-- RIGHT: TEXT -->
					<td width="65%" valign="top" style="padding-left:7px;">

						<div style="font-size:14px; font-weight:bold; color:#003087; line-height:1.25em;">
							MOVE DISCOUNT CARD
						</div>

						<div style="font-size:10px; font-weight:bold; color:#003087; margin-top:1px; line-height:1.25em;">
							FREE MOVING ESTIMATE
						</div>

						<div style="font-size:10px; font-weight:bold; color:#003087; line-height:1.25em;">
							UP TO 40% DISCOUNT ON MOVING
						</div>

						<div style="font-size:14px; font-weight:bold; color:#003087; margin-top:3px; line-height:1.25em;">
							MOVE DISCOUNT CODE
						</div>

						<div class="colorred" style="font-size:18px; font-weight:bold; margin-top:1px; letter-spacing:0.5px;">
							<cfoutput>#getinfo.discountCode#</cfoutput>
						</div>
					</td>
				</tr>
			</table>

			<!-- BULLETS -->
			<div style="font-size:9.5px; color:#0070C0; margin-top:6px; text-align:left; line-height:1.35em;">
				• Local Moves <br>
				• Long Distance Moves <br>
				• Storage <br>
				• Moving Help <br>
			</div>

			<!-- CONTACT LINES -->
			<div style="font-size:8.5px; margin-top:6px; color:#0070C0; text-align:left; line-height:1.35em;">
				<span>Click to CALL/TEXT:</span>
				<a href="tel:1-800-976-6833" style="color:#0070C0; font-weight:bold; text-decoration:none;">
					1-800-976-6833
				</a>
				<br>
				<span>Click to CHAT or SET UP APPOINTMENT:</span>
				<a href="https://www.nationwideusamovers.com" style="color:#0070C0; font-weight:bold; text-decoration:none;">
					www.nationwideusamovers.com
				</a>
			</div>

		</div>
    </td>

    <!-- RIGHT: CALL US BLOCK -->
    <td width="52%" valign="top" align="center" style="padding-left:15px;">

        <div style="line-height:1.35;">
            <span class="fontsize28 fontbold" style="font-style:italic;">CALL US</span>
            <span class="fontsize14 fontbold"> MON-SUN 7am-9pm</span><br>

            <span class="fontsize20 fontbold">TOLL LINE 1-800-976-6833</span><br><br>

            <span class="fontsize20 fontbold">OR GO ONLINE TO</span><br>
            <a href="https://www.nationwideusamovers.com" style="color:#0070C0; font-weight:bold; font-size:20px; text-decoration:underline;">
                www.nationwideusamovers.com
            </a><br><br>

            <span class="fontsize20 fontbold">OR SCAN THE QR CODE ABOVE</span>
        </div>

    </td>

  </tr>
</table>

<!-- FOOTER -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
  <tr>
    <td align="center">

        <span class="fontsize14 fontbold">
            Nationwide Services provided in <span style="text-decoration:underline;">ALL 50 STATES</span>
        </span><br>
        <span class="fontsize14 fontbold">
            Long Distance Moves - Local Moves - Containerized Moves - Storage Moves - Professional Moving Help
        </span>
        <br>

        <!-- Social Media Icons -->
        <div style="margin:2px 0;">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/facebook.png" width="17" style="margin:0 2px;" alt="Facebook">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/instagram.png" width="17" style="margin:0 2px;" alt="Instagram">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/linkedin.png" width="17" style="margin:0 2px;" alt="LinkedIn">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/twitter.png" width="17" style="margin:0 2px;" alt="Twitter">
            <img src="http://www.top12movingbiz.com/admin/letters/images/social/google.png" width="17" style="margin:0 2px;" alt="Google">
        </div>

        <span class="fontsize9">
            NATIONWIDE USA MOVERS IS A FEDERALLY LICENSED AND AUTHORIZED MOVE MANAGEMENT COMPANY MC# 945837 USDOT# 3558324
        </span>
    </td>
  </tr>
</table>