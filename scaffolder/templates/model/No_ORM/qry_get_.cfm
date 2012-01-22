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
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="qry_get_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I set up the $$objectName$$ service object and get the selected $$objectName$$ object from the database.
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
			<<cfloop from="1" to="$$arrayLen(aPKFields)$$" index="thisKey">>
			<$$aPKFields[thisKey].fuseDocType$$ name="$$aPKFields[thisKey].alias$$"/><</cfloop>>
		</in>
		<out>
			<object name="$$objectName$$Service" scope="variables" />
			<object name="o$$objectName$$" scope="variables" />
		</out>
	</io>
</fusedoc>
--->
<!--- Create the $$objectName$$ service object --->
<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
<!--- Get the object from the database --->
<cfset variables.o$$objectName$$ = variables.$$objectName$$Service.get$$objectName$$(<<cfloop from="1" to="$$listLen(lPKFields)$$" index="i">>$$listGetAt(lPKFields,i)$$=attributes.$$listGetAt(lPKFields,i)$$<<cfif i LT listLen(lPKFields)>>,<</cfif>><</cfloop>>)/>
</cfsilent>
<</cfoutput>>
