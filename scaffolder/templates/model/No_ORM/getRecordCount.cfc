<<!---
Copyright 2006-07 Objective Internet Ltd - http://www.objectiveinternet.com

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
<<!--- Create a array of the many to one joined objects --->>
<<cfset aJoinedObjects = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="getRecordCountByFields" output="false" returntype="numeric" hint="I get the number of records in the table.">
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
		<cfargument name="$$aFields[i].alias$$" type="<<cfif aFields[i].type IS "boolean">>Any<<cfelse>>$$aFields[i].type$$<</cfif>>" required="false" /><</cfloop>>
		<!--- Joined Fields ---><!--- <<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">>
		<cfargument name="$$lFirst(aJoinedFields[i].prefix)$$$$uFirst(aJoinedFields[i].alias)$$" type="<<cfif aJoinedFields[i].type IS "boolean">>Any<<cfelse>>$$aJoinedFields[i].type$$<</cfif>>" required="false" /><</cfloop>>
		 --->
		<cfset var qList = "" />
		
		<cfquery name="qRecordCount" datasource="#variables.dsn#">
			SELECT 	COUNT(*) AS theRecordCount
			FROM	[$$objectName$$]
			<!--- <<cfloop from="1" to="$$ArrayLen(aJoinedObjects)$$" index="i">>
			$$aJoinedObjects[i].joinType$$ JOIN [$$aJoinedObjects[i].name$$] ON 
			<<cfloop from="1" to="$$ArrayLen(aJoinedObjects[i].links)$$" index="j">>[$$objectName$$].[$$aJoinedObjects[i].links[j].from$$] = [$$aJoinedObjects[i].name$$].[$$aJoinedObjects[i].links[j].to$$]<<cfif j NEQ ArrayLen(aJoinedObjects[i].links)>> AND <</cfif>><</cfloop>>
			<</cfloop>> --->
			WHERE	0=0
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
			<cfif structKeyExists(arguments,"$$aFields[i].alias$$") and len(arguments.$$aFields[i].alias$$)>
				AND	[$$objectName$$].[$$aFields[i].name$$] = <cfqueryparam value="#arguments.$$aFields[i].alias$$#" CFSQLType="$$aFields[i].SQLType$$" />
			</cfif><</cfloop>>
		<!--- <<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">>
			<cfif structKeyExists(arguments,"$$aJoinedFields[i].table$$$$aJoinedFields[i].alias$$") and len(arguments.$$aJoinedFields[i].table$$$$aJoinedFields[i].alias$$)>
				AND	[$$aJoinedFields[i].table$$].[$$aJoinedFields[i].name$$] = <cfqueryparam value="#arguments.$$lFirst(aJoinedFields[i].prefix)$$$$uFirst(aJoinedFields[i].alias)$$#" CFSQLType="$$aJoinedFields[i].SQLType$$" />
			</cfif><</cfloop>> --->
		</cfquery>
		
		<cfreturn qRecordCount.theRecordCount />
	</cffunction>
<</cfoutput>>