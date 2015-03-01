<!---
This is a version of the relocate verb that supports a "params"
attribute, a comma-separated list of URL parameters that should
carry over from the original request to the relocation URL. For
example:

    <jf:relocate_with_params url="xfa.shop_all" params="child,page">

will redirect to xfa.shop_all and append any child or page attributes
that may exist on the original URL. If the original URL is

    /somepage?page=93

this will redirect to index.cfm?action=catalog.shop_all&page=93

The params to be preserved may also be specified in the
relocate_params variable instead of the "params" attribute, if
that's easier for the caller. If both are specified, the variable
takes precedence over the attribute.

Note that much of this is copied from the FuseBox 5 built-in
relocate verb. It would be better to make this verb call the
built-in verb after making the destination URL dynamic, but
that's tricky because of the way the destination is hard-wired
into <cflocation> in the original.
--->

<cfscript>
	if (fb_.verbInfo.executionMode is "start") {
		// validate attributes
		// url - string - required
		if (not structKeyExists(fb_.verbInfo.attributes,"url")) {
			fb_throw("fusebox.badGrammar.requiredAttributeMissing",
						"Required attribute is missing",
						"The attribute 'url' is required, for a 'relocate_with_params' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
		}

		// addtoken - boolean - default false
		if (structKeyExists(fb_.verbInfo.attributes,"addtoken")) {
			if (listFind("true,false",fb_.verbInfo.attributes.addtoken) eq 0) {
				fb_throw("fusebox.badGrammar.invalidAttributeValue",
							"Attribute has invalid value",
							"The attribute 'addtoken' must either be ""true"" or ""false"", for a 'relocate_with_params' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
			}
		} else {
			fb_.verbInfo.attributes.addtoken = false;
		}

		// type - server|client - default client
		if (structKeyExists(fb_.verbInfo.attributes,"type")) {
			if (listFind("server,client",fb_.verbInfo.attributes.type) eq 0) {
				fb_throw("fusebox.badGrammar.invalidAttributeValue",
							"Attribute has invalid value",
							"The attribute 'type' must either be ""server"" or ""client"", for a 'relocate_with_params' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
			}
		} else {
			fb_.verbInfo.attributes.type = "client";
		}

		// params - comma-separated list of params to preserve from the original request
		if (IsDefined('relocate_params') OR structKeyExists(fb_.verbInfo.attributes, "params")) {
			params = IsDefined('relocate_params') ? relocate_params : fb_.verbInfo.attributes.params;

			fb_appendLine('<cfset paramsToAppend = ArrayNew(1)>');
			fb_appendLine('<cfset keys = ListToArray("#params#")>');

			fb_appendSegment('
			<cfscript>
			for (i=1; i <= ArrayLen(keys); i++) {
				key = Trim(keys[i]);
				if (structKeyExists(url, key)) {
					ArrayAppend(paramsToAppend, key & "=" & url[key]);
				}
			}
			</cfscript>
			');
			fb_appendLine('<cfset separator = "&">');
		}

		// strict mode - check attribute count:
		if (fb_.verbInfo.action.getCircuit().getApplication().strictMode) {
			if (structCount(fb_.verbInfo.attributes) neq 3) {
				fb_throw("fusebox.badGrammar.unexpectedAttributes",
							"Unexpected attributes",
							"Unexpected attributes were found in a 'relocate_with_params' verb in fuseaction #fb_.verbInfo.circuit#.#fb_.verbInfo.fuseaction#.");
			}
		}

		fb_appendLine('<cfset destination = "#fb_.verbInfo.attributes.url#">');
		if (IsDefined('params')) {
			fb_appendSegment('
			<cfif ArrayLen(paramsToAppend)>
				<cfset destination = destination & "##separator##" & "##ArrayToList(paramsToAppend, ''&'')##">
			</cfif>
			');
		}

		// compile <relocate_with_params>
		if (fb_.verbInfo.attributes.type is "server") {
			fb_appendLine('<cfset getPageContext().forward("##destination##")>');
		} else {
			fb_appendLine('<cflocation url="##destination##" addtoken="#fb_.verbInfo.attributes.addtoken#">');
		}
		fb_appendLine('<cfabort>');
	}
</cfscript>
