<<!---
Copyright 2008 Objective Internet Ltd - http://www.objectiveinternet.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->>
<<!--- Set the name of the object (table) --->>
<<cfset projectName = oMetadata.getProject()>>
<<!--- Set the name of the object (table) --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Create a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName,"showOnDisplay")>>
<<!--- Create a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Create a list of the table field types --->>
<<cfset lFieldTypes = "">>
<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<<cfif aFields[i].type IS "numeric" OR aFields[i].type IS "datetime">>
		<<cfset lFieldTypes = ListAppend(lFieldTypes,aFields[i].validation)>>
	<<cfelse>>
		<<cfset lFieldTypes = ListAppend(lFieldTypes,aFields[i].type)>>
	<</cfif>>
<</cfloop>>
<<!--- Create an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfoutput>>
<cfsetting enablecfoutputonly="true" showdebugoutput="false">
<!--- -->
<?xml version="1.0" encoding="UTF-16"?>
<fusedoc fuse="$$objectName$$_UpdateJson.cfm">
	<responsibilities>
		I accept a json structure containing an array records with of changes and a list of deleted records.
		I loop through the array and update the database.
		I loop through the list and delete the records.
	</responsibilities>
	<properties>
		<history 
			author="Kevin Roche" 
			email="kevin@objectiveinternet.com" 
			date="20-Nov-2008" 
			role="architect" 
			type="create"/>
		<property name="copyright" value="(c)2008 Activity Forum Limited."/>
		<property name="licence" value="See licence.txt"/>
		<property name="version" value="3.50"/>
	</properties>
	<io>
		<in>
			<structure name="fusebox" scope="application" />
			<structure name="data" scope="form" format="json">
				<array name="records" comment="One entry for each modified or new record">
					<structure>
						<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">><$$aFields[i].type$$ name="$$lFirst(aFields[i].alias)$$" />
						<</cfloop>>
					</structure>
				</array>
				<list name="deleted" comment="List of the ids of records to be deleted." />
			</structure>
		</in>
		<out>
			<structure format="json">
				<boolean name="success" comment="Indicates if the update was successful or not"/>
				<string name="message"/>
				<array name="details">
					<structure>
						<string name="recordId"/>
						<string name="field"/>
						<string name="message"/>
					</structure>
				</array>
			</structure>
		</out>
	</io>
</fusedoc>
--->
<!--- Debug Stuff --->
	<!--- 
	<cfsavecontent variable="myContent">
		<cfdump var="#data#" />
	</cfsavecontent>
	<cffile action="WRITE" file="D:\inetpub\wwwroot\dump.htm" output="#myContent#" addnewline="Yes" fixnewline="No"> --->

<!--- Application setup --->
<cfapplication
	name="$$projectName$$"
	sessionmanagement="Yes"
	sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
	clientmanagement="No">

<!--- Database setup --->
<cfset myFusebox=application.fusebox>
<cfset variables.$$objectName$$Service = myFusebox.getApplication().getApplicationData().servicefactory.getBean('$$objectName$$Service')>	

<!--- Use cfjson for deserialization for compatibility --->
<cfobject name="json" component="coldextdemo.coldext.json.json">
<cfset variables.data = json.decode(form.data)>

<!--- Debug Stuff --->
	<!--- 
	<cfsavecontent variable="myContent">
		<cfdump var="#variables.data#" />
	</cfsavecontent>
	<cffile action="APPEND" file="D:\inetpub\wwwroot\dump.htm" output="#myContent#" addnewline="Yes" fixnewline="No">  --->

<cfset aGridErrors = arrayNew(1)>

<!--- Loop over updated records --->
<cfloop from="1" to="#arrayLen(data.records)#" index="counter">
	
	<cfset o$$objectName$$=variables.$$objectName$$Service.get$$objectName$$(<<cfloop from="1" to="$$listLen(lPKFields)$$" index="thisPK">>data.records[counter].$$listGetAt(lPKFields,thisPK)$$<<cfif thisPK IS NOT listLen(lPKFields)>>,<</cfif>><</cfloop>>) />
	<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="i">>
	<cfset o$$objectName$$.set$$uFirst(aFields[i].alias)$$(data.records[counter].$$lFirst(aFields[i].alias)$$) /><</cfloop>>
		
    <cfset aErrors=$$objectName$$Service.validate(o$$objectName$$) />
			
	<cfif ArrayLen(aErrors) EQ 0>
		<cfset success=$$objectName$$Service.save(o$$objectName$$) />
		<cfif NOT success>
			<cfset stError=structNew() />
			<cfset stError["recordId"]=data.records[counter].propertytypeid />
			<cfset stError["message"]="Error in Database Update." />
			<cfset stError["field"]="Unknown" />
			<cfset ArrayAppend(aErrors,stError) />
		</cfif>
	</cfif>
			
	<cfif ArrayLen(aErrors) GT 0>
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="thisError">
			<cfset aErrors[thisError]["recordId"] = data.records[counter].propertytypeid>
			<cfset ArrayAppend(aGridErrors,aErrors[thisError])>
		</cfloop>
	</cfif>
</cfloop>


<!--- Loop over list of deleted records --->
<cfloop list="#data.deleted#" index="thisId">
	<cfset aErrors = arrayNew(1)>
	<cfset o$$objectName$$=variables.$$objectName$$Service.get$$objectName$$(thisId) />
	<cfset o$$objectName$$.setIsActive(0) />
	<cfset success=$$objectName$$Service.save(o$$objectName$$) />
	<cfif NOT success>
		<cfset stError=structNew() />
		<cfset stError["recordId"]=thisId />
		<cfset stError["message"]="Error while deleting." />
		<cfset stError["field"]="Unknown" />
		<cfset ArrayAppend(aErrors,stError) />
	</cfif>
	
	<cfif ArrayLen(aErrors) GT 0>
		<cfloop from="1" to="#ArrayLen(aErrors)#" index="thisError">
			<cfset aErrors[thisError].propertyTypeId = thisId>
			<cfset ArrayAppend(aGridErrors,aErrors[thisError])>
		</cfloop>
	</cfif>
</cfloop>

<!--- Debug stuff --->
	<!--- 
	<cfset stError=structNew() />
	<cfset stError["recordId"]=0 />
	<cfset stError["message"]="Not really an error." />
	<cfset stError["field"]="Unknown" />
	<cfset ArrayAppend(aGridErrors,stError) /> --->

<!--- Debug stuff --->
	<!--- 
	<cfsavecontent variable="myContent">
		<cfdump var="#aGridErrors#" />
	</cfsavecontent>
	<cffile action="APPEND" file="D:\inetpub\wwwroot\dump.htm" output="#myContent#" addnewline="Yes" fixnewline="No">  --->

<cfif ArrayLen(aGridErrors) GT 0>
	<cfobject name="json" component="AF3_5_Property.coldext.json.json">
	<cfoutput>
	<cfheader statuscode="500">
	{
		success: false,
		message: "Error updating Property Types!<br>Please correct the errors and try again.<br>",
		details: #json.encode(aGridErrors,"array","lower")#
	}
	</cfoutput>
<cfelse>
	<cfoutput>
	{
		success: true,
		message: "Property Types Updated!"
	}
	</cfoutput>
</cfif>
<cfsetting enablecfoutputonly="false">

<!--- 
$Log$
 --->
<</cfoutput>>