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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnList")>>
<<!--- Create a list to contain all the fields --->>
<<cfset lAllFields = lFields>>
<<!--- Add the joined fields to list of all fields --->>
<<cfset lAllFields = ListAppend(lAllFields,oMetaData.getJoinedFieldListFromXML(objectName,"showOnList"))>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfoutput>>
	<cffunction name="$$objectName$$_List" access="public" hint="I display a list of the records in the $$objectName$$ table.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="$$oMetaData.getSelectedTableLabel()$$ List" />
		<cfset request.page.description="I display a list of the $$objectName$$ records." />

		<cfset XFA.Edit="#myFusebox.originalCircuit#.$$objectName$$_Edit" />
		<cfset XFA.Delete="#myFusebox.originalCircuit#.$$objectName$$_Action_Delete" />
		<cfset XFA.View="#myFusebox.originalCircuit#.$$objectName$$_View" />
		<cfset XFA.Add="#myFusebox.originalCircuit#.$$objectName$$_Add" />
		<cfset XFA.Prev="#myFusebox.originalCircuit#.$$objectName$$_List" />
		<cfset XFA.Next="#myFusebox.originalCircuit#.$$objectName$$_List" />
		<cfset XFA.Page="#myFusebox.originalCircuit#.$$objectName$$_List" />
		<cfset XFA.Sort="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<cfparam name="attributes._maxrows" default="10"/>
		<cfparam name="attributes._startrow" default="1" />
		<cfparam name="attributes._listSortByFieldList" default="<<cfloop list="$$lPKFields$$" index="thisPKField">>$$objectName$$|$$thisPKField$$|ASC,<</cfloop>>" />
		
		<cfparam name="fieldlist" default="$$lAllFields$$"/>
		
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_list_$$objectName$$.cfm" />
		
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_list_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>
