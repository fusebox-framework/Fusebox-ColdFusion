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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnForm")>>
<<!--- Some fields are removed from the display if present as we never add them directly --->>
<<cfset lFields = oMetaData.ListRemoveList(lFields,oMetadata.getLSkipColumns())>>
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Add" access="public" output="Yes" hint="I display a blank form allowing the user to enter a new $$objectName$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Add $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I display a blank form allowing the user to enter a new $$objectName$$ record." />
		
		<cfset XFA.Save="#myFusebox.originalCircuit#.$$objectName$$_Action_Add" />
		<cfset XFA.Cancel="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<!--- Create an empty $$objectName$$ --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_create_$$objectName$$.cfm" />
		<!--- Populate any related table recordsets --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_related_$$objectName$$.cfm" />
		
		<!--- Display the form --->
		<cfparam name="fieldlist" default="$$lFields$$"/>
		<cfset mode="insert" />
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_form_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>
