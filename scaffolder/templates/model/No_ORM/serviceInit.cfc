<<!---
Copyright 2007 Objective Internet Ltd - http://www.objectiveinternet.com

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
	<cffunction name="init" access="public" output="false" returntype="$$objectName$$Service">
		<cfargument name="$$objectName$$DAO" type="$$objectName$$DAO" required="true" />
		<cfargument name="$$objectName$$Gateway" type="$$objectName$$Gateway" required="true" />
		<cfargument name="$$objectName$$Validator" type="$$objectName$$Validator" required="true" />
		<cfargument name="$$objectName$$Messages" type="$$objectName$$Messages" required="true" />

		<cfset variables.$$objectName$$DAO = arguments.$$objectName$$DAO />
		<cfset variables.$$objectName$$Gateway = arguments.$$objectName$$Gateway />
		<cfset variables.$$objectName$$Validator = arguments.$$objectName$$Validator />
		<cfset variables.$$objectName$$Messages = arguments.$$objectName$$Messages />
		<cfreturn this/>
	</cffunction>
<</cfoutput>>