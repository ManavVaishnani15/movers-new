<cfparam name="REQUEST.letter_body" default="">

<style>
	table{
		font-family:calibri;
	}

	.fontbold{
		font-weight:bold;
	}
	
	.fontstyleitalic{
		font-style:italic;
	}
	
	.colornavy{
		color:#002060;
	}
	
	.colorred{
		color:#ff0000;
	}
	
	/* begin fontsize classes */
	.fontsize5{
		font-size:0.35em;
	}
	.fontsize6{
		font-size:6px;
	}
	
	.fontsize7{
		font-size:7px;
	}
	
	.fontsize8{
		font-size:8px;
	}
	
	.fontsize9{
		font-size:9px;
	}
	
	.fontsize10{
		font-size:10px;
	}
	
	.fontsize11{
		font-size:11px;
	}
	
	.fontsize12{
		font-size:12px;
	}
	
	.fontsize14{
		font-size:14px;
	}
	
	.fontsize16{
		font-size:16px;
	}
	
	.fontsize18{
		font-size:18px;
	}
	
	.fontsize20{
		font-size:20px;
	}
	
	.fontsize24{
		font-size:24px;
	}
	.fontsize26{
		font-size:26px;
	}
	.fontsize28{
		font-size:28px;
	}

	.fontsize32{
		font-size:32px;
	}
	/* end fontsize classes */
	
	
	/* begin width classes */
	.width10p{
		width: 10%;
	}
	.width15p{
		width: 15%;
	}
	.width18p{
		width: 18%;
	}
	.width20p{
		width: 20%;
	}
	.width21p{
		width: 21%;
	}
	.width25p{
		width: 25%;
	}
	.width28p{
		width: 28%;
	}
	.width30p{
		width: 30%;
	}
	
	.width35p{
		width:35%;
	}
	
	.width40p{
		width: 40%;
	}
	.width42p{
		width:42%;
	}
	.width85p{
		width:85%;
	}
	.width38p{
		width:38%;
	}
	.width39p{
		width:39%;
	}
	.width50p{
		width:50%;
	}
	.width60p{
		width:60%;
	}
	.width80p{
		width:80%;
	}
	.width100p{
		width: 100%;
	}
	.width70p{
		width: 70%;
	}
	.width75p{
		width: 75%;
	}
	.width78p{
		width: 78%;
	}
	.width80p{
		width: 80%;
	}
	
	.width81p{
		width: 81%;
	}
	.width82p{
		width: 82%;
	}
	.width85p{
		width: 85%;
	}
	.width90p{
		width: 90%;
	}
	.height75p{
		height:75px;
	}
	.height84p{
		height:84px;
	}
	.height85p{
		height:85px;
	}
	.height86p{
		height:86px;
	}
	.height88p{
		height:88px;
	}
	.height90p{
		height: 90px;
	}
	height91p{
		height:91px;
	}
	.heightCustomize85p{
		height:85px;
	}
	.heightCustomize67p{
		height:67px;
	}
	/* end width classes */
	
	/* begin vertical align classes */
	.vertical-align-top{
		vertical-align:top;
	}
	/* end vertical align classes */
	
	.line-height-letter{
		line-height: 1.7em;
	}
	
	.text-align-center{
		text-align:center;
	}
	
	.text-underline{
		text-decoration:underline;
	}
	p {
		line-height: 130%;
	}
	
</style>

<cfoutput>
	<table class="width100p" align="center" border="1" cellpadding="0" cellspacing="0"<!--- style="margin-top:-10px"--->>
			<tr>
				<td  align="center" class="width25p">
					<img src="http://www.top12movingbiz.com/admin/letters/images/New Logo for Letter.png" alt="" border="0" class="width70p" style="text-align:left;"/><br>
					<span class="fontsize5 fontbold colornavy width100p text-align-center">OVER 30 YEARS IN THE MOVING INDUSTRY</span>
				</td>
				<td align="center" class="width42p">
					<span class="fontbold fontsize32 colornavy width100p">MOVING SOON?</span>
				</td>
				<td align="center" class="width20p vertical-align-top">
					#dateformat(now(), "MM/DD/YYYY")#
				</td>
			</tr><br>
			<!---<tr>
				<td colspan="3">
					<!---&nbsp;--->
				</td>
				
			</tr>--->
			<tr>
				<td colspan="3" class="line-height-letter">
					#trim(REQUEST.letter_body)#<br>
					<p class="fontbold fontsize14 text-align-center">
						Vanlinequotes.com is your “<span class="text-underline">ONE STOP SHOP</span>” for moving quotes<br>
					</p>
					<span class="fontsize12">
						Get a variety of quotes from Major Van Lines and Professionally Licensed Moving Companies, in one email. Additionally
