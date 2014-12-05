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
<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="act_validate_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I validate the object.
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
			<object name="$$uFirst(objectName)$$Service" scope="variables" />
			<object name="o$$uFirst(objectName)$$" scope="variables" />
		</in>
		<out>
			<array name="aErrors" scope="variables" />
		</out>
	</io>
</fusedoc>
--->
<!--- Validate the object --->
<cfset $$uFirst(objectName)$$Service.validate(o$$uFirst(objectName)$$) />
<cfset objectIsValid = NOT o$$uFirst(objectName)$$.isInvalid()>
</cfsilent>
<</cfoutput>>
