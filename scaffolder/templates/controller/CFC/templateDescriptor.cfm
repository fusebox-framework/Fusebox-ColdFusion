<!---
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
--->

<!--- 
This is a template descriptor file for the CFC based Fusebox Templates.
The templates will create the fusebox framework for a complete maintenance application 
for each of the selected database tables using the Fusebox 5.5 CFC based fusebox.
 --->
 
<!--- Create a description of each of the templates. --->
<!--- This is the list for a CFC based Controller. --->
<cfscript>
//Controller: init.cfm
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
	
//Controller: circuit.cfc
	stFileData = structNew();
	stFileData.templateFile = "controller_circuit";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
//Controller: project.cfc extends the circuit.cfc. 
// This file is placed in the controller directory while and extends that in the subdirectory.
	stFileData = structNew();
	stFileData.templateFile = "dummy";
	stFileData.outputFile = "#variables.project#";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

//Controller Fuseactions: list, view, add, action_add, edit, action_edit, action_delete.
	stFileData = structNew();
	stFileData.templateFile = "list";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "view";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "true";
	stFileData.suffix = "cfc";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "add";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_add";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "edit";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_edit";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.suffix = "cfc";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_delete";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>

