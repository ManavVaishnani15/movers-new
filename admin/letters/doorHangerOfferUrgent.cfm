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
            font-size:24px;
            font-family: arial, helvetica;
            font-weight:bold;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.9em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:24px;
        }
        .hangerDiv {
            width:50%; 
            border:5px solid red;
        }
        .hangerMain {
            padding-top:189px;
            text-align: center;
        }
        div {
            font-weight:bold;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.8em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.8em;
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
                    <div style="width:300px; margin-left: auto; margin-right: auto; padding-top:15px; font-size:3.2em" class="redHighlight">
                        URGENT!!!
                    </div>

                    <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:15px;">
                        <div class="clientName">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div >
                            OR CURRENT OCCUPANT
                        </div>
                    </div>

                    <div style="padding-top:15px; font-size:22px">
                        #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
                    </div>
                    <div style="padding-top:15px; font-size:21px">
                        WE HAVE VERY IMPORTANT<br />
                        INFORMATION REGARDING THE<br />
                        RECENT OFFER YOU RECEIVED<br />
                        ON YOUR HOME ON
                    </div>

                    <div style="padding:20px 0 8px 0">
                        <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
                        <span class="redHighlight" style="font-size:24px">#dateformat(getinfo.CONTRACT_DATE, "MM/DD/YYYY")#</span>
                    </div>
                    <div style="padding-top:15px; font-size:15px;">
                        CALL IMMEDIATELY<br />
                        BEFORE <span style="color:##f00">7 PM</span><br />
                        ON
                    </div>
                    <div style="padding:15px 0 8px 0">
                        <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
                        <span class="redHighlight" style="font-size:">#dateformat(getinfo.DOOR_HANGEROFFERURGENT_CALL_DATE, "MM/DD/YYYY")#</span>
                        
                    </div>

                    <div style="padding-top:15px">
                        CALL IN REFERENCE<br />
                        NUMBER
                    </div>

                    <div style="padding:0 0 10px 0">
                        <span class="redHighlight" style="font-size:24px;">#getInfo.discountCode#</span>
                    </div>

                    <div style="padding:20px 0 10px 0" class="blueHighlight">
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
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDiv">
                <div class="hangerMain">
                    <div style="width:300px; margin-left: auto; margin-right: auto; padding-top:15px; font-size:3.2em" class="redHighlight">
                        URGENT!!!
                    </div>

                    <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:15px;">
                        <div class="clientName">
                            #getinfo.first_name# #getinfo.last_name#
                        </div>
                        <div >
                            OR CURRENT OCCUPANT
                        </div>
                    </div>

                    <div style="padding-top:15px; font-size:22px">
                        #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
                    </div>
                    <div style="padding-top:15px; font-size:21px">
                        WE HAVE VERY IMPORTANT<br />
                        INFORMATION REGARDING THE<br />
                        RECENT OFFER YOU RECEIVED<br />
                        ON YOUR HOME ON
                    </div>

                    <div style="padding:20px 0 8px 0">
                        <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
                        <span class="redHighlight" style="font-size:24px">#dateformat(getinfo.CONTRACT_DATE, "MM/DD/YYYY")#</span>
                    </div>
                    <div style="padding-top:15px; font-size:15px;">
                        CALL IMMEDIATELY<br />
                        BEFORE <span style="color:##f00">7 PM</span><br />
                        ON
                    </div>
                    <div style="padding:15px 0 8px 0">
                        <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
                        <span class="redHighlight" style="font-size:24px">#dateformat(getinfo.DOOR_HANGEROFFERURGENT_CALL_DATE, "MM/DD/YYYY")#</span>
                        
                    </div>

                    <div style="padding-top:15px">
                        CALL IN REFERENCE<br />
                        NUMBER
                    </div>

                    <div style="padding:0 0 10px 0">
                        <span class="redHighlight" style="font-size:24px">#getInfo.discountCode#</span>
                    </div>

                    <div style="padding:20px 0 10px 0" class="blueHighlight">
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
            </td>
        </tr>
    </table>    
</cfoutput>

</body>
</html>

<!--- <cffunction name="printHanger" returntype="string">
    <cfoutput>
    <div class="hangerMain">
        <div style="width:300px; margin-left: auto; margin-right: auto; padding-top:15px; font-size:3.2em" class="redHighlight">
            URGENT!!!
        </div>

        <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:15px;">
            <div class="clientName">
                #getinfo.first_name# #getinfo.last_name#
            </div>
            <div >
                OR CURRENT OCCUPANT
            </div>
        </div>

        <div style="padding-top:15px; font-size:22px">
            #getInfo.FROM_ADDRESS#<cfif getinfo.FROM_ADDRESS2 is not "">, #getinfo.FROM_ADDRESS2#</cfif>
        </div>
        <div style="padding-top:15px; font-size:21px">
            WE HAVE VERY IMPORTANT<br />
            INFORMATION REGARDING THE<br />
            RECENT OFFER YOU RECEIVED<br />
            ON YOUR HOME ON
        </div>

        <div style="padding:20px 0 8px 0">
            <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
            <span class="redHighlight" style="font-size:">#dateformat(getinfo.CONTRACT_DATE, "MM/DD/YYYY")#</span>
        </div>
        <div style="padding-top:15px; font-size:15px;">
            CALL IMMEDIATELY<br />
            BEFORE <span style="color:##f00">7 PM</span><br />
            ON
        </div>
        <div style="padding:15px 0 8px 0">
            <!--- <span class="redHighlight">#dateformat(getinfo.contract_date, "MM/DD/YYYY")#</span> --->
            <span class="redHighlight" style="font-size:">#dateformat(getinfo.DOOR_HANGEROFFERURGENT_CALL_DATE, "MM/DD/YYYY")#</span>
            
        </div>

        <div style="padding-top:15px">
            CALL IN REFERENCE<br />
            NUMBER
        </div>

        <div style="padding:0 0 10px 0">
            <span class="redHighlight">#getInfo.discountCode#</span>
        </div>

        <div style="padding:20px 0 10px 0" class="blueHighlight">
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
</cffunction> --->