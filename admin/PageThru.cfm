<CFSETTING ENABLECFOUTPUTONLY="Yes">
<!-----------------------------------------------------------------------------------------------------
	
*** RETURNED VARS ***

PT_StartRow  - the first row of the paged query to be displayed on the current page.
PT_EndRow - the last row of the paged query to be displayed on the current page.
PT_PageThru - navigation.  Output this variable wherever you want the PageThru navigation
	to be displayed.
PT_ErrorCode - Numeric error code.  If not zero, an error occured. 
PT_ErrorMsg - Error description.


------------------------------------------------------------------------------------------------------>


<!--- INITIALIZE VARAIBLES --->
<CFPARAM NAME="Attributes.TotalRecords" DEFAULT="0">
<CFPARAM NAME="Attributes.DisplayCount" DEFAULT="25">
<CFPARAM NAME="Attributes.PageGroup" DEFAULT="10">
<CFPARAM NAME="Attributes.CurrentPage" DEFAULT="1">
<CFPARAM NAME="Attributes.TemplateURL" DEFAULT="">
<CFPARAM NAME="Attributes.AddedPath" DEFAULT="">
<CFPARAM NAME="Attributes.ImagePath" DEFAULT="">
<CFPARAM NAME="Attributes.ImageHeight" DEFAULT="10">
<CFPARAM NAME="Attributes.ImageWidth" DEFAULT="10">
<CFPARAM NAME="Attributes.HiLiteColor" DEFAULT="Red">
<CFPARAM NAME="Attributes.PreviousStr" DEFAULT="&lt;">
<CFPARAM NAME="Attributes.PreviousGroupStr" DEFAULT="&lt;&lt;">
<CFPARAM NAME="Attributes.NextStr" DEFAULT="&gt;">
<CFPARAM NAME="Attributes.NextGroupStr" DEFAULT="&gt;&gt;">
<CFSET ErrorCode = 0>
<CFSET PageStr = "">

<!--- ERROR CODES --->
<CFSET ErrorArray = ArrayNew(1)>
<CFSET ErrorArray[1] = "The 'TotalRecords' parameter must be a positive integer.">
<CFSET ErrorArray[2] = "The 'DisplayCount' parameter must be an integer greater than zero.">
<CFSET ErrorArray[3] = "The 'PageGroup' parameter must be a positive integer.">
<CFSET ErrorArray[4] = "The 'CurrentPage' parameter must be an integer greater than zero.">

<!--- CHECK IF PARAMETERS PASSED ARE PROPER --->
<CFIF NOT IsNumeric(Attributes.TotalRecords) OR Val(Attributes.TotalRecords) LT 0>
	<CFSET ErrorCode = 1>
</CFIF>
<CFIF NOT IsNumeric(Attributes.DisplayCount) OR Val(Attributes.DisplayCount) LT 1>
	<CFSET ErrorCode = 2>
</CFIF>
<CFIF NOT IsNumeric(Attributes.PageGroup) OR Val(Attributes.PageGroup) LT 0>
	<CFSET ErrorCode = 3>
</CFIF>
<CFIF NOT IsNumeric(Attributes.CurrentPage) OR Val(Attributes.CurrentPage) LT 1>
	<CFSET ErrorCode = 4>
</CFIF>


<!---	Calculate Page Starts and Stops	--->
<CFSET Start = (Attributes.CurrentPage - 1) * Attributes.DisplayCount + 1>
<CFSET End = Attributes.CurrentPage * Attributes.DisplayCount>
<CFSET End = IIf(End GT Attributes.TotalRecords, Attributes.TotalRecords, End)>

<CFSET MaxPages = Attributes.TotalRecords / Attributes.DisplayCount>
<CFIF Attributes.TotalRecords MOD Attributes.DisplayCount>
<CFSET MaxPages = IncrementValue(MaxPages)>
</CFIF>


<!---	Calculate the range of diaplyed pages	--->
<CFIF MaxPages GT Attributes.PageGroup AND Attributes.PageGroup>
	<CFIF (MaxPages - Attributes.CurrentPage) GT (Attributes.PageGroup - 1)>
		<CFSET FromPage = Attributes.CurrentPage>
		<CFSET ToPage = Attributes.CurrentPage + Attributes.PageGroup - 1>
	<CFELSE>
		<CFSET FromPage = MaxPages - (Attributes.PageGroup - 1)>
		<CFSET ToPage = MaxPages>
	</CFIF>
<CFELSE>
	<CFSET FromPage = 1>
	<CFSET ToPage = MaxPages>
