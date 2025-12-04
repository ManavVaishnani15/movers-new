<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfparam name="directPrint" default="0" />

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
            font-size:14px;
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
<!---<cfif parameterexists(un) is 'no'> <b>Log In</b>
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
</cfif>--->
<cfquery name="getinfo" datasource="aaalh3x_onestep">
    select * from CLIENTS
    where id=#clientid#
</cfquery>

<body>

<cfif directPrint is 1>
    <cfdocument format="pdf"  orientation="portrait" scale="95">
        <cfoutput>
        
      <table style="width:99%" align="center" border="0" style="margin-top:-10px">
            
                        
                                     <tr>
             <td></td>
              <td align="left" width="90%">
                  
                                             </td>
              <td align="right"><span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span></td>
              </tr>
        
        <tr>
         <td colspan="3" align="center">
             <img src="http://www.top12movingbiz.com/admin/letters/images/Newheader.png" alt="" border="0" width="100%"></td>
       
        </tr>
        
        
        <tr>
        <td colspan="3">
            <br>
            <span style="font-size: 14px">
        Dear <span style="font-weight:bold"> #getinfo.first_name# #getinfo.last_name# or Current Occupant, </span>
        </span>
        
     
            </td>
        </tr>
        
        
        <tr>
        <td colspan="3" style="margin-top:20px;">
            
      <span style="font-size: 12px;margin-top:15px;">
   Don't forget to set up your appointment with an Affordable USA Movers Certified Moving Consultant and get your quote by  #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#.

  </span>
        </td>
        </tr>
        
        
        
        
       
        
        <tr style="padding-top:15px; padding-bottom:15px">
        <td colspan="3">
        <img src="http://www.top12movingbiz.com/admin/letters/images/body1.png" alt="" border="0" width="100%" style="margin-top:15px">
        </td>
        </tr>
        
        
        <tr>
        <td align="center" colspan="3">
       
        <h2> <span style="color: red; align: center;"><u>#getInfo.discountCode#</u></span>  </h2>
       
        </td>
        </tr>
        
        <tr>
        <td colspan="3">
        <img src="http://www.top12movingbiz.com/admin/letters/images/body2Followup.png" alt="" border="0" width="100%" style="margin-bottom:-25px">
        </td>
        </tr>
        
        
        
        <tr>
        
        <td align="center" colspan="3">
       
       <h2><span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span> </h1>
       
        </td>
       
        </tr>
       
       <tr>
       <td colspan="3">
          
       <img src="http://www.top12movingbiz.com/admin/letters/images/Newfooter.png" style="border: 0; margin-top:10px;" alt="Affordable USA Movers BBB Business Review" width="100%">
       
       </td>
       </tr>
     
        </table>    
          
        
        
        </cfoutput>
    </cfdocument>
    
<cfelse>
    <cfoutput>
     
       <table style="width:99%" align="center" border="0" style="margin-top:-10px">
            
                        
                                     <tr>
             <td></td>
              <td align="left" width="90%">
                  
                                             </td>
              <td align="right"><span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span></td>
              </tr>
        
        <tr>
         <td colspan="3" align="center">
             <img src="http://www.top12movingbiz.com/admin/letters/images/Newheader.png" alt="" border="0" width="100%"></td>
       
        </tr>
        
        
        <tr>
        <td colspan="3">
            <br>
            <span style="font-size: 14px">
        Dear <span style="font-weight:bold"> #getinfo.first_name# #getinfo.last_name# or Current Occupant, </span>
        </span>
        
     
            </td>
        </tr>
        
        
        <tr>
        <td colspan="3" style="margin-top:20px;">
            
      <span style="font-size: 14px;margin-top:15px;">
   Don't forget to set up your appointment with an Affordable USA Movers Certified Moving Consultant and get your quote by  #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#.

  </span>
        </td>
        </tr>
        
        
        
        
       
        
        <tr style="padding-top:15px; padding-bottom:15px">
        <td colspan="3">
        <img src="http://www.top12movingbiz.com/admin/letters/images/body1.png" alt="" border="0" width="100%" style="margin-top:15px">
        </td>
        </tr>
        
        
        <tr>
        <td align="center" colspan="3">
       
        <h2> <span style="color: red; align: center;"><u>#getInfo.discountCode#</u></span>  </h2>
       
        </td>
        </tr>
        
        <tr>
        <td colspan="3">
        <img src="http://www.top12movingbiz.com/admin/letters/images/body2Followup.png" alt="" border="0" width="100%" style="margin-bottom:-25px">
        </td>
        </tr>
        
        
        
        <tr>
        
        <td align="center" colspan="3">
       
       <h2><span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span> </h1>
       
        </td>
       
        </tr>
       
       <tr>
       <td colspan="3">
          
       <img src="http://www.top12movingbiz.com/admin/letters/images/Newfooter.png" style="border: 0; margin-top:10px;" alt="Affordable USA Movers BBB Business Review" width="100%">
       
       </td>
       </tr>
     
        </table>    
          
             
        </cfoutput>
</cfif>

</body>
</html>