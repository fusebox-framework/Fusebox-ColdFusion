<cfsilent>
<!--- I am the user interface for the fusebox scaffolder --->

<!--- The following variables are needed to drive this page. They come from act_findfilepaths.cfm --->
<cfparam name="baseDirectory" />	<!--- Where your code will go 			Eg: [D:\Inetpub\wwwroot\ScaffoldTest\ ] --->
<cfparam name="baseURL" />			<!--- The URL for the same directory 	Eg: [/ScaffoldTest/ ] --->
<cfparam name="rootDirectory" />	<!--- The web server root 				Eg: [D:\Inetpub\wwwroot\ ] --->
<cfparam name="thisFilePath" />		<!--- The file path to the scaffolder 	Eg: [D:\Inetpub\wwwroot\scaffolder\ ] --->
<cfparam name="thisURLPath" />		<!--- The URL path to the scaffolder  	Eg: [/scaffolder/ ] --->
<cfparam name="thisCFCPath" />		<!--- The CFC path to the scaffolder	Eg: [scaffolder.] --->

<!--- Work out where the scaffolding.xml file might be found. --->
<cfparam name="url.scaffolding.filename" default="scaffolding.xml">
<cfparam name="url.scaffolding.configFilePath" default="#baseDirectory##url.scaffolding.filename#">
<cfset configFileURL = "http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT##baseURL##getFileFromPath(url.scaffolding.configFilePath)#">

<!--- Work out the path for the call to the metadata cfc  --->
<!--- <cfset metadataURL = "http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/Scaffolder/scaffolder/xmlProxy.cfm"> --->
<cfset metadataURL = "http://#cgi.SERVER_NAME#/Scaffolder/scaffolder/xmlProxy.cfm">

<!--- Get a recordset of available datasources. --->
<cfinvoke component="#thisCFCPath#scaffolder.Metadata" method="GetSupportedDatasourcesAsQuery" returnvariable="qDatasources" />
<!--- Get recordsets of available templates. --->
<cfinvoke component="#thisCFCPath#scaffolder.Metadata" method="getTemplates" templateType="controller" returnvariable="qControllerTemplates" />
<cfinvoke component="#thisCFCPath#scaffolder.Metadata" method="getTemplates" templateType="model" returnvariable="qModelTemplates" />
<cfinvoke component="#thisCFCPath#scaffolder.Metadata" method="getTemplates" templateType="view" returnvariable="qViewTemplates" />
<cfinvoke component="#thisCFCPath#scaffolder.Metadata" method="getTemplates" templateType="custom" returnvariable="qCustomTemplates" />
</cfsilent>
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:spry="http://ns.adobe.com/spry">
<head>
	<title>Fusebox Scaffolder Generator Configuration</title>
	<script src="#thisURLPath#SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <script src="#thisURLPath#SpryAssets/xpath.js" type="text/javascript"></script>
    <script src="#thisURLPath#SpryAssets/SpryData.js" type="text/javascript"></script>
    <link href="#thisURLPath#SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css">

<!--- If there is already a scaffolding XML file we can read the configuration from it --->
<!--- Otherwise we get the configuration from a call to the metadata.cfc --->
<cfif fileExists(url.scaffolding.configFilePath)>
	<script type="text/javascript">
	<!--
		var dsTables = new Spry.Data.XMLDataSet("#configFileURL#", "scaffolding/objects/object",{sortOnLoad:"@name",sortOrderOnLoad:"ascending",useCache:false});
		var dsConfig = new Spry.Data.XMLDataSet("#configFileURL#", "scaffolding/config/properties",{sortOnLoad:"@datasource",sortOrderOnLoad:"ascending",useCache:false});
	// End Hiding-->	
	</script>
<cfelse>
	<script type="text/javascript">
	<!--
		var dsTables = new Spry.Data.XMLDataSet("#metadataURL#?datasource=_null", "scaffolding/objects/object",{sortOnLoad:"@name",sortOrderOnLoad:"ascending",useCache:false});
		var dsConfig = new Spry.Data.XMLDataSet("#metadataURL#?datasource=_null", "scaffolding/config/properties",{sortOnLoad:"@datasource",sortOrderOnLoad:"ascending",useCache:false});
	// End Hiding-->
	</script>
</cfif>

