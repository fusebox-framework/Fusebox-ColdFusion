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
<<!--- Look for the update and create dates --->>
<<cfset lSkipFields = oMetaData.getLSkipColumns()>>
<<!--- Look for the active and deleted flags --->>
<<cfset activeIndicator = oMetaData.getActiveIndicator()>>
<<cfset deletedIndicator = oMetaData.getDeletedIndicator()>>

<<cfoutput>>
	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="$$objectName$$" type="$$objectName$$Bean" required="yes" />
		<<cfloop from="1" to="$$arrayLen(aFields)$$" index="i">><<cfif aFields[i].type IS "date" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset arguments.$$objectName$$.set$$uFirst(aFields[i].alias)$$(now())>
		<<cfelseif aFields[i].format IS "integer" AND ListFindNoCase(lSkipFields,aFields[i].alias)>><cfset arguments.$$objectName$$.set$$uFirst(aFields[i].alias)$$(0)>
		<</cfif>><</cfloop>> 
		<cfreturn variables.$$objectName$$DAO.save($$objectName$$) />
	</cffunction>
<</cfoutput>>