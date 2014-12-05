<<!---
Copyright 2006-09 Objective Internet Ltd - http://www.objectiveinternet.com

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
<<!--- Look for the active and deleted flags --->>
<<cfset activeIndicator = oMetaData.getActiveIndicator()>>
<<cfset deletedIndicator = oMetaData.getDeletedIndicator()>>

<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="qry_list_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I set up the $$objectName$$ service object, initialise the totalRowCount and get a recordset of $$objectName$$ records.
	</responsibilities>
	<properties>
		<history author="$$oMetaData.getAuthor()$$" email="$$oMetaData.getAuthorEmail()$$" date="$$dateFormat(now(),'dd-mmm-yyyy')$$" role="Architect" type="Create" />
		<property name="copyright" value="(c)$$year(now())$$ $$oMetaData.getCopyright()$$" />
		<property name="licence" value="$$oMetaData.getLicence()$$" />
		<property name="version" value="$Revision: $$oMetaData.getVersion()$$ $" />
		<property name="lastupdated" value="$Date: $$DateFormat(now(),'yyyy/mm/dd')$$ $$ TimeFormat(now(),'HH:mm:ss')$$ $" />
		<property name="updatedby" value="$Author: $$oMetaData.getAuthor()$$ $" />
	</properties>
	<io>
		<in>
			<object name="myFusebox" />
			<number name="_StartRow" precision="integer" scope="attributes"/>
			<number name="_maxrows" precision="integer" scope="attributes"/>
			<string name="_listSortByFieldList" scope="attributes"/>
		</in>
		<out>
			<object name="$$objectName$$Service" scope="variables" />
			<recordset name="q$$objectName$$" scope="variables" />
		</out>
	</io>
</fusedoc>
--->

<<cfif ListFindNoCase(lFields,activeIndicator)>><!--- Set the default to only get active records --->
<cfparam name="attributes.$$activeIndicator$$" default="true"><</cfif>>
<<cfif ListFindNoCase(lFields,deletedIndicator)>><!--- Set the default to not get deleted records --->
<cfparam name="attributes.$$deletedIndicator$$" default="false"><</cfif>>
<!--- Set up the $$objectName$$ Service --->
<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
<!--- Get the total number of rows --->
<cfset attributes.totalRowCount=variables.$$objectName$$Service.getRecordCount() />
<!--- Check that start is not past the end --->
<cfif attributes._StartRow GT attributes.totalRowCount>
	<cfset attributes._startrow = val((attributes._maxrows * ((attributes.totalRowCount - 1) \ attributes._maxrows)) + 1) /> 
</cfif>
<!--- Get the next few rows from the database --->
<cfset variables.q$$objectName$$ = variables.$$objectName$$Service.getMultiple(sortByFieldList=attributes._listSortByFieldList,startrow=attributes._startRow,maxrows=attributes._maxrows<<cfif ListFindNoCase(lFields,activeIndicator)>>,$$activeIndicator$$=attributes.$$activeIndicator$$<</cfif>><<cfif ListFindNoCase(lFields,deletedIndicator)>>,$$activeIndicator$$=attributes.$$deletedIndicator$$<</cfif>>) />
</cfsilent>
<</cfoutput>>
