<<cfoutput>>
<cfsilent>
<!--- -->
<fusedoc fuse="qry_delete_$$objectName$$.cfm" language="ColdFusion 7.01" version="2.0">
	<responsibilities>
		I delete the selected$$objectName$$ object.
	</responsibilities>
	<properties>
		<history author="$$oMetaData.getAuthor()$$" email="$$oMetaData.getAuthorEmail()$$" date="$$dateFormat(now(),'dd-mmm-yyyy')$$" role="Architect" type="Create" />
		<property name="copyright" value="(c)$$year(now())$$ $$oMetaData.getCopyright()$$" />
		<property name="licence" value="$$oMetaData.getLicence()$$" />
		<property name="version" value="$Revision: $$oMetaData.getVersion()$$ $" />
		<property name="lastupdated" value="$Date: $$DateFormat(now(),'yyyy/mm/dd')$$ $$ TimeFormat(now(),'HH:mm:ss')$$ $" />
		<property name="updatedby" value="$Author: $$oMetaData.getAuthor()$$ $" />
	</properties>
	<io>
		<in>
			<object name="$$objectName$$" scope="variables" />
			<<cfloop from="1" to="$$arrayLen(aPKFields)$$" index="thisKey">>
			<$$aPKFields[thisKey].fuseDocType$$ name="$$aPKFields[thisKey].alias$$"/><</cfloop>>
		</in>
		<out>
			<object name="$$objectName$$" scope="variables" />
		</out>
	</io>
</fusedoc>
--->
<!--- Set the value of the primary key ---><<cfloop from="1" to="$$ArrayLen(aPKFields)$$" index="i">>
<cfset $$aPKFields[i].alias$$=attributes.$$aPKFields[i].alias$$ /><</cfloop>>
<!--- Create the $$objectName$$ Service --->
<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>
<!--- Delete the $$objectName$$ --->
<cfset $$objectName$$Service.delete($$lPKFields$$) />
</cfsilent>
<</cfoutput>>





