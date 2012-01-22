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
<<cfoutput>>
<!--- Controller --->
<cfcomponent displayname="circuit.cfc" hint="I control the fuses executed in the $$oMetaData.getProject()$$ circuit.">
	<!--- 
	author="$$oMetaData.getAuthor()$$" 
	email="$$oMetaData.getAuthorEmail()$$" 
	date="$$dateFormat(now(),'dd-mmm-yyyy')$$"
	copyright="(c)$$year(now())$$ $$oMetaData.getCopyright()$$"
	licence="$$oMetaData.getLicence()$$"
	version="Revision: $$oMetaData.getVersion()$$"
	 --->
	<cffunction name="prefuseaction" hint="Initialise the application.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset attributes = event.getallvalues()>
		<cfset request.page = structNew() />
		<cfset myFusebox.basePath = getDirectoryFromPath(getBaseTemplatePath())>
		<cfset myFusebox.baseUrl = getDirectoryFromPath(cgi.PATH_INFO)>
		<cfinclude template="../../model/m$$oMetaData.getProject()$$/act_init.cfm" />
		<cfinclude template="../../udfs/udf_appendParam.cfm" />
	</cffunction>
	
	<cffunction name="postfuseaction" hint="Create the menu and page layout.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<!--- Create Menu --->
		<cfsavecontent variable="request.page.menu">
			<cfinclude template="../../view/vLayout/dsp_menu.cfm" />
		</cfsavecontent>
		<!--- Do Page Layout --->
		<cfinclude template="../../view/vLayout/dsp_layout.cfm" />
	</cffunction>
	
</cfcomponent>
<</cfoutput>>
