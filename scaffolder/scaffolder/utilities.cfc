<cfcomponent displayname="utilities.cfc" hint="I supply a number of utility functions to the scaffolder.">

	<cffunction name="cleanLabelText" returntype="string" output="No" 
				hint="I process a field name to make a text label for the field by replacing any underscores with a space and putting spaces in front of Camel case words.">
		<cfargument name="text" required="Yes" type="string">
		
		<cfset var local = StructNew()>
		
		<!--- Replace underscores with spaces --->
		<cfset local.text = replace(arguments.text,"_"," ","all")>
		<!--- Look for uppercase letters in camel case names --->
		<cfset local.out = uCase(left(local.text,1))>
		<cfset local.charCount = len(local.text)>
		<cfloop index="local.i" from="2" to="#local.charCount#">
			<cfset local.value = asc(Mid(Text,local.i,1))>
			<cfset local.prev  = asc(Mid(Text,local.i-1,1))>
			<!--- Is this an uppercase character ? --->
			<cfif (local.value GE 65 AND local.value LE 90 AND local.prev GE 97 AND local.prev LE 122)>
				<!--- The character is uppercase so add a space --->
				<cfset local.out = local.out & " " & Mid(local.Text,local.i,1)>
			<cfelse>
				<cfset local.out = local.out & Mid(local.Text,local.i,1)>
			</cfif>
		</cfloop>
		
		<cfreturn local.out>
	</cffunction>
	
	<cffunction name="uFirst" returntype="string" access="public" output="No" 
				hint="I make the first character of a string uppercase">
		<cfargument name="inString" type="string" required="Yes" />
		<cfreturn UCase(Left(inString,1)) & RemoveChars(inString,1,1)>
	</cffunction>
	
	<cffunction name="lFirst" returntype="string" access="public" output="No" 
				hint="I make the first character of a string lowercase">
		<cfargument name="inString" type="string" required="Yes" />
		<cfreturn LCase(Left(inString,1)) & RemoveChars(inString,1,1)>
	</cffunction>
	
	<cffunction name="ArrayConcat" access="private" returntype="array" output="No" 
				hint="I concatenate two arrays.">
		<cfargument name="a1" type="array" />
		<cfargument name="a2" type="array" />
		
		<cfset var i=1>
		<cfscript>
			if ((NOT IsArray(a1)) OR (NOT IsArray(a2))) {
				writeoutput("Error in <Code>ArrayConcat()</code>! Correct usage: ArrayConcat(<I>Array1</I>, <I>Array2</I>) -- Concatenates Array2 to the end of Array1");
				return 0;
			}
			for (i=1;i LTE ArrayLen(a2);i=i+1) {
				ArrayAppend(a1, Duplicate(a2[i]));
			}
		</cfscript>
		<cfreturn a1>
	</cffunction>
	
	<cffunction name="ListRemoveList" access="public" returntype="string" output="No" 
				hint="Removes second list from first list, accepting an optional delimiter and whether to remove one or all list items.">
		<cfargument name="list1" type="string" required="Yes">
		<cfargument name="list2" type="string" required="Yes">
		<cfargument name="delimiters" type="string" required="No" default=",">
		<cfargument name="pattern" type="string" required="No" default="one">
		<cfscript>
			/**
			* Removes second list from first list, accepting an optional delimiter and whether to remove one or all list items.
			*
			* @param list1      List to parse. (Required)
			* @param list2      List of items to remove. (Required)
			* @param delimiters      Delimiter. Defaults to a comma. (Optional)
			* @param scope      One or all. If one, removes one instance of the item from list2. All if otherwise. Defaults to one. (Optional)
			* @return Returns a string.
			* @author Ann Terrell (ann@landuseoregon.com)
			* @version 2, May 10, 2005
			*/		
			var removeall = false;
			var listReturn = list1;
			var position = 1;
			
			// default removal pattern is remove one of each item in list2
			if (arguments.pattern eq "all") removeall=true;
			
			//checking list1
			for(position = 1; position LTE ListLen(list2,delimiters); position = position + 1) {
			value = ListGetAt(list2, position , delimiters );
			    
			    if (removeall) {
			        while (ListFindNoCase(listReturn, value , delimiters ) NEQ 0)
			         listReturn = ListDeleteAt(listReturn, ListFindNoCase(listReturn, value , delimiters ) , delimiters );
			        }
			    else {
			            if (ListFindNoCase(listReturn, value , delimiters ) NEQ 0)
			        listReturn = ListDeleteAt(listReturn, ListFindNoCase(listReturn, value , delimiters ) , delimiters );
			        }
			}
		</cfscript>	        
		<cfreturn listReturn>
	</cffunction>
	
	<cffunction name="ListKeepList" access="public" returntype="string" output="No" 
		hint="Keeps items in the first list only if they are in the second list, accepting an optional delimiter.">
		<cfargument name="list1" type="string" required="Yes">
		<cfargument name="list2" type="string" required="Yes">
		<cfargument name="delimiters" type="string" required="No" default=",">
		<cfscript>
			var listReturn = list1;
			var position = 1;
			
			//checking list1
			for(position = 1; position LTE ListLen(list1,delimiters); position = position + 1) {
				value = ListGetAt(list1, position , delimiters );
			    if (ListFindNoCase(list2, value , delimiters ) EQ 0){
			        listReturn = ListDeleteAt(listReturn, ListFindNoCase(listReturn, value , delimiters ) , delimiters );
			        }
			}
		</cfscript>	        
		<cfreturn listReturn>
	</cffunction>
	
	<cffunction name="isNot" returntype="boolean" access="public" output="No" 
				hint="I invert a boolean result.">
		<cfargument name="value" type="any" required="Yes" />
		<cfif arguments.value>
			<cfreturn false>
		<cfelse>
			<cfreturn true>
		</cfif>
	</cffunction>
	
	<cffunction name="incrementProgress" access="package" returntype="void" output="No" hint="I update the progress value for the progress bar">
		<cfset variables.progress = variables.progress + 1>
	</cffunction>
	
	<cffunction name="progressReport" access="public" returntype="void" output="Yes" hint="I display a progress message and progress bar">
		<cfargument name="message" required="yes" type="string">
		<cfargument name="progress" required="no" type="numeric">
		<cfargument name="reset" required="no" type="boolean" default="false">
		<cfargument name="fullProgress" required="no" type="numeric">
		<cfargument name="complete" required="no" type="boolean">
		
		<cfset var progressPercent = 0>
		<cfset var width = 0>
		
		<cfif reset OR NOT isDefined("variables.progress")>
			<cfset variables.progress = 0>
			<cfset variables.messageCount = 0>
			<cfset variables.fullProgress = 100>
		</cfif>
		<cfif isDefined("arguments.fullProgress")>
			<cfset variables.fullProgress = arguments.fullProgress>
		</cfif>
		<cfif isDefined("arguments.progress")>
			<cfset variables.progress = arguments.progress>
		</cfif>
		<cfset variables.messageCount = variables.messageCount + 1>
		<cfset progressPercent = 100 * variables.progress / variables.fullProgress>
		<cfset width = 5 * progressPercent>
		<cfoutput>
			<div id="msg_#variables.messageCount#">#arguments.message#</div>
			<script language="JavaScript">
				document.getElementById("msg_#variables.messageCount#").scrollIntoView();
				window.parent.document.getElementById("progressLabel").innerHTML="#NumberFormat(progressPercent,"09.9")#%";
				window.parent.document.getElementById("progressBar").width=#width#;
				<cfif isDefined("arguments.complete")>
					window.parent.document.getElementById("btnRun1").disabled=false;
					window.parent.document.getElementById("btnRun2").disabled=false;
				</cfif>
			</script>
		
		</cfoutput><cfflush>
	</cffunction>
	
	<cffunction name="listWrap" returntype="string" output="No" hint="I add a prefix and suffix to every element of a list.">
		<cfargument name="theList" type="string" required="Yes" hint="I am the the list to be processed" />
		<cfargument name="prefix" type="string" required="Yes" hint="The prefix to be added to each member of the list" />
		<cfargument name="suffix" type="string" required="No" default="" hint="The suffix to be added to each member of the list" />
		<cfargument name="delimiters" type="string" required="No" default="," hint="The new delimter" />
		
		<cfset var local = StructNew()>
		
		<cfset local.newList = "">
		
		<cfloop list="#arguments.theList#" index="local.theItem">
			<cfset local.newlist = ListAppend(local.newList, arguments.prefix & local.theItem & arguments.suffix, arguments.delimiters)>
		</cfloop>
		
		<cfreturn local.newlist>
	</cffunction>
	
	<cffunction name="format" returntype="string" output="No" hint="I create an expression which will format the field for display or edit.">
		<cfargument name="theValue" required="Yes" type="string" hint="I am a string containing the name of the variable to be formatted." />
		<cfargument name="format" required="Yes" type="string" hint="I am a string representing the formatting rule to be used" />
		
		<cfset var formatType = ListFirst(arguments.format,"()")>
		<cfset var formatDetail = "">
		<cfset var formattedValue = "">
		
		<!--- For each possible format make the code which will format the value --->
		<cfswitch expression="#formatType#">
			<cfcase value="Date">
				<cfif ListLen(arguments.format,"()") GT 1>
					<cfset formatDetail = Trim(ListGetAt(arguments.format,2,"()"))>
					<cfset formattedValue = "LSDateFormat(#arguments.theValue#,""#formatDetail#"")">
				<cfelse>
					<cfset formattedValue = "LSDateFormat(#arguments.theValue#)">
				</cfif>
			</cfcase>
			<cfcase value="Time">
				<cfif ListLen(arguments.format,"()") GT 1>
					<cfset formatDetail = Trim(ListGetAt(arguments.format,2,"()"))>
					<cfset formattedValue = "LSTimeFormat(#arguments.theValue#,""#formatDetail#"")">
				<cfelse>
					<cfset formattedValue = "LSTimeFormat(#arguments.theValue#)">
				</cfif>
			</cfcase>
			<cfcase value="Trim">
				<cfset formattedValue = "Trim(#arguments.theValue#)">
			</cfcase>
			<cfcase value="YesNo">
				<cfset formattedValue = "YesNoFormat(#arguments.theValue#)">
			</cfcase>
			<cfcase value="Number">
				<cfset formatDetail = ListGetAt(arguments.format,2,"()")>
				<cfset formattedValue = "NumberFormat(#arguments.theValue#,""#formatDetail#"")">
			</cfcase>
			<cfcase value="Integer">
				<cfset formatDetail = "9">
				<cfset formattedValue = "NumberFormat(#arguments.theValue#,""#formatDetail#"")">
			</cfcase>
			<cfcase value="Currency">
				<cfset formattedValue = "LSCurrencyFormat(#arguments.theValue#)">
			</cfcase>
			<cfdefaultcase>
				<cfset formattedValue = "Trim(#arguments.theValue#)">
			</cfdefaultcase>
		</cfswitch>
		<cfreturn formattedValue>
	</cffunction>

</cfcomponent>
