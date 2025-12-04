<!--- AFFILIATE ID DETECTION --->

<cfset servera='#cgi.server_name#'>
<cfif #servera# CONTAINS 'home'>
<cfset afftot = #LEN(servera)#>
<cfset rightrem = #afftot# - 19>
<cfset rightoff = #LEFT(servera, rightrem)#>
<cfset remtot = #LEN(rightoff)#>
<cfset leftrem = #remtot# - 4>
<cfset affid = #RIGHT(rightoff, leftrem)#>
</cfif>
<cfif parameterexists(affid) is 'no'>
<cfset affid=0>
</cfif>

