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
<<!--- Set the name of the object (table) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<!--- Look for the active and deleted flags --->>
<<cfset activeIndicator = oMetaData.getActiveIndicator()>>
<<cfset deletedIndicator = oMetaData.getDeletedIndicator()>>

<<cfoutput>>
	<cffunction name="getMultiple" access="public" output="false" returntype="query" 
				hint="I query the database and return a recordset containing records which match the criteria.">
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><cfargument name="$$aFields[i].alias$$" type="<<cfif aFields[i].type IS "boolean">>Any<<cfelse>>$$aFields[i].type$$<</cfif>>" required="false" <<cfif aFields[i].name IS "$$activeIndicator$$">>default="true"<<cfelseif aFields[i].name IS "$$deletedIndicator$$">>default="false"<</cfif>> />
		<</cfloop>>
		<!--- Joined Fields ---><!--- 
		<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><cfargument name="$$lFirst(aJoinedFields[i].prefix)$$$$uFirst(aJoinedFields[i].alias)$$" type="<<cfif aJoinedFields[i].type IS "boolean">>Any<<cfelse>>$$aJoinedFields[i].type$$<</cfif>>" required="false" <<cfif aJoinedFields[i].alias IS "$$oMetadata.getActiveIndicator()$$">>default="true"<<cfelseif aJoinedFields[i].alias IS "$$oMetadata.getDeletedIndicator()$$">>default="false"<</cfif>> />
		<</cfloop>> --->
		
		<cfargument name="sortByFieldList" default="" type="string" required="No" Hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC..."/>
		<cfargument name="startrow" default="1" type="numeric" required="No" />
		<cfargument name="maxrows" type="numeric" required="No" />
		
		<cfreturn variables.$$objectName$$Gateway.getByFields(argumentCollection=arguments) />
	</cffunction>
<</cfoutput>>
