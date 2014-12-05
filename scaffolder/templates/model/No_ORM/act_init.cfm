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
<cfsilent>
<!--- -->
<fusedoc fuse="act_init.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		This template initialises the coldspring framework service factory.
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
			<string name="init" scope="attributes" optional="Yes" />
			<object name="myFusebox" />
		</in>
		<out>
		</out>
	</io>
</fusedoc>
--->
<cfif isDefined("attributes.init") OR NOT structKeyExists(myFusebox.getApplication().getApplicationData(),"servicefactory")>
	<cfset myFusebox.getApplication().getApplicationData().servicefactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties="#structnew()#" )/>
	<cfset myFusebox.getApplication().getApplicationData().servicefactory.loadBeansFromXmlFile( beanDefinitionFile="#myFusebox.basePath#/model/config/coldSpring.xml" ) />
</cfif>
</cfsilent>
<</cfoutput>>

