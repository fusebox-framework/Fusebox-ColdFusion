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
<<!--- Create a list to contain all the fields --->>
<<cfset lAllFields = lFields>>
<<!--- Get an array of joinedfields --->>
<<cfset aJoinedFields = oMetaData.getJoinedFieldsFromXML(objectName)>>
<<!--- Add the joined fields to list of all fields --->>
<<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">>
	<<cfset lAllFields = ListAppend(lAllFields,aJoinedFields[i].table & aJoinedFields[i].alias)>>
<</cfloop>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>

<<cfoutput>>

<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_list_$$objectName$$.cfm,v $" language="ColdFusion 7.01" version="2.0"  >
	<responsibilities>
		I display a listing of the $$objectName$$ records from a recordset. 
		Each record in the list has a link for viewing, deleting, and editing the selected 
			$$objectName$$ record.
		If there are more records than can comfortably displayed I show a list of the pages with link to
			each page and prev and next buttons.
		I also display a link to add a new $$objectName$$.
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
			<string name="self" scope="request" />
			<string name="XFA.Display" scope="variables" comments="link to view a record" />
			<string name="XFA.Edit" scope="variables" comments="link to edit a record" />
			<string name="XFA.Add" scope="variables" comments="link to add a record" />
			<string name="XFA.Delete" scope="variables" comments="link to delete a record" />
			<string name="XFA.Prev" scope="variables" comments="link to next page" />
			<string name="XFA.Next" scope="variables" comments="link to next page" />
			
			<number name="_maxrows" scope="attributes" optional="Yes" comments="Used to limit the display to a number of records." />
			<number name="_startrow" scope="attributes" optional="Yes" comments="Used to specify the first record to display." />
			<number name="_totalRowCount" precision="integer" scope="variables" comments="Count of rows in the $$objectName$$ table." />
			<string name="_listSortByFieldList" default="">
			
			<recordset name="q$$objectname$$" primaryKeys="$$lPKFields$$" scope="variables" comments="Recordset containing $$objectName$$ records " >
			<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<$$aFields[i].type$$ name="$$lFirst(aFields[i].alias)$$" /><</cfloop>>
			<<!--- <<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><<cfif NOT ListFindNoCase(lFields,aJoinedFields[i].alias)>>
				<$$aJoinedFields[i].type$$ name="$$aJoinedFields[i].alias$$" /><</cfif>><</cfloop>> --->>
			</recordset>
			
			<list name="fieldlist" scope="variables" optional="Yes" 
				default="$$lAllFields$$" 
				comments="List of fields to display." />
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
			<string name="pkey" scope="formOrUrl" comments="the primary key of the record being viewed, edited or deleted" />
		</out>
	</io>
</fusedoc>
--->
<cfparam name="XFA.Display">
<cfparam name="XFA.Update">
<cfparam name="XFA.Delete">
<cfparam name="XFA.Add">
<cfparam name="XFA.Page">
<cfparam name="XFA.Prev">
<cfparam name="XFA.Next">

<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">

<cfparam name="attributes._totalRowCount" default="0">
<cfparam name="request.searchSafe" default="false">

<cfset sortParams = appendParam("","_listSortByFieldList",attributes._listSortByFieldList)>
<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
<cfset pageParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>

<!--- Complete list of fields that could be displayed --->
<cfparam name="variables.fieldlist" default="$$lFields$$"><<!--- <cfparam name="variables.fieldlist" default="$$lAllFields$$"> --->>

