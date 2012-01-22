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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnForm")>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_Edit" access="public">
		<!-- Edit_Form: I display the selected $$objectName$$ record in a form which allows the user to edit it. -->
		<set name="request.page.subtitle" value="Edit $$oMetaData.getSelectedTableLabel()$$" />
		<set name="request.page.description" value="I display the selected $$objectName$$ record in a form which allows the user to edit it." />

		<xfa name="Save" value="$$objectName$$_Action_Edit" />
		<xfa name="Cancel" value="$$objectName$$_List" />
		
		<!-- Get the current $$objectName$$ -->
		<include circuit="m$$oMetaData.getProject()$$" template="qry_get_$$objectName$$.cfm" />
		<!-- Populate any related table recordsets -->
		<include circuit="m$$oMetaData.getProject()$$" template="qry_related_$$objectName$$.cfm" />
		
		<!-- Display the form in edit mode -->
		<set name="fieldlist" value="$$lFields$$" overwrite="false" />
		<set name="mode" value="edit" />
		<include circuit="v$$oMetaData.getProject()$$" template="dsp_form_$$objectName$$.cfm" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
<</cfoutput>>
