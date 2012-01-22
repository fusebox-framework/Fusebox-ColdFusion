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
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>

<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="$RCSfile: dsp_form_$$objectName$$.cfm,v $" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		This page is a form that allows inserts and updates of $$objectName$$ records.
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
			<string name="self" scope="variables" optional="Yes" />
			<string name="XFA.save" scope="request" optional="Yes" />
			<string name="XFA.cancel" scope="request" optional="Yes" />
			
			<list name="fieldlist" scope="variables" optional="Yes" comments="Controls the fields displayed and the sequence of the display." />
			
			<number name="_Startrow" scope="attributes" optional="Yes" default="1">
			<number name="_Maxrows" scope="attributes" optional="Yes" default="10">
			<string name="_listSortByFieldList" scope="variables" optional="Yes" default="">
			<string name="searchSafe" scope="request" optional="Yes" default="false">
			
			<array name="aErrors" scope="variables" optional="Yes" Created by Validation. Present when an error has been found with server validation and passes back from action." >
				<structure>
					<string name="field" />
					<string name="type" />
					<string name="message" />
				</structure>
			</array>
			
			<string name="standardThClass" scope="variables" optional="Yes" default="standard" />
			<string name="highlightThClass" scope="variables" optional="Yes" default="highlight" />
			<string name="standardTdClass" scope="variables" optional="Yes" default="standard" />
			
			<object name="o$$uFirst(objectName)$$" scope="variables"  />
		</in>
		<out>
			<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><$$aFields[i].fuseDocType$$ name="$$lFirst(aFields[i].alias)$$" />
			<</cfloop>>
		</out>
	</io>
</fusedoc>
--->
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
<!--- Set some defaults for the table display classes --->
<cfparam name="standardThClass" default="standard" />
<cfparam name="highlightThClass" default="highlight" />
<cfparam name="standardTdClass" default="standard" />
<cfparam name="highlightTdClass" default="highlight" />
<!--- Error reporting --->
<cfparam name="highlightfields" default="" />
<cfparam name="aErrors" default="#arrayNew(1)#" />
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- Specify the list of fields to be displayed --->
<cfparam name="fieldlist" default="$$lFields$$" />
<cfparam name="lDisplayFields" default="" />
<!--- The object being edited or added --->
<cfparam name="o$$uFirst(objectName)$$">
<!--- The page and column widths look and feel --->
<cfparam name="_layoutTableWidth" default="400">
<cfparam name="_layoutLHColWidth" default="200">

</cfsilent>
<cfsetting enablecfoutputonly="false" /><cfsetting enablecfoutputonly="false" />
<cfoutput>
<!--- Javascript to validate the entries --->
<script language="JavaScript">
<!--
	function reset(myform){
		myform.reset();
	};

	function save(myform, XFA){
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><<cfif aFields[i].required AND NOT structKeyExists(aFields[i],"primaryKeySeq")>>
		if(myform.$$lFirst(aFields[i].alias)$$.value == ""){
			alert("Please enter the $$aFields[i].label$$");
			return false;
		}<</cfif>><</cfloop>>
		document.getElementById("btnSave").disabled=true;
		myform.fuseaction.value = XFA;
		myform.submit();
	};
