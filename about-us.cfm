<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Top12MovingBiz - About Us</title>
		<cfif parameterexists(affid) is 'no'>
		<cfinclude template="affdet.cfm"></cfif>
		<STYLE>
		<!--
		A{text-decoration:none}
		-->
		</STYLE>
	</head>
	<body bgcolor="#f0f0f0" background="images/background.jpg" topmargin="0" leftmargin="0">
		<div align="center">
			<table border="0" cellspacing="0" cellpadding="0" width="1000">
				<tr>
					<td width="25">
					<IMG alt="Free Moving Quote" src="images/moving-quote-tl.jpg" width =25 height=324 ></TD>
					<td width="454" valign="top">
						<table border="0" cellspacing="0" cellpadding="0" width="454">
							<tr>
								<td width="454" valign="top">
								<IMG alt=Top12MovingBiz src="images/top12movingbiz.jpg" width=454 height=56></TD>
							</TR>
							<tr>
								<td width="454" valign="top" bgcolor="#f0f0f0" style="BACKGROUND: none transparent scroll repeat 0% 0%"
									> <font face="arial" size="6" color="#3f2a51">You promote our services,
									<br>
									we will take care of the
									rest.
									</FONT>
									<br>
									<br> <font face="arial" size="2" color="#252932">You can make income helping us to provide as many as a dozen quotes from
									<BR>
									different moving companies to homeowners. Whether they are moving
									<br>
									a short distance or long distance, moving household goods or
									<br>
									commercial office equipment, we provide everything they need
									<br>
									to get moving - and you
									get paid for helping us find them!
									</FONT>
								</TD>
							</TR>
						</TABLE>
					</TD>
					<td width="527" valign="top">
					<IMG alt="Relocation Quotes" src="images/moving-relocation.jpg" width=527 height=324 ></TD>
				</TR>
			</TABLE>
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
				<tr>
					<td bgcolor="#332846" height="47">
						<div align="center">
							<a href="index.cfm?a=a<cfif parameterexists(affid) is 'yes'>
								<cfoutput>&affid=#affid#</cfoutput>
								</cfif>
								">
								<IMG border=0 alt="Home Page" src="images/home-off.jpg" width =210 height=47 /></a>
								<A href="signup.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
								<IMG border=0 alt="Partner Signup" src="images/partner-signup-off.jpg" width =239 height=47 ></A>
								<IMG border=0 alt="About Top12MovingBiz" src="images/about-us-on.jpg" width =181 height=47 >
								<A href="benefits.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
								<IMG border=0 alt="Partner Benefits" src="images/benefits-off.jpg" width =333 height=47 ></A>
							</DIV>
						</TD>
					</TR>
				</TABLE>
				<table border="0" cellspacing="0" cellpadding="5" width="1000">
					<tr>
						<td width="1000">
							<br>
							<font face="arial" size="4" color="182430"> <b>About Us</b></font>
							<br>
						<br></TD>
					</TR>
				</TABLE>
				<table border="0" cellspacing="0" cellpadding="0" width="1000">
					<tr>
						<td bgcolor="332846">
							<br>
							<font face="arial" size="2" color="white">
							Copyright 2014-
							<cfoutput>#dateformat(now(), "YYYY")#</cfoutput>
							Top12MovingBiz.com
							</FONT>
							<br>
						<br></TD>
					</TR>
				</TABLE>
				<table border="0" cellspacing="0" cellpadding="0" width="1000">
					<tr>
						<td width="208" valign="middle">
						<IMG border=0 alt=Top12MovingBiz.com src="images/top12movers-logo.jpg" width=208 height=157></TD>
						<td width="798" valign="middle">
							<!--- <div style="float:right;">
															<img src="/admin/letters/images/bbb-logo.jpg" style="border: 0;width: 75px; height:auto;" alt="Top 12 Movers BBB Business Review">
														</div> --->
							<div align="center">
								<A href="index.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d">HOME</FONT>
								</A>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<A href="signup.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d"
									>PARTNER SIGNUP</FONT>
								</A>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<A href="about-us.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d"
									>ABOUT US</FONT>
								</A>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<A href="contact-us.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d"
									>CONTACT US</FONT>
								</A>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<A href="login.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d">PARTNER&nbsp;LOGIN</FONT>
								</A>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<A href="privacy.cfm?a=a<cfif parameterexists(affid) is 'yes'>
									<cfoutput>&affid=#affid#</cfoutput>
									</cfif>
									">
									<font face="arial" size="3" color="#576c7d">PRIVACY</FONT>
								</A>
							</DIV>
						</TD>
					</TR>
				</TABLE>
			</DIV>
		</body>
	</html>