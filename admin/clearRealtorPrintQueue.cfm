<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYY-MM-DD")#>
<cfif parameterexists(keyword) is 'no'>
<cfset keyword=''>
</cfif>
<cfif parameterexists(searchacct) is 'no'>
<cfset searchacct=''>
</cfif>
<cfif parameterexists(type) is 'no'>
<cfset type=''>
</cfif>


<html>
<head>
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

    <cfquery name="printQueue" datasource="aaalh3x_onestep">
        update realtor_printQueue
            set cleared=1
        where (memberId is null or memberId=#verify.id#)
            <cfif isDefined('url.type') and url.type is "followUp">
                and (printType='followUp' OR printType='MayflowerfollowUp')
            <cfelse>
                and (printType <> 'followUp' AND printType <> 'MayflowerfollowUp')
            </cfif>
            <cfif isDefined('url.type') and url.type is "hanger">
                and hanger=1
            <cfelse>
                and hanger=0
            </cfif>
        and printed=0
        and cleared=0
    </cfquery>
<cflocation url="mainRealtor.cfm?un=#un#&pw=#pw#" addtoken="no" />
