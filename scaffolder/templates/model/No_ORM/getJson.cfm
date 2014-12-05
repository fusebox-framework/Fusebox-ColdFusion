<<!---
Copyright 2008 Objective Internet Ltd - http://www.objectiveinternet.com

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
<<cfset projectName = oMetadata.getProject()>>
<<!--- Set the name of the object (table) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Create a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnDisplay")>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Create a list of the table field types --->>
<<cfset lFieldTypes = "">>
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<<cfif aFields[i].type IS "numeric" OR aFields[i].type IS "datetime">>
		<<cfset lFieldTypes = ListAppend(lFieldTypes,aFields[i].validation)>>
	<<cfelse>>
		<<cfset lFieldTypes = ListAppend(lFieldTypes,aFields[i].type)>>
	<</cfif>>
<</cfloop>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$$objectName$$_getJson.cfm">
	<responsibilities>
		I get data from the $$objectName$$ table and pass it on in JSON format.
	</responsibilities>
	<properties>
		<history 
			author="Kevin Roche" 
			email="kevin@objectiveinternet.com" 
			date="30-Nov-2008" 
			role="architect" 
			type="create"/>
		<property name="copyright" value="(c)2008 Activity Forum Limited."/>
		<property name="licence" value="See licence.txt"/>
		<property name="version" value="3.50"/>
	</properties>
	<io>
		<in>
			<structure name="fusebox" scope="application" />
			<number name="start" scope="url" default="0" />
			<number name="limit" scope="url" default="10" comment="Number of records required." />
			<string name="sort" scope="url" default="title" />
			<string name="dir" scope="url" default="ASC" />
			<string name="query" scope="url" default="" />
			<string name="sort" scope="form" default="title" />
			<string name="dir" scope="form" default="ASC" />
			<string name="start" scope="form" default="0" comment="Number of the first record required (starting at 0)." />
		</in>
		<out>
			<structure format="json" >
				<recordset name="q$$objectName$$" primaryKeys="$$lPKFields$$" scope="variables" comments="Recordset containing $$objectName$$ records in JSON format." >
					<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><$$aFields[i].type$$ name="$$lFirst(aFields[i].alias)$$" />
					<</cfloop>>
				</recordset>
				<number name="totalcount" comment="Total number of records in the database"/>
			</structure>
		</out>
	</io>
</fusedoc>
--->
<cfscript>
	function trueFalse(value){
		if (trim(value) IS "")
			return "";
		if (value)
			return "true";
		return "false";
	}
</cfscript>

<cfapplication
	name="$$projectName$$"
	sessionmanagement="Yes"
	sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
	clientmanagement="No">
<cfset myFusebox=application.fusebox>
<cfsetting enablecfoutputonly="true" showdebugoutput="false">

<!--- set defaults in url scope --->
<cfparam name="url.start" default="0">
<cfparam name="url.limit" default="10">
<cfparam name="url.sort" default="title">
<cfparam name="url.dir" default="ASC">
<cfparam name="url.query" default="">
<!--- merge url scope into form scope without overwriting --->
<cfset form = StructAppend(form, url, false)>

<!--- grid filter support --->
<!--- coldfusion doesn't handle HTML arrays so we need to count the filter[] struct keys --->
<cfset filterIndex = -1>
<cfloop condition="#StructKeyExists(form, 'filter[#filterIndex+1#][field]')#">
	<cfset filterIndex = filterIndex + 1>
</cfloop>

<!--- define query columns --->
<cfset lFields = "$$lFields$$">
<cfset lDataTypes = "$$lFieldTypes$$">
<cfset lNewData = RepeatString("varchar,", listLen(lFields))>

<!--- validate sort column and sort direction --->
<cfif NOT ListFindNoCase(lFields, form.sort)><cfset form.sort = "title"></cfif>
<cfif NOT ListFindNoCase("ASC,DESC", form.dir)><cfset form.dir = "ASC"></cfif>

<cfset variables.$$uFirst(objectName)$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$uFirst(objectName)$$Service')>

<!--- Get the record count --->
<cfset _totalRowCount=variables.$$uFirst(objectName)$$Service.getRecordCount(isActive=1) />
<!--- Get the requested records --->
<cfset variables.q$$uFirst(objectName)$$ = variables.$$uFirst(objectName)$$Service.getMultiple(sortByFieldList="$$uFirst(objectName)$$|#form.sort#|#form.dir#",startrow=(form.start+1),maxrows=form.limit) />

<!--- Clean up boolean and date fields --->
<cfset variables.q$$uFirst(objectName)$$_Formatted = queryNew(lFields,lNewData)>
<cfloop query="variables.q$$uFirst(objectName)$$">
	<cfset QueryAddRow(variables.q$$uFirst(objectName)$$_Formatted)>
	<cfloop from="1" to="#listLen(lFields)#" index="i">
		<cfset thisColumn = listGetAt(lFields,i)>
		<cfswitch expression="#listGetAt(lDataTypes,i)#">
			<cfcase value="integer">
				<cfset thisValue = val(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])>
			</cfcase>
			<cfcase value="date">
				<cftry><cfset thisValue = lsDateFormat(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])><cfcatch><cfset thisValue = ""></cfcatch></cftry>
			</cfcase>
			<cfcase value="datetime">
				<cftry><cfset thisValue = lsDateFormat(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow]) & " " & lsTimeFormat(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])><cfcatch><cfset thisValue = ""></cfcatch></cftry>
			</cfcase>
			<cfcase value="time">
				<cftry><cfset thisValue = lsTimeFormat(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])><cfcatch><cfset thisValue = ""></cfcatch></cftry>
			</cfcase>
			<cfcase value="currency">
				<cftry><cfset thisValue = lsCurrencyFormat(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])><cfcatch><cfset thisValue = ""></cfcatch></cftry>
			</cfcase>
			<cfcase value="boolean">
				<cftry><cfset thisValue = trueFalse(variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow])><cfcatch><cfset thisValue = ""></cfcatch></cftry>
			</cfcase>
			<cfdefaultcase>
				<cfset thisValue = variables.q$$uFirst(objectName)$$[thisColumn][q$$uFirst(objectName)$$.currentRow]>
			</cfdefaultcase>
		</cfswitch>
		<cfset QuerySetCell( variables.q$$uFirst(objectName)$$_Formatted,thisColumn,thisValue)>
	</cfloop>
</cfloop>

<!--- put data and total row count into a struct we can use client side --->
<cfset myResult = StructNew()>
<cfset myResult["query"] = q$$uFirst(objectName)$$_Formatted>
<cfset myResult["totalcount"] = _totalRowCount>

<!--- use cfjson serialization for compatibility --->
<cfobject name="json" component="$$projectName$$.coldext.json.json">

<cfoutput>
#json.encode(myResult,"array","lower")#
</cfoutput>

<cfsetting enablecfoutputonly="true">

<</cfoutput>>
