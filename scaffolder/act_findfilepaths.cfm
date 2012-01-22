<!--- Work out where everything should be placed in the file system --->
<!--- baseDirectory     Where your code will go 			Eg: [D:\Inetpub\wwwroot\ScaffoldTest\ ] --->
<!--- baseURL           The URL for the same directory   	Eg: [/ScaffoldTest/ ] --->
<!--- rootDirectory  	The web server root 				Eg: [D:\Inetpub\wwwroot\ ] --->
<!--- thisFilePath	 	The file path to the scaffolder 	Eg: [D:\Inetpub\wwwroot\scaffolder\ ] --->
<!--- thisURLPath		The URL path to the scaffolder  	Eg: [/scaffolder/ ] --->
<!--- thisCFCPath		The CFC path to the scaffolder		Eg: [scaffolder.] --->

<!--- Work out where all the generated code will go. --->
<!--- If the user interface supplies these values we should use them. --->
<cfif isDefined("URL.baseDirectory")>
	<cfset baseDirectory = URL.baseDirectory>
<cfelseif isDefined("Form.baseDirectory")>
	<cfset baseDirectory = Form.baseDirectory>
<cfelse>
	<cfset baseDirectory = getDirectoryFromPath(cgi.PATH_TRANSLATED)>
</cfif>

<cfif isDefined("URL.baseURL")>
	<cfset baseURL = URL.baseURL>
<cfelseif isDefined("Form.baseURL")>
	<cfset baseURL = Form.baseURL>
<cfelse>
	<cfset baseURL = getDirectoryFromPath(cgi.SCRIPT_NAME)>
</cfif>

<!--- Work out where the URL and File path match by removing matching directories until they don't match --->
<cfset rootDirectory = baseDirectory>
<cfset rootURL = baseURL>

<cfloop from="#ListLen(baseURL,'/')#" to="1" step="-1" index="i">
	<cfset thisDir = ListGetAt(baseURL,i,"/")>
	<cfif listLast(rootDirectory,"\/") IS thisDir>
		<cfset rootDirectory = left(rootDirectory,(len(rootDirectory) - len(thisDir) - 1))>
		<cfset rootURL = left(rootURL,(len(rootURL) - len(thisDir) - 1))>
	</cfif>
</cfloop>

<!--- Work out which directory the scaffolder is located in (this template is in the same place)--->
<cfset thisFilePath = getDirectoryFromPath(getCurrentTemplatePath())>

<cfif Left(thisFilePath,Len(rootDirectory)) IS rootDirectory>
	<cfset thisURLPath = rootURL & replace(removeChars(thisFilePath, 1, Len(rootDirectory)),"\","/","all")>
<cfelse>
	<cfset thisURLPath = rootURL & "Rubbish/">
</cfif>

<cfset thisCFCPath = replace(removeChars(thisURLPath,1,1),"/",".","all")>

