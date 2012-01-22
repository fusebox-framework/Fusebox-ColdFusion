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
<<!--- Look for the update dates --->>
<<cfset lSkipFields = oMetaData.getLIgnoreOnInsert()>>

<<cfoutput>>
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>
		<cfargument name="$$aPKFields[i].alias$$" type="$$aPKFields[i].type$$" required="true" /><</cfloop>>
		
		<cfset var $$objectName$$ = createObject("component","$$oMetaData.getDottedPath(arguments.DestinationFilePath,oMetaData.getProject(),oMetaData.getSelectedTableAlias())$$Bean").init(argumentCollection=arguments) />
		<<cfif trim(oMetaData.getActiveIndicator()) IS NOT "" AND ListFindNoCase(lFields,oMetaData.getActiveIndicator())>>
		<cfset variables.$$objectName$$DAO.read($$objectName$$) />
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfif aFields[i].type IS "date" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset $$objectName$$.set$$uFirst(aFields[i].alias)$$(now())>
		<<cfelseif aFields[i].format IS "integer" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset $$objectName$$.set$$uFirst(aFields[i].alias)$$(0)><</cfif>><</cfloop>>
		<cfset $$objectName$$.set$$uFirst(oMetaData.getActiveIndicator())$$(false)>
		<cfreturn variables.$$objectName$$DAO.update($$objectName$$) />
		<<cfelseif trim(oMetaData.getDeletedIndicator()) IS NOT "" AND ListFindNoCase(lFields,oMetaData.getDeletedIndicator())>>
		<cfset variables.$$objectName$$DAO.read($$objectName$$) />
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfif aFields[i].type IS "date" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset $$objectName$$.set$$uFirst(aFields[i].alias)$$(now())>
		<<cfelseif aFields[i].format IS "integer" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset $$objectName$$.set$$uFirst(aFields[i].alias)$$(0)><</cfif>><</cfloop>>
		<cfset $$objectName$$.set$$uFirst(oMetaData.getDeletedIndicator())$$(true)>
		<cfreturn variables.$$objectName$$DAO.update($$objectName$$) />
		<<cfelse>><cfreturn variables.$$objectName$$DAO.delete($$objectName$$) />
		<</cfif>>
	</cffunction>
<</cfoutput>>