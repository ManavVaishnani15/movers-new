<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Top12MovingBiz - Partner Signup Form</title>
<cfif parameterexists(affid) is 'no'><cfinclude template="affdet.cfm"></cfif>
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
<td width="25"><IMG alt="Free Moving Quote" src="images/moving-quote-tl.jpg" width =25 height=324 ></TD>
<td width="454" valign="top">
 <table border="0" cellspacing="0" cellpadding="0" width="454">
 <tr>
 <td width="454" valign="top"><IMG alt=Top12MovingBiz src="images/top12movingbiz.jpg" width=454 height=56></TD></TR>
 <tr>
 <td width="454" valign="top" bgcolor="#f0f0f0" style="BACKGROUND: none transparent scroll repeat 0% 0%" 
         ><font face="arial" size="6" color="#3f2a51">You promote our services,<br>we will take care of the 
            rest.</FONT><br><br>
<font face="arial" size="2" color="#252932">You can make income helping us to provide as many as a dozen quotes from<BR>
different moving companies to homeowners. Whether they are moving<br>
a short distance or long distance, moving household goods or<br>
commercial office equipment, we provide everything they need<br>
to get moving - and you 
            get paid for helping us find them!</FONT> </TD></TR></TABLE></TD>
<td width="527" valign="top"><IMG alt="Relocation Quotes" src="images/moving-relocation.jpg" width=527 height=324 ></TD></TR></TABLE>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
<tr>
<td bgcolor="#332846" height="47"><div align="center"><a href="index.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><IMG border=0 alt="Home Page" src="images/home-off.jpg" width =210 height=47 ><IMG border=0 alt="Partner Signup" src="images/partner-signup.jpg" width =239 height=47 ><A href="about-us.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><IMG border=0 alt="About Top12MovingBiz" src="images/about-us-off.jpg" width =181 height=47 ></A><A href="benefits.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><IMG border=0 alt="Partner Benefits" src="images/benefits-off.jpg" width =333 height=47 ></A></DIV></TD></TR></TABLE>
<table border="0" cellspacing="0" cellpadding="5" width="1000">
<tr>
<td width="1000">

<br>
<font face="arial" size="4" color="182430"><b>Business Partner Signup Form</b></font><br>
<br>
<cfif parameterexists(fname) is 'no'><form action="signup.cfm" method="post">
<table border="0" cellspacing="0" cellpadding="3">
<tr><td valign="middle"><font face="arial" size="3">First Name</font></td><td valign="middle"><input type="text" name="fname" size="50"></td></tr><tr>
<tr><td valign="middle"><font face="arial" size="3">Last Name</font></td><td valign="middle"><input type="text" name="lname" size="50"></td></tr><tr>
<tr><td valign="middle"><font face="arial" size="3">Address</font></td><td valign="middle"><input type="text" name="address" size="50"></td></tr><tr>
<tr><td valign="middle"></font></td><td valign="middle"><input type="text" name="address2" size="50"></td></tr><tr>
<tr><td valign="middle"><font face="arial" size="3">City</font></td><td valign="middle"><input type="text" name="city" size="50"></td></tr>
<tr><td valign="middle"><font face="arial" size="3">State</font></td><td valign="middle"><select name="state"><option value="AL">AL</option>
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
                <option value="WY">WY</option></select><font face="arial" size="3"> &nbsp;&nbsp;Zip Code</font> <input tpye="text" name="zip" size="10"></td></tr>
<tr><td valign="middle"><font face="arial" size="3">Phone</font></td><td valign="middle"><input type="text" name="phone" size="10"></td></tr>
<tr><td valign="middle"><font face="arial" size="3">Cell</font></td><td valign="middle"><input type="text" name="cell" size="10"></td></tr>
<tr><td valign="middle"><font face="arial" size="3">Email</font></td><td valign="middle"><input type="text" name="email" size="50"></td></tr>
<tr><td colspan="2"><div align="right"><input type="submit" value="Submit"></div></td></tr>
<cfif parameterexists(affid) is 'yes'><input type="hidden" name="affid" value="#affid#"><cfelse><input type="hidden" name="affid" value="0"></cfif>
</table></form>
<br>


