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
	<cffunction name="getSuggestions" access="remote" output="false" returntype="array" hint="I get suggested values to populate an autosuggest field.">
		<cfargument name="suggestionColumn" required="Yes" type="string">
		<cfargument name="suggestionValue" required="Yes" type="any">
		<cfargument name="maxrows" required="No" default="10">
		
		<cfset var aSuggestions = arrayNew(1)>
		<cfset var qSuggestions = variables.$$objectName$$Gateway.getLikeFields(argumentCollection=arguments) />
		
		<cfloop query="qSuggestions">
			<cfset arrayAppend(aSuggestions, value)>
		</cfloop>
		<cfreturn aSuggestions>
	</cffunction>
<</cfoutput>>