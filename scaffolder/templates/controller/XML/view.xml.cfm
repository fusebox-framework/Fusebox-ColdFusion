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

<<cfoutput>>
	<fuseaction name="$$objectName$$_View" access="public">
		<!-- Display: I display the selected $$objectName$$ record. -->
		<set name="request.page.subtitle" value="View $$oMetaData.getSelectedTableLabel()$$" />
		<set name="request.page.description" value="I display the selected $$objectName$$ record." />

		<xfa name="Edit" value="$$objectName$$_Edit_Form" />
		<xfa name="Delete" value="$$objectName$$_Action_Delete" />
		<xfa name="List" value="$$objectName$$_List" />
		
		<!-- You can modify the following list of fields to reorder, add to or remove fields from the displayed data -->
		<set name="fieldlist" value="$$lFields$$" overwrite="false" />
		
		<include template="../../model/m$$oMetaData.getProject()$$/qry_view_$$objectName$$.cfm" />
		
		<include circuit="v$$oMetaData.getProject()$$" template="dsp_view_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
<</cfoutput>>

