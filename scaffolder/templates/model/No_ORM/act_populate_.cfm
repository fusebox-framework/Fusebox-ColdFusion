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
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of the fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Generate an array of the Primary Key fields --->>
<<cfset aPKFields = oMetaData.getPKFieldsFromXML(objectName)>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="act_populate_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I populate the $$objectName$$ object with data from attributes scope.
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
			<object name="$$objectName$$" scope="variables" />
			<<cfloop from="1" to="$$arrayLen(aPKFields)$$" index="thisKey">>
			<$$aPKFields[thisKey].fuseDocType$$ name="$$aPKFields[thisKey].alias$$" scope="attributes"/><</cfloop>>
		</in>
		<out>
			<object name="$$objectName$$" scope="variables" />
		</out>
	</io>
</fusedoc>
--->
<!--- Set default values for each of the object's properties ---><<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
<cfparam name="attributes.$$aFields[i].alias$$" <<cfif aFields[i].type IS "string">>default=""<<cfelseif aFields[i].type IS "date">>default="1-January-0100"<<cfelseif aFields[i].alias IS oMetaData.getActiveIndicator()>>default="1"<<cfelse>>default="0"<</cfif>>/><<cfif aFields[i].type IS "date">><cfif trim(attributes.$$aFields[i].alias$$) IS ""><cfset attributes.$$aFields[i].alias$$ = "1-January-0100"></cfif><<cfelseif aFields[i].type IS "numeric">><cfif trim(attributes.$$aFields[i].alias$$) IS ""><cfset attributes.$$aFields[i].alias$$ = "0"></cfif><</cfif>><</cfloop>>
<!--- Set the object's properties ---><<cfloop list="$$lFields$$" index="thisField">>
<cfset variables.o$$objectName$$.set$$uFirst(thisField)$$(attributes.$$thisField$$) /><</cfloop>>
</cfsilent>
<</cfoutput>>
