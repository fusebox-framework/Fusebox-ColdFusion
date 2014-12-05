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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnList")>>
<<!--- Create a list to contain all the fields --->>
<<cfset lAllFields = lFields>>
<<!--- Add the joined fields to list of all fields --->>
<<cfset lAllFields = ListAppend(lAllFields,oMetaData.getJoinedFieldListFromXML(objectName,"showOnList"))>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Listing" access="public" output="Yes" hint="I display a list of the records in the $$objectName$$ table.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="$$oMetaData.getSelectedTableLabel()$$ List" />
		<cfset request.page.description="I display a list of the records in the $$objectName$$ table." />
		
		<cfset xfa.Update="#myFusebox.originalCircuit#.$$objectName$$_Edit_Form" />
		<cfset xfa.Delete="#myFusebox.originalCircuit#.$$objectName$$_Action_Delete" />
		<cfset xfa.Display="#myFusebox.originalCircuit#.$$objectName$$_Display" />
		<cfset xfa.Add="#myFusebox.originalCircuit#.$$objectName$$_Add_Form" />
		<cfset xfa.Prev="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		<cfset xfa.Next="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		<cfset xfa.Page="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		<cfset xfa.Sort="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		
		<cfparam name="attributes._maxrows" default="10" />
		<cfparam name="attributes._startrow" default="1" />
		<<cfloop list="$$lPKFields$$" index="thisPKField">>
		<cfparam name="attributes._listSortByFieldList" default="$$objectName$$|$$thisPKField$$|ASC" /><</cfloop>>
		
		<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
		
		<cfset attributes.totalRowCount=variables.$$objectName$$Service.getRecordCount() />
		<cfif attributes._StartRow GT attributes.totalRowCount>
			<cfset attributes._startrow = val((attributes._maxrows * ((attributes.totalRowCount - 1) \ attributes._maxrows)) + 1) /> 
		</cfif>
		
		<cfset variables.q$$objectName$$ = variables.$$objectName$$Service.get$$objectName$$s(sortByFieldList=attributes._listSortByFieldList,startrow=attributes._startRow,maxrows=attributes._maxrows) />
		
		<cfparam name="fieldlist" default="$$lFields$$"/>
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_list_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>
