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
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<!--- Make a list of fields pointing to parent tables --->>
<<cfset lFKFields = oMetaData.getFKFieldList(objectName,"manyToOne")>>

<<cfoutput>>
	<cfparam name="variables.message" default="#structNew()#">
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<cfparam name="variables.message.$$aFields[i].name$$" default="#structNew()#">
	<cfparam name="variables.message.$$aFields[i].name$$.en_us" default="#structNew()#">
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.label" default="$$aFields[i].label$$">
  <<cfif structKeyExists(aFields[i],"required") AND aFields[i].required>>
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.required" default="$$aFields[i].label$$ is a required field." />
  <</cfif>>
  <<cfif structKeyExists(aFields[i],"type") AND (aFields[i].type IS "numeric" OR aFields[i].type IS "boolean")>>
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.invalidType" default="$$aFields[i].label$$ must be $$aFields[i].type$$." />
  <<cfelseif structKeyExists(aFields[i],"type")>>
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.invalidType" default="$$aFields[i].label$$ must be a valid $$aFields[i].type$$." />
  <</cfif>>
  <<cfif structKeyExists(aFields[i],"type") AND structKeyExists(aFields[i],"maxlength") 
 			AND aFields[i].type IS NOT "integer" AND aFields[i].type IS NOT "numeric" 
 			AND aFields[i].type IS NOT "boolean" AND aFields[i].type IS NOT "date" AND aFields[i].type IS NOT "time">>
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.tooLong" default="Your entry in $$aFields[i].label$$ is too long, maximum length is $$aFields[i].maxlength$$." />
  <</cfif>>
  <<cfif ListFindNoCase(lFKFields,aFields[i].name)>>
	<cfparam name="variables.message.$$aFields[i].name$$.en_us.notFound" default="Your entry in $$aFields[i].label$$ was not found in the database." />
  <</cfif>>
<</cfloop>>
<</cfoutput>>
