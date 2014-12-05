<!---
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
--->

<!--- 
This is a template descriptor file for the ColdSpring Templates.
The templates will create a complete maintenance application for the selected database 
tables using the ColdSpring Framework and Fusebox 5
It currently assumes that all the tables have a primary key field defined as integer, identity.
 --->
 
<!--- Create a description of each of the templates. --->
<!--- This is the list for an XML based controller. --->
<cfscript>
// Fusebox
	stFileData = structNew();
	stFileData.templateFile = "fusebox.xml";
	stFileData.outputFile = "fusebox.xml";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "fusebox.init";
	stFileData.outputFile = "fusebox.init";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

//Controller: circuit.xml.cfm
	stFileData = structNew();
	stFileData.templateFile = "controller_circuit.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "list.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "view.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "true";
	stFileData.suffix = "cfm";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "add.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_add.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "edit.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_edit.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.suffix = "cfm";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_delete.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>

