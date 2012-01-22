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
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfoutput>>
<cffunction name="init" displayname="init" hint="I initialise a validator for the $$objectName$$ object.">
  <<cfloop from="1" to="$$arrayLen(aManyToOne)$$" index="j">>
	<cfargument name="$$aManyToOne[j].alias$$Service" type="$$aManyToOne[j].alias$$Service" required="Yes" /><</cfloop>>
  <<cfloop from="1" to="$$arrayLen(aManyToOne)$$" index="j">>
	<cfset variables.$$aManyToOne[j].alias$$Service = arguments.$$aManyToOne[j].alias$$Service><</cfloop>>
	<cfreturn this>
</cffunction>
<</cfoutput>>

