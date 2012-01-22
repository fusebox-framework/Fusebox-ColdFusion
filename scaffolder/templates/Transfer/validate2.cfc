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
<<!--- Set the name of the object (table) being updated --->>
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
	
	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfargument name="this$$objectName$$" required="True" type="$$objectName$$Record" />
		<cfargument name="errors" required="True" type="array" default="#arrayNew(1)#" />
		<cfargument name="fieldList" required="false" type="string" 
				 default="#variables._fieldList#">
		
		<cfloop list="#arguments.fieldList#" index="thisField">
			<cfset Evaluate("validate#thisField#(this$$objectName$$,errors)")>
		</cfloop>
		<cfreturn errors>
	</cffunction>
	
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<cffunction name="validate$$aFields[i].name$$" access="public" returntype="array" output="false">
		<cfargument name="this$$objectName$$" required="True" type="$$objectName$$Record" />
		<cfargument name="errors" required="true" type="array" />
		<cfset var thisError = structNew() />
		
	<<cfif structKeyExists(aFields[i],"required") AND aFields[i].required>><<!--- Required Field --->>
		<cfif (NOT len(trim(this$$objectName$$.get$$aFields[i].alias$$())))>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "$$aFields[i].label$$ is required." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
	<</cfif>>
		
	<<cfif structKeyExists(aFields[i],"validation") AND (aFields[i].validation IS "integer")>><!--- Integer --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("integer",trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Integer." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND (aFields[i].validation IS "real")>><!--- Numeric --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isNumeric(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Number." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "boolean">><!--- Boolean --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isBoolean(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be Yes or No." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "date">><!--- Date --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT LSisDate(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isDate(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Date." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "time">><!--- Time --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isTime(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.timeValidation = true>>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Time." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "currency">><!--- Currency --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("regex",trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())),"[0-9.,]*")>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Currency Amount." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "zip_code">><!--- Zip Code or Post Code --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isZip_Code(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.zipcodeValidation = true>>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Zip or Post Code." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "email">><!--- Email Address --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("email",trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Email Address." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "phone">><!--- Phone Number --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("regex",trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())),"[0-9\(\)\+ -]*")>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid Phone Number." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "url">><!--- URL --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isValid("URL",trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid URL." />
	<<cfelseif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "ip">><!--- IP Address --->
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isIPAddress(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))><<cfset variables.stValidations.ipValidation = true>>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid IP Address." />
	<<cfelse>>
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND NOT isSimpleValue(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())))>
			<cfset thisError.message = "$$aFields[i].label$$ must be a valid value." />
	<</cfif>>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "invalidType" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
	<<cfif structKeyExists(aFields[i],"type") AND aFields[i].type IS "date">>	<cfelseif len(trim(this$$objectName$$.get$$aFields[i].name$$())) AND this$$objectName$$.get$$aFields[i].name$$() DOES NOT CONTAIN "{">
			<cfset this$$objectName$$.set$$aFields[i].name$$(Replace(this$$objectName$$.get$$aFields[i].name$$(),"/","-","all"))>
			<cfset this$$objectName$$.set$$aFields[i].name$$(LSParseDateTime(this$$objectName$$.get$$aFields[i].name$$()))>
	<</cfif>>
		</cfif>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"maxlength") 
	  AND aFields[i].validation IS NOT "integer" AND aFields[i].validation IS NOT "real" 
	  AND aFields[i].validation IS NOT "boolean" AND aFields[i].validation IS NOT "date" AND aFields[i].validation IS NOT "time" >>
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) GT $$aFields[i].maxlength$$)>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.info = "$$aFields[i].maxlength$$" />
			<cfset thisError.message = "$$aFields[i].label$$ is too long, maximum is $$aFields[i].maxlength$$." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"minlength") 
	   AND aFields[i].validation IS NOT "integer" AND aFields[i].validation IS NOT "real" 
	   AND aFields[i].validation IS NOT "boolean" AND aFields[i].validation IS NOT "date" AND aFields[i].validation IS NOT "time" >>
		<cfif (len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) LT $$aFields[i].minlength$$)>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "tooShort" />
			<cfset thisError.info = "$$aFields[i].minlength$$" />
			<cfset thisError.message = "$$aFields[i].label$$ is too short, minimum is $$aFields[i].minlength$$." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"minValue") 
	  AND (aFields[i].validation IS "integer" OR aFields[i].validation IS "real")>>
		<cfif (val(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) LT $$aFields[i].minValue$$)>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "tooSmall" />
			<cfset thisError.info = "$$aFields[i].minValue$$" />
			<cfset thisError.message = "The value of $$aFields[i].label$$ is too small, minimum is $$aFields[i].minValue$$." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND structKeyExists(aFields[i],"maxValue") 
	  AND (aFields[i].validation IS "integer" OR aFields[i].validation IS "real")>>
		<cfif (val(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) GT $$aFields[i].maxValue$$)>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "tooSmall" />
			<cfset thisError.info = "$$aFields[i].maxValue$$" />
			<cfset thisError.message = "The value of $$aFields[i].label$$ is too large, maximum is $$aFields[i].maxValue$$." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
	<</cfif>>
	<<cfif structKeyExists(aFields[i],"validation") AND aFields[i].validation IS "parent">>
		<<cfloop from="1" to="$$arrayLen(aManyToOne)$$" index="j">>
			<<cfloop from="1" to="$$arrayLen(aManyToOne[j].links)$$" index="k">>
				<<cfif aManyToOne[j].links[k].from IS aFields[i].name>>
		<cfif len(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$())) AND 
			  NOT variables.$$aManyToOne[j].Alias$$Service.exists(trim(this$$uFirst(objectName)$$.get$$uFirst(aFields[i].name)$$()))>
			<cfset thisError.field = "$$aFields[i].alias$$" />
			<cfset thisError.type = "notFound" />
			<cfset thisError.info = "$$aManyToOne[j].Alias$$" />
			<cfset thisError.message = "The value of $$aFields[i].label$$ was not found in the $$aManyToOne[j].Alias$$ table." />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
				<</cfif>>
			<</cfloop>>
		<</cfloop>>
	<</cfif>>
		<cfreturn errors>
	</cffunction>
