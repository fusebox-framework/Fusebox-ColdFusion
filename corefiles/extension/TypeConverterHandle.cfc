<cfcomponent output="false" fusebox:lifecycle="requeststart">

	<cffunction name="init">
		<cfargument name="fbXml" required="true" hint="Kinda Helps with Configuration" />
		<cfset variables.typeConverters = structNew() />
		<cfset load(fbXml) />
		<cfreturn this />
	</cffunction>
	<cffunction name="run">
		<cfargument name="attributes" hint="Fusebox's Attributes" />
		<cfargument name="event" hint="Fusebox's event object" />
		<cfargument name="myFusebox" hint="Fusebox's event object" />
		<cfset runConverters(arguments.attributes, arguments.event, arguments.myFusebox) />
	</cffunction>
	
	<cffunction name="addConverter" access="public"
				hint="Adds converter for the given parameter.">
		<cfargument name="object" />
		<cfargument name="parameter" />
		<cfargument name="target" />
		<cfset variables.typeConverters[parameter] = structNew() />
		<cfset variables.typeConverters[parameter].target = target />
		<cfset variables.typeConverters[parameter].object = createObject("component", object).init() />
	</cffunction>
	<cffunction name="runConverters" access="private"
				hint="Manages and executes the appropriate converters.">
		<cfargument name="parameters" />
		<cfargument name="event" />
		<cfargument name="myfusebox" />
		<cfset var converterKey = "" />
		<cfloop collection="#variables.typeConverters#" item="converterKey">
			<cfif structKeyExists(arguments.parameters, converterKey)>
				<cfset arguments.parameters[variables.typeConverters[converterKey].target] 
					= variables.typeConverters[converterKey].object
						.convert(arguments.parameters[converterKey]
								, converterKey, arguments.myfusebox.getApplicationData()
								, event ) />
				<cfif structKeyExists(variables.typeConverters[converterKey].object, "Reset")>
					<cfset variables.typeConverters[converterKey].object.reset() />
				</cfif>	
			</cfif>
		</cfloop>
	</cffunction>
	<cffunction name="load" returntype="void" access="private" output="false" 
					hint="I load the Type converters.">
			<cfargument name="fbCode" type="any" required="true" 
						hint="I am the parsed XML representation of the fusebox.xml file." />
			<cfset var converters = xmlSearch(arguments.fbCode,"/fusebox/converters/converter") />
			<cfset var n = arrayLen(converters) />
			<cfset var i = 0 />
			<cfset var target = "" />
			<cfloop from="1" to="#n#" index="i">
				<cfif not structKeyExists(converters[i].xmlAttributes, "class")>
					<cfthrow type="fusebox.badGrammar.requiredAttributeMissing"
							message="Required attribute is missing"
							detail="The attribute 'class' is required, for a 'converter' declaration in fusebox.xml." />
				</cfif>
				<cfif not structKeyExists(converters[i].xmlAttributes, "parameter")>
					<cfthrow type="fusebox.badGrammar.requiredAttributeMissing"
							message="Required attribute is missing"
							detail="The attribute 'parameter' is required, for the declaration of circuit '#converters[i].xmlAttributes.class#' in fusebox.xml." />
				</cfif>
				<cfif structKeyExists(converters[i].xmlAttributes, "target")>
					<cfset target = converters[i].xmlAttributes.target />
				<cfelse>
					<cfset target = converters[i].xmlAttributes.parameter />
				</cfif>
				<cfset addConverter(converters[i].xmlAttributes.class
													, converters[i].xmlAttributes.parameter
													, target ) />
			</cfloop>
	</cffunction>

</cfcomponent>