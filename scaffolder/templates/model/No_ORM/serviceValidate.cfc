<<!---
Copyright 2007-2009 Objective Internet Ltd - http://www.objectiveinternet.com

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
	<cffunction name="validate" access="public" output="false" returntype="any">
		<cfargument name="$$uFirst(objectName)$$" required="true" type="$$objectName$$Bean" />
		<cfargument name="fieldList" required="false" type="string" />
		<cfset var thisError = 0>
		<cfset variables.$$objectName$$Validator.validate(argumentCollection=arguments) />
		<cfreturn this>
	</cffunction>
<</cfoutput>>
