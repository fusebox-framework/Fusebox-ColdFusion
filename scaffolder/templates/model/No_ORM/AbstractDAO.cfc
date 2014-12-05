<cfcomponent displayname="AbstractDAO.cfc">
	<cffunction name="queryRowToStruct" access="private" returntype="struct" hint="I convert a row from the query into a struct.">
		<cfargument name="qData" required="Yes" type="query">
		
		<cfset var stData = structNew()>
		
		<cfloop list="#qData.columnlist#" index="thisColumn">
			<cfset stData[thisColumn] = qData[thisColumn][1]>
		</cfloop>
		
		<cfreturn stData>
	</cffunction>
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Object" type="Any" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Object)>
			<cfset success = update(arguments.Object) />
		<cfelse>
			<cfset success = create(arguments.Object) />
		</cfif>
		
		<cfreturn success />
	</cffunction>
	
</cfcomponent>
	
