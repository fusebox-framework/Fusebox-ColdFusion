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
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<cfoutput>>
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>
		<cfargument name="$$aPKFields[i].alias$$" type="$$aPKFields[i].type$$" required="true" /><</cfloop>>
		
		<cfset $$objectName$$ = variables.TransferFactory.getTransfer().get("$$objectName$$.$$objectName$$"<<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>,arguments.$$aPKFields[i].alias$$<</cfloop>>) />
	  <<cfif ListFindNoCase(lFields,"isActive")>>
		<cfset $$objectName$$.setIsActive(false)>
		<cfset variables.TransferFactory.getTransfer().save($$objectName$$) />
	  <<cfelseif ListFindNoCase(lFields,"active")>>
	  	<cfset $$objectName$$.setActive(false)>
		<cfset variables.TransferFactory.getTransfer().save($$objectName$$) />
	  <<cfelse>>
		<cfset variables.TransferFactory.getTransfer().delete($$objectName$$) />
	  <</cfif>>
	  	<cfreturn true>
	</cffunction>
<</cfoutput>>