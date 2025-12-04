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
            font-size:19px;
            font-family: arial, helvetica;
            font-weight:bold;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:1.2em;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:1.1em;
        }
        .hangerDiv {
            width:50%; 
            border:5px solid red;
        }
        .hangerMain {
            padding-top:149px;
            text-align: center;
        }
        div {
            font-weight:bold;
            font-size: 14px;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.4em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.4em;
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
            <td class="hangerDiv">
                #printApptUrgent()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv">
                #printApptUrgent()#
            </td>
        </tr>
    </table>    
</cfoutput>

</body>
</html>

<cffunction name="printApptUrgent" returntype="string">
    <cfoutput>
    <div class="hangerMain">
        <div style="width:300px; margin-left: auto; margin-right: auto">
            <img src="http://www.top12movingbiz.com/admin/letters/images/logo_small.jpg" alt="" border="0" style="width:200px">
        </div>

        <div style="padding-top:15px">
            <span class="redHighlight" style="text-decoration: underline;">WE HAVE AN APPOINTMENT!!!</span>
        </div>

        <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:15px;">
            <div class="clientName">
                #getinfo.first_name# #getinfo.last_name#
            </div>
            <div style="font-size:0.9em">
                OR CURRENT OCCUPANT
            </div>
        </div>

        <div style="padding-top:5px;">
            #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
        </div>
        <div style="padding-top:15px;font-size:1.1em">
            A CERTIFIED MOVING CONSULTANT<br />
            WILL STOP BY ON
        </div>

        <div style="padding:0px 0 8px 0">
            <span class="redHighlight">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>
        </div>

        <div>
            TO PROVIDE YOU A FREE MOVE QUOTE
        </div>
        <div style="font-size:0.85em;font-style: italic;">
             (Takes 30min - Quote emailed to you same day)
        </div>
        
        <div style="padding-top:15px; line-height:25px">
            PLEASE CALL US IMMEDIATELY OR GO TO<br />
            <div style="text-decoration: underline;" class="blueHighlight">
                www.affordableusamovers.com
            </div>
            TO CONFIRM, RESCHEDULE OR SET UP AN <br />
            APPOINTMENT TIME THAT WORKS BEST FOR <br />
            YOU AND MENTION YOUR
            <span style="text-decoration: underline;">REALTY DISCOUNT CODE</span><br />
            <span class="redHighlight">#getInfo.discountCode#</span>
            TO LOCK IN YOUR DISCOUNT
        </div>

        <div style="padding-top:7px;font-size:0.9em">
            **  Up to a 70% discount off the Tariff Rates on out of State moves 
        </div>
        <div style="font-size:0.9em">
            **  Up to 40% savings on local moves and storage 
        </div>

        <div style="padding-top:15px; text-decoration: underline;">
            Free box delivery service on self
            pack moves when moving through us
        </div>
        
        <div style="padding-bottom:10px" class="blueHighlight">
           PHONE 
           <cfif getInfo.door_hanger_state is "DC">
                (202)-729-8277
            <cfelseif getInfo.door_hanger_state is "MD">
                (301)-235-9070
            <cfelseif getInfo.door_hanger_state is "VA">
                (703)-570-4232
           </cfif>
        </div>
        <div style="font-size:0.8em">
            We guarantee to get you a quality mover at an affordable price
        </div>
        <div style="padding-top:10px;font-size:0.9em;" class="blueHighlight">
            www.affordable<span style="color: red">usa</span>movers.com
        </div>
    </div>
    </cfoutput>
</cffunction>