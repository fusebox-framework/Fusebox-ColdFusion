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
This is a template descriptor file for the Transfer Templates.
The templates will create a complete maintenance application for the selected database 
tables using the Transfer Framework and Fusebox 5
It currently assumes that all the tables have a primary key field defined as integer, identity.
 --->
 
<!--- Create a description of each of the templates. --->
<!--- This is the list for Transfer --->
<cfscript>
//Supporting files: datasource.xml, transfer.xml
	stFileData = structNew();
	stFileData.templateFile = "datasource";
	stFileData.outputFile = "datasource";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "xml";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "transfer";
	stFileData.outputFile = "transfer";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "xml";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

//Supporting files: udf_appendParam.cfm, dsp_layout.cfm, dsp_menu
	stFileData = structNew();
	stFileData.templateFile = "udf_appendParam";
	stFileData.outputFile = "udf_appendParam";
	stFileData.MVCpath = "#destinationFilePath#udfs#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_layout";
	stFileData.outputFile = "dsp_layout";
	stFileData.MVCpath = "#destinationFilePath#view#variables.OSdelimiter#vLayout#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_menu";
	stFileData.outputFile = "dsp_menu";
	stFileData.MVCpath = "#destinationFilePath#view#variables.OSdelimiter#vLayout#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

// Fusebox
	//stFileData = structNew();
	//stFileData.templateFile = "fusebox.xml";
	//stFileData.outputFile = "fusebox.xml";
	//stFileData.MVCpath = "#destinationFilePath#";
	//stFileData.inPlace = "false";
	//stFileData.overwrite = "false";
	//stFileData.useAliasInName = "false";
	//stFileData.suffix = "cfm";
	//stFileData.perObject = "false";
	//ArrayAppend(aTemplateFiles,stFileData);
</cfscript>
<cfscript>
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
	
	stFileData = structNew();
	stFileData.templateFile = "fusebox.appinit";
	stFileData.outputFile = "fusebox.appinit";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

//View: dsp_list_, disp_display_, dsp_form_
	stFileData = structNew();
	stFileData.templateFile = "dsp_list_";
	stFileData.outputFile = "dsp_list_";
	stFileData.MVCpath = "#destinationFilePath#view#variables.OSdelimiter#v#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_display_";
	stFileData.outputFile = "dsp_display_";
	stFileData.MVCpath = "#destinationFilePath#view#variables.OSdelimiter#v#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "dsp_form_";
	stFileData.outputFile = "dsp_form_";
	stFileData.MVCpath = "#destinationFilePath#view#variables.OSdelimiter#v#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
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
	
//Controller: project.cfc extends the circuit.cfc. Allows a more traditional location of circuit files.
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

//Controller Fuseactions: listing, display, add_form, action_add, edit_form, action_update, action_delete.
	stFileData = structNew();
	stFileData.templateFile = "listing";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "display";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.perObject = "true";
	stFileData.suffix = "cfc";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "add_form";
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
	stFileData.templateFile = "edit_form";
	stFileData.outputFile = "circuit";
	stFileData.MVCpath = "#destinationFilePath#controller#variables.OSdelimiter##variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "action_update";
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
<!--- <cfscript>
//Model - DAO:
	stFileData = structNew();
	stFileData.templateFile = "baseDAO";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "DAO";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "DAOinit";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "save";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "exists";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "create";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "read";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "update";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "delete";
	stFileData.outputFile = "DAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>
 --->
<cfscript>
//Model - Gateway:
	stFileData = structNew();
	stFileData.templateFile = "baseGateway";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "gateway";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "gatewayInit";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "getAll";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "getByFields";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "deleteByFields";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "getRecordCount";
	stFileData.outputFile = "Gateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>
<!--- 
<cfscript>
//Model - Record:
	stFileData = structNew();
	stFileData.templateFile = "baseRecord";
	stFileData.outputFile = "Record";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "record";
	stFileData.outputFile = "Record";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "recordInit";
	stFileData.outputFile = "Record";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "accessors";
	stFileData.outputFile = "Record";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	//stFileData = structNew();
	//stFileData.templateFile = "recordExists";
	//stFileData.outputFile = "Record";
	//stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	//stFileData.inPlace = "true";
	//stFileData.overwrite = "true";
	//stFileData.useAliasInName = "true";
	//stFileData.suffix = "cfc";
	//stFileData.perObject = "true";
	//ArrayAppend(aTemplateFiles,stFileData);

//Model - Validator
	stFileData = structNew();
	stFileData.templateFile = "baseValidator";
	stFileData.outputFile = "Validator";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "Validator";
	stFileData.outputFile = "Validator";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "validatorInit";
	stFileData.outputFile = "Validator";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "validate2";
	stFileData.outputFile = "Validator";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

//Model - Messages used for validation and labels:
	stFileData = structNew();
	stFileData.templateFile = "baseMessages";
	stFileData.outputFile = "Messages";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "messages";
	stFileData.outputFile = "Messages";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "getMessage";
	stFileData.outputFile = "Messages";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "messageTextEnUs";
	stFileData.outputFile = "Messages";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

//Model - Transfer Object:
	stFileData = structNew();
	stFileData.templateFile = "To";
	stFileData.outputFile = "To";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

//Model - Value Object:
	stFileData = structNew();
	stFileData.templateFile = "Vo";
	stFileData.outputFile = "Vo";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "as";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript>
--->
<cfscript>
//Model - Service:
	stFileData = structNew();
	stFileData.templateFile = "baseService";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "service";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceInit";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceGet";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceExists";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceGetAll";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "serviceGetRecordCount";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceGetMultiple";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceSave";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceDelete";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceValidate";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "serviceGetMessages";
	stFileData.outputFile = "Service";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

//Model - ColdSpring Definition:
	stFileData = structNew();
	stFileData.templateFile = "coldspring";
	stFileData.outputFile = "coldspring";
	stFileData.MVCpath = "#destinationFilePath#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "xml";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
</cfscript><!---  
//Model - Circuit:
	stFileData = structNew();
	stFileData.templateFile = "model_circuit.xml";
	stFileData.outputFile = "circuit.xml";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

</cfscript> --->

