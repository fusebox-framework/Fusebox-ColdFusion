<cfset highlightAppName = false>
<cfset highlightFilePath = false>
<cfset highlightPassword = false>

<!--- Check that the application is in the correct place --->
<cfset webrootPath = getDirectoryFromPath(cgi.PATH_TRANSLATED)>
<cfset urlPath = getDirectoryFromPath(cgi.PATH_INFO)>

<cfif ListLast(webrootPath,"/\") IS NOT "scaffolder" 
	OR  ListLast(urlPath,"/\") IS NOT "scaffolder">
	The scaffolder must be placed in the scaffolder subdirectory of the web root.
	<cfabort>
<cfelse>
	<cfset webrootPath = Left(webrootPath,len(webrootPath)-11)>
	<cfset urlPath = Left(urlPath,len(urlPath)-11)>
</cfif>
<cfif urlPath IS NOT "/">
	The scaffolder must be placed in the scaffolder subdirectory of the web root.
	<cfabort>
</cfif>

<cfif isDefined("form.scaffolding.applicationName") AND trim(form.scaffolding.applicationName) IS "">
	<cfset highlightAppName = true>
</cfif>
<cfif isDefined("form.scaffolding.configFilePath") AND trim(form.scaffolding.configFilePath) IS "">
	<cfset highlightFilePath = true>
</cfif>
<cfif isDefined("form.scaffolding.password") AND trim(form.scaffolding.password) IS "">
	<cfset highlightPassword = true>
</cfif>

<cfif isDefined("form.scaffolding.applicationName") AND trim(form.scaffolding.applicationName) IS NOT "" AND
	  isDefined("form.scaffolding.configFilePath") AND trim(form.scaffolding.configFilePath) IS NOT "" AND
	  isDefined("form.scaffolding.password") AND trim(form.scaffolding.password) IS NOT "">
	
	<cfif form.scaffolding.configFilePath CONTAINS "/" OR 
		  form.scaffolding.configFilePath CONTAINS "\">
		<cfset errortext2 = "The application directory must be directly under the webroot.">
	<cfelseif form.scaffolding.configFilePath IS "fusebox5">
		<cfset errortext2 = "It is not possible to share your application directory with the framework.">
	<cfelseif form.scaffolding.configFilePath IS "scaffolder">
		<cfset errortext2 = "It is not possible to share your application directory with the scaffolder.">
	<cfelse>
		<cfif NOT directoryExists(webrootPath & scaffolding.configFilePath)>
			<cfdirectory action="CREATE" directory="#webrootPath##scaffolding.configFilePath#">
		</cfif>
		
		<cfif NOT fileExists(webrootPath & scaffolding.configFilePath & "/index.cfm")>
			<cffile action="READ" file="#webrootPath#scaffolder/index-template.cfm" variable="indexFile">
		
			<cfset indexFile = ReplaceNoCase(indexFile,"$$applicationName$$",scaffolding.applicationName)>
			<cfset indexFile = ReplaceNoCase(indexFile,"$$password$$",scaffolding.password)>
		
			<cffile action="WRITE" file="#webrootPath##scaffolding.configFilePath#/index.cfm" output="#indexFile#" addnewline="No">
		</cfif>
		<cflocation url="/#scaffolding.configFilePath#/index.cfm?scaffolding.go=display" addtoken="No">
	</cfif>
</cfif>
	  
<cfinclude template="dsp_setup.cfm">