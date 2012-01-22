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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnDisplay")>>
<<!--- Create a list to contain all the fields --->>
<<cfset lAllFields = lFields>>
<<!--- Add the joined fields to list of all fields --->>
<<cfset lAllFields = ListAppend(lAllFields,oMetaData.getJoinedFieldListFromXML(objectName,"showOnDisplay"))>>

<<cfoutput>>
	<cffunction name="$$objectName$$_View" access="public" output="Yes" hint="I display the selected $$objectName$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="View $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I display the selected $$objectName$$ record." />

		<cfset XFA.Edit="#myFusebox.originalCircuit#.$$objectName$$_Edit" />
		<cfset XFA.Delete="#myFusebox.originalCircuit#.$$objectName$$_Action_Delete" />
		<cfset XFA.List="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<!--- You can modify the following list of fields to reorder, add to or remove fields from the displayed data --->
		<cfparam name="fieldlist" default="$$lFields$$"/>
		
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_view_$$objectName$$.cfm" />
		
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_view_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>

