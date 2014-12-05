<!---
Copyright 2006-08 Objective Internet Ltd - http://www.objectiveinternet.com

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
<!--- This is the template set for ColdSpring and with No ORM --->
<cfscript>
//Model - ColdSpring Definition:
	stFileData = structNew();
	stFileData.templateFile = "coldspring";
	stFileData.outputFile = "coldspring";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#config#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "xml";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
//Controller - Fuses:
	stFileData = structNew();
	stFileData.templateFile = "act_init";
	stFileData.outputFile = "act_init";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "qry_list_";
	stFileData.outputFile = "qry_list_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "qry_view_";
	stFileData.outputFile = "qry_view_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "qry_create_";
	stFileData.outputFile = "qry_create_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "qry_related_";
	stFileData.outputFile = "qry_related_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

	stFileData = structNew();
	stFileData.templateFile = "qry_get_";
	stFileData.outputFile = "qry_get_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_populate_";
	stFileData.outputFile = "act_populate_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "qry_save_";
	stFileData.outputFile = "qry_save_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "qry_delete_";
	stFileData.outputFile = "qry_delete_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "act_validate_";
	stFileData.outputFile = "act_validate_";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
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
	stFileData.templateFile = "AbstractDAO";
	stFileData.outputFile = "AbstractDAO";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
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
	
	//stFileData = structNew();
	//stFileData.templateFile = "DAOinit";
	//stFileData.outputFile = "DAO";
	//stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	//stFileData.inPlace = "true";
	//stFileData.overwrite = "true";
	//stFileData.useAliasInName = "true";
	//stFileData.suffix = "cfc";
	//stFileData.perObject = "true";
	//ArrayAppend(aTemplateFiles,stFileData);
	
	//stFileData = structNew();
	//stFileData.templateFile = "save";
	//stFileData.outputFile = "DAO";
	//stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	//stFileData.inPlace = "true";
	//stFileData.overwrite = "true";
	//stFileData.useAliasInName = "true";
	//stFileData.suffix = "cfc";
	//stFileData.perObject = "true";
	//ArrayAppend(aTemplateFiles,stFileData);
	
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
	stFileData.templateFile = "AbstractGateway";
	stFileData.outputFile = "AbstractGateway";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
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
	stFileData.templateFile = "getSuggest";
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

//Model - Bean:
	stFileData = structNew();
	stFileData.templateFile = "baseBean";
	stFileData.outputFile = "Bean";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "bean";
	stFileData.outputFile = "Bean";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "beanInit";
	stFileData.outputFile = "Bean";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "true";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfc";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	// Abstract bean with onMissingMethod will only work with CF8 and above
	if (ListFirst(server.coldFusion.productVersion) LT 8){
		stFileData = structNew();
		stFileData.templateFile = "accessors";
		stFileData.outputFile = "Bean";
		stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
		stFileData.inPlace = "true";
		stFileData.overwrite = "true";
		stFileData.useAliasInName = "true";
		stFileData.suffix = "cfc";
		stFileData.perObject = "true";
		ArrayAppend(aTemplateFiles,stFileData);
	}
	else{
		stFileData = structNew();
		stFileData.templateFile = "AbstractBean";
		stFileData.outputFile = "AbstractBean";
		stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
		stFileData.inPlace = "false";
		stFileData.overwrite = "true";
		stFileData.useAliasInName = "false";
		stFileData.suffix = "cfc";
		stFileData.perObject = "false";
		ArrayAppend(aTemplateFiles,stFileData);
	}
	
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
	stFileData.templateFile = "AbstractValidator";
	stFileData.outputFile = "AbstractValidator";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#generated#variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfc";
	stFileData.perObject = "false";
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
	//stFileData = structNew();
	//stFileData.templateFile = "To";
	//stFileData.outputFile = "To";
	//stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	//stFileData.inPlace = "false";
	//stFileData.overwrite = "true";
	//stFileData.useAliasInName = "true";
	//stFileData.suffix = "cfc";
	//stFileData.perObject = "true";
	//ArrayAppend(aTemplateFiles,stFileData);

//Model - Value Object:
	//stFileData = structNew();
	//stFileData.templateFile = "Vo";
	//stFileData.outputFile = "Vo";
	//stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	//stFileData.inPlace = "false";
	//stFileData.overwrite = "true";
	//stFileData.useAliasInName = "true";
	//stFileData.suffix = "as";
	//stFileData.perObject = "true";
	//ArrayAppend(aTemplateFiles,stFileData);

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
	stFileData.templateFile = "serviceGetSuggest";
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
	
//Model - AJAX Proxies:
	stFileData = structNew();
	stFileData.templateFile = "GetJson";
	stFileData.outputFile = "GetJson";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);
	
	stFileData = structNew();
	stFileData.templateFile = "UpdateJson";
	stFileData.outputFile = "UpdateJson";
	stFileData.MVCpath = "#destinationFilePath#model#variables.OSdelimiter#m#variables.project##variables.OSdelimiter#";
	stFileData.inPlace = "false";
	stFileData.overwrite = "true";
	stFileData.useAliasInName = "true";
	stFileData.suffix = "cfm";
	stFileData.perObject = "true";
	ArrayAppend(aTemplateFiles,stFileData);

</cfscript>