<</cfloop>>
	<<cfif structKeyExists(variables.stValidations,"timeValidation")>>
	<cffunction name="isTime">
		<cfargument name="timeValue" type="string" required="Yes">
		<cfset ampmTemp = "">
		<!--- Check that it is a '.' or ':' delimited list 2 or 3 long --->
		<cfif listLen(arguments.timeValue,".:") LT 1 OR listLen(arguments.timeValue,".:") GT 3>
			<cfreturn false>
		</cfif>
		<!--- Strip off any AM or PM from the time ---> 
		<cfif timeValue CONTAINS "am">
			<cfset ampmTemp = "am">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"am","")>
		<cfelseif timeValue CONTAINS "a">
			<cfset ampmTemp = "am">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"a","")>
		<cfif timeValue CONTAINS "pm">
			<cfset ampmTemp = "pm">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"pm","")>
		<cfelseif timeValue CONTAINS "p">
			<cfset ampmTemp = "pm">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"p","")>
		</cfif>
		<!--- Check that each part is a number in the right range --->
		<cfif NOT isNumeric(listgetat(arguments.timeValue,1,".:")) OR listgetat(arguments.timeValue,1,".:") GT 23 OR listgetat(ip,1,".:") LT 0>
			<cfreturn false>
		</cfif>
		<cfif ampmTemp IS NOT "" listgetat(arguments.timeValue,1,".:") GT 12 OR listgetat(ip,1,".:") LT 1>
			<cfreturn false>
		</cfif>
		<cfif NOT isNumeric(listgetat(arguments.timeValue,2,".:")) OR listgetat(arguments.timeValue,2,".:") GT 59 OR listgetat(ip,2,".:") LT 0>
			<cfreturn false>
		</cfif>
		<cfif listLen(arguments.timeValue,".:") EQ 3 AND (NOT isNumeric(listgetat(arguments.timeValue,3,".:")) OR listgetat(arguments.timeValue,3,".:") GT 59 OR listgetat(ip,3,".:") LT 0)>
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>
	<</cfif>>
	<<cfif structKeyExists(variables.stValidations,"zipcodeValidation")>>
	<cffunction name="isZip_Code" output="No" returntype="boolean" hint="I validate a US, Canadian or UK Post Code">
		<cfargument name="zipCode" type="string" required="Yes">
		<cfif isValid("zipcode",arguments.zipCode) OR isZipUK(zipCode) OR isZipCanada(zipCode)>
			<cfreturn true>
		</cfif>
		<cfreturn false>
	</cffunction>
	<cffunction name="isZipUK" output="No" returntype="boolean" hint="I validate a UK Post Code">
		<!--- valid patterns: A9 9AA, A9A 9AA, A99 9AA, AA9 9AA, AA9A 9AA, AA99 9AA --->
		<cfargument name="zipCode" type="string" required="Yes">
		<cfreturn isValid("regex", zipCode,'^[[:alpha:]][[:alpha:]]([[:digit:]]){1,2}( )?[[:digit:]][[:alpha:]][[:alpha:]]$')>
	</cffunction>
	<cffunction name="isZipCanada" output="No" returntype="boolean" hint="I validate a Canadian Post Code">
		<!--- valid pattern: A9A 9A9 --->
		<cfargument name="zipCode" type="string" required="Yes">
		<cfreturn isValid("regex", zipCode,'^[[:alpha:]][[:digit:]][[:alpha:]]( )?[[:digit:]][[:alpha:]][[:digit:]]$')>
	</cffunction>
	<</cfif>>
	<<cfif structKeyExists(variables.stValidations,"ipValidation")>>
	<cffunction name="isIPAddress">
		<cfargument name="ip" type="string" required="Yes">
		<cfset var ii = 1>
		<!--- Check that it is a '.' delimited list 4 long --->
		<cfif listlen(arguments.ip,".") IS NOT 4>
			<cfreturn false>
		</cfif>
		<!--- Check that each part is a number between 0 and 255 --->
		<cfloop from="1" to="4" index="ii">
			<cfif NOT isNumeric(listgetat(arguments.ip,ii,".")) OR listgetat(arguments.ip,ii,".") GT 255 OR listgetat(arguments.ip,ii,".") LT 0>
				<cfreturn false>
			</cfif>
		</cfloop>
		<!--- Check for the special cases of 255.255.255.255 or 0.0.0.0, which is not valid --->
		<cfif arguments.ip IS "255.255.255.255" OR arguments.ip is "0.0.0.0">
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>
	<</cfif>>
	
<</cfoutput>>
