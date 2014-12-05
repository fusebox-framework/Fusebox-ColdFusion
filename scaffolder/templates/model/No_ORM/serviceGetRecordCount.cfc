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
<<cfoutput>>
	<cffunction name="getRecordCount" access="public" output="false" returntype="numeric">
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><cfargument name="$$aFields[i].alias$$" type="<<cfif aFields[i].type IS "boolean">>Any<<cfelse>>$$aFields[i].type$$<</cfif>>" required="false" <<cfif aFields[i].alias IS "$$oMetadata.getActiveIndicator()$$">>default="true"<<cfelseif aFields[i].alias IS "$$oMetadata.getDeletedIndicator()$$">>default="false"<</cfif>> />
		<</cfloop>>
		<!--- Joined Fields ---><!--- 
		<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><cfargument name="$$lFirst(aJoinedFields[i].prefix)$$$$uFirst(aJoinedFields[i].alias)$$" type="<<cfif aJoinedFields[i].type IS "boolean">>Any<<cfelse>>$$aJoinedFields[i].type$$<</cfif>>" required="false" <<cfif aJoinedFields[i].alias IS "$$oMetadata.getActiveIndicator()$$">>default="true"<<cfelseif aJoinedFields[i].alias IS "$$oMetadata.getDeletedIndicator()$$">>default="false"<</cfif>> />
		<</cfloop>> --->
		
		<cfreturn variables.$$objectName$$Gateway.getRecordCountByFields(argumentCollection=arguments) />
	</cffunction>
<</cfoutput>>
