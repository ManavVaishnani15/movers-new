<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
            select * from CLIENTS
            where id=#clientid#
        </cfquery>
    </cfif>

<cfif parameterexists(un) is 'no'> <b>Log In</b>
    <br>
    <form action="main.cfm" method="post">
        username
        <input type="text" name="username" size="15">
        <br>
        password
        <input type="password" name="password" size="15">
        <br>
        <input type="submit" value="Log In">
    </form>
    <cfabort>
<cfelse>
    <cfquery name="verify" datasource="aaalh3x_onestep">
        select * from MEMBERS
        where username='#un#' and temp_pw=#pw# and active=1
    </cfquery>
    <cfif #verify.recordcount# is 0>
        <b>Log In</b>
        <br>
        <form action="main.cfm" method="post">
            username
            <input type="text" name="username" size="15">
            <br>
            password
            <input type="password" name="password" size="15">
            <br>
            <input type="submit" value="Log In">
        </form>
        <cfabort>
    </cfif>
</cfif>
<cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from CLIENTS
    where id=#clientid#
</cfquery>


<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="100">
<style type="text/css">
.tableClass {
	font-family:Arial, Helvetica, sans-serif;
	font-size:18px;	
}
.greenText {
	color:#090;	
}
.redText {
	color:#F00;
	font-size:20px;
	font-weight:bold;
}
</style>
<BR>
<table width="1000" border="0" cellspacing="0" cellpadding="0" background="http://www.top12movingbiz.com/admin/letters/images/mayflowerFlyer.jpg" align="center">
  <tr>
    <td height="1268" valign="bottom"><table width="95%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="43%">&nbsp;</td>
        <td width="57%">
				<table width="100%" border="0" cellspacing="2" cellpadding="0" class="tableClass">
                    <tr>
                      <td><table width="100%" border="0" cellspacing="2" cellpadding="0" class="tableClass">
                        <tr>
                          <td width="50%" valign="top">Anthony Booker<br>
                            AMSA Certified<br>
                            Moving Consultant<br>
                            abooker@move-estimator.com</td>
                          <td valign="top"><strong>Local Office Numbers:</strong><br>
                            <span class="greenText">Washington DC: 202-602-2295<br>
                            Maryland: 301-200-3656<br>
                            Virginia: 703-259-9010</span><br><br></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td class="tableClass"><br>
                        <CFOUTPUT>
                        <strong>This move offer entitles #getinfo.first_name# #getinfo.last_name# or Current Occupant at
                        #getInfo.from_address# to a Free In-Home Estimate, substantial savings on
                        moving services and a special incentive.</strong><br></CFOUTPUT></td>
                    </tr>
                    <tr>
                      <td align="center"><span class="redText"><br>
                      MOVE OFFER CODE<br>
                      </span></td>
                    </tr>
                    <tr>
                      <td align="center" class="redText"><cfoutput>#getInfo.discountCode#</cfoutput></td>
                    </tr>
                  </table>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</cfdocument>
                
<CFELSE>
<style type="text/css">
.tableClass {
	font-family:Arial, Helvetica, sans-serif;
	font-size:18px;	
}
.greenText {
	color:#090;	
}
.redText {
	color:#F00;
	font-size:20px;
	font-weight:bold;
}
</style>
<BR>
<table width="1000" border="0" cellspacing="0" cellpadding="0" background="http://www.top12movingbiz.com/admin/letters/images/mayflowerFlyer.jpg" align="center">
  <tr>
    <td height="1268" valign="bottom"><table width="95%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="43%">&nbsp;</td>
        <td width="57%">
				<table width="100%" border="0" cellspacing="2" cellpadding="0" class="tableClass">
                    <tr>
                      <td><table width="100%" border="0" cellspacing="2" cellpadding="0" class="tableClass">
                        <tr>
                          <td width="50%" valign="top">Anthony Booker<br>
                            AMSA Certified<br>
                            Moving Consultant<br>
                            abooker@move-estimator.com</td>
                          <td valign="top"><strong>Local Office Numbers:</strong><br>
                            <span class="greenText">Washington DC: 202-602-2295<br>
                            Maryland: 301-200-3656<br>
                            Virginia: 703-259-9010</span><br><br></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td class="tableClass"><br>
                        <CFOUTPUT>
                        <strong>This move offer entitles #getinfo.first_name# #getinfo.last_name# or Current Occupant at
                        #getInfo.from_address# to a Free In-Home Estimate, substantial savings on
                        moving services and a special incentive.</strong><br></CFOUTPUT></td>
                    </tr>
                    <tr>
                      <td align="center"><span class="redText"><br>
                      MOVE OFFER CODE<br>
                      </span></td>
                    </tr>
                    <tr>
                      <td align="center" class="redText"><cfoutput>#getInfo.discountCode#</cfoutput></td>
                    </tr>
                  </table>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</cfif>