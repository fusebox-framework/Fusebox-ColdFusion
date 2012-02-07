<!---


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
<cfcomponent hint="I represent an implicit circuit." output="false" extends="fuseboxNoXmlCircuit">
	
	<cffunction name="init" returntype="any" access="public" output="false" 
				hint="I am the constructor.">
		<cfargument name="fbApp" type="fuseboxApplication" required="true" 
					hint="I am the fusebox application object." />
		<cfargument name="alias" type="string" required="true" 
					hint="I am the circuit alias." />
		<cfargument name="myFusebox" type="myFusebox" required="true" 
					hint="I am the myFusebox data structure." />
		<cfreturn SUPER.init(fbApp,alias,myFusebox,"")>
	</cffunction>
	
	<cffunction name="reload" returntype="any" access="public" output="false" 
				hint="I reload the circuit file and build the in-memory structures from it.">
		<cfargument name="myFusebox" type="myFusebox" required="true" 
					hint="I am the myFusebox data structure." />
		
		<cfset var found = false />
		<cfset var path = "" />
		
		<cfset this.access = "public" />
		<cfset variables.fuseactionIsMethod = false />
		
		<!---
			in order of preference, we want to find:
			1. {MVC}/{alias}.cfc
				- this implies fuseactions are methods
			2. {MVC}/{alias}/
				- we can look for {fuseaction}.xml or {fuseaction}.cfm later
			3. {alias}/
				- we can look for {fuseaction}.xml or {fuseaction}.cfm later
		--->

		<cfloop index="path" list="controller/,model/,view/">

			<cfset variables.originalPath = path />
			<cfset variables.fullPath = variables.appPath & variables.originalPath />
			<cfset variables.relativePath = variables.fuseboxApplication.relativePath(variables.appPath,variables.fullPath) />
	
			<!--- if the CFC actually exists, see if we can figure out if it exists in a sensible place --->
			<cfif fileExists(variables.fullPath & Replace(getAlias(),".","/","ALL") & ".cfc")>
				<cfset variables.dottedPath = variables.fuseboxApplication.locateCfc(variables.fullPath & Replace(getAlias(),".","/","ALL") & ".cfc") />
				<cfif variables.dottedPath is not "">
					<cfset found = true />
					<cfset variables.fuseactionIsMethod = true />
					<cfif variables.fuseboxApplication.debug>
						<cfset arguments.myFusebox.trace("Compiler","Implicit component-as-circuit #variables.originalPath##Replace(getAlias(),".","/","ALL")#.cfc identified") />
					</cfif>
					<cfbreak />
				</cfif>
			</cfif>

			<!--- first time through, access is public for controller - should change to internal for model / view circuits --->
			<cfset this.access = "internal" />
			
		</cfloop>

		<cfif not found>
			<!--- no CFCs so look for an MVC directory --->
			<cfset this.access = "public" />

			<cfloop index="path" list="controller/,model/,view/">
	
				<cfset variables.originalPath = path & Replace(getAlias(),".","/","ALL") & "/" />
				<cfset variables.fullPath = variables.appPath & variables.originalPath />
				<cfset variables.relativePath = variables.fuseboxApplication.relativePath(variables.appPath,variables.fullPath) />
	
				<!--- MVC circuit directory? --->
				<cfif directoryExists(variables.fullPath)>
					<!--- looks like we have a candidate --->
					<cfset found = true />
					<cfif variables.fuseboxApplication.debug>
						<cfset arguments.myFusebox.trace("Compiler","Implicit circuit #variables.originalPath# identified") />
					</cfif>
					<cfbreak />
				</cfif>
				
				<!--- first time through, access is public for controller - should change to internal for model / view circuits --->
				<cfset this.access = "internal" />
				
			</cfloop>

		</cfif>					
		
		<cfif not found>
			<!--- no MVC, what about just a directory? --->
			<cfset this.access = "public" />
			<cfset variables.originalPath = Replace(getAlias(),".","/","ALL") & "/" />
			<cfset variables.fullPath = variables.appPath & variables.originalPath />
			<cfset variables.relativePath = variables.fuseboxApplication.relativePath(variables.appPath,variables.fullPath) />

			<cfif directoryExists(variables.fullPath)>

				<!--- ok, the directory exists --->
				<cfif variables.fuseboxApplication.debug>
					<cfset arguments.myFusebox.trace("Compiler","Implicit circuit #Replace(getAlias(),".","/","ALL")# identified") />
				</cfif>

			<cfelse>

				<cfthrow type="fusebox.undefinedCircuit" 
						message="undefined Circuit" 
						detail="You specified a Circuit of #Replace(getAlias(),".","/","ALL")# which is not defined." />

			</cfif>

		</cfif>
		
		<!--- we don't know what fuseactions an implicit circuit has --->
		<cfset this.fuseactions = structNew() />
		<cfset this.parent = "" />
		<cfset this.permissions = "" />
		<cfset this.path = variables.relativePath />
		<cfset this.rootPath = variables.fuseboxApplication.relativePath(variables.fullPath,variables.appPath) />
		<cfset this.timestamp = now() />

	</cffunction>
	
</cfcomponent>