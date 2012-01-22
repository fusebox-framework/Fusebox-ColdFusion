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
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Create a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnDisplay")>>
<<!--- Create a list to contain all the fields --->>
<<cfset lAllFields = lFields>>
<<!--- Add the joined fields to list of all fields --->>
<<cfset lAllFields = ListAppend(lAllFields,oMetaData.getJoinedFieldListFromXML(objectName,"showOnDisplay"))>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Display" access="public" output="Yes" hint="I display the selected $$objectName$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="View $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I display the selected $$objectName$$ record." />

		<cfset xfa.Edit="#myFusebox.originalCircuit#.$$objectName$$_Edit_Form" />
		<cfset xfa.Delete="#myFusebox.originalCircuit#.$$objectName$$_Action_Delete" />
		<cfset xfa.List="#myFusebox.originalCircuit#.$$objectName$$_Listing" />

		<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
					 
		<<cfloop list="$$lPKFields$$" index="thisPKField">>
		<cfset variables.$$thisPKField$$="#attributes.$$thisPKField$$#" /><</cfloop>>
		<cfset variables.o$$objectName$$="#variables.$$objectName$$Service.get$$objectName$$($$lPKFields$$)#" />
		<<cfloop from="1" to="$$arrayLen(aManyToOne)$$" index="thisParent">>
		<cfset variables.o$$uFirst(aManyToOne[thisParent].alias)$$ = o$$objectName$$.get$$aManyToOne[thisParent].alias$$()><</cfloop>>
		
		<cfparam name="fieldlist" default="$$lFields$$"/>
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_display_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>

