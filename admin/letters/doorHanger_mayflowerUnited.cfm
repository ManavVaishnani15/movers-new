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
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:1.1em;
        }
        .blueHighlight {
            font-weight:bold;
            color:##489cdf;
        }
        .hangerDiv {
             width:50%;
            border:5px solid blue;
        }
        .hangerDivGreen {
            width:50%;
            border:5px solid green;
        }
        .hangerMainMayflower {
            padding-top:110px;
            text-align: center;
            font-family: arial;
            font-size: 15px;
        }
        .hangerMainMayflower  div {
                font-weight:bold;
                font-size: 15px;
            }
        .vertFlip {
            -webkit-transform: rotate(180deg);
            -moz-transform: rotate(180deg);
            -o-transform: rotate(180deg);
            -ms-transform: rotate(180deg);
            transform: rotate(180deg);
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
<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="88">
        <style>
            .redHighlight {
                font-weight:bold;
                color:red;
                font-size:1.1em;
            }
            .blueHighlight {
                font-weight:bold;
                color:##489cdf;
            }
            .hangerDiv {
                width:50%;
                border:5px solid blue;
            }
            .hangerDivGreen {
                width:50%;
                border:5px solid green;
            }
            .hangerMainMayflower {
                padding-top:110px;
                text-align: center;
                font-family: arial;
                font-size: 15px;
            }
            .hangerMainMayflower div {
                font-weight:bold;
                font-size: 15px;
            }
        </style>
    <table style="width:99%">
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                #printHangerMayflower()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDivGreen" >
                #printMayflowerHangerBack()#
            </td>
        </tr>
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                #printHangerMayflower()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDivGreen" >
                #printMayflowerHangerBack()#
            </td>
        </tr>
    </table>
    </cfdocument>
<cfelse>
    <table style="width:99%">
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                #printHangerMayflower()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDivGreen" >
                #printMayflowerHangerBack()#
            </td>
        </tr>
        <tr>
            <td class="hangerDiv">
                <!--- door hanger front --->
                #printHangerMayflower()#
            </td>
            <td style="width:90px">&nbsp;</td>
            <td class="hangerDivGreen" >
                #printMayflowerHangerBack()#
            </td>
        </tr>
    </table>
</cfif>
</cfoutput>

</body>
</html>

<cffunction name="printHangerMayflower" returntype="string">
    <cfoutput>
    <div class="hangerMainMayflower">
        <div style="width:300px; margin-left: auto; margin-right: auto; padding-top:35px; font-size:3.0em" class="redHighlight">
            URGENT!!!
        </div>
        
        <div style="width:80%; margin-left:auto; margin-right: auto; padding-top:30px">
            <div style="font-size:1.4em; font-weight: bold">
                #getinfo.first_name# #getinfo.last_name#
            </div>
            <div style="font-size:0.8em">
                OR CURRENT OCCUPANT
            </div>
            <div>
                #getInfo.from_address#
                <cfif getInfo.from_address2 is not "">
                    , #getInfo.from_address2#
                </cfif>
            </div>
        </div>
        <div style="padding-top:20px;font-size:1.1em;font-weight: bold;">
           WE HAVE VERY IMPORTANT INFORMATION<br />
           REGARDING YOUR CLOSING ON<br>
            <span style="font-size:1.4em; font-weight: bold">#dateformat(getinfo.closing_date, "MM/DD/YYYY")#</span>
        </div>
        <div style="padding-top:20px">
            PLEASE CALL US AND HAVE YOUR FREE<br />
            MOVE ESTIMATE DONE BEFORE <br />
            <span style="font-size:1.4em; font-weight: bold">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span>
        </div>

        <div style="padding-top:20px">
            TO RECEIVE A MOVE DISCOUNT AT OUR<br/>
            HIGHEST DISCOUNT LEVEL
        </div>
        <div style="padding-top:20px">
            MENTION YOUR PERSONAL DISCOUNT<br/>
            CODE FOR UP TO 60% DISCOUNT ON OUT<br />
            OF STATE MOVES, DEEP DISCOUNTS ON<br/>
            LOCAL MOVES AND STORAGE
        </div>
        <div style="padding-top:20px">
            <span style="font-size:1.2em;">PERSONAL DISCOUNT CODE</span>
        </div>
        <div style="font-size:1.4em; padding-top:10px; color: red;">
            #getInfo.discountCode#
        </div>
        
        <div style="padding-top:10px; padding-bottom:10px; font-size:0.9em; color:##489cdf">
           PACKING SUPPLIES AND BOX DELIVERY <br/>
           AVAILABLE 
        </div>
        <div style="font-size:1.4em; font-weight: bold; color:red">
            CALL US <br/>
            1-800-656-3620
        </div>
        <div >
            <img src="http://www.top12movingbiz.com/admin/letters/images/Picture1.jpg" alt="" border="0" style="width:160px">
        </div>

    </div>
    </cfoutput>
</cffunction>


<cffunction name="printMayflowerHangerBack" returntype="string">
    <cfoutput>
    <div class="hangerMainMayflower">
        <div><br /><br /><br /></div>
        <div style="text-align:left">
            <ul>
                <li style="margin:0 0 10px 0;">
                    Evening and Weekend Appointments available 
                </li>
                <li style="margin:0 0 10px 0;">
                    Walkthroughs normally take less<br/> 
                    than 30 min and the move quote will<br/> 
                    be emailed to you the same day  
                </li>
                <li style="margin:0 0 10px 0;">
                    Virtual tour or on-site surveys available  
                </li>
                <li>
                    <span style="color: red; font-style: italic;">Don't Worry!!! </span>
                    if you've gotten other move quotes your 
                </li>
            </ul>
        </div>
        <div style="padding-top:15px">
            <span style="font-size:1.2em;">Personal Discount Code</span>
        </div>
        <div style="font-size:1.4em; color: red;">
            #getInfo.discountCode#
        </div>
        <div >
            will get you better discounts and pricing<br />
            through our agency
        </div>
        <div style="padding-top:10px; padding-bottom:10px; font-size:1.3em; color:##489cdf">
            Call direct Anthony Booker <br />
            Certified Moving Consultant for <br />
            Washington DC metro area to <br />
            schedule your free Virtual tour or <br />
            in home estimate <br />
            1-800-656-3620
        </div>

        <table style="margin-left:auto; margin-right: auto; padding-top:30px; width: 250px">
            <tr>
                <td>
                    <img src="http://www.top12movingbiz.com/admin/letters/images/viptransport.jpg" style="border: 0;width: 100px;" >
                </td>
                <td>
                    <img src="http://www.top12movingbiz.com/admin/letters/images/bbb_dark.jpg" style="border: 0;width: 20px;" >
                </td>
                <td style="font-weight: bold; font-size: 0.8em">
                    AGENT FOR
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <img src="http://www.top12movingbiz.com/admin/letters/images/mayflower.jpg" style="border: 0;width: 220px;" >
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div style="width: 100%">
                        <div style="float:right">
                            <img src="http://www.top12movingbiz.com/admin/letters/images/united.jpg" style="border: 0;width: 110px;" >
                        </div>
                        <div style="float:left">
                            <img src="http://www.top12movingbiz.com/admin/letters/images/united_truck.jpg" style="border: 0;width: 120px;" >
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </cfoutput>
</cffunction>