</CFIF>


<!---	Decide to use hypertext or graphic navigation	--->
<CFIF NOT CompareNoCase(UCase(Attributes.ImagePath), 'NONE')>
	<CFSET PGStr = Attributes.PreviousGroupStr>
	<CFSET PPStr = Attributes.PreviousStr>
	<CFSET NPStr = Attributes.NextStr>
	<CFSET NGStr = Attributes.NextGroupStr>
<CFELSE>
	<CFSET PGStr = "<img src=""#Attributes.ImagePath#Images/lleftArrow.gif"" width=""#Attributes.ImageWidth#"" height=""#Attributes.ImageHeight#"" border=0 align=""absmiddle"" value=""#Attributes.PreviousGroupStr#"">">
	<CFSET PPStr = "<img src=""#Attributes.ImagePath#Images/leftArrow.gif"" width=""#Attributes.ImageWidth#"" height=""#Attributes.ImageHeight#"" border=0 align=""absmiddle"" value=""#Attributes.PreviousStr#"">">
	<CFSET NPStr = "<img src=""#Attributes.ImagePath#Images/rightArrow.gif"" width=""#Attributes.ImageWidth#"" height=""#Attributes.ImageHeight#"" border=0 align=""absmiddle"" value=""#Attributes.NextStr#"">">
	<CFSET NGStr = "<img src=""#Attributes.ImagePath#Images/rrightArrow.gif"" width=""#Attributes.ImageWidth#"" height=""#Attributes.ImageHeight#"" border=0 align=""absmiddle"" value=""#Attributes.NextGroupStr#"">">
</CFIF>


<CFIF MaxPages GT 1>
	<CFSET PageStr = "Page&nbsp;">
	<CFIF FromPage NEQ 1 AND Attributes.PageGroup>
		<CFIF (Attributes.CurrentPage - Attributes.PageGroup) GTE 1><CFSET Prev = Attributes.CurrentPage - Attributes.PageGroup><CFELSE><CFSET Prev = 1></CFIF>
		<CFSET PageStr = PageStr & " <A HREF=""#Attributes.TemplateURL#?CurrentPage=#Prev##Attributes.AddedPath#"">#PGStr#</A> ">
	</CFIF>
	<CFIF Attributes.CurrentPage NEQ 1><CFSET Prev = Attributes.CurrentPage - 1>
		<CFSET PageStr = PageStr & " <A HREF=""#Attributes.TemplateURL#?CurrentPage=#Prev##Attributes.AddedPath#"">#PPStr#</A> ">
	</CFIF>
	<CFLOOP INDEX="Count" FROM="#FromPage#" TO="#ToPage#">
		<CFIF Count IS Attributes.CurrentPage>
			<CFSET PageStr = PageStr & " <B><font color=""#Attributes.HiLiteColor#""> #Count#</font></B> ">
		<CFELSE>
			<CFSET PageStr = PageStr & " <A HREF=""#Attributes.TemplateURL#?CurrentPage=#Count##Attributes.AddedPath#""> #Count#</A> ">
		</CFIF>
	</CFLOOP>
	<CFIF Attributes.CurrentPage NEQ MaxPages><CFSET Next = Attributes.CurrentPage + 1>
		<CFSET PageStr = PageStr & " <A HREF=""#Attributes.TemplateURL#?CurrentPage=#Next##Attributes.AddedPath#"">#NPStr#</A> ">
	</CFIF>
	<CFIF ToPage NEQ MaxPages AND Attributes.PageGroup><CFSET Next = ToPage + 1>
		<CFSET PageStr = PageStr & " <A HREF=""#Attributes.TemplateURL#?CurrentPage=#Next##Attributes.AddedPath#"">#NGStr#</A> ">
	</CFIF>
</CFIF>

<!---	20000619
<CFSET Start = IIf(Start GT End, End, Start)>
--->

<!--- RETURN VARIABLES --->
<CFSET Caller.PT_StartRow = IIf(End, Start, 0)>
<CFSET Caller.PT_EndRow = End>
<CFSET Caller.PT_PageThru = PageStr>
<CFSET Caller.PT_ErrorCode = ErrorCode>
<CFIF ErrorCode IS 0>
	<CFSET Caller.PT_ErrorMsg = "OK.">
<CFELSE>
	<CFSET Caller.PT_ErrorMsg = ErrorArray[ErrorCode]>
</CFIF>

<CFSETTING ENABLECFOUTPUTONLY="No">
