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
This is a template descriptor file for the HTML View Templates.
The templates will create forms for a complete maintenance application for the 
selected database tables using basic HTML
 --->
 
<!--- Create a description of each of the templates. --->
<!--- This is the list for ColdSpring --->
<cfscript>
//Supporting files: udf_appendParam.cfm, dsp_layout.cfm
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
	stFileData.overwrite = "false";
	stFileData.useAliasInName = "false";
	stFileData.suffix = "cfm";
	stFileData.perObject = "false";
	ArrayAppend(aTemplateFiles,stFileData);

//View: dsp_list_, dsp_view_, dsp_form_
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
	stFileData.templateFile = "dsp_view_";
	stFileData.outputFile = "dsp_view_";
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

</cfscript>

