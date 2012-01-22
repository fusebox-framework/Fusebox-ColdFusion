<<!---
Copyright 2008 Objective Internet Ltd - http://www.objectiveinternet.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->>
<<!--- Set the name of the object (table) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of PK fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfset variables.stValidations = structNew()>>
<<cfoutput>>
	<cfset variables._fieldList = "$$lFields$$">
	
	<cffunction name="validate" access="public" returntype="any" output="false" hint="I validate the requested fields in the object">
		<cfargument name="$$objectName$$" required="True" type="$$objectName$$Bean" />
		<cfargument name="fieldList" required="false" type="string" default="#variables._fieldList#">
		
		<!--- loop over the requested fields and call the validator for each --->
		<cfloop list="#arguments.fieldList#" index="thisField">
			<cfset evaluate("validate#thisField#($$objectName$$)")>
		</cfloop>
	</cffunction>
	
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<cffunction name="validate$$uFirst(aFields[i].name)$$" access="public" returntype="any" output="false" hint="I validate the $$lFirst(aFields[i].name)$$ field.">
		<cfargument name="$$objectName$$" required="True" type="$$objectName$$Bean" />
		
	<<cfif structKeyExists(aFields[i],"required") AND aFields[i].required>><<!--- Required Field --->>
		<cfif (NOT len(trim(arguments.$$objectName$$.get$$aFields[i].alias$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","required","$$aFields[i].label$$ is required.") />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND (aFields[i].validation IS "integer")>><!--- Integer --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("integer",trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidInteger","$$aFields[i].label$$ must be a valid Integer.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND (aFields[i].validation IS "real")>><!--- Numeric --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isNumeric(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidNumeric","$$aFields[i].label$$ must be a valid Number.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "boolean">><!--- Boolean --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isBoolean(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidBoolean","$$aFields[i].label$$ must be must be Yes or No.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "date">><!--- Date --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT LSisDate(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isDate(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidDate","$$aFields[i].label$$ must be a valid Date.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "time">><!--- Time --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isTime(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.timeValidation = true>>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidTime","$$aFields[i].label$$ must be a valid Time.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "currency">><!--- Currency --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("regex",trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$()),"[0-9.,]*"))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidCurrencyAmount","$$aFields[i].label$$ must be a valid Currency Amount.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "zip_code">><!--- Zip Code or Post Code --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isZip_Code(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.zipcodeValidation = true>>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidZipCode","$$aFields[i].label$$ must be a valid Zip or Post Code.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "email">><!--- Email Address --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("email",trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidEmail","$$aFields[i].label$$ must be a valid Email Address.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "phone">><!--- Phone Number --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("regex",trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$()),"[0-9\(\)\+ -]*"))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidPhone","$$aFields[i].label$$ must be a valid Phone Number.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "url">><!--- URL --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("URL",trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidUrl","$$aFields[i].label$$ must be a valid URL.") />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "ip">><!--- IP Address --->
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isIPAddress(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.ipValidation = true>>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidIpAddress","$$aFields[i].label$$ must be a valid IP Address.") />
	<<cfelse>>
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isSimpleValue(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","invalidSimpleValue","$$aFields[i].label$$ must be a valid value.") />
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"type") AND aFields[i].type IS "date">>	<cfelseif len(trim(arguments.$$objectName$$.get$$aFields[i].name$$())) AND arguments.$$objectName$$.get$$aFields[i].name$$() DOES NOT CONTAIN "{"><!--- Clean up date --->
			<cfset $$objectName$$.set$$aFields[i].name$$(Replace(arguments.$$objectName$$.get$$aFields[i].name$$(),"/","-","all"))>
			<cfset $$objectName$$.set$$aFields[i].name$$(LSParseDateTime(arguments.$$objectName$$.get$$aFields[i].name$$()))>
	<</cfif>>
		</cfif>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"maxlength") 
	  AND aFields[i].validation IS NOT "integer" AND aFields[i].validation IS NOT "real" 
	  AND aFields[i].validation IS NOT "boolean" AND aFields[i].validation IS NOT "date" AND aFields[i].validation IS NOT "time" >>
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) GT $$aFields[i].maxlength$$)>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","tooLong","$$aFields[i].label$$ is too long, maximum is $$aFields[i].maxlength$$.","$$aFields[i].maxlength$$") />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"minlength") 
	   AND aFields[i].validation IS NOT "integer" AND aFields[i].validation IS NOT "real" 
	   AND aFields[i].validation IS NOT "boolean" AND aFields[i].validation IS NOT "date" AND aFields[i].validation IS NOT "time" >>
		<cfif (len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) LT $$aFields[i].minlength$$)>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","tooShort","$$aFields[i].label$$ is too Short, minimum is $$aFields[i].minlength$$.","$$aFields[i].minlength$$") />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"minValue") 
	  AND (aFields[i].validation IS "integer" OR aFields[i].validation IS "real")>>
		<cfif (val(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) LT $$aFields[i].minValue$$)>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","tooSmall","The value of $$aFields[i].label$$ is too small, minimum is $$aFields[i].minValue$$.","$$aFields[i].minValue$$") />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"maxValue") 
	  AND (aFields[i].validation IS "integer" OR aFields[i].validation IS "real")>>
		<cfif (val(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) GT $$aFields[i].maxValue$$)>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","tooLarge","The value of $$aFields[i].label$$ is too small, minimum is $$aFields[i].maxValue$$.","$$aFields[i].maxValue$$") />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "parent">>
		<<cfloop from="1" to="$$arrayLen(aManyToOne)$$" index="j">>
			<<cfloop from="1" to="$$arrayLen(aManyToOne[j].links)$$" index="k">>
				<<cfif aManyToOne[j].links[k].from IS aFields[i].name>>
		<cfif len(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND 
			  NOT variables.$$aManyToOne[j].Alias$$Service.exists(trim(arguments.$$lFirst(objectName)$$.get$$uFirst(aFields[i].name)$$()))>
			<cfset $$objectName$$.addError("$$aFields[i].alias$$","notFound","The value of $$aFields[i].label$$ was not found in the $$aManyToOne[j].Alias$$ table.","$$aManyToOne[j].Alias$$") />
		</cfif>
				<</cfif>>
			<</cfloop>>
		<</cfloop>>
	<</cfif>>
		<cfreturn this>
	</cffunction>
<</cfloop>>
<</cfoutput>>