<script type="text/javascript">
<!--
	// Watch for changes to the dataset and update the configuration.
	var configObserver = new Object;
	configObserver.onDataChanged = function(dataset, data){
		var datasource = dataset.getData()[0]["@datasource"];
		var username = dataset.getData()[0]["@username"];
		var password = dataset.getData()[0]["@password"];
		var controllertemplate = dataset.getData()[0]["@controllertemplate"];
		var modeltemplate = dataset.getData()[0]["@modeltemplate"];
		var viewtemplate = dataset.getData()[0]["@viewtemplate"];
		var project = dataset.getData()[0]["@project"];
		var author = dataset.getData()[0]["@author"];
		var authorEmail = dataset.getData()[0]["@authorEmail"];
		var copyright = dataset.getData()[0]["@copyright"];
		var licence = dataset.getData()[0]["@licence"];
		var version = dataset.getData()[0]["@version"];
		
		var lignoreoninsert = dataset.getData()[0]["@lignoreoninsert"];
		var lignoreonupdate = dataset.getData()[0]["@lignoreonupdate"];
		var activeindicator = dataset.getData()[0]["@activeindicator"];
		var deletedindicator = dataset.getData()[0]["@deletedindicator"];
		
		// update the select dropdown with the datasource
		var selDatasource = document.getElementById("datasource");
		for (var i=1;i < selDatasource.options.length; i++){
			if(selDatasource.options[i].value == datasource){
				selDatasource.selectedIndex = i;
			}
		};
		
		// update the select dropdowns with the templates
		var selControllerTemplate = document.getElementById("controllertemplate");
		var selModelTemplate = document.getElementById("modeltemplate");
		var selViewTemplate = document.getElementById("viewtemplate");
		
		for (var i=1;i < selControllerTemplate.options.length; i++){
			if(selControllerTemplate.options[i].value == controllertemplate){
				selControllerTemplate.selectedIndex = i;
			}
		};
		for (var i=1;i < selModelTemplate.options.length; i++){
			if(selModelTemplate.options[i].value == modeltemplate){
				selModelTemplate.selectedIndex = i;
			}
		};
		for (var i=1;i < selViewTemplate.options.length; i++){
			if(selViewTemplate.options[i].value == viewtemplate){
				selViewTemplate.selectedIndex = i;
			}
		};
		
		if (username != undefined)
			document.getElementById("username").value = username;
		if (password != undefined)
			document.getElementById("password").value = password;
		if (author != undefined)
			document.getElementById("author").value = author;
		if (project != undefined)
			document.getElementById("project").value = project;
		if (authorEmail != undefined)
			document.getElementById("authorEmail").value = authorEmail;
		if (copyright != undefined)
			document.getElementById("copyright").value = copyright;
		if (licence != undefined)
			document.getElementById("licence").value = licence;
		if (version != undefined)
			document.getElementById("version").value = version;
		if (lignoreoninsert != undefined)
			document.getElementById("lIgnoreOnInsert").value = lignoreoninsert;
		if (lignoreonupdate != undefined)
			document.getElementById("lIgnoreOnUpdate").value = lignoreonupdate;	
		if (activeindicator != undefined)
			document.getElementById("activeIndicator").value = activeindicator;
		if (deletedindicator != undefined)
			document.getElementById("deletedIndicator").value = deletedindicator;
		checkGenerate();
		return;
	}
	
	dsConfig.addObserver(configObserver);
	
	// If the list of tables changes check once it is loaded
	var tablesRegionObserver = new Object;
	tablesRegionObserver.onPostUpdate = function(notifier, data){
		var theForm = document.getElementById("theForm");
		setAll(theForm);checkGenerate();
	}
	
	Spry.Data.Region.addObserver("tablesListRegion", tablesRegionObserver);
	

	// Table selection, if user selects All it selects all boxes 
	function copyAll(theForm){
		for (var i=0;i<theForm.length;i++){
			if (theForm[i].name == 'scaffolding.lTables'){
				theForm[i].checked = theForm.all.checked;
			}
		}
		return;
	}
	// Table selection, if the user unselects any box, All is unselected too 
	function setAll(theForm){
		theForm.all.checked = 1;
		for (var i=0;i<theForm.length;i++){
			if (theForm[i].name == 'scaffolding.lTables'){
				if (!theForm[i].checked){
					theForm.all.checked = 0;
					return;
				 }
			}
		}
		return;
	}
	// If the xml filename is changed we attempt to read the new xml file.
	function changeFile(filename){
		var rootDirectory = '#JSStringFormat(rootDirectory)#';
		var rootURL = '#JSStringFormat(rootURL)#';
		var startFilePath = filename.slice(0,rootDirectory.length);
		var endFilePath = filename.slice(rootDirectory.length,filename.length);
		
		if (startFilePath == rootDirectory){
			var newURL = rootURL + endFilePath;
			dsTables.setURL(newURL);
			dsTables.loadData();
			dsConfig.setURL(newURL);
			dsConfig.loadData();
		}
		else{
			alert('Unable to determine URL for XML file: ' + filename);
		}
		return;
	}
	
	//  When the user changes the datasource update the tables and the project name
	function datasourceChange(selDatasource){
		var dsn = selDatasource.options[selDatasource.selectedIndex].value;
		var newURL = "#metadataURL#?datasource=" + dsn;
		dsTables.setURL(newURL);
		dsTables.loadData();
		document.getElementById("project").value = dsn;
	}
	
	// Check to see if there is enough data to allow generation. 
	// If we are building the code we need datasource, template and one or more tables.
	// If we are only doing instrospection we need datasource and one or more tables.
	function checkGenerate(){
		var selDatasource = document.getElementById("datasource");
		var selControllerTemplate = document.getElementById("controllertemplate");
		var selModelTemplate = document.getElementById("modeltemplate");
		var selViewTemplate = document.getElementById("viewtemplate");
		var btnGenerate = document.getElementById("btnGenerate");
		var chkGoBuild  = document.getElementById("chkGoBuild");
		
		btnGenerate.disabled = false;
		// Check the datasource
		if (selDatasource.selectedIndex <= 0){
			btnGenerate.disabled = true;
			//alert ("datasource " + selDatasource.selectedIndex);
			return;
			}
		
		// Check the templates
		if (selControllerTemplate.selectedIndex <= 0 && selModelTemplate.selectedIndex <= 0 && selViewTemplate.selectedIndex <= 0 && chkGoBuild.checked){
			btnGenerate.disabled = true;
			//alert ("template " + selTemplate.selectedIndex);
			return;
			}
		
		// Check for at least one table
		var tableChecked = 0;
		var theForm = document.getElementById("theForm");
		for (var i=0;i<theForm.length;i++){
			if (theForm[i].name == 'scaffolding.lTables'){
				// alert ("checking " + theForm[i].value + ' ' + theForm[i].checked);
				if (theForm[i].checked){
					tableChecked = true;
				 }
			}
		}
		if (!tableChecked){
			btnGenerate.disabled = true;
			//alert ("tables");
			}
		return;
	}