vanlinequotes.com will be at your side 7 days a week managing and monitoring your move from start to finish.
					</span>
				</td>
			</tr>
			<tr>
				<td class="width20p">
					<img src="http://www.top12movingbiz.com/admin/letters/images/residential.png" alt="" border="0" class="width90p height86p" />
				</td>
				
				<td class="width40p">
					<img src="http://www.top12movingbiz.com/admin/letters/images/postcard THUMBNAIL NEW.png" alt="" border="0" class="width78p height91p" style="margin-left:23px;"/>
				</td>
				<td class="width20p">
					<img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_together_2.png" alt="" border="0" class="width100p height85p" />
				</td>
			</tr>
			<tr>
				<td colspan="3" class="fontbold fontsize26 colornavy text-align-center">
					LOCK-IN UP TO 40% IN MOVE SAVINGS NOW!!
				</td>
			</tr>
		</table>
			<table class="width100p" align="center" border="0">
			<tr>
				<td <!---class="width10p"---> style="width:22%">
					<img src="http://www.top12movingbiz.com/admin/letters/images/bring_something_in_stairs.png" alt="" border="0" class="width85p height84p" />
				</td>
				<td class="width40p line-height-letter text-align-center">
					<span class="fontbold fontsize20 colornavy">
						TEXT “QUOTES” TO 474747
					</span>
					
					<p class="fontbold fontsize20 colornavy text-align-center" style="margin-top:0;margin-bottom:0;">
						OR
					</p>
					
					<span class="fontbold fontsize24 colorred">
						CALL 1-800-976-6833
					</span>
					
				</td>
				<td class="width20p" align="right">
					<img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_together_1.png" alt="" border="0" class="width90p height84p" style="margin-right:6px;" />
				</td>
			</tr>
			</table>
			<table class="width100p" align="center" border="0">
			<tr>
				<td <!---class="width20p"--->  style="width:18%">
					<img src="http://www.top12movingbiz.com/admin/letters/images/What-to-know-when-designing-high-rise-buildings.jpg" alt="" border="0" class="width100p height84p" />
				</td>
				<td class="width40p line-height-letter vertical-align-top">
					<span class="fontbold fontsize12 fontstyleitalic" style="margin-left:100px;position:absolute;margin-bottom:43px;">
						7 DAYS A WEEK 7am-9pm
					</span>
					
					<p class="fontbold fontsize20 colornavy" style="margin-top:28px;margin-bottom:20px;margin-left:66px;position:absolute">
						OR VISIT US ONLINE AT
					</p>
					
					<span class="fontbold fontsize18 colornavy" style="margin-left:66px;position:absolute;margin-top:55px">
						www.vanlinequotes.com
					</span>
				</td>
				<td class="width20p" align="right">
					<img src="http://www.top12movingbiz.com/admin/letters/images/happy_in_room.JPG" alt="" border="0" class="width85p height84p" style="margin-right:6px;"/>
				</td>
			</tr><br>
			<tr>
				<td colspan="3" class="fontbold fontsize11 text-align-center">
					RESERVE YOUR FUTURE MOVE SAVINGS TODAY AND RECEIVE A GIFT CARD WHEN BOOKING<br />
					TEXT “QUOTES” RIGHT NOW TO 474747<br />
					OR MENTION YOUR MOVE DISCOUNT CODE IF CALLING OR GOING ONLINE TO SET UP TO GET YOUR QUOTES<br />
					FREE VIRTUAL ESTIMATE- 20 min OR LESS
				</td>
			</tr>
			</table>
			<br />
			<table class="width100p" align="center" border="0">
			<tr>
				<td class="width18p">
					<img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_with_phone.png" alt="" border="0" class="width100p height84p"/>
				</td>
				<td class="width40p line-height-letter">
					<table  class="width100p" align="center" border="1">
						<tr>
							<td class="width28p vertical-align-top" align="right">
								<img src="http://www.top12movingbiz.com/admin/letters/images/Best price guaranted no background.png" alt="" border="0" class="width100p" style="margin-left:0px;margin-top:0" />
							</td>
							<td>
								<span class="fontbold fontsize14 colorred" style="margin-left:-50px;position:absolute;margin-top:-40px">
									MOVE DISCOUNT CODE<br />
									#getInfo.discountCode#<br />
								</span>
								
								<span class="fontbold fontsize10 colorred" style="margin-left:-50px;position:absolute;margin-top:15px">
									EXPIRES IN <span class="text-underline">30</span> DAYS
								</span>
							</td>
						</tr>
					</table>
				</td>
				<td class="width20p" align="right">
					<img src="http://www.top12movingbiz.com/admin/letters/images/take_photo_of_living_room.png" alt="" border="0" class="width85p" style="margin-right:6px;" />
				</td>
			</tr>
			</table><br>
			<table  class="width100p" align="center" border="0">
			<tr>
				<td class="text-align-center" align="left" style="width:17%">
					<img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo-balboa-capital-png-1.png" alt="" border="0" <!---class="width100p"---> style="width:80%;" />
				</td>
				<td colspan="2" class="fontbold fontsize8">
					Vanlinequotes.com is a Federally Licensed & FMCSA Authorized Move Manager & Broker MC ## 945837 USDOT ## 2867211 
				</td>
			</tr>
		</table>
</cfoutput>