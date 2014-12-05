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
<<cfoutput>>
<cfcomponent displayname="$$oMetaData.getProject()$$" 
	extends="$$oMetaData.getBaseCFCPath()$$.controller.$$oMetaData.getProject()$$.circuit" 
	hint="I control the fuses executed in the $$oMetaData.getProject()$$ circuit.">
	<!--- 
	author="$$oMetaData.getAuthor()$$" 
	email="$$oMetaData.getAuthorEmail()$$" 
	date="$$dateFormat(now(),'dd-mmm-yyyy')$$"
	copyright="(c)$$year(now())$$ $$oMetaData.getCopyright()$$"
	licence="$$oMetaData.getLicence()$$"
	version="Revision: $$oMetaData.getVersion()$$"
	 --->
<<cfloop list="$$oMetaData.getLTableAliases()$$" index="thisTable">>
	<cffunction name="$$thisTable$$_List" access="public" output="Yes" hint="I display a list of the $$thisTable$$ records.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnList')$$"/>
		
		<cfset super.$$thisTable$$_List(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_View" access="public" output="Yes" hint="I display a single $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnDisplay')$$"/>
		
		<cfset super.$$thisTable$$_View(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_Add" access="public" output="Yes" hint="I display a blank form allowing the user to enter a new $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnForm')$$"/>
		
		<cfset super.$$thisTable$$_Add(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_Action_Add" access="public" output="Yes" hint="I prcess the data for a new $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnForm')$$"/>
		
		<cfset super.$$thisTable$$_Action_Add(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_Edit" access="public" output="Yes" hint="I display a form allowing the user to edit an existing $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnForm')$$"/>
		
		<cfset super.$$thisTable$$_Edit(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_Action_Edit" access="public" output="Yes" hint="I process the data for an update to an existing $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset fieldList="$$oMetaData.getFieldListFromXML(thisTable,'showOnForm')$$"/>
		
		<cfset super.$$thisTable$$_Action_Edit(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="$$thisTable$$_Action_Delete" access="public" output="Yes" hint="I process the delete of an existing $$thisTable$$ record.">
		<cfargument name="myFusebox" />
		<cfargument name="event" />
	 	
		<cfset super.$$thisTable$$_Action_Delete(argumentCollection=arguments)>
	</cffunction>
<</cfloop>>

</cfcomponent>
<</cfoutput>>