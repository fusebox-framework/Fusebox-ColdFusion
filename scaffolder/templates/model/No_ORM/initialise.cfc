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
<<!--- Set the name of the project --->>
<<cfset projectName = oMetaData.getProject()>>
<<cfoutput>>
	<cffunction name="initialise" access="private" hint="I initialise the ColdSpring Factory">
		<cfargument name="myFusebox" />
		<!--- Create New ColdSpring Factory --->
		<cfset myFusebox.getApplication().getApplicationData().servicefactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties="#structnew()#" )/>
		<cfset myFusebox.getApplication().getApplicationData().servicefactory.loadBeansFromXmlFile( beanDefinitionFile="#myFusebox.basePath#/model/config/coldSpring.xml" ) />
	</cffunction>
<</cfoutput>>
	
