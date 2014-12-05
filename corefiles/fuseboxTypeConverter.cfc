<cfinterface displayname="Type Converter">
<!--- I think interfaces are useless in CFML at run time. Feel free to implement this class but this is mostly here 
to help document how to get TypeConverters working in Fusebox. --->

	<cffunction name="init" />
	<cffunction name="convert" />

	<!--- I strongly recommend treating converters as stateless but they 
		are stored at the application level for performance so
		if you want to ensure they are cleared after use implement reset --->
	<!--- cffunction name="reset"  /  --->
	

</cfinterface>