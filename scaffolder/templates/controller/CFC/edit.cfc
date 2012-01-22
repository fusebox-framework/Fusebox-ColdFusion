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
<<!--- Create a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnForm")>>
<<!--- Some fields are removed from the form if present as we never edit them directly --->>
<<cfset lRemoveFields = listAppend(listAppend(oMetaData.getLIgnoreOnInsert(),oMetaData.getActiveIndicator()),oMetaData.getDeletedIndicator())>>
<<cfset lFields = oMetaData.ListRemoveList(lFields,lRemoveFields)>>
<<!--- Some fields are display only if present as we never edit them --->>
<<cfset lDisplayFields = oMetaData.ListKeepList(lFields,oMetaData.getLIgnoreOnUpdate())>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Edit" access="public" output="Yes" hint="I display the selected $$objectName$$ record in a form which allows the user to edit it.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Edit $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I display the selected $$objectName$$ record in a form which allows the user to edit it." />

		<cfset XFA.View="#myFusebox.originalCircuit#.$$objectName$$_View" />
		<cfset XFA.Save="#myFusebox.originalCircuit#.$$objectName$$_Action_Edit" />
		<cfset XFA.Cancel="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<!--- Get the current $$objectName$$ --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_get_$$objectName$$.cfm" />
		<!--- Populate any related table recordsets --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_related_$$objectName$$.cfm" />
		
		<!--- Display the form --->
		<cfparam name="fieldlist" default="$$lFields$$"/>
		<cfset mode="edit" />
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_form_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>