<cfelse><!--- fname exists --->
 <cfif parameterexists(verified) is 'no'>
  <cfif #fname# is ''><cfset error=1></cfif>
  <cfif #lname# is ''><cfset error=1></cfif>
  <cfif #address# is ''><cfset error=1></cfif>
  <cfif #city# is ''><cfset error=1></cfif>
  <cfif #zip# is ''><cfset error=1></cfif>
  <cfif #phone# is '' AND #cell# is ''><cfset error=1></cfif>
  <cfif #email# DOES NOT CONTAIN '.' OR #email# DOES NOT CONTAIN '@'><cfset error=1></cfif>
  <cfif parameterexists(error) is 'yes'>
  <!--- error on form --->
  <font face="arial" size="3" color="red"><b>Error on Form</b><br></font>
  <font face="arial" size="3" color="gray">
   <cfif #fname# is ''>- First Name is blank<br></cfif>
   <cfif #lname# is ''>- Last Name is blank<br></cfif>
   <cfif #address# is ''>- Address is blank<br></cfif>
   <cfif #city# is ''>- City is blank<br></cfif>
   <cfif #zip# is ''>- Zip Code is blank<br></cfif>
   <cfif #phone# is '' AND #cell# is ''>- Phone/Cell is blank (must supply at least one)<br></cfif>
   <cfif #email# DOES NOT CONTAIN '.' OR #email# DOES NOT CONTAIN '@'>- Email is invalid<br></cfif>
  <br></font>
  <font face="arial" size="3">Please make corrections and resubmit the form<br></font>
  <br><form action="signup.cfm" method="post">
  <table border="0" cellspacing="0" cellpadding="3">
  <tr><td valign="middle"><font face="arial" size="3">First Name</font></td><td valign="middle"><input type="text" name="fname" size="50"<cfif #fname# is not ''> value="<cfoutput>#fname#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">Last Name</font></td><td valign="middle"><input type="text" name="lname" size="50"<cfif #lname# is not ''> value="<cfoutput>#lname#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">Address</font></td><td valign="middle"><input type="text" name="address" size="50"<cfif #address# is not ''> value="<cfoutput>#address#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"></font></td><td valign="middle"><input type="text" name="address2" size="50"<cfif #address2# is not ''> value="<cfoutput>#address2#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">City</font></td><td valign="middle"><input type="text" name="city" size="50"<cfif #city# is not ''> value="<cfoutput>#city#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">State</font></td><td valign="middle"><select name="state"><option><cfoutput>#state#</cfoutput><option value="AL">AL</option>
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
                <option value="WY">WY</option></select><font face="arial" size="3"> &nbsp;&nbsp;Zip Code</font> <input tpye="text" name="zip" size="10"<cfif #zip# is not ''> value="<cfoutput>#zip#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">Phone</font></td><td valign="middle"><input type="text" name="phone" size="10"<cfif #phone# is not ''> value="<cfoutput>#phone#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">Cell</font></td><td valign="middle"><input type="text" name="cell" size="10"<cfif #cell# is not ''> value="<cfoutput>#cell#</cfoutput>"</cfif>></td></tr>
  <tr><td valign="middle"><font face="arial" size="3">Email</font></td><td valign="middle"><input type="text" name="email" size="50"<cfif #email# CONTAINS '.' and #email# CONTAINS '@'> value="<cfoutput>#email#</cfoutput>"</cfif></td>
  <tr><td colspan="2"><div align="right"><input type="submit" value="Submit"></div></td></tr>
  <input type="hidden" name="affid" value="<cfoutput>#affid#</cfoutput>">
  </table></form>

  <Cfelse><!--- no error on form, no verification --->
  
  <font face="arial" size="3" color="orange"><b>Verify Your Information</b></font><br><br>
  <font face="arial" size="3">
  <cfoutput>
  #fname# #lname#<br>
  #address#<br>
   <cfif #address2# is not ''>#address2#<br></cfif>
  #city#, #state# #zip#<br>
  <cfif #phone# is not ''>Phone: #phone#<br></cfif>
  <cfif #cell# is not ''>Cell: #cell#<br></cfif>
  #email#<br><br>
  </cfoutput>
  If the information displayed above is incorrect, use your browsers 'Back' button to make any needed corrections<br><br>
  If the information displayed above is correct, click the 'Submit' button below.<br><br>
  </font>
  <form action="signup.cfm" method="post">
  <cfoutput>
  <input type="hidden" name="fname" value="#fname#">
  <input type="hidden" name="lname" value="#lname#">
  <input type="hidden" name="address" value="#address#">
  <input type="hidden" name="address2" value="#address2#">
  <input type="hidden" name="city" value="#city#">
  <input type="hidden" name="state" value="#state#">
  <input type="hidden" name="zip" value="#zip#">
  <input type="hidden" name="phone" value="#phone#">
  <input type="hidden" name="cell" value="#cell#">
  <input type="hidden" name="email" value="#email#">
  <input type="hidden" name="verified" value="1">
  <input type="hidden" name="affid" value="#affid#">
  </cfoutput>  
  <input type="submit" value="Submit"></form>
  </cfif><!--- ends error exists --->
 <cfelse><!--- form complete, verified exists, submit --->
 <cfset datenow='#dateformat(now(), "YYYY-MM-DD")#'>
 
 <cfquery name="addnew" datasource="aaalh3x_onestep">
 Insert into PARTNERS
 (fname,lname,address,address2,city,state,zip,phone,cell,email,active,signup_date,active_since_date,affid)
 values('#fname#','#lname#','#address#','#address2#','#city#','#state#','#zip#','#phone#','#cell#','#email#','1','#datenow#','#datenow#','#affid#')
 </cfquery>

