<cfcomponent displayname="CF Template" extends="utilities" hint="I provide transformation and publishing services for generating and/or publishing scripts using CF Templates and metadata passed to me." output="no">
<!---
Copyright 2006-07 Objective Internet Ltd - http://www.objectiveinternet.com
Some code in this file is Copyright 2006 Peter Bell and provided with the kind permision of Peter Bell. 

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
TODO: Move the work done by the Format method into a template.
 --->
	<cffunction name="init" returntype="cfTemplate" hint="I initialise the generator paths.">
		<cfargument name="ScratchpadFilePath" required="No" default="#getScaffoldingPath()#scratchpad">
		<cfargument name="ScratchpadIncludePath" required="No" default="../scratchpad">
		<cfargument name="CFTemplateFilePath" required="No" default="#getScaffoldingPath()#templates">
		
		<cfset variables.ScratchpadFilePath = arguments.ScratchpadFilePath>
		<cfset variables.ScratchpadIncludePath = arguments.ScratchpadIncludePath>
		<cfset variables.CFTemplateFilePath = arguments.CFTemplateFilePath>
		<!--- If there is no scratchpad then create it --->
		<cfif NOT directoryExists(ScratchpadFilePath)>
			<cfdirectory action="CREATE" directory="#ScratchpadFilePath#"> 
		</cfif>
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getScaffoldingPath" returntype="string" hint="I get the path to the scaffolding directory.">
		<cfset var currentTemplatePath = GetDirectoryFromPath(GetCurrentTemplatePath())>
		<cfset var scaffoldingPath = GetDirectoryFromPath(Left(currentTemplatePath,Len(currentTemplatePath)-1))>
		<cfreturn scaffoldingPath >
	</cffunction>
	
	<cffunction name="generateScript" returntype="void" access="public" output="yes" hint="I generate a script using a CFTemplate and its associated metadata.">
		<cfargument Name="TemplateFilePath" type="string" required="yes" hint="I am the filepath (including the file name and extension) of the CF Template to return.">
		<cfargument Name="oMetadata" type="any" required="yes" hint="The metadata required for generation." />
		<cfargument Name="DestinationFilePath" type="string" required="yes" hint="The physical path to publish the generated script to including the file name and file extension.">
		<cfargument name="UpdateInPlace" type="boolean" required="No" default="No"/>
		<cfargument name="overwrite" type="boolean" required="No" default="No"/>
		
		<cfset var local = StructNew()>
		
		<cffile action="read" file="#variables.CFTemplateFilePath##oMetadata.GetOSdelimiter()##arguments.TemplateFilePath#" variable="local.TemplateCode">	
		<cfscript>
			// Transform template for processing
			local.TemplateCode = Replace(local.TemplateCode,"<<","START_CFTEMP","all");
			local.TemplateCode = Replace(local.TemplateCode,">>","END_CFTEMP","all");
			local.TemplateCode = Replace(local.TemplateCode,"<","&ltTEMP","all");
			local.TemplateCode = Replace(local.TemplateCode,">","&gtTEMP","all");
			local.TemplateCode = Replace(local.TemplateCode,"START_CFTEMP","<","all");
			local.TemplateCode = Replace(local.TemplateCode,"END_CFTEMP",">","all");
			local.TemplateCode = Replace(local.TemplateCode,"$$","CFTEMPVAR","all");
			local.TemplateCode = Replace(local.TemplateCode,"##","TEMPHASH","all");
			local.TemplateCode = Replace(local.TemplateCode,"CFTEMPVAR","##","all");
		</cfscript>
		<!--- Create the Scratchpad directory if it does not exist --->
		<cfif NOT directoryExists(ScratchpadFilePath)>
			<cfdirectory action="CREATE" directory="#arguments.ScratchpadFilePath#"> 
		</cfif>
		<!--- Save the transformed template to the scratchpad directory for parsing --->
		<cfset local.TemplateName = "#CreateUUID()#.cfm">
		<cffile action="write" addnewline="yes" file="#variables.ScratchpadFilePath##oMetadata.GetOSdelimiter()##local.TemplateName#" output="#local.TemplateCode#" fixnewline="no">
		<!--- Run the template to generate code --->
		<cfsavecontent variable="local.generatedScript"><cfinclude template="#variables.ScratchpadIncludePath#/#local.TemplateName#"></cfsavecontent>
		<!--- Delete the scratchpad file --->
		<cffile action="delete" file="#variables.ScratchpadFilePath##oMetadata.GetOSdelimiter()##local.TemplateName#">
		<cfscript>
			// Transform the code back to CF
			local.generatedScript = Replace(local.generatedScript,"&ltTEMP","<","all");
			local.generatedScript = Replace(local.generatedScript,"&gtTEMP",">","all");
			local.generatedScript = Replace(local.generatedScript,"TEMPHASH","##","all");
			local.generatedScript = Replace(local.generatedScript,"!!","##","all");
			NewLine = chr(13) & chr(10);
			DoubleNewLine = chr(13) & chr(10) & chr(13) & chr(10);
			local.generatedScript = Replace(local.generatedScript,DoubleNewLine,NewLine,"all");
			local.generatedScript = Replace(local.generatedScript,DoubleNewLine,NewLine,"all");
			local.generatedScript = Replace(local.generatedScript,DoubleNewLine,NewLine,"all");	
		</cfscript>
		
		<cfif NOT directoryExists(GetDirectoryFromPath(arguments.DestinationFilePath))>
			<cfdirectory action="CREATE" directory="#GetDirectoryFromPath(arguments.DestinationFilePath)#"> 
		</cfif>
		
		<cfif arguments.UpdateInPlace>
			<cfif Right(arguments.DestinationFilePath,8) IS ".xml.cfm">
				<cfset progressReport(message="Creating <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")# Fuseaction</strong> and updating: <strong>#arguments.DestinationFilePath#</strong>")>
				<cfset updateCircuit(addnewline="yes", file=arguments.DestinationFilePath, output=trim(local.GeneratedScript))>
			<cfelseif Right(arguments.DestinationFilePath,11) IS "circuit.cfc" AND oMetaData.getSelectedTable() IS "">
				<cfset progressReport(message="Creating <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")# </strong> and updating: <strong>#arguments.DestinationFilePath#</strong>")>
				<cfset updateInComments(addnewline="yes", file=arguments.DestinationFilePath, output=trim(local.GeneratedScript), template=arguments.TemplateFilePath, project=oMetadata.getProject(), objectName="")>
			<cfelseif Right(arguments.DestinationFilePath,11) IS "circuit.cfc">
				<cfset progressReport(message="Creating <strong>#oMetaData.getSelectedTableAlias()#_#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")# </strong> and updating: <strong>#arguments.DestinationFilePath#</strong>")>
				<cfset updateInComments(addnewline="yes", file=arguments.DestinationFilePath, output=trim(local.GeneratedScript), template=arguments.TemplateFilePath, project=oMetadata.getProject(), objectName=oMetaData.getSelectedTableAlias())>
			<cfelseif Right(arguments.DestinationFilePath,4) IS ".cfc">
				<cfset progressReport(message="Creating <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")# </strong> and updating: <strong>#arguments.DestinationFilePath#</strong>")>
				<cfset updateInComments(addnewline="yes", file=arguments.DestinationFilePath, output=trim(local.GeneratedScript), template=arguments.TemplateFilePath, project=oMetadata.getProject())>
			<cfelse>
				<cfset progressReport(message="Skipping <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")#</strong> because updating <strong>.#ListLast(ListLast(arguments.TemplateFilePath,"\/"),".")#</strong> files is not supported.")>
			</cfif>
		<cfelse>
			<cfif fileExists(arguments.DestinationFilePath) AND arguments.overwrite>
				<cfset progressReport(message="Creating <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")#</strong> and overwriting: <strong>#arguments.DestinationFilePath#</strong>")>
				<cffile action="delete" file="#arguments.DestinationFilePath#">
				<cffile action="write" addnewline="yes" file="#arguments.DestinationFilePath#" output="#trim(local.GeneratedScript)#" fixnewline="no">
			<cfelseif NOT fileExists(arguments.DestinationFilePath)>
				<cfset progressReport(message="Creating <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")#</strong> and creating: <strong>#arguments.DestinationFilePath#</strong>")>
				<cffile action="write" addnewline="yes" file="#arguments.DestinationFilePath#" output="#trim(local.GeneratedScript)#" fixnewline="no">
			<cfelse>
				<cfset progressReport(message="Skipping <strong>#ListFirst(ListLast(arguments.TemplateFilePath,"\/"),".")#</strong> because <strong>#arguments.DestinationFilePath#</strong> exists already.")>
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="updateCircuit" access="private" returntype="void" output="yes" 
				hint="I update an existing circuit xml with a new fuseaction, by looking for a particular fuseaction.">
		<cfargument name="file" required="Yes" type="string" hint="I am the path to the circuit file to be updated"/>
		<cfargument name="output" required="Yes" type="string" hint="I am the new fuseaction to be added or updated"/> 
		<cfargument name="addnewline" required="No" default="no" type="boolean" />
		
		<cfset var local = StructNew()>
		
		<cfset local.found = "false">
		
		<!--- To parse the XML it must declare any possible name spaces : There must be a better way! --->
		<cftry>
			<cfset local.xFuseaction = xmlParse("<circuit xmlns:cf=""cf/"" xmlns:reactor=""reactor/"" xmlns:cs=""coldspring/"">" & arguments.output & "</circuit>")>
			<cfcatch>
				<cfdump var="# arguments.output#" ><cfabort>
			</cfcatch>
		</cftry>
		<!--- Read in the current circuit and parse the XML --->
		<cfif fileExists(arguments.file)>
			<cffile action="READ" file="#arguments.file#" variable="local.circuit">
		<cfelse>
			<cfset local.circuit = xmlParse("<circuit></circuit>")>
		</cfif>
		<cfset local.xCircuit = xmlParse(local.circuit)>
		
		<!--- Find the name of the fuseaction being added --->
		<cfset local.fName = local.xFuseaction.circuit.fuseaction.XmlAttributes.name>
		
		<!--- Make an array of the current fuseactions in the circuit --->
		<cfset local.aFuseactions = local.xCircuit.circuit.xmlChildren>
		
		<!--- Loop over the existing fuseactions and replace the existing fuseaction with the same name or add the new one --->
		<cfsavecontent variable="local.xmlOutput">
