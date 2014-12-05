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
<<!--- Set the path to the generated model --->>
<<cfset generatedModelPath = "$$oMetaData.getDottedPath(arguments.DestinationFilePath,"","generated." & oMetaData.getSelectedTableAlias())$$Messages">>
<<cfoutput>>
<cfcomponent displayname="$$oMetaData.getSelectedTableAlias()$$Messages" extends="$$generatedModelPath$$">
</cfcomponent>
<</cfoutput>>
