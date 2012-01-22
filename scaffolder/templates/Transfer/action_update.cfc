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
<<!--- Generate an array of the table fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Action_Update" access="public" output="Yes" hint="I update the selected $$objectName$$ record using the entered data." >
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Edit $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I update the selected $$objectName$$ record using the entered data." />

		<cfset xfa.Continue="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		<cfset xfa.Save="#myFusebox.originalCircuit#.$$objectName$$_Action_Update" />
		<cfset xfa.Cancel="#myFusebox.originalCircuit#.$$objectName$$_Listing" />
		
		<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
		
		<<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>
		<cfparam name="attributes.$$aPKFields[i].alias$$" <<cfif aPKFields[i].type IS "string">>default=""<<cfelse>>default="0"<</cfif>>/><</cfloop>>
		<cfset o$$objectName$$=variables.$$objectName$$Service.get$$objectName$$(attributes.$$lPKFields$$) />
		
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
		<<cfif ListFindNoCase("Radio,Checkbox",aFields[i].formType)>><cfparam name="attributes.$$aFields[i].name$$" default="false"/>
		<<cfelseif aFields[i].type IS "date">><cfif trim(attributes.$$aFields[i].alias$$) IS ""><cfset attributes.$$aFields[i].alias$$ = "1-January-0100"></cfif><<cfelseif aFields[i].type IS "numeric">><cfif trim(attributes.$$aFields[i].alias$$) IS ""><cfset attributes.$$aFields[i].alias$$ = "0"></cfif>
		<</cfif>><cfset o$$objectName$$.set$$uFirst(aFields[i].name)$$(attributes.$$aFields[i].name$$) /><</cfloop>>
		
		<cfset aErrors=arrayNew(1)><!--- <cfset aErrors=$$objectName$$Service.validate(o$$objectName$$) /> --->
		
		<cfif ArrayLen(aErrors) EQ 0>
			<cfset success=$$objectName$$Service.save(o$$objectName$$) />
			<cfif success>
				<cflocation addtoken="No" url="#myFusebox.getSelf()#?fuseaction=#XFA.Continue#&amp;_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&amp;_startrow=#attributes._startrow#&amp;_maxrows=#attributes._maxrows#" />
			<cfelse>
				<cfset stError=structNew() />
				<cfset stError.message="Error in Database Update" />
				<cfset stError.field="Unknown" />
				<cfset ArrayAppend(aErrors,stError) />
			</cfif>
		</cfif>
		<cfif ArrayLen(aErrors) NEQ 0>
			<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
			<cfset variables.$$aManyToOne[i].alias$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$aManyToOne[i].alias$$Service')>
			<</cfloop>>
			
			<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
			<cfset variables.sortByFieldList="" />
			<cfinvoke object="$$aManyToOne[i].name$$Service" method="getAll" returnvariable="q$$aManyToOne[i].name$$">
				<cfinvokeargument name="sortByFieldList" value="#variables.sortByFieldList#" />
			</cfinvoke><</cfloop>>
			
			<cfparam name="fieldlist" default="$$lFields$$"/>
			
			<cfset mode="edit" />
			<cfsavecontent variable="request.page.pageContent">
				<cfif structKeyExists(request.page,"pageContent")><cfoutput>#request.page.pageContent#</cfoutput></cfif>
				<cfinclude template="../../view/v$$oMetaData.getProject()$$/dsp_form_$$objectName$$.cfm" />
			</cfsavecontent>
		</cfif>
	</cffunction>
<</cfoutput>>
