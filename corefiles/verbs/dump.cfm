<cfscript>
/*	//--- custom verb ---//	
	Author:		Iain Turbitt
	Created: 	30-11-06
	Behaviour:	<cfdump var =""> with optional <cfabort> appended	*/
	
	// check tag attributes: 'var' is required
	if (not structKeyExists(fb_.verbInfo.attributes,"var")){
		strArgs.type	= "fusebox.badGrammar.requiredAttributeMissing";
		strArgs.message	= "Required attribute is missing";
		strArgs.detail	= "The attribute 'var' is required.";
		fb_throw(argumentCollection=strArgs);
	}
	// compile tag
	if (fb_.verbInfo.executionMode is "start"){
		cfml = "<cfdump var=""#fb_.verbInfo.attributes.var#"">";
		// do we include the <cfabort> tag?
		abort = false;
		if (structKeyExists(fb_.verbInfo.attributes,"abort")){
			// 'abort' attribute has been supplied
			abort = fb_.verbInfo.attributes.abort;	
		}
		if(abort) cfml = cfml&"<cfabort>";
		// write to parsed file
		fb_appendLine(cfml);
	}
</cfscript>
