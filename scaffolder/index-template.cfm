
<cfinclude template="/scaffolder/manager.cfm">

<cfapplication
	name="$$applicationName$$"
	sessionmanagement="Yes"
	sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
	clientmanagement="No">

<cfset FUSEBOX_APPLICATION_PATH = "">
<cfset FUSEBOX_PARAMETERS.allowImplicitCircuit = true>
<cfset FUSEBOX_PARAMETERS.allowImplicitFusebox = true>
<cfset FUSEBOX_PARAMETERS.defaultFuseaction = "$$defaultFuseaction$$">
<cfset FUSEBOX_PARAMETERS.password = "$$password$$" />
<cfset FUSEBOX_PARAMETERS.mode = "development-full-load" />
<cfset FUSEBOX_PARAMETERS.debug = true />

<cfinclude template="/fusebox5/fusebox5.cfm">

