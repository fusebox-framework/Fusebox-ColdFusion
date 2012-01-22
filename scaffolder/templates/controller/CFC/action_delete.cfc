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
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
	<cffunction name="$$objectName$$_Action_Delete" access="public" hint="I delete the selected $$objectName$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset request.page.subtitle="Delete $$oMetaData.getSelectedTableLabel()$$" />
		<cfset request.page.description="I delete the selected $$objectName$$ record." />

		<cfset XFA.Continue="#myFusebox.originalCircuit#.$$objectName$$_List" />
		
		<!--- Delete the selected $$objectName$$ record. --->
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/qry_delete_$$objectName$$.cfm" />
		
		<cflocation addtoken="No" url="#myFusebox.getSelf()#?fuseaction=#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._startrow#&_maxrows=#attributes._maxrows#" />
	</cffunction>
<</cfoutput>>
