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
<<!--- Set the name of the object (table alias) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Set the name of the table --->>
<<cfset tableName = oMetaData.getSelectedTable()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"insert")>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName,"insert")>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>

<<cfoutput>>
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="$$objectName$$" type="$$objectName$$Bean" required="true" hint="I add a new $$objectName$$ to the database." />
		
		<cfset var qCreate = 0 />
		<cfset var qGetId = 0 />
		<cftry>
			<cfquery name="qCreate" datasource="#variables.dsn#">
				INSERT INTO [$$tableName$$]
					(<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
					<<cfif (NOT structKeyExists(aFields[i],"identity") OR NOT aFields[i].identity) >>[$$aFields[i].name$$]<<cfif i NEQ ArrayLen(aFields)>>,<</cfif>><</cfif>><</cfloop>>
					)
				VALUES
					(<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
					<<cfif (NOT structKeyExists(aFields[i],"identity") OR NOT aFields[i].identity) >><cfqueryparam value="#arguments.$$objectName$$.get$$uFirst(aFields[i].alias)$$()#" CFSQLType="$$aFields[i].SQLtype$$" null="<<cfif aFields[i].type IS 'date'>>#arguments.$$objectName$$.get$$uFirst(aFields[i].alias)$$() IS createDate(100,1,1)#<<cfelse>>#NOT len(arguments.$$objectName$$.get$$aFields[i].alias$$())#<</cfif>>" /><<cfif i NEQ ArrayLen(aFields)>>,<</cfif>><</cfif>><</cfloop>>
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<!--- Get the most recent record from the database to find its key --->
		<cfquery name="qGetId" datasource="#variables.dsn#">
			SELECT 	[$$lPKFields$$] FROM [$$tableName$$]
			WHERE	<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfif (structKeyExists(aFields[i],"identity") AND aFields[i].identity) OR (structKeyExists(aFields[i],"maxlength") AND aFields[i].maxlength GT 256) >><<cfelse>>[$$tableName$$].[$$aFields[i].name$$] <<cfif aFields[i].type IS 'date'>><cfif arguments.$$objectName$$.get$$aFields[i].alias$$() IS createDate(100,1,1)><<cfelse>><cfif NOT len(arguments.$$objectName$$.get$$aFields[i].alias$$())><</cfif>> IS NULL<cfelse> = <cfqueryparam value="#arguments.$$objectName$$.get$$aFields[i].alias$$()#" CFSQLType="$$aFields[i].SQLtype$$"/></cfif><<cfif i NEQ ArrayLen(aFields)>> AND <</cfif>><</cfif>>
			<</cfloop>>
			ORDER BY <<cfloop list="$$lPKFields$$" index="thisPKField">>[$$thisPKField$$] DESC<<cfif thisPKField IS NOT listLast(lPKFields)>>,<</cfif>><</cfloop>>
			
		</cfquery>
		<!--- Set the key in the object --->
		<cfif qGetId.recordcount GT 0>
			<<cfloop list="$$lPKFields$$" index="thisPKField">>
			<cfset arguments.$$objectName$$.set$$uFirst(thisPKField)$$(qGetId.$$lFirst(thisPKField)$$)><</cfloop>>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
		
		<cfreturn true />
	</cffunction>
<</cfoutput>>