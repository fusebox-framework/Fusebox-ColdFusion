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
<<cfoutput>>
<!--- Controller --->
<cfcomponent displayname="">
	
	<cffunction name="prefuseaction">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfset attributes = event.getallvalues()>
		<cfset request.page = structNew() />
		<cfinclude template="../../udfs/udf_appendParam.cfm" />
	</cffunction>
	
	<cffunction name="postfuseaction">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
		<cfsavecontent variable="request.page.menu">
			<cfinclude template="../../view/vLayout/dsp_menu.cfm" />
		</cfsavecontent>
		<cfinclude template="../../view/vLayout/dsp_layout.cfm" />
	</cffunction>
	
</cfcomponent>
<</cfoutput>>
