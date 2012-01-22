<cfcomponent hint="I possibly fooloishly provide the Fusebox Context to things called outside Fusebox. Such as direct called CFCs.">

		<cffunction name="init">
			<cfif NOT structKeyExists(request._myFusebox)>
				<cfset request._FuseboxContext = this />	
			</cfif>
			<cfreturn request._FuseboxContext />
		</cffunction>
		<cffunction name="setMyFusebox">
			<cfset this.myFusebox = arguments[1] />
			<cfreturn this>
		</cffunction>
		<cffunction name="setFuseboxEvent">
			<cfset this.fuseboxEvent = arguments[1] />
			<cfreturn this>
		</cffunction>
		<cffunction name="execute">
			<cfargument name="objectOrFuseaction" />
			<cfargument name="method" />
			<cfif isSimpleValue()>
				<!--- TODO implement --->
			<cfelse>
				<cfsilent>
					<cfinvoke component="#arguments.objectOrFuseaction#" method="#arguments.method#" myFusebox="#this.myFusebox#" event="#this.fuseboxEvent#">
				</cfsilent>
			</cfif>
		</cffunction>
		
</cfcomponent>