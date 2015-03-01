<!---
This is a version of the relocate verb that keeps the
analytics parameters from the original request. That is,
it appends the utm parameters from the original request
to the redirect's destination url.

It requires the relocate_with_params verb.
--->
<cfset relocate_params = "utm_source,utm_campaign,utm_medium,utm_content,utm_term">
<cfinclude template="relocate_with_params.cfm">
