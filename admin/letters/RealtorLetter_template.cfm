<cfparam name="REQUEST.letter_body" default="">

<style>
	table{
		font-family:calibri;
	}

	.fontbold{
		font-weight:bold;
	}
	
	.fontstyleitalic{
		font-style:italic;
	}
	
	.colornavy{
		color:#002060;
	}
	
	.colorred{
		color:#ff0000;
	}
	
	.colorblack{
		color:#000000;
	}
	.colorblue{
		color:#0070C0;
	}
	
	
	
	/* begin fontsize classes */
	.fontsize5{
		font-size:0.35em;
	}
	.fontsize6{
		font-size:6px;
	}
	
	.fontsize7{
		font-size:7px;
	}
	
	.fontsize8{
		font-size:8px;
	}
	
	.fontsize9{
		font-size:9px;
	}
	
	.fontsize10{
		font-size:10px;
	}
	
	.fontsize11{
		font-size:11px;
	}
	
	.fontsize12{
		font-size:12px;
		color:#666;
		font-style:italic;
	}
	
	.fontsize13{
		font-size:11.5px;
	}
	
	.fontsize14{
		font-size:14px;
	}
	
	.fontsize16{
		font-size:16px;
	}
	
	.fontsize18{
		font-size:18px;
	}
	
	.fontsize20{
		font-size:20px;
	}
	
	.fontsize24{
		font-size:24px;
	}
	.fontsize26{
		font-size:26px;
	}
	.fontsize28{
		font-size:28px;
	}

	.fontsize32{
		font-size:32px;
	}
	/* end fontsize classes */
	
	
	/* begin width classes */
	.width10p{
		width: 10%;
	}
	.width15p{
		width: 15%;
	}
	.width18p{
		width: 18%;
	}
	.width20p{
		width: 20%;
	}
	.width21p{
		width: 21%;
	}
	.width25p{
		width: 25%;
	}
	.width28p{
		width: 28%;
	}
	.width30p{
		width: 30%;
	}
	
	.width35p{
		width:35%;
	}
	
	.width40p{
		width: 40%;
	}
	.width42p{
		width:42%;
	}
	.width85p{
		width:85%;
	}
	.width38p{
		width:38%;
	}
	.width39p{
		width:39%;
	}
	.width50p{
		width:50%;
	}
	.width60p{
		width:60%;
	}
	.width80p{
		width:80%;
	}
	.width100p{
		width: 100%;
	}
	.width70p{
		width: 70%;
	}
	.width75p{
		width: 75%;
	}
	.width78p{
		width: 78%;
	}
	.width80p{
		width: 80%;
	}
	
	.width81p{
		width: 81%;
	}
	.width82p{
		width: 82%;
	}
	.width85p{
		width: 85%;
	}
	.width90p{
		width: 90%;
	}
	.height75p{
		height:75px;
	}
	.height84p{
		height:84px;
	}
	.height85p{
		height:85px;
	}
	.height86p{
		height:86px;
	}
	.height88p{
		height:88px;
	}
	
	.height90p{
		height: 90.95px;
	}
	height91p{
		height:91px;
	}
	.heightCustomize85p{
		height:85px;
	}
	.heightCustomize67p{
		height:67px;
	}
	/* end width classes */
	
	/* begin vertical align classes */
	.vertical-align-top{
		vertical-align:top;
	}
	/* end vertical align classes */
	
	.line-height-letter{
		line-height: 1.7em;
	}
	
	.text-align-center{
		text-align:center;
	}
	
	.text-underline{
		text-decoration:underline;
	}
	.text_italics {font-style:italic}
	


</style>
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="20%" align="center"><img src="http://www.top12movingbiz.com/admin/letters/images/1/Logo.jpg" width="90%"></td>
    <td width="45%">&nbsp;</td>
    <td width="25%" align="right" class="fontsize13">
    Nationwide USA Movers<br>
    Corporate Headquarters<br>
    244 Fifth Avenue-Suite 1297<br>
    New York-NY 10001
    </td>
  </tr>
  <tr>
  	<td colspan="3" align="right"><p class="fontsize13"><cfoutput>#DateFormat(Now(), "mm/dd/yyyy")#</cfoutput></p></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td>
	<cfoutput>#trim(REQUEST.letter_body)#</cfoutput>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td width="90%">&nbsp;</td>
  </tr>
  <tr>
    <td align="center">
    <span class="fontsize12">Nationwide USA Movers Inc<br />
244 Fifth Avenue, Suite 1297<br />
New York, NY 10001<br />
MC #945837 USDOT# 3558324</span>
    </td>
  </tr>
</table>
