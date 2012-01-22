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

<<cfoutput>>
	<fuseaction name="$$objectName$$_List" access="public">
		<!-- Listing: I display a list of the records in the $$objectName$$ table. -->
		<set name="request.page.subtitle" value="$$oMetaData.getSelectedTableLabel()$$ List" />
		<set name="request.page.description" value="I display a list of the $$objectName$$ records in the table." />

		<xfa name="Edit" value="$$objectName$$_Edit" />
		<xfa name="Delete" value="$$objectName$$_Action_Delete" />
		<xfa name="View" value="$$objectName$$_View" />
		<xfa name="Add" value="$$objectName$$_Add" />
		<xfa name="Prev" value="$$objectName$$_List" />
		<xfa name="Next" value="$$objectName$$_List" />
		<xfa name="Page" value="$$objectName$$_List" />
		<xfa name="Sort" value="$$objectName$$_List" />
		
		<set name="attributes._maxrows" value="10" overwrite="false" />
		<set name="attributes._startrow" value="1" overwrite="false" />
		<set name="attributes._listSortByFieldList" value="<<cfloop list="$$lPKFields$$" index="thisPKField">>$$objectName$$|$$thisPKField$$|ASC,<</cfloop>>" overwrite="false" />
		
		<set name="fieldlist" value="$$lAllFields$$" overwrite="false"/>
		
		<include template="../../model/m$$oMetaData.getProject()$$/qry_list_$$objectName$$.cfm" />
		
		<include template="../../view/v$$oMetaData.getProject()$$/dsp_list_$$objectName$$.cfm" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
<</cfoutput>>
