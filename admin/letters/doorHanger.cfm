<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
    <cfif parameterexists(clientid) is 'yes'>
        <cfquery name="getinfo" datasource="aaalh3x_onestep">
            select * from CLIENTS
            where id=#clientid#
        </cfquery>
    </cfif>
    <html>
<head>
        <title>
            <cfif parameterexists(clientid) is 'yes'>
                <cfoutput>#getinfo.first_name# #getinfo.last_name# Door Hanger</cfoutput>
            </cfif>
        </title> 
    <style>
        body {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:21px;
            font-family: arial, helvetica;
            font-weight:bold;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:23px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.7em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:23px;
        }
        .hangerDivOld {
            width:50%; 
            border:5px solid red;
        }
        .hangerMain {
            padding-top:140px;
            text-align: center;
        }
        div {
            font-weight:bold;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.6em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.6em;
            }
        }
    </style>
</head>
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

<body>

<cfoutput>
    <table style="width:99%">
        <tr>
            <td class="hangerDivOld">
                #printHanger()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDivOld">
                #printHanger()#
            </td>
        </tr>
    </table>    
</cfoutput>

</body>
</html>

<cffunction name="printHanger" returntype="string">
    <cfoutput>
    <div class="hangerMain">
        <h2 style="color:red;font-size:60px;margin-bottom:40px">URGENT!!!</h2>
        
        <div style="width:80%; margin-left:auto; margin-right: auto;">
            <div class="clientName">
                #getinfo.first_name# #getinfo.last_name#
            </div>
            <div>
                OR CURRENT OCCUPANT
            </div>
        </div>
        <div style="padding-top:20px;font-size:1.2em">
            #getInfo.from_address#<br>
            <cfif getInfo.from_address2 is not "">
                #getInfo.from_address2#<br>
            </cfif>
            #getInfo.from_city#, #getinfo.from_state# #getInfo.from_zip#
        </div>

        <div style="padding-top:20px;font-size:1.5em">
            WE HAVE VERY IMPORTANT
            
            INFORMATION REGARDING
            
            YOUR CLOSING/MOVE ON
            <div style="padding-top:10px">
               #dateformat(getinfo.closing_date, 'mm/dd/yyyy')#
           </div>
        </div>
        <div style="padding-top:20px">
            <span style="font-size:1.5em">CALL IMMEDIATELY</span><br>
            BEFORE <span class="redHighlight">7 PM</span>
            <br>
            ON
            <div style="padding-top:10px">
                <span style="font-size:1.5em">#dateformat(getinfo.door_hanger_call_date, 'mm/dd/yyyy')#</span>
            </div>
        </div>

        <div style="padding-top:20px;font-size:1.5em">
            CALL IN REFERENCE NUMBER<br>
            <span class="redHighlight">#getInfo.discountCode#</span>
        </div>
        
        <div style="padding-top:20px; padding-bottom:10px" class="blueHighlight">
           PHONE 
           <cfif getInfo.door_hanger_state is "DC">
                (202)-602-2295
            <cfelseif getInfo.door_hanger_state is "MD">
                (301)-200-3656
            <cfelseif getInfo.door_hanger_state is "VA">
                (703)-259-9010
           </cfif>
        </div>

    </div>
    </cfoutput>
</cffunction>