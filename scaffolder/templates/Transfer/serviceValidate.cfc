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
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfoutput>>
	<cffunction name="validate" access="public" output="false" returntype="array">
		<cfargument name="this$$objectName$$" required="True" type="$$objectName$$Record" />
		<cfargument name="errors" required="false" type="array" />
		<cfargument name="fieldList" required="false" type="string" />
		<!--- Note that in the language code all - must be converted to _ because it is used as a cf variable name --->
		<cfargument name="languageCode" required="false" type="string" default="en_us" />
		<cfset var thisError = 0>
		
		<cfset var aErrors = variables.$$objectName$$Validator.validate(argumentCollection=arguments) />
		
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="thisError">
			<cfset aErrors[thisError].message = variables.$$objectName$$Messages.getMessage(aErrors[thisError].field,aErrors[thisError].type,arguments.languageCode)>
		</cfloop>
		<cfreturn aErrors>
	</cffunction>
<</cfoutput>>