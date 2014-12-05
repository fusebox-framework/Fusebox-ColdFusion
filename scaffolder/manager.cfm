<!--- 
I am the scaffolder manager. I call the requested functions of the scaffolder. This application 
is built like a small fusebox but with each fuseaction implemented with <cfif> statements.

I am triggered by the presence of a scaffolding.go parameter in the URL or Form scope.
Valid Values are: 
	url.scaffolding.go = display       			Show the user interface.
	url.scaffolding.go = introspectDB  			Instrospect DB and create scaffolding XML.
	url.scaffolding.go = build         			Build the application using the selected template.
	url.scaffolding.go = introspectDB,build  	Instrospect and Build
 --->

<!--- Need the following line since in all except trivial cases it will take a while to generate the code. --->
<cfsetting requestTimeOut = "3600" >
<cfif isDefined("url.scaffolding.go") OR isDefined("form.scaffolding.go")>
	<!--- Prefuseaction --->
	<!--- Set up all the required file and URL paths --->
	<cfinclude template="/scaffolder/act_findfilepaths.cfm">
	
	<!--- Copy URL and Form scope to attributes --->
	<cfscript>
		if (NOT IsDefined("attributes"))
    		attributes=structNew();
		StructAppend(attributes, url, "no");
		StructAppend(attributes, form, "no");
	</cfscript>
	
	<!--- Fuseaction = Display --->
	<cfif ListFindNoCase(attributes.scaffolding.go,"display")>
		<!--- We asked for the user interface, show it. --->
		<cfinclude template="/scaffolder/dsp_scaffolding.cfm">
		<!--- Next step will be called by the interface so we stop.  --->
		<cfabort>
	</cfif>
	
	<!--- Build the argumentsCollection to pass to the metadata object using data from the form. --->
	<cfset argumentCollection = structNew()>
	<cfset lArguments = "configFilePath,datasource,username,password,project,template,author,authorEmail,copyright,licence,version,lTables,lIgnoreOnInsert,lIgnoreOnUpdate,activeIndicator,deletedIndicator">
	
	<cfloop list="#lArguments#" index="thisArgument">
		<cfif isDefined("attributes.scaffolding.#thisArgument#") AND trim(Evaluate("attributes.scaffolding.#thisArgument#")) IS NOT "">
			<cfset argumentCollection[thisArgument] = Evaluate("attributes.scaffolding.#thisArgument#")>
		</cfif>
	</cfloop>
	
	<!--- Create the MetaData object.  --->
	<cfset oMetaData = CreateObject("component","scaffolder.scaffolder.metadata").init(argumentCollection=argumentCollection)>
	
	<!--- Fuseaction = introspectDB --->
	<cfif ListFindNoCase(attributes.scaffolding.go,"introspectDB")>
		<!--- We requested the database introspection. --->
		<cfset oMetaData.introspectDB()>
	</cfif>
	
	<!--- Fuseaction = build --->
	<cfif ListFindNoCase(attributes.scaffolding.go,"build")>
		<!--- Fix the default fuseaction in the index.cfm --->
		<cffile action="READ" file="#baseDirectory#index.cfm" variable="indexFile">
		<cfif indexFile CONTAINS "$$defaultFuseaction$$">
			<cfset indexFile = ReplaceNoCase(indexFile,"$$defaultFuseaction$$","#attributes.scaffolding.project#.#listFirst(attributes.scaffolding.lTables)#_List")>
			<cffile action="WRITE" file="#baseDirectory#index.cfm" output="#indexFile#" addnewline="No">
		</cfif>
		
		<!--- We requested the code to be generated so set up the cftemplate object and call build for each selected template. --->
		<cfset cftemplate = CreateObject("component","scaffolder.scaffolder.cftemplate").init()>
		<!--- Calculate how long the progress bar must be --->
		<cfif isDefined("attributes.scaffolding.lTables")>
			<cfset progressBar = 1 + (1 + ListLen(attributes.scaffolding.lTables))*ListLen(attributes.scaffolding.template)>
		</cfif>
		<cfset cftemplate.progressReport(message="Start",progress=1,fullProgress=progressBar)>
		<cfloop list="#attributes.scaffolding.template#" index="thisTemplate">
			<cfif isDefined("attributes.scaffolding.lTables")>
				<cfset oMetaData.build(cftemplate=cftemplate,template=thisTemplate,lTables=attributes.scaffolding.lTables,destinationFilePath=baseDirectory,baseURL=form.baseURL)>
			<cfelse>
				<cfset oMetaData.build(cftemplate=cftemplate,template=thisTemplate,destinationFilePath=baseDirectory,baseURL=form.baseURL)>
			</cfif>
			<cfset cftemplate.progressReport(message="Completed #ListFirst(thisTemplate,"/")# Code Generation.")>
		</cfloop>
		<cfset cftemplate.progressReport(message="End.",progress=progressBar,complete=true)>
	</cfif>
	<!--- Since code generation is complete we can stop. --->
	<cfabort>
</cfif>