</cfsilent>
<cfsetting enablecfoutputonly="No"><cfsetting enablecfoutputonly="No">
<table width="790" border="0" cellpadding="2" cellspacing="2" summary="This table shows a list of $$objectName$$ records." class="">
	<cfoutput>
	<tr>
		<cfloop list="#variables.fieldlist#" index="thisField">
			<cfswitch expression="#thisField#">
				<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<cfcase value="$$lFirst(aFields[i].alias)$$">
					<th width="" align="right" class="standard">
						<cfif isDefined("attributes._listSortByFieldList") AND attributes._listSortByFieldList IS "$$aFields[i].table$$|$$lFirst(aFields[i].alias)$$|ASC">
							<a href="#myFusebox.getSelf()#?fuseaction=#XFA.Sort#&_listsortByFieldList=$$objectName$$|$$lFirst(aFields[i].alias)$$|DESC"><<cfif ListLast(aFields[i].label," ") IS "Id" AND structKeyExists(aFields[i],"parent")>>$$Left(aFields[i].label,Len(aFields[i].label)-3)$$<<cfelse>>$$aFields[i].label$$<</cfif>></a>
						<cfelse>
							<a href="#myFusebox.getSelf()#?fuseaction=#XFA.Sort#&_listsortByFieldList=$$objectName$$|$$lFirst(aFields[i].alias)$$|ASC"><<cfif ListLast(aFields[i].label," ") IS "Id" AND structKeyExists(aFields[i],"parent")>>$$Left(aFields[i].label,Len(aFields[i].label)-3)$$<<cfelse>>$$aFields[i].label$$<</cfif>></a>
						</cfif>
					</th>
				</cfcase>
				<</cfloop>>
				<<!--- <<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><<cfif NOT ListFindNoCase(lFields,aJoinedFields[i].alias)>>
				<cfcase value="$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$">
					<th width="" align="left" class="standard">
						<cfif isDefined("attributes._listSortByFieldList") AND attributes._listSortByFieldList IS "$$aJoinedFields[i].table$$|$$aJoinedFields[i].alias$$|ASC">
							<a href="#myFusebox.getSelf()#?fuseaction=#XFA.Sort#&_listsortByFieldList=$$aJoinedFields[i].table$$|$$aJoinedFields[i].alias$$|DESC">$$aJoinedFields[i].label$$</a>
						<cfelse>
							<a href="#myFusebox.getSelf()#?fuseaction=#XFA.Sort#&_listsortByFieldList=$$aJoinedFields[i].table$$|$$aJoinedFields[i].alias$$|ASC">$$aJoinedFields[i].label$$</a>
						</cfif>
					</th>
				</cfcase>
				<</cfif>><</cfloop>> --->>
			</cfswitch>
		</cfloop>
		<th width="" align="center" class="standard">Options</th>
	</tr>
	</cfoutput>
	<cfif q$$objectName$$.recordcount gt 0>
	<cfoutput query="q$$objectName$$">
	<tr>
		<cfloop list="#variables.fieldlist#" index="thisField">
			<cfswitch expression="#thisField#">
				<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<cfcase value="$$lFirst(aFields[i].alias)$$">
					<<cfif aFields[i].formType IS "Password">><td align="right" class="standard">*****</td>
					<<cfelseif ListLast(aFields[i].label," ") IS "Id" AND structKeyExists(aFields[i],"parent") AND ListFindNoCase(lAllFields,"$$aFields[i].parent$$Name")>><td align="right" class="standard">#q$$uFirst(objectName)$$.$$aFields[i].parent$$Name#&nbsp;</td>
					<<cfelseif ListLast(aFields[i].label," ") IS "Id" AND structKeyExists(aFields[i],"parent") AND ListFindNoCase(lAllFields,"$$aFields[i].parent$$Title")>><td align="right" class="standard">#q$$uFirst(objectName)$$.$$aFields[i].parent$$Title#&nbsp;</td>
					<<cfelse>><td align="right" class="standard"><cftry>#$$Format("q$$uFirst(objectName)$$.$$lFirst(aFields[i].alias)$$","$$aFields[i].format$$")$$#<cfcatch>#q$$uFirst(objectName)$$.$$lFirst(aFields[i].alias)$$#</cfcatch></cftry>&nbsp;</td><</cfif>>
				</cfcase>
				<</cfloop>>
				
				<<!--- <<cfloop from="1" to="$$ArrayLen(aJoinedFields)$$" index="i">><<cfif NOT ListFindNoCase(lFields,aJoinedFields[i].alias)>>
				<cfcase value="$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$">
					<<cfif aJoinedFields[i].formType IS "Password">><td align="right" class="standard">&nbsp;</td><<cfelse>>
					<td align="right" class="standard"><cftry>#$$Format("q$$objectName$$.$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$","$$aJoinedFields[i].format$$")$$#<cfcatch>#q$$objectName$$.$$lFirst(aJoinedFields[i].table)$$$$uFirst(aJoinedFields[i].alias)$$#</cfcatch></cftry>&nbsp;</td><</cfif>>
				</cfcase>
				<</cfif>><</cfloop>> --->>
			</cfswitch>
		</cfloop>
		<td align="center" class="standard">
			<cfif isDefined("XFA.display")>[<a href="#myFusebox.getSelf()##appendParam(appendParam(pageParams,"fuseaction",XFA.display),"$$lPKFields$$",$$lPKFields$$)#">View</a>]</cfif>
			<cfif isDefined("XFA.update") >[<a href="#myFusebox.getSelf()##appendParam(appendParam(pageParams,"fuseaction",XFA.update),"$$lPKFields$$",$$lPKFields$$)#">Edit</a>]</cfif>
			<cfif isDefined("XFA.delete") >[<a href="#myFusebox.getSelf()##appendParam(appendParam(pageParams,"fuseaction",XFA.delete),"$$lPKFields$$",$$lPKFields$$)#">Delete</a>]</cfif>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="#listLen(fieldlist)#" class="standard">&nbsp;</td>
	</tr>
	<cfelse>
		<tr>
			<td colspan="#listLen(fieldlist)#" class="standard">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="#listLen(fieldlist)#" class="standard">There are no $$uFirst(objectName)$$s.</td>
		</tr>
		<tr>
			<td colspan="#listLen(fieldlist)#" class="standard">&nbsp;</td>
		</tr>
	</cfif>
