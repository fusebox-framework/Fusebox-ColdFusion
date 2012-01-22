<<cfoutput>>
<cfcomponent displayname="$$oMetaData.getProject()$$" 
	extends="$$oMetaData.getBaseCFCPath()$$.controller.$$oMetaData.getProject()$$.circuit" 
	hint="I control the fuses executed in the $$oMetaData.getProject()$$ circuit.">
	<!--- 
	author="$$oMetaData.getAuthor()$$" 
	email="$$oMetaData.getAuthorEmail()$$" 
	date="$$dateFormat(now(),'dd-mmm-yyyy')$$"
	copyright="(c)$$year(now())$$ $$oMetaData.getCopyright()$$"
	licence="$$oMetaData.getLicence()$$"
	version="Revision: $$oMetaData.getVersion()$$"
	 --->
</cfcomponent>
<</cfoutput>>