<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/">
		<cfloop from="1" to="#arrayLen(local.aFuseactions)#" index="local.i"><cfif structKeyExists(local.aFuseactions[local.i],"xmlAttributes") AND structKeyExists(local.aFuseactions[local.i].xmlAttributes,"name") AND local.aFuseactions[local.i].xmlAttributes.name IS local.fName><cfset local.found = "true">
	<cfoutput>#arguments.output#
	
</cfoutput><cfelse>
	<cfoutput>#trim(Replace(toString(local.aFuseactions[local.i]),"<?xml version=""1.0"" encoding=""UTF-8""?>",""))#
	
</cfoutput></cfif></cfloop><cfif NOT local.found>
	#arguments.output#
</cfif>
</circuit>
		</cfsavecontent>
		
		<!--- Write out the revised circuit --->
		<cffile action="write" addnewline="#arguments.addnewline#" file="#arguments.File#" output="#trim(local.xmlOutput)#">
	</cffunction>
	
	<cffunction name="updateCFC" access="public" returntype="void" output="yes" 
				hint="I update a method in a CFC by looking for a particular method name.">
		<cfargument name="file" required="Yes" type="string" hint="I am the path to the CFC to be updated"/>
		<cfargument name="output" required="Yes" type="string" hint="I am the new method to be added or updated"/> 
		<cfargument Name="project" type="any" required="yes" hint="The project name." />
		<cfargument name="addnewline" required="No" default="no" type="boolean" />
		
		<!--- Read the new method and read the name of the method --->
		<cfset var pos1 = FindNoCase("name=",output,1) + 6>
		<cfset var pos2 = ReFind("""",output,pos1)>
		<cfset var functionname = Mid(output,pos1,pos2-pos1)>
		<cfset var local = structNew()>
		<cfset var beforeCode = "">
		<cfset var afterCode = "">
		<cfset var foundFunction = 0>
		
		<!--- Read in the current CFC --->
		<cfif fileExists(arguments.file)>
			<cffile action="READ" file="#arguments.file#" variable="local.CFC">
		<cfelse>
			<cfset local.CFC = "<cfcomponent displayname=""#ListLast(arguments.file,'\/')#"" extends=""reactor.project.#arguments.project#.Gateway.#ListFirst(ListLast(arguments.file,'\/'),".")#"">#chr(10)#</cfcomponent>">
		</cfif>
		
		<!--- Find the first method with the same name --->
		<cfset pos1 = 0>
		<cfset pos2 = 0>
		<cfset foundFunction = FindNoCase("<cffunction",local.CFC,foundFunction+1)>
		<cfloop condition="foundFunction IS NOT 0">
			<cfset pos1 = FindNoCase("name=",local.CFC,foundFunction) + 6>
			<cfset pos2 = ReFind("""",local.CFC,pos1)>
			<cfset functionNameFound = Mid(local.CFC,pos1,pos2-pos1)>
			<cfif functionNameFound IS functionname>
				<cfset endFunction = FindNoCase("</cffunction>",local.CFC,pos2) + 13>
				<cfset beforeCode = Left(local.CFC,foundFunction - 1)>
				<cfset afterCode = RemoveChars(local.CFC,1,endFunction)>
				<!--- <cfoutput>
					#HTMLCodeFormat(beforeCode)#
				</cfoutput> --->
				<cfbreak>
			</cfif>
			<cfset foundFunction = FindNoCase("<cffunction",local.CFC,pos2)>
		</cfloop>
		<cfif foundFunction IS 0>
			<!--- No matching function was found so look for the cfcomponent ending tag --->
			<cfset pos1 = FindNoCase("</cfcomponent>",local.CFC,1) - 1>
			<cfif pos1 LT 0>
				<cfthrow message="I can't find the ending tag in the CFC: #arguments.file#" detail="I can't find the ending tag in the CFC: #arguments.file# #HTMLCodeFormat(local.CFC)#">
			<cfelse>
				<cfset beforeCode = Left(local.CFC,pos1)>
				<cfset afterCode = RemoveChars(local.CFC,1,pos1)>
			</cfif>
		</cfif>
		<cfset local.newCFC = beforeCode & chr(10) & chr(9) & arguments.output & chr(10) & afterCode>
		<!--- <cfoutput>
			#HTMLCodeFormat(local.newCFC)#
			<br />------------------------<br />
		</cfoutput> --->
		<!--- Write out the revised circuit --->
		<cffile action="write" addnewline="#arguments.addnewline#" file="#arguments.File#" output="#trim(local.newCFC)#">
		
	</cffunction>
	
	<cffunction name="UpdateInComments"
			hint="I update a code snippet by looking for the existing snippet between a set of predefined comments">
		<cfargument name="file" required="Yes" type="string" hint="I am the path to the file to be updated"/>
		<cfargument name="output" required="Yes" type="string" hint="I am the code to be added or updated"/> 
		<cfargument name="project" type="any" required="yes" hint="The project name." />
		<cfargument name="template" type="any" required="yes" hint="The template name." />
		<cfargument name="addnewline" required="No" default="no" type="boolean" />
		<cfargument name="objectName" required="No" default="" type="string" />
		
		<cfset var local = structNew()>
		
		<!--- Read in the current Code, create a dummy if not there --->
		<cfif fileExists(arguments.file)>
			<cffile action="READ" file="#arguments.file#" variable="local.Code">
		<cfelseif right(arguments.file,4) IS ".cfc">
			<cfset local.Code = "<cfcomponent displayname=""#ListLast(arguments.file,'\/')#"">#chr(10)#</cfcomponent>">
		<cfelseif right(arguments.file,8) IS ".xml.cfm">
			<cfset local.Code = "<circuit></circuit>">
		<cfelseif right(arguments.file,4) IS ".xml">
			<cfset local.Code = "<circuit></circuit>">
		<cfelse>
			<cfset local.Code = "">
		</cfif>
		
		<!--- Create a sutable comment to search for or wrap around the generated code --->
		<cfif arguments.objectName IS NOT "">
			<cfset local.commentIdentity = arguments.objectName & "_" & ListFirst(GetFileFromPath(arguments.template),".")>
		<cfelse>
			<cfset local.commentIdentity = ListFirst(GetFileFromPath(arguments.template),".")>
		</cfif>
		<cfif right(arguments.file,8) IS ".xml.cfm" OR right(arguments.file,4) IS ".xml">
			<cfset local.start = "<!-- Start of #local.commentIdentity# code generated by fusebox scaffolder, it will be replaced if fusebox scaffolder is rerun. -->">
			<cfset local.end = "<!-- End of #local.commentIdentity# code generated by fusebox scaffolder. -->">
		<cfelseif right(arguments.file,3) IS ".as" OR right(arguments.file,4) IS ".js">
			<cfset local.start = "/* Start of #local.commentIdentity# code generated by fusebox scaffolder, it will be replaced if fusebox scaffolder is rerun. */">
			<cfset local.end = "/* End of #local.commentIdentity# code generated by fusebox scaffolder. */">
		<cfelse>
			<cfset local.start = "<!--- Start of #local.commentIdentity# code generated by fusebox scaffolder, it will be replaced if fusebox scaffolder is rerun. --->">
			<cfset local.end = "<!--- End of #local.commentIdentity# code generated by fusebox scaffolder. --->">
		</cfif>
		
		<!--- Find the starting comment --->
		<cfset local.foundComment = FindNoCase(local.Start,local.Code,1)>
		
		<cfif local.foundComment GT 0>
			<!--- The starting comment was found, look for the ending comment. --->
			<cfset local.foundEnd = FindNoCase(local.End,local.Code,local.foundComment)>
			<cfif local.foundEnd GT 0>
				<!--- Ending comment was found so remove the starting and ending comment and everything between. --->
				<cfset local.beforeCode = Left(local.Code,local.foundComment - 1)>
				<cfset local.afterCode = RemoveChars(local.Code,1,local.foundEnd+Len(local.End)-1)>
			<cfelse>
				<!--- Ending comment was not found so just remove the starting comment. --->
				<cfset local.beforeCode = Left(local.Code,local.foundComment - 1)>
				<cfset local.afterCode = RemoveChars(local.Code,1,local.foundComment+Len(local.Start)-1)>
			</cfif>
			
		<cfelseif right(arguments.file,4) IS ".cfc">
			<!--- No matching comment was found inside a CFC --->
			<!--- Look for a suitable closing cfcomponent tag --->
			<cfset local.foundEnd = FindNoCase("</cfcomponent>",local.Code,1)>
			
			<cfif local.foundEnd GT 0>
				<!--- We found the closing cfcomponent tag so put all the code before it into the before and the end code into the end --->
				<cfset local.beforeCode = Left(local.Code,local.foundEnd - 1)>
				<cfset local.afterCode = RemoveChars(local.Code,1,local.foundEnd - 1)>
			<cfelse>
				<!--- We did not find the closing cfcomponent tag so put all the code in the before --->
				<cfset local.beforeCode = local.Code>
				<cfset local.afterCode = "">
			</cfif>
		
		<cfelseif left(arguments.file,11) IS "circuit.xml">
			<!--- No matching comment was found inside a circuit --->
			<!--- Look for a suitable closing circuit tag --->
			<cfset local.foundEnd = FindNoCase("</circuit>",local.Code,1) - 1>
			<cfdump var="#foundEnd#"><br />
			<cfif local.foundEnd GT 0>
				<!--- We found the closing circuit tag so put all the code before it into the before and the end code into the end --->
				<cfset local.beforeCode = Left(local.Code,local.foundEnd)>
				<cfset local.afterCode = RemoveChars(local.Code,1,local.foundEnd-1)>
			<cfelse>
				<!--- We did not find the closing circuit tag so put all the code in the before --->
				<cfset local.beforeCode = local.Code>
				<cfset local.afterCode = "">
			</cfif>
			
		<cfelse>
			<!--- No matching comment was found in another type of file, go to the end --->
			<cfset local.beforeCode = local.Code>
			<cfset local.afterCode = "">
			
		</cfif>
		<!--- Build the file from the before and after code with the new code in between comments --->
		<cfset local.newCode = local.beforeCode & chr(10) & local.Start & chr(10) & arguments.output & chr(10) & local.End & chr(10) & local.afterCode>
		
		<!--- Remove any sets of multiple newlines --->
		<cfset local.newCode = Replace(local.newCode,chr(10) & chr(10),chr(10),"all")>
		
		<!--- Write out the updated file --->
		<cffile action="write" addnewline="#arguments.addnewline#" file="#arguments.File#" output="#trim(local.newCode)#">
		
	</cffunction>
	
</cfcomponent>
