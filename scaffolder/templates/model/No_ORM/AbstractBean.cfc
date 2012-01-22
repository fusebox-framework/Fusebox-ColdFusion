<cfcomponent displayname="AbstractBean.cfc"
	hint="I am an abstract class. I should not be called directly but inherited using the extends attribute of cfcomponent. I provide utility methods, validation handling and dynamic getters and setters.">  
	
	<cfproperty name="_properties" type="struct">
	<cfproperty name="_isInvalid" type="boolean" hint="Use isInvalid() to access.">
	<cfproperty name="_errors" type="struct" hint="Use getErrorArrayFor() to access.">
	<cfproperty name="_testCrashDummy" type="string" hint="Used only for testing." gettable="true" settable="true">
	
	<cfset variables.instance = structNew()>
	<cfset variables.instance._isInvalid = "false">
	<cfset variables.instance._errors = structNew()>
	<cfset variables.instance._testCrashDummy = "">
	
	<cffunction name="init" 
				hint="I am a method that may be overridden. Just here for completeness."
				output="false">
		<cfreturn this>
	</cffunction>
	
	<!--- Get and set the memento. --->
	<cffunction name="setMemento"
			hint="I am a useful method that allows all the properties to be set using a struct."
			access="public" 
			returntype="Any" 
			output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" 
			hint="I am a useful method that allows all the properties to be retrieved as a struct."
			access="public" 
			returntype="struct" 
			output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
	
	<!--- Validation management --->
	<cffunction name="isInvalid" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance._isInvalid />
	</cffunction>
	
	<cffunction name="addError" 
				hint="Use this to add an error to the collection for this object."
				returntype="Any"
				output="false">
		<cfargument name="field" required="true" type="string" />
		<cfargument name="type" required="true" type="string" />
		<cfargument name="message" required="true" type="string" />
		<cfargument name="info" required="false" type="string" />
		
		<cfset var newError = structNew()>
		
		<cfif NOT structKeyExists(variables.instance._errors,arguments.field)>
			<cfset variables.instance._errors[arguments.field] = arrayNew(1) />
		</cfif>
		
		<cfset newError.field = arguments.field />
		<cfset newError.type = arguments.type />
		<cfset newError.message = arguments.message />
		<cfif isDefined("arguments.info")><cfset newError.info = arguments.info /></cfif>
		
		<cfset arrayAppend(variables.instance._errors[arguments.field],newError)>
		
		<cfset variables.instance._isInvalid = "true" />
		
		<cfreturn this /><!--- to allow method chaining --->
		
	</cffunction>
	
	<cffunction name="totalErrorCount" access="public" output="false" returntype="numeric">
		<cfset var errorCount = 0>
		<cfloop collection="#variables.instance._errors#" item="thisField">
			<cfset errorCount = errorCount + arrayLen(variables.instance._errors[thisField])>
		</cfloop>
		<cfreturn errorCount>
	</cffunction>
	
	<cffunction name="hasErrorsFor" access="public" returntype="boolean" hint="I checks for errors for a field." output="false">
		<cfargument name="field" type="string" required="true" />
		<cfreturn structKeyExists(variables.instance._errors,arguments.field)/>
	</cffunction>
	
	<cffunction name="getErrorArrayFor" access="public" returntype="array" hint="I gets an array for all error messages for a field." output="false">
		<cfargument name="field" type="string" required="true" />
		
		<cfset var Local = structNew() />
		
		<cfif NOT structKeyExists(variables.instance,"_errors")>
			<cfreturn arrayNew(1) />
		</cfif>
		<cfif NOT structKeyExists(variables.instance._errors,arguments.field)>
			<cfreturn arrayNew(1) />
		</cfif>
		
		<!--- we're here so we must have some error(s) to return --->
		<cfreturn variables.instance._errors[arguments.field] />
	</cffunction>
	
	<!--- Default setters and getters --->
	<cffunction name="onMissingMethod"
			hint="I act as a generic getter and setter for the class properties."
			access="public"
			description="Usage getXYZ() or setXYZ(value) where XYZ is the property name" 
			returntype="any"
			output="false">
		<cfargument name="missingMethodName" type="string" />
		<cfargument name="missingMethodArguments" type="struct" />
		<cfset var propertyName = "" />
		
		<cfset getAccessors() />
		
		<cfswitch expression="#Left( arguments.missingMethodName, 3 )#">
			<cfcase value="get">
				<cfset propertyName = ReplaceNoCase( arguments.missingMethodName, "get", "" ) />
				<cfif StructKeyExists( variables.instance._properties, propertyName ) AND variables.instance._properties[propertyName].gettable>
					<cfreturn variables.instance[ propertyName ] />
				<cfelseif StructKeyExists( variables.instance._properties, propertyName )>
					<cfthrow type="notGettable" message="Property '#propertyName#' is not marked gettable. Cannot get value." />
				<cfelse>
					<cfthrow type="unknownProperty" message="Unknown property '#propertyName#'. Cannot get value." />
				</cfif>
			</cfcase>
			<cfcase value="set">
				<!--- I do not validate the type as I want to be able to save any string here and validate it later. --->
				<cfset propertyName = ReplaceNoCase( arguments.missingMethodName, "set", "" ) />
				
				<cfif StructKeyExists( variables.instance._properties, propertyName ) AND variables.instance._properties[propertyName].settable>
					<cfset variables.instance[ propertyName ] = arguments.missingMethodArguments[1] />
				<cfelseif StructKeyExists( variables.instance._properties, propertyName )>
					<cfthrow type="notSettable" message="Property '#propertyName#' is not marked settable. Cannot set value." />
				<cfelse>
					<cfthrow type="unknownProperty" message="Unknown property '#propertyName#'. Cannot set value." />
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfthrow type="unknownMethod" message="Unknown method #arguments.missingMethodName#." />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
		
	<cffunction name="getAccessors"
		 hint="I build a structure of public properties, data types and if the property is gettable aor settable."
		 access="public"
		 output="false">
		<cfset var metadata = "" />
		<cfset var properties = arrayNew(1) />
		<cfset var index = "" />
		 
	  <cfif StructKeyExists( variables.instance, "_properties" ) AND IsStruct( variables.instance._properties )>
		 <cfreturn variables.instance._properties />
	  <cfelse>
		 <!--- The first time we get or set a property we need to build a structure of properties --->
		 <cfset variables.instance._properties = {} />
		 
		 <cfset metadata = getMetaData(this)>
		 
		 <!--- Loop through the component hierarchy --->
		 <cfloop condition="structKeyExists(metadata,'properties') OR structKeyExists(metadata,'extends')">
			<cfif structKeyExists(metadata,"properties")>
				<cfset properties = metadata.properties />
				<cfloop array="#properties#" index="index">
				  <cfset variables.instance._properties[index.name] = structNew()/>
				  <cfif IsDefined("index.type")>
					 <cfset variables.instance._properties[index.name].type = index.type/>
				  <cfelse>
					 <cfset variables.instance._properties[index.name].type = "any" />
				  </cfif>
				  <cfif IsDefined("index.gettable")>
					 <cfset variables.instance._properties[index.name].gettable = iif(index.gettable,"true","false")/>
				  <cfelse>
					 <cfset variables.instance._properties[index.name].gettable = "false" />
				  </cfif>
				  <cfif IsDefined("index.settable")>
					 <cfset variables.instance._properties[index.name].settable = iif(index.settable,"true","false")/>
				  <cfelse>
					 <cfset variables.instance._properties[index.name].settable = "false"/>
				  </cfif>
				</cfloop>
			</cfif>
			<!--- Check if we need to go to the next level of hierarchy --->
			<cfif structKeyExists(metadata,"extends")>
				<cfset metadata = metadata.extends>
			<cfelse>
				<cfset metadata = "">
			</cfif>
		 </cfloop>
		 
		 <cfreturn variables.instance._properties />
	  </cfif>
		 
	</cffunction>
</cfcomponent>
