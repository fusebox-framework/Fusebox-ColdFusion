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
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_Action_Edit" access="public">
		<!-- Action_Edit: I update the selected $$objectName$$ record using the entered data. -->
		<set name="request.page.subtitle" value="Edit $$oMetaData.getSelectedTableLabel()$$" />
		<set name="request.page.description" value="I update the selected $$objectName$$ record using the entered data." />

		<xfa name="Continue" value="$$objectName$$_List" />
		<xfa name="Save" value="$$objectName$$_Action_Update" />
		<xfa name="Cancel" value="$$objectName$$_List" />
		
		<!-- Get the current $$objectName$$ -->
		<include circuit="m$$oMetaData.getProject()$$" template="qry_get_$$objectName$$.cfm" />
		<!-- Populate the $$objectName$$ -->
		<include circuit="m$$oMetaData.getProject()$$" template="act_populate_$$objectName$$.cfm" />
		<!-- Validate the $$objectName$$ -->
		<include circuit="m$$oMetaData.getProject()$$" template="act_validate_$$objectName$$.cfm" />
		
		<!-- If the $$objectName$$ is valid then update the database -->
		<if condition="#objectIsValid#">
			<true>
				<include circuit="m$$oMetaData.getProject()$$" template="qry_save_$$objectName$$.cfm" />
			</true>
		</if>
		
		<!-- Save was not sucessful so we redisplay the form with error messages -->
		<!-- Populate any related table recordsets -->
		<include circuit="m$$oMetaData.getProject()$$" template="qry_related_$$objectName$$.cfm" />
			
		<!-- Display the form in edit mode -->
		<set name="fieldlist" value="$$lFields$$" overwrite="false" />
		<set name="mode" value="edit" />
		<include circuit="v$$oMetaData.getProject()$$" template="dsp_form_$$objectName$$.cfm" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
<</cfoutput>>