// End Hiding-->
</script>
	
</head>
<body>
<div style="width:505; height:107; background:url(#thisURLPath#fuseboxLogo.gif); vertical-align:baseline; text-align:center; font-family:Verdana, Arial, Helvetica, sans-serif; font-weight:bold;"><br /><br /><br /><br />Scaffolding Code Generator</div>

<form method="post" target="generateFrame" id="theForm" action="/scaffolder/manager.cfm">
  <div id="TabbedPanels1" class="TabbedPanels" style="width:600">
    <ul class="TabbedPanelsTabGroup">
      <li class="TabbedPanelsTab" tabindex="1" id="filename">Scaffolding Path &amp; Filename</li>
      <li class="TabbedPanelsTab" tabindex="5" id="config">Configuration</li>
      <li class="TabbedPanelsTab" tabindex="17" id="comments">Comments</li>
      <li class="TabbedPanelsTab" tabindex="27" id="generate">Special Cols</li>
	  <li class="TabbedPanelsTab" tabindex="27" id="generate">Generate</li>
    </ul>
    <div class="TabbedPanelsContentGroup">
      <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
      	<table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(1);return false;" tabindex="3" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<p>Please enter the path to the xml file that will be used to save<br />
			the scaffolding configuration information.</p>
        	<p>The default value will usually not need to be changed unless<br />
			there is more than one database in your application.</p>
			</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<td>Scaffolding Configuration: </td>
			<td>
				<input type="text" name="scaffolding.configFilePath" tabindex="2" id="configFilePath" onChange="changeFile(this.value);" value="#url.scaffolding.configFilePath#" size="50" tabindex="1" >
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(1);return false;" tabindex="4" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
		</tr>
		</table>
      </div>
      <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small;">
        <table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(0);return false;" tabindex="13" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(2);return false;" tabindex="14" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		<tr>
            <td>Datasource: </td>
            <td>
            <select name="scaffolding.datasource" id="datasource" onChange="datasourceChange(this);checkGenerate();" tabindex="6">
                <option value="" selected="selected">Please select a datasource</option>
                <cfloop query="qDatasources">
                <option value="#qDatasources.Datasourcename#" >#qDatasources.Datasourcename#</option>
                </cfloop>
            </select>
            </td>
        </tr>
        <tr>
            <td>Username: </td>
            <td>
                <input type="text" name="scaffolding.username" id="username" size="30" value="" tabindex="7">
            </td>
            <td rowspan="2">
                Only enter a username and password if you wish to generate code with these fields.
            </td>
        </tr>
        <tr>
            <td>Password: </td>
            <td>
                <input type="text" name="scaffolding.password" id="password" size="30" value="" tabindex="8">
            </td>
        </tr>
		<tr>
            <td>Project: </td>
            <td>
                <input type="text" name="scaffolding.project" id="project" size="30" value="" tabindex="9">
            </td>
			<td>
				Used to name the circuits and directories.
			</td>
        </tr>
        <tr>
            <td>Tables: </td>
            <td>
				<input type="checkbox" name="all" id="all" onClick="copyAll(this.form);checkGenerate();" onKeyPress="copyAll(this.form);checkGenerate();" checked="checked" tabindex="11" /><label for="all">All</label>
               	  <div spry:region="dsTables" id="tablesListRegion">
                  	<table style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
               	    <tr spry:repeat="dsTables">
                    	<td><input type="checkbox" name="scaffolding.lTables" checked="checked" value="{@name}" onClick="setAll(this.form);checkGenerate();" onKeyPress="setAll(this.form);checkGenerate();" tabindex="12">&nbsp;{@name}</td>
                    </tr>
                    </table>
               	  </div>
            </td>
        </tr>
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(0);return false;" tabindex="15" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(2);return false;" tabindex="16" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		</table>
      </div>
      <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(1);return false;" tabindex="23" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(3);return false;" tabindex="24" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		<tr>
            <td>Author: </td>
            <td>
                <input type="text" name="scaffolding.author" id="author" size="30" tabindex="18">
            </td>
            <td rowspan="5">
                These fields are used to add comments containing this information to the generated code.<br /><br />
				You may leave them blank if you want.
            </td>
        </tr>
        <tr>
            <td>Email: </td>
            <td>
                <input type="text" name="scaffolding.authorEmail" id="authorEmail" size="30" tabindex="19">
            </td>
        </tr>
        <tr>
            <td>Copyright: </td>
            <td>
                <input type="text" name="scaffolding.copyright" id="copyright"  size="30" tabindex="20">
            </td>
        </tr>
        <tr>
            <td>Licence Text: </td>
            <td>
                <input type="text" name="scaffolding.licence" id="licence" size="30" tabindex="21">
            </td>
        </tr>
        <tr>
            <td>Version: </td>
            <td>
                <input type="text" name="scaffolding.version" id="version" size="30" tabindex="22">
            </td>
        </tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(1);return false;" tabindex="25" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(3);return false;" tabindex="26" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
        </table>
      </div>
	  <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(2);return false;" tabindex="23" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(4);return false;" tabindex="24" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
		<tr>
            <td colspan="2">Comma separated list of Fields to Skip on Insert: </td>
			<td rowspan="6">
                These fields specify special actions to be taken, based on column names.
            </td>
		</tr>
		<tr>
            <td colspan="2">
                <input type="text" name="scaffolding.lIgnoreOnInsert" id="lIgnoreOnInsert" size="60" tabindex="18">
            </td>
        </tr>
        <tr>
            <td colspan="2">Comma separated list of Fields to Skip on Updates: </td>
		</tr>
		<tr>
			<td colspan="2">
                <input type="text" name="scaffolding.lIgnoreOnUpdate" id="lIgnoreOnUpdate" size="60" tabindex="19">
            </td>
        </tr>
        <tr>
            <td>Active Indicator: </td>
            <td>
                <input type="text" name="scaffolding.activeIndicator" id="activeIndicator"  size="30" tabindex="20">
            </td>
        </tr>
        <tr>
            <td>Deleted Indicator: </td>
            <td>
                <input type="text" name="scaffolding.deletedIndicator" id="deletedIndicator" size="30" tabindex="21">
            </td>
        </tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(2);return false;" tabindex="25" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button onClick="TabbedPanels1.showPanel(4);return false;" tabindex="26" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
			</td>
		</tr>
        </table>
      </div>
      <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
        <tr>
			<td width="190">&nbsp;</td>
			<td width="200">&nbsp;</td>
			<td align="right" width="200">
				<button onClick="TabbedPanels1.showPanel(3);return false;" tabindex="31" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button disabled="disabled" id="btnRun1" onClick="window.open('#baseURL#index.cfm','_blank');return false;" tabindex="32"  style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">Run  &gt;&gt;</button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<p>On this page you can choose the functions you want to run, 
				and the template set you will use to generate code.</p>
        		<p>Since the Build takes a long time to run, you may want to  
				examine and edit the generated metadata (scaffolding.xml) file
				after introspection and before you run the build step.</p> 
				<p>You can edit it to ensure that the generated code meets your
				needs.</p>
			</td>
		</tr>
		<tr>
            <td>Controller Template: </td>
            <td>
            <select name="scaffolding.template" id="controllertemplate" onChange="checkGenerate();" tabindex="10">
                <option value="">Please select a template</option>
                <cfloop query="qControllerTemplates">
                <option value="controller/#qControllerTemplates.name#" >#Replace(qControllerTemplates.name,"_"," ","all")#</option>
                </cfloop>
            </select>
            </td>
			<td>&nbsp;</td>
        </tr>
		<tr>
            <td>Model Template: </td>
            <td>
            <select name="scaffolding.template" id="modeltemplate" onChange="checkGenerate();" tabindex="10">
                <option value="">Please select a template</option>
                <cfloop query="qModelTemplates">
                <option value="model/#qModelTemplates.name#" >#Replace(qModelTemplates.name,"_"," ","all")#</option>
                </cfloop>
            </select>
            </td>
			<td>&nbsp;</td>
        </tr>
		<tr>
            <td>View Template: </td>
            <td>
            <select name="scaffolding.template" id="viewtemplate" onChange="checkGenerate();" tabindex="10">
                <option value="">Please select a template</option>
                <cfloop query="qViewTemplates">
                <option value="view/#qViewTemplates.name#" >#Replace(qViewTemplates.name,"_"," ","all")#</option>
                </cfloop>
            </select>
            </td>
			<td>&nbsp;</td>
        </tr>
		<tr>
			<td valign="top">Functions to Run:</td>
			<td>
				<input type="checkbox" name="scaffolding.go" id="chkGoIntrospect" value="introspectDB" tabindex="28" 
					<cfif NOT fileExists(url.scaffolding.configFilePath)>
						checked="checked"
					</cfif>
					>Introspect DB<br />
				<input type="checkbox" name="scaffolding.go" id="chkGoBuild" value="build" checked="checked" tabindex="29" onClick="checkGenerate();">Build Scaffolding<br />
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td valign="top">Generated code location:</td>
			<td colspan="2">
				<input type="hidden" name="baseDirectory" id="baseDirectory" value="#baseDirectory#">
				<input type="hidden" name="baseURL" id="baseURL" value="#baseURL#">
				#baseDirectory#
			</td>
		</tr>
		<tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" name="btnGenerate" disabled="disabled" value="Generate" id="btnGenerate" tabindex="30" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
            </td>
			<td>&nbsp;</td>
        </tr>
		<tr>
			<td height="20" colspan="3" align="center">
				<table border="1" cellpadding="0" cellspacing="0" width="500">
				<tr>
					<td>
						<img id="progressBar" src="#thisURLPath#progress_bar.jpg" width="1" height="12" alt="Progress %">
					</td>
				</tr>
				</table>
				<div id="progressLabel" align="center">&nbsp;</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<iframe height="300" width="580" name="generateFrame"></iframe>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="TabbedPanels1.showPanel(3);return false;" tabindex="33" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">&lt;&lt; prev</button>
				<button disabled="disabled" id="btnRun2" onClick="window.open('#baseURL#index.cfm','_blank');return false;" tabindex="34" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">Run  &gt;&gt;</button>
			</td>
		</tr>
        </table>
      </div>
    </div>
  </div>
</div>
</form>
<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
changeFile(document.getElementById("configFilePath").value);
//-->
</script>
<cfsetting showdebugoutput="No">
</body>
</html>
</cfoutput>


