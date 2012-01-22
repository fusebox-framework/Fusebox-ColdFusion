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
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="qry_save_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I save the object in the database, and if sucessful redirect to the next page.
		If the database update fails I add an error to the error array.
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
			<xfa name="Continue"/>
			<array name="aErrors" />
			<object name="o$$uFirst(objectName)$$" scope="variables" />
			<object name="$$objectName$$Service" scope="variables" />
			<string name="_listSortByFieldList" scope="attributes" />
			<number name="_startrow" precision="integer" scope="attributes"/>
			<number name="_maxrows" precision="integer" scope="attributes"/>
		</in>
		<out>
			<array name="aErrors" comment="Only if there are errors" />
			<string name="fuseaction" scope="formOrUrl" />
			<string name="_listSortByFieldList" scope="formOrUrl" />
			<number name="_startrow" precision="integer" scope="formOrUrl" />
			<number name="_maxrows" precision="integer" scope="formOrUrl" />
		</out>
	</io>
</fusedoc>
--->
<!--- Add the new object to the database --->
<cftry>
	<cfset $$objectName$$Service.save(o$$objectName$$) />
	<cfcatch type="Database">
		<cfset o$$objectName$$.addError("Unknown","databaseError","#cfcatch.detail#") />
	</cfcatch>
	<cfcatch type="Any">
		<cfset o$$objectName$$.addError("Unknown","#cfcatch.type#","#cfcatch.detail#") />
	</cfcatch>
</cftry>
<cfset objectIsValid = NOT o$$uFirst(objectName)$$.isInvalid()>
<cfif objectIsValid>
	<cflocation addtoken="No" url="#myFusebox.getSelf()#?fuseaction=#XFA.Continue#&_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&_startrow=#attributes._startrow#&_maxrows=#attributes._maxrows#" />
</cfif>
<cfset objectIsNotValid = "true">
</cfsilent>
<</cfoutput>>
