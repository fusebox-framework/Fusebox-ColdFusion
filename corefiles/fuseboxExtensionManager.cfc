<cfcomponent output="false" hint="I am the manager for all Extensions in Fusebox.">
	<cfset variables.extensions = structNew() />
	<cfset variables.extensions.application = ArrayNew(1) />
	<cfset variables.extensions.requeststart = ArrayNew(1) />
	
	<cffunction name="init">
		<cfargument name="pathUtil" required="false" hint="A Configured PathUtil" intent:require="true" />
		<cfargument name="fuseboxXmlCode" required="false" hint="The Fusebox XML" intent:require="true" />
		<cfset variables.fbXml = arguments.fuseboxXmlCode />
		<cfset variables.pathUtil = arguments.pathUtil />
		
		<cfreturn this />
	</cffunction>	 
	<cffunction name="loadExtensions" access="public" output="false">
		<cfargument name="path" type="string" required="true" />
		<cfset var pathing = "" />
		<cfset var fbExtensions = "" />
		<cfset var extHolder = "" />
		<cfset var loadCount = 0 />
		<cfif NOT directoryExists(arguments.path)>
			<cfthrow type="fusebox.BadDirectory" message="Directory does not exist." detail="Yourn path is probably wrong: #path#" />
		</cfif>
		<cfdirectory action="list" directory="#arguments.path#" filter="*.cfc" name="fbExtensions" />
		<cfloop query="fbExtensions">
			<cfif fbExtensions.type EQ "file">				
				<cfset extHolder = createObject("component", pathUtil.locateCfc("#fbExtensions.directory#/#fbExtensions.name#")).init(variables.fbXml) />
				<cfif addExtension(extHolder, getMetaData(extHolder)["fusebox:lifecycle"])>
					<cfset loadCount = loadCount + 1 />
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn loadCount />
	</cffunction>
	<cffunction name="addExtension" access="public">
		<cfargument name="ext" displayname="Extension" hint="A Fusebox Extension" />
		<cfargument name="lifecycle" hint="The appropriate lifecycle for this extension to be executed" />
		<cfset arrayAppend(variables.extensions[arguments.lifecycle], arguments.ext) />
		<cfreturn true />
	</cffunction>
	
	<cffunction name="runApplicationExtentions" access="public" output="true"
				hint="Run application level lifecycle extensions">
		<cfargument name="attributes" required="false" hint="Fusebox attributes" />
		<cfargument name="event" required="false" hint="Fusebox's event object" />
		<cfargument name="myFusebox" required="false" hint="Fusebox's myFusebox object" />
		<cfset runExtensions("application", attributes, event, myFusebox) />
	</cffunction>
	
	<cffunction name="runRequestStartExtentions" access="public" output="true"
				hint="Run application level lifecycle extensions">
		<cfargument name="attributes" required="false" hint="Fusebox attributes" />
		<cfargument name="event" required="false" hint="Fusebox's event object" />
		<cfargument name="myFusebox" required="false" hint="Fusebox's myFusebox object" />
		<cfset runExtensions("requeststart", attributes, event, myFusebox) />
	</cffunction>
	
	<cffunction name="runExtensions">
		<cfargument name="lifecycle" required="false">
		<cfargument name="attributes" required="false" hint="Fusebox attributes" />
		<cfargument name="event" required="false" hint="Fusebox's event object" />
		<cfargument name="myFusebox" required="false" hint="Fusebox's myFusebox object" />
		<cfset var index = 0 />
		<cfloop from="1" to="#ArrayLen(variables.extensions[arguments.lifecycle])#" index="index">
			<cfset variables.extensions[arguments.lifecycle][index].run(attributes, event, myFusebox) />
		</cfloop>
	</cffunction>
</cfcomponent>
