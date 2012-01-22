<<!---
Copyright 2007 Objective Internet Ltd - http://www.objectiveinternet.com

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
<<cfset lFields = "">>

<<cfoutput>>
	
	<!--- Properties ---><<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfset lFields = ListAppend(lFields, aFields[i].alias)>>
	<cfproperty name="$$lFirst(aFields[i].alias)$$" type="$$aFields[i].type$$" /><</cfloop>>
	<!--- Properties of Joined Fields ---><<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><cfproperty name="$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$" type="$$aJoinedFields[i].type$$" /><</cfloop>>
	
	<cffunction name="init" access="public" returntype="$$objectName$$Record" output="false">
	<<cfset lFields = "">>
	<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
		<cfargument name="$$lFirst(aFields[i].alias)$$" type="Any" required="false" default="<<cfif aFields[i].type IS "string">><<cfelseif aFields[i].type IS "boolean">>True<<cfelseif aFields[i].type IS "date">>#now()#<<cfelse>>0<</cfif>>" /><</cfloop>>
	<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">>
		<cfargument name="$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$" type="Any" required="false" default="<<cfif aJoinedFields[i].type IS "string">><<cfelseif aJoinedFields[i].type IS "boolean">>True<<cfelseif aJoinedFields[i].type IS "date">>#now()#<<cfelse>>0<</cfif>>" /><</cfloop>>
	
		<!--- run setters --->
	<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
		<cfset set$$uFirst(aFields[i].alias)$$(arguments.$$lFirst(aFields[i].alias)$$) /><</cfloop>>
	<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">>
		<cfset set$$uFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$(arguments.$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$) /><</cfloop>>
		
		<cfreturn this />
 	</cffunction>
	
<</cfoutput>>
