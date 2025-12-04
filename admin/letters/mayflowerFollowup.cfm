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
    <html>
<head>
        <title>
            <cfif parameterexists(clientid) is 'yes'>
                <cfoutput>#getinfo.first_name# #getinfo.last_name# Mayflower Follow Up</cfoutput>
            </cfif>
        </title> 
    <style>
        body {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:17px;
         /*   font-weight:bold;*/
            font-family:arial
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:19px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:17px;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.4em;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        @media print {
            body {
                font-family:arial;
            }
            .clientName {
                border-bottom: 1px solid black; font-size:1.4em;
            }
        }
    </style>
</head>
<body>
<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="95">
    <cfoutput>
    
     <table style="width:99%">
     
      <tr>
     <td align="right">#DateFormat(Now(), "MM/DD/YYYY")#</td>
     </tr>
     
     <tr>
     <td> <img src="http://www.top12movingbiz.com/admin/letters/images/VanNewHeader.png" alt="" border="0" width="100%"></td>
     </tr>
     
     <tr>
     <td>
     <span style="font-size: 14px;">
         <br>
     Dear <span style="font-weight:bold">#getinfo.first_name# #getinfo.last_name# or Current Occupant,</span>
     <br>

</span>
    
     </td>
     </tr>
     
     
          <tr style="margin-top:20px; margin-bottom:30px;">
     <td>
    
    <span style="font-size:14px;margin-top:30px;">
      
  Don't forget that your move discount offer will expire soon! Don't miss this opportunity, have your <b>FREE ESTIMATE </b>
done by #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#.
</span>

     </td>
     </tr>
     
     <tr>
     <td><img src="http://www.top12movingbiz.com/admin/letters/images/VanBody1.png" alt="" border="0" width="100%"></td>
     </tr>
     
     <tr>
     <td align="center">
     <h1 style="color: red;"><u>#getInfo.discountCode#</u></h1>
     </td>
     </tr>
     
     <tr>
     <td><img src="http://www.top12movingbiz.com/admin/letters/images/7VanBody2.png" alt="" border="0" width="100%"></td>
     </tr>
     
      <tr>
     <td align="center">
     <h1 style="color: red; margin-top:-30px;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</h1>
     </td>
     </tr>
     
     <tr>
     <td>
        <br>
     <img src="http://www.top12movingbiz.com/admin/letters/images/VanNewFooter.png" alt="" border="0" width="100%" style="margin-top:-60px;"></td>
     </tr>
     
     </table>
    
    
    
    
    </cfoutput>
    </cfdocument>
<cfelse>
    <style>
        .closingLetter {
            /* to centre page on screen*/
            margin-left: auto;
            margin-right: auto;
            font-size:22px;
            font-family: arial;
        }
        .redHighlight {
            font-weight:bold;
            color:red;
            font-size:24px;
            text-decoration: underline;
        }
        .redHighlightDate {
            font-weight:bold;
            color:red;
            font-size:1.4em;
        }
        .blueHighlight {
            font-weight:bold;
            color:#489cdf;
            font-size:22px;
        }
        .clientName {
            border-bottom: 1px solid black; font-size:1.4em;
        }
        .highlight {
            font-weight: bold;
            font-size: 1.2em;
        }
        @media print {
            .clientName {
                border-bottom: 1px solid black; font-size:1.4em;
            }
        }
    </style>
    <cfoutput>
     
       <table style="width:99%">
     
      <tr>
     <td align="right">#DateFormat(Now(), "MM/DD/YYYY")#</td>
     </tr>
     
     <tr>
     <td> <img src="http://www.top12movingbiz.com/admin/letters/images/VanNewHeader.png" alt="" border="0" width="100%"></td>
     </tr>
     
     <tr>
     <td>
     <span style="font-size: 14px;">
         <br>
     Dear <span style="font-weight:bold">#getinfo.first_name# #getinfo.last_name# or Current Occupant,</span>
     <br>

</span>
    
     </td>
     </tr>
     
     
          <tr style="margin-top:20px; margin-bottom:30px;">
     <td>
    
    <span style="font-size:14px;margin-top:30px;">
      
  Don't forget that your move discount offer will expire soon! Don't miss this opportunity, have your <b>FREE ESTIMATE </b>
done by #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#.
</span>

     </td>
     </tr>
     
     <tr>
     <td><img src="http://www.top12movingbiz.com/admin/letters/images/VanBody1.png" alt="" border="0" width="100%"></td>
     </tr>
     
     <tr>
     <td align="center">
     <h1 style="color: red;"><u>#getInfo.discountCode#</u></h1>
     </td>
     </tr>
     
     <tr>
     <td><img src="http://www.top12movingbiz.com/admin/letters/images/7VanBody2.png" alt="" border="0" width="100%"></td>
     </tr>
     
      <tr>
     <td align="center">
     <h1 style="color: red; margin-top:-30px;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</h1>
     </td>
     </tr>
     
     <tr>
     <td>
        <br>
     <img src="http://www.top12movingbiz.com/admin/letters/images/VanNewFooter.png" alt="" border="0" width="100%" style="margin-top:-60px;"></td>
     </tr>
     
     </table>
    
    
    
    
    </cfoutput>
</cfif>
</body>
</html>