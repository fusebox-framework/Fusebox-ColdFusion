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
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnForm")>>
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Add_Form" access="public" output="Yes" hint="I display a blank form allowing the user to enter a new $$objectName$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Add $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I display a blank form allowing the user to enter a new $$objectName$$ record." />
		
		<cfset xfa.Save="#myFusebox.originalCircuit#.$$objectName$$_Action_Add" />
		<cfset xfa.Cancel="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		
		<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
		<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
		<cfset variables.$$aManyToOne[i].alias$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$aManyToOne[i].alias$$Service')><</cfloop>>
		
		<<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>
		<cfparam name="$$aPKFields[i].alias$$" <<cfif aPKFields[i].type IS "string">>default=""<<cfelse>>default="0"<</cfif>> /><</cfloop>>
		<cfset o$$objectName$$=variables.$$objectName$$Service.get$$objectName$$($$lPKFields$$) />
		
		<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
		<cfset variables.sortByFieldList="" />
		<cfinvoke component="#variables.$$aManyToOne[i].name$$Service#" method="getAll" returnvariable="q$$aManyToOne[i].name$$">
			<cfinvokeargument name="sortByFieldList" value="#variables.sortByFieldList#" />
		</cfinvoke><</cfloop>>
		
		<cfparam name="fieldlist" default="$$lFields$$"/>
		<cfset mode="insert" />
		
		<cfsavecontent variable="request.page.pageContent">
			<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
			<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_form_$$objectName$$.cfm" />
		</cfsavecontent>
	</cffunction>
<</cfoutput>>