</table>
<span class="standard">
	<cfset pagecount = ((attributes.totalRowCount - 1) \ attributes._Maxrows) + 1>
	<!--- Display a list of page numbers so that the user can go directly to any page --->
	<cfloop index="page" from="1" to="#pagecount#">
		<cfset variables.StartRow = ((page - 1)*attributes._Maxrows)+1 >
		<cfset selParams = appendParam(sortParams,"_StartRow",variables.Startrow)>
		<cfset selParams = appendParam(selParams,"fuseaction",XFA.Page)>
		<cfif attributes._Startrow EQ variables.StartRow>
			<cfoutput>[#page#]</cfoutput>
		<cfelse>
			<cfoutput>[<a href="#myFusebox.getSelf()##selParams#">#page#</a>]</cfoutput>
		</cfif>
	</cfloop>
	<br />
	<!--- Display prev and next buttons  --->
	<cfset prevrow = attributes._Startrow - attributes._Maxrows>
	<cfset prevParams = appendParam(sortParams,"_StartRow",prevrow)>
	<cfset prevParams = appendParam(prevParams,"fuseaction",XFA.Prev)>
	<cfif prevrow LT 1>
		[Prev]
	<cfelse>
	<cfoutput>[<a href="#myFusebox.getSelf()##prevParams#">Prev</a>]</cfoutput>
	</cfif>
	
	<cfset nextrow = attributes._Startrow + attributes._Maxrows>
	<cfset nextParams = appendParam(sortParams,"_StartRow",nextrow)>
	<cfset nextParams = appendParam(nextParams,"fuseaction",XFA.Next)>
	<cfif nextrow GT attributes.totalRowCount>
		[Next]
	<cfelse>
	<cfoutput>[<a href="#myFusebox.getSelf()##nextParams#">Next</a>]</cfoutput>
	</cfif>
	
	<cfoutput>[<a href="#myFusebox.getSelf()##appendParam(pageParams,"fuseaction",XFA.add)#">Add New $$objectName$$</a>]</cfoutput>
</span>
<!--- 
$Log$
 --->
<</cfoutput>>
