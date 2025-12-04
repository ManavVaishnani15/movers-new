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
             <img src="https://www.top12movingbiz.com/admin/letters/images/Newheader.png" alt="" border="0" width="100%"></td>
       
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
		<table width="99%" border="0">
        <tr>
            <td>
                <table width="99%" border="0">
                    <tr>
                        <td align="center">
                            <table width="99%" border="0" style="margin-top: 25px;">
                                <tr>
                                    <td align="left" width="30%">
                                        <img src="./images/New logo.png" alt=""<!--- style="width:250px;height:100px;"--->><br>
                                        <span style="font-size:8px;color: midnightblue;font-family:Calibri;font-weight:bold;margin-left:20px;">OVER 30 YEARS IN THE MOVING INDUSTRY</span>
                                    </td>
                                    <td align="center" width="30%"><h2 style="font-size: 28px;font-weight: bold;">MOVING SOON?</h2> </td>
                                    <td align="right" width="30%"><span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table><br><br>
                <table width="99%">
                    <tr>
                        <td valign="top">
                            <span style="font-size: 12px;">Dear</span>
                            <span style="font-weight:bold;">#getinfo.first_name# #getinfo.last_name# or Current Occupant, </span>
							<br><br>
                            <span style="font-size: 12px;">Recently, we have been trying to reach you! Your move discounts are waiting and we would like to help you with</span><br><br>
                            <span style="font-size: 12px;">your move!</span><br><br>
                            <center><h2 style="font-size: 14px;font-family:Calibri;">Vanlinequotes.com is your “ONE STOP SHOP” for moving quotes</h2></center><br><br>
                            <span style="font-size: 12px;font-family:Calibri;">Get a variety of quotes from Major Van Lines and Professionally Licensed Moving Companies, in one email. Additionally</span><br><br>
                            <span style="font-size: 12px;font-family:Calibri;">vanlinequotes.com will be at your side 7 days a week managing and monitoring your move from start to finish.</span><br><br>
                        </td>
                    </tr>
                </table><br><br>
                <table id="img3" width="90%">
                    <tr>
                        <td width="30%"> <img src="http://www.top12movingbiz.com/admin/letters/images/residential.png" alt="" style="width:250px;height:160px;margin-right: 35px;"></td>
                        <td width="30%"> <img src="http://www.top12movingbiz.com/admin/letters/images/postcard THUMBNAIL NEW.png" alt="" style="width:280px;height:180px;margin-right: 35px;"></td>
                        <td width="30%" align="right"> <img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_together_2.png" alt="" style="width:250px;height:160px;"></td>
                    </tr>
                </table><br><br>
                <table width="90%">
                    <center><h1 style="font-weight: bold;font-size: 28px;color: midnightblue;font-family:Calibri;">LOCK-IN UP TO 40% MOVE SAVINGS NOW!!</h1></center><br><br>
                </table><br>
                <table id="img33" width="90%" style="margin: auto;">
                    <tr>
                        <td width="30%"> <img src="http://www.top12movingbiz.com/admin/letters/images/bring_something_in_stairs.png" alt="" style="width:275px;height:150px;"></td>
                        <td width="30%" align="center">
                            <h1 style="font-weight: bold;font-size: 24px;color: midnightblue;width:350px;font-family:Calibri;">TEXT “QUOTES” TO 474747</h1>
                            <h1 style="font-weight: bold;font-size: 24px;color: midnightblue;width:350px;font-family:Calibri;">OR</h1>
                        </td>
                        <td width="30%" align="right"> <img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_together_1.png" alt="" style="width:275px;height:150px;"></td>
                    </tr>
                </table>
                <table width="99%">
                	<tr>
                		<td align="center">
                			<table width="900px">
			                    <tr>
			                        <td align="center">
			                            <h1 style="font-weight: bold;font-size: 24px;color:red;font-family:Arial;">CALL 1-800-976-6833</h1>
			                        </td>
			                    </tr>
                			</table>
                		</td>
                	</tr>
                </table>
                
                <table id="visit" width="90%" style="margin: auto;">
                    <tr>
                        <td width="30%"><img src="http://www.top12movingbiz.com/admin/letters/images/What-to-know-when-designing-high-rise-buildings.jpg" alt="" style="width:275px;height:150px;"></td>
                        <td width="30%" align="center">
                            <i><h3 style="font-weight: bold;font-size: 12px;color: black;width:350px;font-family:Arial;">7 DAYS A WEEK 7am-9pm</h3></i>
                            <h1 style="font-weight: bold;font-size: 24px;color: midnightblue;width:350px;font-family:Calibri;">OR VISIT US ONLINE AT</h1>
                            <h1 style="font-weight: bold;font-size: 18px;color: midnightblue;width:350px;font-family:Calibri">www.vanlinequotes.com</h1>
                        </td>
                        <td width="30%" align="right"> <img src="http://www.top12movingbiz.com/admin/letters/images/happy_in_room.jpg" alt="" style="width:275px;height:150px;"></td>
                    </tr>
                </table><br>
                <table id="reserve" width="99%">
                <tr>
                	<td align="center">
                		<table width="900px"style="margin:auto;">
		                    <tr>
		                        <td id="left" align="center" valign="top">
		                            <span style="font-size: 11px;font-weight:bold;font-family:Calibri;">RESERVE YOUR FUTURE MOVE SAVINGS TODAY AND RECEIVE A GIFT CARD WHEN BOOKING</span><br>
								</td>
		                    </tr>
		                    <tr>
		                    	<td  align="center" valign="top">
		                    		<span style="font-size: 11px;font-weight:bold;font-family:Calibri;">TEXT “QUOTES’ RIGHT NOW TO 474747</span></center><br>
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<td  align="center" valign="top">
		                    		<span style="font-size: 11px;font-weight:bold;font-family:Calibri;">OR MENTION YOUR MOVE DISCOUNT CODE IF CALLING OR GOING ONLINE TO SET UP TO GET YOUR QUOTES</span><br>
		                    	</td>
		                    </tr>
		                    <tr>
		                    	<td  align="center" valign="top">
		                    		<span style="font-size: 11px;font-weight:bold;font-family:Calibri;">FREE VIRTUAL ESTIMATE- 20 min OR LESS</span>
		                    	</td>
		                    </tr>
						</table>
                	</td>
                </tr>
			</table>
		<table width="99%">
			<tr>
				<td>
					<table id="move" width="90%" style="margin: auto;">
                    <tr>
                        <td width="30%"><img src="http://www.top12movingbiz.com/admin/letters/images/take_picture_with_phone.png" alt="" style="width:275px;height:150px;"></td>
                        <td width="30%" align="center">
                            <h1 style="font-weight: bold;font-size: 16px;color: red;width:350px;font-family:Calibri">MOVE DISCOUNT CODE</h1>
                            <h2><span style="color: red;font-weight: bold;">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span> </h1>
                        </td>
                        <td width="30%" align="right"> <img src="http://www.top12movingbiz.com/admin/letters/images/take_photo_of_living_room.png" alt="" style="width:275px;height:150px;"></td>
                    </tr>
                </table>
				</td>
			</tr>
		</table><br>
		<table width="100%">
			<tr>
				<td>
					<table width="1000px">
						<tr>
							<td style="height:50px;">
       							<img src="http://www.top12movingbiz.com/admin/letters/images/Newfooter.png" style="border: 0; margin-top:6px;" alt="Affordable USA Movers BBB Business Review" width="100%">
							</td>
						</tr>
					</table>
				</td>
			</tr>
							
		</table>
            </td>
        </tr>
    </table>
       <!---<table style="width:99%" align="center" border="0" style="margin-top:-10px">
		<tr>
			<td>
				<i><img src="./images/New logo.png" alt="logo" style="width:250px;height:130px;margin-left:10px;margin-right:40px;" /></i><span style="color:MidnightBlue;font-size:12px;font-weight:bold;width:400px;">OVER 30 YEARS IN THE MOVING INDUSTRY</span><br><br>
			</td>
			<td>
				<center><h1 style="color:MidnightBlue;width:400px;font-size:43px;margin-left:10px;"><span>MOVING SOON?</span></h1></center>
			</td>
