<cfcomponent displayname="AbstractGateway" hint="I am an abstract class that is used to set up common methods in a gateway. I should not be called directly but inherited using the extends attribute of cfcomponent">
	
	<cffunction name="init" access="public" output="false" returntype="Any">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getAll" access="public" output="false" returntype="query">
		<cfargument name="sortByFieldList" required="No" type="string">
		<cfreturn getByFields(argumentCollection=arguments)>
	</cffunction>
	
</cfcomponent>
	
