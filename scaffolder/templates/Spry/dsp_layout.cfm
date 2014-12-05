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
<cfsilent>
<!--- -->
<<cfoutput>>
<fusedoc fuse="dsp_layout.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I am a simple fusebox layout page. I collect the various page content variables and display them in the various places on the page.
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
			<structure name="page" scope="request" >
				<string name="title" />
				<string name="subtitle" />
				<string name="stylesheets" />
				<string name="javascript" />
				<string name="menu" />
				<string name="pageContent" />
				<string name="rightmenu" />
			</structure>
		</in>
		<out>
			<string name="fuseaction" scope="formOrUrl" />
		</out>
	</io>
</fusedoc><</cfoutput>>
--->
<cfparam name="request.page.title" default="">
<cfparam name="request.page.subtitle" default="">
<cfparam name="request.page.stylesheets" default="">
<cfparam name="request.page.javascript" default="">
<cfparam name="request.page.menu" default="">
<cfparam name="request.page.pageContent" default="">
<cfparam name="request.page.rightmenu" default="">
</cfsilent>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title><cfoutput>#request.page.title# - #request.page.subtitle#</cfoutput></title>
<!--- Simple stylesheet supports highlighting of form errors --->
<style>
.pagetitle {
	FONT-SIZE: 16px; COLOR: Black; FONT-FAMILY: Arial, Helvetica, Geneva, Swiss, SunSans-Regular
}
.highlight {
	FONT-SIZE: 12px; COLOR: Red; FONT-FAMILY: Arial, Helvetica, Geneva, Swiss, SunSans-Regular
}
.standard  {
	FONT-SIZE: 12px; COLOR: Black; FONT-FAMILY: Arial, Helvetica, Geneva, Swiss, SunSans-Regular
}
</style>
<cfoutput>
#request.page.stylesheets#
#request.page.javascript#
</cfoutput>
</head>

<body>
<cfoutput><h1 class="pagetitle">#request.page.subtitle#</h1></cfoutput>
<table>
	<tr>
		<!--- LH Menu --->
		<td valign="top"><cfoutput>#request.page.menu#</cfoutput></td>
		<!--- Mail Page Content --->
		<td valign="top"><cfoutput>#request.page.pageContent#</cfoutput></td>
		<!--- RH Menu --->
		<td valign="top"><cfoutput>#request.page.rightmenu#</cfoutput></td>
	</tr>
</table>
</body>
</html>