<!---			<td align="left" width="90%">
                  
			</td>--->
              <td align="right"><span style="font-size: 15px">#dateformat(now(), "MM/DD/YYYY")#</span></td>
		</tr>
        
       <!--- <tr>
			<td colspan="3" align="center">
			     <!---<img src="http://www.top12movingbiz.com/admin/letters/images/Newheader.png" alt="" border="0" width="100%">--->
			</td>
        </tr>--->
        <tr>
			<td colspan="3">
			<span style="font-size: 15px">
	        	Dear <span style="font-weight:bold"> #getinfo.first_name# #getinfo.last_name# or Current Occupant, </span>
			</span>
	        </td>
        </tr>
        
        
        <tr>
        <td colspan="5" style="margin-top:20px;">
	      	<span style="font-size: 14px;margin-top:15px;">
		   		<!---Don't forget to set up your appointment with an Affordable USA Movers Certified Moving Consultant and get your quote by  #dateformat(getinfo.appointment_date, "MM/DD/YYYY")#.--->
		   		Recently, we have been trying to reach you! Your move discounts are waiting and we would like to help you with
				your move!
	  		</span><br><br><br>
	  		<center>
	  			<h3>
		  			<span>
		  				Vanlinequotes.com is your “ONE STOP SHOP” for moving quotes
		  			</span>
	  			</h3>
	  		</center>
        </td>
        </tr>
        <tr style="padding-top:15px; padding-bottom:15px">
	        <td>
	        	<!---<img src="http://www.top12movingbiz.com/admin/letters/images/body1.png" alt="" border="0" width="100%" style="margin-top:15px">--->
	        	<img src="./images/residential.png" alt="" style="width:160px;height:100px;">
	        </td>
	        <td><img src="./images/residential.png" alt="" style="width:160px;height:100px;"></td>
	        <td><img src="./images/residential.png" alt="" style="width:160px;height:100px;"></td>
        </tr>
        <tr>
        	<td colspan="5" style="margin-top:20px;">
        	<center>
        		<h1><span style="color:MidnightBlue;align:center;font-size:45px;">
        			RESERVE YOUR MOVE DISCOUNTS NOW!!
        		</span>
        		</h1>
        	</center>
        	</td>
        </tr>
        <tr>
        	<td>
        		<img src="./images/residential.png" alt="" style="width:160px;height:100px;">
        	</td>
        	<td>
        		<span> TEXT “QUOTES” TO 474747 OR</span>
        	</td>
        	<td>
        		<img src="./images/residential.png" alt="" style="width:160px;height:100px;">
        	</td>
        </tr>
        <tr>
        	<td><span> CALL 1-800-976-6833</span></td>
        </tr>
        <tr style="padding-top:15px; padding-bottom:15px">
        	<td><img src="./images/residential.png" alt="" style="width:160px;height:100px;"></td>
        	<td><span> OR VISIT US ONLINE AT</span><br><span>www.vanlinequotes.com</span></td>
        	<td><img src="./images/residential.png" alt="" style="width:160px;height:100px;"></td>
        </tr>
        
        <tr>
        	<td colspan="5">
        		<span>RESERVE YOUR FUTURE MOVE DISCOUNTS TODAY AND RECEIVE A GIFT CARD WHEN BOOKING</span><br>
        		<center><span>TEXT “QUOTES’ RIGHT NOW TO 474747</span></center><br>
        		<span>OR MENTION YOUR MOVE DISCOUNT CODE IF CALLING OR GOING ONLINE TO SET UP TO GET YOUR QUOTES</span><br>
        		<center><span>FREE VIRTUAL ESTIMATE- 20 min OR LESS</span></center>
        	</td>
        </tr>
       <tr>
       		<td><img src="C:\inetpub\wwwroot\VanLineQuotes.com\admin\letters\images/take_picture_with_phone.png" alt="" style="width:160px;height:100px;"></td>
	        <td align="center" colspan="3">
	        	<h2><span style="color: red; align: center;">MOVE DISCOUNT CODE</span></h2>
	        	<h2><span style="color: red; align: center;"><u>#getInfo.discountCode#</u></span></h2>
			</td>
			<td><img src="./images/residential.png" alt="" style="width:160px;height:100px;"></td>
        </tr>
        
       <!--- <tr>
        <td colspan="3">
        <img src="http://www.top12movingbiz.com/admin/letters/images/body2Followup.png" alt="" border="0" width="100%" style="margin-bottom:-25px">
        </td>
        </tr>--->
        
        
        
        <tr>
			<td align="center" colspan="5">
			<h2><span style="color: red">#dateformat(getinfo.appointment_date, "MM/DD/YYYY")#</span> </h1>
			</td>
        </tr>
       
       <tr>
		<td colspan="5">
       		<img src="http://www.top12movingbiz.com/admin/letters/images/Newfooter.png" style="border: 0; margin-top:10px;" alt="Affordable USA Movers BBB Business Review" width="100%">
		</td>
       </tr>
       
</table>--->    
	</cfoutput>
</cfif>

</body>
</html>