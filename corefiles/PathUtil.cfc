<cfcomponent output="false" hint="Path functionality">
	<cfset variables.webrootdirectory = replace(getDirectoryFromPath(getBaseTemplatePath()),"\","/","all") />
	<cfset variables.coreRoot = replace(getDirectoryFromPath(getCurrentTemplatePath()),"\","/","all") />
	<cfset variables.approotdirectory = variables.coreRoot />
	<cfset variables.osdelimiter = "/" />
	<cffunction name="init" returntype="PathUtil" access="public" output="false" 
					hint="I am the constructor.">
		<cfargument name="appPath" type="string" required="true" 
						hint="I am FUSEBOX_APPLICATION_PATH." />
		<cfargument name="callerPath" type="string" required="true" 
						hint="I am FUSEBOX_CALLER_PATH." />
	
		<cfset variables.approotdirectory = getFBCanonicalPath(normalizePartialPath(arguments.callerPath) & normalizePartialPath(arguments.appPath)) />
		<cfset calculatePaths(variables.approotdirectory) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="relativePath" returntype="string" access="public" output="false" 
				hint="I compute the relative path from one file system location to another.">
		<cfargument name="from" type="string" required="true" 
					hint="I am the full pathname from which the relative path should be computed." />
		<cfargument name="to" type="string" required="true" 
					hint="I am the full pathname to which the relative path should be computed." />
		
		<cfset var relative = "" />
		<cfset var fromFirst = listFirst(arguments.from,"/") />
		<cfset var fromRest = arguments.from />
		<cfset var toFirst = listFirst(arguments.to,"/") />
		<cfset var toRest = arguments.to />
		<cfset var needSlash = false />
		
		<!--- trap special case first --->
		<cfif arguments.from is arguments.to>
			<cfreturn "" />
		</cfif>
	
		<!--- walk down the common part of the paths --->
		<cfloop condition="fromFirst is toFirst">
			<cfset needSlash = true />
			<cfset fromRest = listRest(fromRest,"/") />
			<cfset toRest = listRest(toRest,"/") />
			<cfset fromFirst = listFirst(fromRest,"/") />
			<cfset toFirst = listFirst(toRest,"/") />
		</cfloop>	
		<!--- at this point the paths differ --->
		<cfif not needSlash>
			<!--- the paths differed from the top so we need to strip the leading / --->
			<cfset toRest = right(toRest,len(toRest)-1) />
		</cfif>
		<cfset relative = repeatString("../",listLen(fromRest,"/")) & toRest />
		<!---
			ensure the trailing / is present - strictly speaking this is a bug fix for Railo
			but it's probably a good practice anyway
		--->
		<cfif right(relative,1) is not "/">
			<cfset relative = relative & "/" />
		</cfif>
	
		<cfreturn relative />
		
	</cffunction>
	
	<cffunction name="getFBCanonicalPath" returntype="string" access="public" output="false" 
				hint="I return a canonical file path (with all /../ sections resolved).">
		<cfargument name="path" type="string" required="true" 
					hint="I am the path to resolve." />
		
		<cfset var resolvedPath = replace(arguments.path,"\","/","all") />
		<cfset var leadingSlash = left(resolvedPath,1) is "/" />
		<!--- UNC fix from Phil Muhm - ticket 239 --->
		<cfset var leadingDoubleSlash = left(resolvedPath,2) is "//" />
		<cfset var trailingSlash = right(resolvedPath,1) is "/" />
		<cfset var segment = ""/>
		<cfset var j = 1 />
		<cfset var n = 0 />
		<cfset var pathParts = arrayNew(1) />
		<cfset var delimiter = "" />
	
		<!--- remove pairs of directory/../ --->		
		<cfloop list="#resolvedPath#" delimiters="/" index="segment">
			<cfif segment is ".">
				<!--- just ignore this --->
			<cfelseif segment is "..">
				<cfif j gt 1 and pathParts[j-1] is not "..">
					<cfset j = j - 1 />
				<cfelse>
					<cfset pathParts[j] = segment />
					<cfset j = j + 1 />
				</cfif>
			<cfelse>
				<cfset pathParts[j] = segment />
				<cfset j = j + 1 />
			</cfif>
		</cfloop>
		
		<!--- rebuild the path --->
		<cfif leadingSlash>
			<cfset delimiter = "/" />
		</cfif>
		<cfset resolvedPath = "" />
		<cfset n = j - 1 />
		<cfloop from="1" to="#n#" index="j">
			<cfset resolvedPath = resolvedPath & delimiter & pathParts[j] />
			<cfset delimiter = "/" />
		</cfloop>
		<cfif trailingSlash>
			<cfset resolvedPath = resolvedPath & "/" />
		</cfif>
		<!--- UNC fix from Phil Muhm - ticket 239 --->
		<cfif leadingDoubleSlash>
			<cfset resolvedPath = "/" & resolvedPath />
		</cfif>
	
		<cfreturn resolvedPath />
		
	</cffunction>
	
	<cffunction name="normalizePartialPath" returntype="string" access="public" output="false" 
				hint="I return a normalized file path (that has / instead of \ and ends with /).">
		<cfargument name="partialPath" type="string" required="true" 
					hint="I am the path to normalize." />
		
		<cfset var unixPath = replace(arguments.partialPath,"\","/","all") />
		
		<cfif right(unixPath,1) is not "/">
			<cfset unixPath = unixPath & "/" />
		</cfif>
		
		<cfreturn unixPath />
		
	</cffunction>
		
	<cffunction name="locateCfc" returntype="string" access="public" output="false"
					hint="I deduce the dot-separated path to a CFC given its file system path (and a few heuristics).">
			<cfargument name="filename" type="string" required="true" />
		
			<cfset var cfcPath = getFBCanonicalPath(filename) />
			<cfset var webRoot = getFBCanonicalPath(expandPath("/")) />
			<cfset var lenWebRoot = len(webRoot) />
			<cfset var lenAppRoot = len(getApplicationRoot()) />
			<cfset var lenCfcPath = len(cfcPath) />
			<cfset var cfcDotPath = "" />
			<cfset var firstSlash = 0 />
			
			<cfif lenCfcPath gt lenWebRoot and
					left(cfcPath,lenWebRoot) is webRoot>
				<!--- looks like it is under the webroot --->
				<cfset cfcDotPath = replace(mid(cfcPath,lenWebRoot+1,lenCfcPath-lenWebRoot-4),"/",".","all") />
			<cfelse>
				<!--- must be mapped --->
				<cfif lenCfcPath gt lenAppRoot and
						left(cfcPath,lenAppRoot) is getApplicationRoot()>
					<!--- looks like it is under the approot - assume approot is a mapping --->
					<cfset cfcDotPath = listLast(getApplicationRoot(),"/") & "." &
							replace(mid(cfcPath,lenAppRoot+1,lenCfcPath-lenAppRoot-4),"/",".","all") />
				<cfelse>
					<!--- dot-convert entire path and attempt to create it, dropping leading directories until we succeed --->
					<!--- remove stuff up to leading / and also the .cfc at the end --->
					<!--- note: this is *expensive* --->
					<cfset firstSlash = find("/",cfcPath) />
					<cfset cfcDotPath = replace(mid(cfcPath,firstSlash+1,lenCfcPath-firstSlash-4),"/",".","all") />
					<cfloop condition="listLen(cfcDotPath) gt 0">
						<cftry>
							<cfset createObject("component",cfcDotPath) />
							<!--- succeeded - return it --->
							<cfbreak />
							<cfcatch type="any">
								<!--- failed - keep searching --->
							</cfcatch>
						</cftry>
						<cfset cfcDotPath = listRest(cfcDotPath,".") />
					</cfloop>
				</cfif>
			</cfif>
			
			<cfreturn cfcDotPath />
		
		</cffunction>
	
	<cffunction name="getApplicationRoot" returntype="any" access="public" output="false" 
				hint="I am a convenience method to return the full application root directory path.">
		<cfreturn variables.approotdirectory />
	</cffunction>
	<cffunction name="getCorePath">
		<cfreturn variables.coreRoot>
	</cffunction>
	
	<cffunction name="compatibility" access="public" output="false" returntype="struct"
			 hint="Returns a strcture of information that FuseboxApplication exposes in it's THIS scope.">
		<cfset var returnStruct = structNew() />
		<cfset returnStruct.webrootdirectory 	= variables.webrootdirectory />
		<cfset returnStruct.approotdirectory 	= variables.approotdirectory/>
		<cfset returnStruct.osdelimiter			= variables.osdelimiter />	
		<cfset returnStruct.coreToAppRootPath 	= variables.coreToAppRootPath />
		<cfset returnStruct.appRootPathToCore 	= variables.appRootPathToCore />
		<cfset returnStruct.coreToWebRootPath 	= variables.coreToWebRootPath />
		<cfset returnStruct.WebRootPathToCore 	= variables.WebRootPathToCore />
		<cfreturn returnStruct />
	</cffunction>
	
	<cffunction name="calculatePaths" access="private" output="false" returntype="void"
				hint="calculates all the paths given an application root">
		<cfargument name="approot" required="true" />
		<cfset variables.coreToAppRootPath = relativePath(variables.coreRoot,arguments.approot) />
		<cfset variables.appRootPathToCore = relativePath(arguments.approot,variables.coreRoot) />
		<cfset variables.coreToWebRootPath = relativePath(variables.coreRoot,variables.webrootdirectory) />
		<cfset variables.WebRootPathToCore = relativePath(variables.webrootdirectory,variables.coreRoot) />
	</cffunction>

</cfcomponent>