//-->
</script>
<!--- Start of the form --->
<cfform name="frmAddEdit" action="#myFusebox.getSelf()#" method="post">		
	<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
	<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
	<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />
	
	<table border="0" cellpadding="2" cellspacing="2" width="#_layoutTableWidth#"
		summary="This table shows details of a Fuseaction record." class="">
		
		<!--- Show any Error Messages --->
		<cfif o$$objectName$$.totalErrorCount() >
			<tr>
				<td colspan="2">
				<p class="#variables.highlightThClass#">Invalid entries were found, please correct them and resubmit.</p>
				</td>
			</tr>
			<cfif o$$objectName$$.hasErrorsFor("unknown")>
				<tr>
					<td colspan="2" class="#variables.highlightTdClass#">
					<cfset aErrors = o$$objectName$$.getErrorArrayFor("unknown")>
					<cfloop from="1" to="#arrayLen(aErrors)#" index="thisError">
						#aErrors[thisError].message#<br>
					</cfloop>
					</td>
				</tr>
			</cfif>
		</cfif>
		<!--- Show the form fields --->
		<cfloop list="#fieldlist#" index="thisField">
			<cfswitch expression="#thisField#">
				<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
				<cfcase value="$$lFirst(aFields[i].alias)$$">
					<<cfif ListFindNoCase(lPKFields,aFields[i].alias)>><!--- Primary Key --->
					<cfif mode is "edit">
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cftry>#$$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$#<cfcatch>#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#</cfcatch></cftry>
							<input type="hidden" name="$$lFirst(aFields[i].alias)$$" value="#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#" />
						</td>
					</tr>
					</cfif>
					<<cfelseif aFields[i].formType IS "Dropdown">>
					<!--- a dropdown list --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td><<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"#q$$aFields[i].parent$$.","#","_")>>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].parent)$$$$uFirst(aFields[i].display)$$()# 
							<cfelse>
								<select name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" size="1">
									<option value=""></option>
									<cfloop query="q$$aFields[i].parent$$">
										<option value="$$optionValues$$" <cfif o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$() EQ "$$optionValues$$">selected="selected"</cfif> >#q$$aFields[i].parent$$.$$aFields[i].display$$#</option>
									</cfloop>
								</select>
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Radio">>
					<!--- radio buttons --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td><<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"#q$$aFields[i].parent$$.","#","_")>>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].parent)$$$$uFirst(aFields[i].display)$$()# 
							<cfelse>
								<cfloop query="q$$aFields[i].parent$$">
									<input type="Radio" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$_$$optionValues$$" value="$$optionValues$$" <cfif o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$() EQ "$$optionValues$$">checked="checked"</cfif> />#q$$lFirst(aFields[i].parent)$$.$$lFirst(aFields[i].display)$$#<br />
								</cfloop>
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Checkbox">>
					<!--- checkbox --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								<cftry>#yesNoFormat(o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$())#<cfcatch>o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()</cfcatch></cftry>
							<cfelse>
								<input type="Checkbox" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" value="1" <cfif o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()>checked="checked"</cfif> /><br />
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Textarea">>
					<!--- a Textarea --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#
							<cfelse>
								<textarea name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" cols="$$ListFirst(aFields[i].size,"x")$$" rows="$$ListLast(aFields[i].size,"x")$$"<!--- maxlength="$$aFields[i].maxlength$$" ---> ><cftry>#$$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$#<cfcatch>#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#</cfcatch></cftry></textarea>
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Hidden">>
					<!--- a hidden field --->
					<input type="hidden" name="$$lFirst(aFields[i].alias)$$" value="#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#" />
					<<cfelseif aFields[i].formType IS "Display">>
					<!--- a displayed field --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cftry>#$$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$#<cfcatch>#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#</cfcatch></cftry>
							<input type="Hidden" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" value="#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#" />
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Date" AND ListFirst(server.ColdFusion.ProductVersion) GE 8>>
					<!--- Date with pop up calendar --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								<cftry>#lsDateFormat(o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$())# #lsTimeFormat(o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$())#<cfcatch>o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()</cfcatch></cftry>
							<cfelse>
								<cftry><cfset displayValue = $$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$><cfcatch><cfset displayValue = ""></cfcatch></cftry>
								<cfinput type="DateField" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" value="#displayValue#" mask="dd-mmm-yyyy">
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Calendar" AND ListFirst(server.ColdFusion.ProductVersion) GE 8>>
					<!--- Calendar --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								<cftry>#lsDateFormat(o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$())#<cfcatch>o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()</cfcatch></cftry>
							<cfelse>
								<cftry><cfset displayValue = $$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$><cfcatch><cfset displayValue = ""></cfcatch></cftry>
								<cfif isDate(displayValue)>
									<cfcalendar name="$$lFirst(aFields[i].alias)$$" selectedDate="#displayValue#" />
								<cfelse>
									<cfcalendar name="$$lFirst(aFields[i].alias)$$" />
								</cfif>
							</cfif>
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "AutoSuggest" AND ListFirst(server.ColdFusion.ProductVersion) GE 8>>
					<!--- AutoSuggest --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cftry><cfset displayValue = $$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$><cfcatch><cfset displayValue = "o$$uFirst(objectName)$$.get$$lFirst(aFields[i].alias)$$"></cfcatch></cftry>
							<cfinput type="text" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" value="#displayValue#" autosuggest="cfc:$$objectName$$">
						</td>
					</tr>
					<<cfelseif aFields[i].formType IS "Password">>
					<!--- Password --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								****
							<cfelse>
								<input type="Password" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" size="$$aFields[i].size$$" <<cfif structKeyExists(aFields[i],"maxlength")>>maxlength="$$aFields[i].maxlength$$"<</cfif>> />
							</cfif>
						</td>
					</tr>
					<<cfelse>>
					<!--- default text box --->
					<tr>
						<th width="#_layoutLHColWidth#" align="left" <cfif ListFindNocase(highlightfields,'$$lFirst(aFields[i].alias)$$')>class="#variables.highlightThClass#"<cfelse>class="#variables.standardThClass#"</cfif> >
							$$aFields[i].label$$
						</th>
						<td>
							<cfif ListFindNoCase(lDisplayFields,"$$lFirst(aFields[i].alias)$$")>
								<cftry>#$$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$#<cfcatch>#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#</cfcatch></cftry>
							<cfelse>
								<input type="Text" name="$$lFirst(aFields[i].alias)$$" id="$$lFirst(aFields[i].alias)$$" size="$$aFields[i].size$$" <<cfif structKeyExists(aFields[i],"maxlength")>>maxlength="$$aFields[i].maxlength$$"<</cfif>> value="<cftry>#$$Format("o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()","$$aFields[i].format$$")$$#<cfcatch>#o$$uFirst(objectName)$$.get$$uFirst(aFields[i].alias)$$()#</cfcatch></cftry>" />
							</cfif>
						</td>
					</tr>
					<</cfif>>
					<!--- Display Errors if present --->
					<cfif o$$uFirst(objectName)$$.hasErrorsFor("$$aFields[i].alias$$")>
					<tr>
						<td colspan="2" class="#variables.highlightTdClass#">
						<cfset aErrors = o$$uFirst(objectName)$$.getErrorArrayFor("$$aFields[i].alias$$")>
						<cfloop from="1" to="#arrayLen(aErrors)#" index="thisError">
							#aErrors[thisError].message#<br>
						</cfloop>
						</td>
					</tr>
					</cfif>
				</cfcase><</cfloop>>
			</cfswitch>
		</cfloop>
		<tr>
			<td colspan="2" align="right">
				<br>
				<cfset sortParams = appendParam("","fuseaction",XFA.cancel)>
				<cfset sortParams = appendParam(sortParams,"_listSortByFieldList",attributes._listSortByFieldList)>
				<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
				<cfset sortParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>
				
				<input type="button" value="Save" id="btnSave" onclick="save(this.form,'#XFA.Save#');" />
				<input type="button" value="Reset" id="btnReset" onclick="reset(this.form);" />
				<input type="button" value="Cancel" id="btnCancel" onclick="location.href='#myFusebox.getSelf()##sortParams#';" />
				<input type="hidden" name="fuseaction" value="#XFA.save#" />
			</td>
		</tr>
	</table>
	</cfform>
</cfoutput>
<</cfoutput>>

