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
            font-size:18px;
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
            font-size:15px;
        }
        .hangerDiv {
            width:50%; 
            border:5px solid red;
        }
        .hangerMain {
            padding-top:159px;
            text-align: center;
        }
        div {
            font-weight:bold;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.1em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.1em;
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
                #printHangerOffer()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv">
                #printHangerOffer()#
            </td>
        </tr>
    </table>    
</cfoutput>

</body>
</html>

<cffunction name="printHangerOffer" returntype="string">
    <cfoutput>
    <div class="hangerMain">
        <div style="width:300px; margin-left: auto; margin-right: auto">
            <div style="float:left; margin-top: 30px">
                <img src="http://www.top12movingbiz.com/admin/letters/images/top12Moverslogo_med.jpg" alt="" border="0" style="width:175px">
            </div>
            <div >
                <img src="http://www.top12movingbiz.com/admin/letters/top12movers-logo.jpg" width="104" height="73" alt="" border="0">
            </div>
        </div>
        <div style="padding-top:15px; font-size:0.9em">
            We will get you the lowest price from
            one of the Top 12 Moving Companies
        </div>

        <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:12px;">
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
        <div style="padding-top:11px;">
            WE SEE YOUR HOME JUST
            RECEIVED AN OFFER ON
        </div>

        <div style="padding:0px 0 8px 0">
            <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span>
            
        </div>
        <div style="padding-top:3px; font-size:15px;" class="redHighlight">
            CONGRATULATIONS!!!
        </div>
        <div style="padding-top:3px">
            WE WOULD LIKE TO PROVIDE YOU A <span style="text-decoration:underline">FREE</span> MOVE QUOTE
        </div>
        <div style="font-size:0.85em">
             (Takes 30min - Quote emailed to you same day)
        </div>
        
        <div style="padding-top:15px;font-size:1.1em">
            PLEASE CALL US IMMEDIATELY
        </div>

        <div style="font-size:0.9em"> 
            TO SET AN APPOINTMENT WITH A CERTIFIED<br />
            MOVING CONSULTANT
        </div>

        <div style="padding-top:7px;font-size:0.9em">
            MENTION YOUR
            <span style="text-decoration: underline;">MOVE DISCOUNT CODE</span><br />
            AND LOCK IN YOUR DISCOUNT
        </div>

        <div style="padding-top:7px;font-size:0.9em">
            ** Up to 70% discount on State-to-State move
        </div>
        <div style="font-size:0.9em">
            ** Up to 40% savings on local moves and storage
        </div>

        <div style="padding-top:10px; text-decoration: underline;">
            Free box delivery service on self
            pack moves when moving through us
        </div>

        <div style="padding-top:10px;font-size:1.1em">
            MOVE DISCOUNT CODE
        </div>

        <div style="padding:0 0 6px 0">
            <span class="redHighlight">#getInfo.discountCode#</span>
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
            We guarantee to get you the lowest price
            that will fit your budget
        </div>
        <div style="padding-top:10px;font-size:0.9em; color:##EE8A0B">
            www.Top12Movers.com
        </div>
    </div>
    </cfoutput>
</cffunction>