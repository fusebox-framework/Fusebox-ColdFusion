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
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Action_Add" access="public" output="Yes" hint="I add a new $$objectName$$ record using the entered data.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Add $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I add a new $$objectName$$ record using the entered data." />

		<cfset xfa.Continue="#myFusebox.originalCircuit#.$$objectName$$_List" />
		<cfset xfa.Save="#myFusebox.originalCircuit#.$$objectName$$_Action_Add" />
		<cfset xfa.Cancel="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<!--- Create an empty $$objectName$$  --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_create_$$objectName$$.cfm" />
		<!--- Populate the $$objectName$$  --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/act_populate_$$objectName$$.cfm" />
		<!--- Validate the $$objectName$$  --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/act_validate_$$objectName$$.cfm" />
		
		<!--- If the $$objectName$$ is valid then add it to the database --->
		<cfif objectIsValid>
			<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_save_$$objectName$$.cfm" />
		</cfif>
		
		<!--- Save was not sucessful so we redisplay the form with error messages --->
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
