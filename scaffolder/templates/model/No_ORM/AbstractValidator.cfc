<cfcomponent displayname="AbstractValidator.cfc" hint="I provide a number of useful validation functions.">
	
	<cffunction name="init" returntype="any" hint="I initialise the validator.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="isTime" hint="I check that the argument is a valid time value">
		<cfargument name="timeValue" type="string" required="Yes">
		<cfset var ampmTemp = "">
		
		<!--- Strip off any AM or PM from the time ---> 
		<cfif timeValue CONTAINS "am">
			<cfset ampmTemp = "am">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"am","")>
		<cfelseif timeValue CONTAINS "a">
			<cfset ampmTemp = "am">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"a","")>
		<cfelseif timeValue CONTAINS "pm">
			<cfset ampmTemp = "pm">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"pm","")>
		<cfelseif timeValue CONTAINS "p">
			<cfset ampmTemp = "pm">
			<cfset arguments.timeValue = replaceNoCase(arguments.timeValue,"p","")>
		</cfif>
		
		<!--- Check that it is a '.' or ':' delimited list 1 to 3 long --->
		<cfif listLen(arguments.timeValue,".:") LT 1 OR listLen(arguments.timeValue,".:") GT 3>
			<cfreturn false>
		</cfif>
		
		<!--- Check that each part is a number in the right range --->
		<!--- Hours --->
		<cfif NOT isNumeric(listGetAt(arguments.timeValue,1,".:")) OR listGetAt(arguments.timeValue,1,".:") GT 23 OR listGetAt(arguments.timeValue,1,".:") LT 0>
			<cfreturn false>
		</cfif>
		<cfif ampmTemp IS NOT "" AND listGetAt(arguments.timeValue,1,".:") GT 12 OR listGetAt(arguments.timeValue,1,".:") LT 1>
			<cfreturn false>
		</cfif>
		<!--- Minutes --->
		<cfif ListLen(arguments.timeValue,".:") GE 2 AND (NOT isNumeric(listGetAt(arguments.timeValue,2,".:")) OR listGetAt(arguments.timeValue,2,".:") GT 59 OR listGetAt(arguments.timeValue,2,".:") LT 0)>
			<cfreturn false>
		</cfif>
		<!--- Seconds --->
		<cfif listLen(arguments.timeValue,".:") EQ 3 AND (NOT isNumeric(listGetAt(arguments.timeValue,3,".:")) OR listGetAt(arguments.timeValue,3,".:") GT 59 OR listGetAt(arguments.timeValue,3,".:") LT 0)>
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="isZip_Code" output="No" returntype="boolean" hint="I validate a US, Canadian or UK Post Code">
		<cfargument name="zipCode" type="string" required="Yes">
		<cfargument name="isoCountryCode" type="string" required="No">
		<cfif NOT isDefined("arguments.isoCountryCode")>
			<cfif isValid("zipcode",arguments.zipCode) OR isZipUK(arguments.zipCode) OR isZipCanada(arguments.zipCode)>
				<cfreturn true>
			<cfelse>
				<cfreturn false>
			</cfif>
		<cfelse>
			<cfswitch expression="#arguments.isoCountryCode#">
				<cfcase value="US">
					<cfreturn isValid("zipcode",arguments.zipCode)>
				</cfcase>
				<cfcase value="CA">
					<cfreturn isZipCanada(arguments.zipCode)>
				</cfcase>
				<cfcase value="GB">
					<cfif listFindNoCase("AB,AL,BA,BB,BD,BH,BL,BN,BR,BS,BT,CA,CB,CF,CH,CM,CO,CR,CT,CV,CW,DA,DD,DE,DG,DH,DL,DN,DT,DY,EC,EH,EN,EX,FK,FY,GL,GU,HA,HD,HG,HP,HR,HS,HU,HX,IG,IP,IV,KA,KT,KW,KY,LA,LD,LE,LL,LN,LS,LU,ME,MK,ML,NE,NG,NN,NP,NR,NW,OL,OX,PA,PE,PH,PL,PO,PR,RG,RH,RM,SA,SE,SG,SK,SL,SM,SN,SO,SP,SR,SS,ST,SW,SY,TA,TD,TF,TN,TQ,TR,TS,TW,UB,WA,WC,WD,WF,WN,WR,WS,WV,YO,ZE",Left(arguments.zipCode,2))>
						<cfreturn isZipUK(arguments.zipCode)>
					<cfelseif listFindNoCase("B,E,G,L,M,N,S,W",Left(arguments.zipCode,1)) AND  isNumeric(Mid(arguments.zipCode,2,1))>
						<cfreturn isZipUK(arguments.zipCode)>
					<cfelse>
						<cfreturn false>
					</cfif>
				</cfcase>
				<cfcase value="GG">
					<cfreturn isZipUK(arguments.zipCode) AND Left(arguments.zipCode,2) IS "GY">
				</cfcase>
				<cfcase value="JE">
					<cfreturn isZipUK(arguments.zipCode) AND Left(arguments.zipCode,2) IS "JE">
				</cfcase>
				<cfcase value="IM">
					<cfreturn isZipUK(arguments.zipCode) AND Left(arguments.zipCode,2) IS "IM">
				</cfcase>
				<cfdefaultcase>
					<cfif trim(arguments.zipCode) IS "">
						<cfreturn false>
					</cfif>
				</cfdefaultcase>
			</cfswitch>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="isZipUK" output="No" returntype="boolean" hint="I validate a UK Post Code">
		<!--- valid patterns: A9 9AA, A9A 9AA, A99 9AA, AA9 9AA, AA9A 9AA, AA99 9AA --->
		<cfargument name="zipCode" type="string" required="Yes">
		<cfreturn isValid("regex", uCase(arguments.zipCode),'[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][A-Z]{2}')>
	</cffunction>
	
	<cffunction name="isZipCanada" output="No" returntype="boolean" hint="I validate a Canadian Postal Code">
		<!--- valid pattern: A9A 9A9 and must not contain the letters D,F,I,O,Q,U --->
		<cfargument name="zipCode" type="string" required="Yes">
		<cfset var i = 0>
		<cfloop from="1" to="#len(arguments.zipCode)#" index="i">
			<cfif listFindNoCase("D,F,I,O,Q,U",mid(arguments.zipCode,i,1))>
				<cfreturn false>
			</cfif>
		</cfloop>
		<cfreturn isValid("regex", arguments.zipCode,'^[[:alpha:]][[:digit:]][[:alpha:]]( )?[[:digit:]][[:alpha:]][[:digit:]]$')>
	</cffunction>
	
	<cffunction name="isIPAddress">
		<cfargument name="ip" type="string" required="Yes">
		<cfset var ii = 1>
		<!--- Check that it is a '.' delimited list 4 long --->
		<cfif listlen(arguments.ip,".") IS NOT 4>
			<cfreturn false>
		</cfif>
		<!--- Check that each part is a number between 0 and 255 --->
		<cfloop from="1" to="4" index="ii">
			<cfif NOT isNumeric(listGetAt(arguments.ip,ii,".")) OR listGetAt(arguments.ip,ii,".") GT 255 OR listGetAt(arguments.ip,ii,".") LT 0>
				<cfreturn false>
			</cfif>
		</cfloop>
		<!--- Check for the special cases of 255.255.255.255 or 0.0.0.0, which is not valid --->
		<cfif arguments.ip IS "255.255.255.255" OR arguments.ip is "0.0.0.0">
			<cfreturn false>
		</cfif>
		<cfreturn true>
	</cffunction>
	
	<cffunction name="isRoutableIPAddress">
		<cfargument name="ip" type="string" required="Yes">
		<cfif isIPAddress(arguments.ip)>
			<cfif listFirst(ip,".") IS 10>
				<cfreturn false>
			<cfelseif listFirst(ip,".") IS 127>
				<cfreturn false>
			<cfelseif listFirst(ip,".") IS 172 AND (listGetAt(ip,2,".") GT 15 OR listGetAt(ip,2,".") LT 32)>
				<cfreturn false>
			<cfelseif listFirst(ip,".") IS 192 AND (listGetAt(ip,2,".") IS 168)>
				<cfreturn false>
			<cfelseif listFirst(ip,".") IS 169 AND (listGetAt(ip,2,".") IS 254)>
				<cfreturn false>
			<cfelse>
				<cfreturn true>
			</cfif>
		</cfif>
		<cfreturn false>
	</cffunction>

</cfcomponent>