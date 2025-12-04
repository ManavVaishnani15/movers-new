<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfset datenow = #dateformat(now(), "YYYY-MM-DD")#>
<cfparam name="directPrint" default="0" />

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
            font-size:14px;
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
            padding-top:179px;
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
                        <div style="font-size:0.9em; padding-top: 5px;">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>

                    <div style="padding-top:15px;">
                        #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
                    </div>
                    <div style="padding-top:15px;font-size:1.1em">
                        A CERTIFIED MOVING CONSULTANT<br />
                        WILL STOP BY ON
                    </div>

                    <div style="padding:10px 0 10px 0">
                        <span class="redHighlight" style="font-size: 1.6em">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>
                    </div>

                    <div>
                        TO PROVIDE YOU A FREE MOVE QUOTE
                    </div>
                    <div style="font-style: italic; font-weight: normal;">
                         (Takes 30min - Quote emailed to you same day)
                    </div>
                    
                    <div style="padding-top:10px; line-height:25px">
                        PLEASE CALL US IMMEDIATELY AND<br />
                        MENTION YOUR<br />
                        <span style="text-decoration: underline;">PERSONAL DISCOUNT CODE</span><br />
                        <span class="redHighlight">#getInfo.discountCode#</span><br />
                        TO LOCK IN YOUR DISCOUNT
                    </div>

                    <div style="text-align: left; padding-left:8px;">
                        <div style="padding-top:7px;">
                           ** <span style="text-decoration: underline;">Fixed Flat Price</span> on local, storage and out-of-state<br/>
                           &nbsp;&nbsp;&nbsp; moves and big discounts off the price of your <br/>
                            &nbsp;&nbsp;&nbsp; move
                        </div>
                        <div style="padding-top:7px;">
                            ** <span style="text-decoration: underline;">Discounted packing supplies &amp; boxes</span> available<br />
                            &nbsp;&nbsp;&nbsp; for pick up or delivery for self pack moves
                        </div>
                    </div>
                    
                    
                    <div style="padding-bottom:6px; padding-top:6px" class="blueHighlight">
                       PHONE 
                       <cfif getInfo.door_hanger_state is "DC">
                            (202)-729-8277
                        <cfelseif getInfo.door_hanger_state is "MD">
                            (301)-235-9070
                        <cfelseif getInfo.door_hanger_state is "VA">
                            (703)-570-4232
                       </cfif>
                    </div>
                    <div style="padding-top:5px;font-size:0.9em;" >
                        We bring you high-quality movers at affordable prices
                    </div>
                    <div class="blueHighlight" style="font-size: 1.1em; padding-top: 8px">
                        www.affordable<span style="color: red">usa</span>movers.com
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="width:40px; padding-left: 20px" />
                    </div>
                </div>
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv">
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
                        <div style="font-size:0.9em; padding-top: 5px;">
                            OR CURRENT OCCUPANT
                        </div>
                    </div>

                    <div style="padding-top:15px;">
                        #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
                    </div>
                    <div style="padding-top:15px;font-size:1.1em">
                        A CERTIFIED MOVING CONSULTANT<br />
                        WILL STOP BY ON
                    </div>

                    <div style="padding:10px 0 10px 0">
                        <span class="redHighlight" style="font-size: 1.6em">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>
                    </div>

                    <div>
                        TO PROVIDE YOU A FREE MOVE QUOTE
                    </div>
                    <div style="font-style: italic; font-weight: normal;">
                         (Takes 30min - Quote emailed to you same day)
                    </div>
                    
                    <div style="padding-top:10px; line-height:25px">
                        PLEASE CALL US IMMEDIATELY AND<br />
                        MENTION YOUR<br />
                        <span style="text-decoration: underline;">PERSONAL DISCOUNT CODE</span><br />
                        <span class="redHighlight">#getInfo.discountCode#</span><br />
                        TO LOCK IN YOUR DISCOUNT
                    </div>

                    <div style="text-align: left; padding-left:8px;">
                        <div style="padding-top:7px;">
                           ** <span style="text-decoration: underline;">Fixed Flat Price</span> on local, storage and out-of-state<br/>
                           &nbsp;&nbsp;&nbsp; moves and big discounts off the price of your <br/>
                            &nbsp;&nbsp;&nbsp; move
                        </div>
                        <div style="padding-top:7px;">
                            ** <span style="text-decoration: underline;">Discounted packing supplies &amp; boxes</span> available<br />
                            &nbsp;&nbsp;&nbsp; for pick up or delivery for self pack moves
                        </div>
                    </div>
                    
                    <div style="padding-bottom:6px; padding-top:6px" class="blueHighlight">
                       PHONE 
                       <cfif getInfo.door_hanger_state is "DC">
                            (202)-729-8277
                        <cfelseif getInfo.door_hanger_state is "MD">
                            (301)-235-9070
                        <cfelseif getInfo.door_hanger_state is "VA">
                            (703)-570-4232
                       </cfif>
                    </div>
                    <div style="padding-top:5px;font-size:0.9em;" >
                        We bring you high-quality movers at affordable prices
                    </div>
                    <div class="blueHighlight" style="font-size: 1.1em; padding-top: 8px">
                        www.affordable<span style="color: red">usa</span>movers.com
                        <img src="http://www.top12movingbiz.com/admin/letters/images/bbb-logo.png" style="width:40px; padding-left: 20px" />
                    </div>
                </div>
            </td>
        </tr>
    </table>    
</cfoutput>

</body>
</html>