<!---  ACTIVE STATES
 1 = active
 2 = pending
 3 = disabled
 4 = denied

 the 'active since_date' reflects the date that the ACTIVE feild was last updated 
 --->
 



 Email to Top12
 
#datenow# #timeformat(now(), "h:mm tt")#<br><br>
 
<b>#fname# #lname#</b><br>
#address#'<br>
 <cfif #address2# is not ''>#address2#<br></cfif>
#city#, #state# #zip#<br>
 <cfif #phone# is not ''>Phone: #phone#<br></cfif>
 <cfif #cell# is not ''>Cell: #cell#<br></cfif>
<a href="mailto:#email#">#email#</a><br>
<br>
 <cfif #affid# is not ''>
 #affid#<br>
 </cfif>
 
 
 
 Email to Signup
 
 
 
 
 </cfif><!--- ends verified exists --->
</cfif><!--- ends fname exists --->

</TD></TR></TABLE>
<table border="0" cellspacing="0" cellpadding="0" width="1000">
<tr><td bgcolor="332846"><br><font face="arial" size="2" color="white">Copyright 2014-<cfoutput>#dateformat(now(), "YYYY")#</cfoutput> Top12MovingBiz.com</FONT><br><br></TD></TR></TABLE>
<table border="0" cellspacing="0" cellpadding="0" width="1000">
<tr>
<td width="208" valign="middle"><IMG border=0 alt=Top12MovingBiz.com src="images/top12movers-logo.jpg" width=208 height=157></TD>
<td width="798" valign="middle"><div align="center">
<A href="index.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d">HOME</FONT></A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="signup.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d" 
     >PARTNER SIGNUP</FONT></A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="about-us.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d" 
     >ABOUT US</FONT></A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="contact-us.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d" 
     >CONTACT US</FONT></A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="login.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d">PARTNER&nbsp;LOGIN</FONT></A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="privacy.cfm?a=a<cfif parameterexists(affid) is 'yes'><cfoutput>&affid=#affid#</cfoutput></cfif>"><font face="arial" size="3" color="#576c7d" 
     >PRIVACY</FONT></A> 
  </DIV></TD></TR></TABLE></DIV>
</body>
</html>
