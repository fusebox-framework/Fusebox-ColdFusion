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
<<!--- Set the name of the object (table alias) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Set the name of the table --->>
<<cfset tableName = oMetaData.getSelectedTable()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of PK fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>

<<cfoutput>>
	<cffunction name="getAutoSuggest" access="public" output="false" returntype="query">
		<cfargument name="suggestionColumn" required="Yes">
		<cfargument name="suggestionValue" required="Yes">
		<cfargument name="maxrows" required="Yes">
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
		<cfargument name="$$aFields[i].alias$$" type="<<cfif aFields[i].type IS "boolean">>Any<<cfelse>>$$aFields[i].type$$<</cfif>>" required="false" <<cfif aFields[i].alias IS "$$oMetadata.getActiveIndicator()$$">>default="true"<<cfelseif aFields[i].alias IS "$$oMetadata.getDeletedIndicator()$$">>default="false"<</cfif>> /><</cfloop>>
		
		<cfset var qList = "" />
		<cfset var orderBy = "#arguments.suggestionColumn# ASC" />
		
		<!--- Check to see that we have a valid column name --->
		<cfif NOT listFindNoCase(lFields,arguments.suggestionColumn)>
			<cfset qList=queryNew(arguments.suggestionColumn,"varchar")>
			<cfreturn qList />
		</cfif>
		
		<!--- Query the table. --->
		<cfquery name="qList" datasource="#variables.dsn#">
			SELECT 	<cfif structKeyExists(arguments,"maxrows") AND arguments.maxrows GT 0>TOP #arguments.maxrows#</cfif>
					DISTINCT
					#arguments.suggestionColumn#
			FROM	[$$tableName$$]
			
			WHERE	#arguments.suggestionColumn# LIKE <cfqueryparam value="#arguments.suggestionValue#%" cfsqltype="CF_SQL_VARCHAR" />
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
			<cfif structKeyExists(arguments,"$$aFields[i].alias$$") and len(arguments.$$aFields[i].alias$$)>
				AND	[$$aFields[i].name$$] = <cfqueryparam value="#arguments.$$aFields[i].alias$$#" CFSQLType="$$aFields[i].SQLType$$" />
			</cfif><</cfloop>>
			<cfif structKeyExists(arguments, "sortByFieldList") and len(arguments.sortByFieldList)>
				ORDER BY #orderBy#
			</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>
	
<</cfoutput>>

