<!--- I display a page which can be used to set up a fusebox application from scratch --->
<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:spry="http://ns.adobe.com/spry">
<head>
	<title>Fusebox Scaffolder Application Configuration</title>
	<script src="SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <script src="SpryAssets/xpath.js" type="text/javascript"></script>
    <script src="SpryAssets/SpryData.js" type="text/javascript"></script>
    <link href="SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css">
</head>
<body>
<div style="width:505; height:107; background:url(fuseboxLogo.gif); vertical-align:baseline; text-align:center; font-family:Verdana, Arial, Helvetica, sans-serif; font-weight:bold;"><br /><br /><br /><br />Scaffolding Code Generator</div>

<form method="post" target="generateApplication" id="theForm" action="index.cfm">
  <div id="TabbedPanels1" class="TabbedPanels" style="width:600">
	<ul class="TabbedPanelsTabGroup">
		<li class="TabbedPanelsTab" tabindex="1" id="filename">Welecome</li>
		<li class="TabbedPanelsTab" tabindex="2" id="filename">Database Tips</li>
		<li class="TabbedPanelsTab" tabindex="3" id="filename">Code Generation Tips</li>
		<li class="TabbedPanelsTab" tabindex="4" id="filename">Application Set-Up</li>
	</ul>
    <div class="TabbedPanelsContentGroup">
	  <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
	  	<p>The Fusebox Scaffolder will build an application that will maintain the tables in a chosen database.
			At present, for the code generation to be completely sucessful, the following limitations exist in 
			the capability of the code generator:
			<ul>
				<li>The DBMS must be Microsoft SQL Server 2000 or 2005.</li>
				<li>The tables must be set up with an integer primary key which is an identity<br>(auto incrementing).</li>
			</ul></p>
		<p>If the above is not true, then the generated code will not run without error but it may still be useful.
			The Purpose of scaffolding is to give your application a boost at the start of the coding process so you can
			still use the code generator to create code and then edit it to remove any bugs or to add additional features.</p>
		
	  	<p>To begin you must have Fusebox 5 or 5.5 installed in your web root in a directory called:
		<ul>
			<li>/fusebox5</li>
		</ul></p>
		<p>And this scaffolder must be in a directory called:
		<ul>
			<li>/scaffolder</li>
		</ul></p>
		<div style="text-align: right;"><button onClick="TabbedPanels1.showPanel(1);return false;" tabindex="5" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button></div>
	  </div>
	  <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
		<p>To generate the best code here are a few tips you can bear in mind when building your database:
			<ul>
				<li>Use names that represent the real objects you are modelling for the tables.</li>
				<li>Start each table name with an uppercase letter.</li>
				<li>Use names that represent the real properties objects you are modelling for the columns.</li>
				<li>Start each column name with a lowercase letter.</li>
				<li>Use camel case to separate words.</li>
			</ul>
		</p>
		<p>The generated code is fairly limited and many programmers refer to it as CRUD. This is not said in a derogatory
			way but it stands for the words Create, Read, Update, and Delete which are the basic functions that the generated
			code will perform. Once you have generated the code you can edit it but be aware thet running the generator a 
			second time will overwrite some code so you should be careful not to do that if you have changed the code 
			and you want to keep your changes.</p>
		<div style="text-align: right;"><button onClick="TabbedPanels1.showPanel(2);return false;" tabindex="5" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button></div>
	  </div>
	  <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
		<p>There are two phases to the code generation process. In the first phase an XML metadata description 
			of your database is created. It is often a good idea to stop generation after that point and edit 
			the XML description. This will allow you to add any extra relationships that are important in your 
			code but not represented by foreign keys in the database.</p>
		<p>You can also change the defaults for the display and edit of each column, by making changes to the
			scaffolding XML file.</p>
		<p>In the second phase of the process CFML is generated. It is possible to choose from several different 
		templates and generate code in different formats.</p>
		<p>Some of the templates will require additional ORM frameworks like Transfer, Reactor or Coldspring, or AJAX 
		Frameworks like Spry or Ext JS. If you choose one of those please remember to copy the framework to the web
		server before trying to run your application.</p>
		<p>If your database has a large number of tables you might prefer to create multiple applications, rather 
		than one large one. You can do this by running the generator multiple times and choosing a selection of the 
		tables each time. Each run should target a different directory.
		When complete you will have to merge the generated applications by copying the generated files.</p>
		<div style="text-align: right;"><button onClick="TabbedPanels1.showPanel(3);return false;" tabindex="5" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button></div>
	  </div>
      <div class="TabbedPanelsContent" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
      	<table width="590" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">
		<tr>
			<td colspan="2">
			<br><p>The Fusebox Scaffolder will build an application in a subdirectory below the webroot.</p>
			<p <cfif highlightAppName>style="color:##ff3300;"</cfif>>Please enter the name of your application.</p>
			</td>
		</tr>
		<tr>
			<td>Application Name: </td>
			<td>
				* <input type="text" name="scaffolding.applicationName" tabindex="2" id="applicationName" size="40" tabindex="1" <cfif isDefined("form.scaffolding.applicationName")>value="#form.scaffolding.applicationName#"</cfif> >
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<br><p <cfif highlightFilePath>style="color:##ff3300;"</cfif>>Please enter the name of the subdirectory where you wish to build your application.</p>
			</td>
		</tr>
		<tr>
			<td>Application Location: </td>
			<td>
				* <input type="text" name="scaffolding.configFilePath" tabindex="2" id="configFilePath" size="40" tabindex="1" <cfif isDefined("form.scaffolding.configFilePath")>value="#form.scaffolding.configFilePath#"</cfif>>
			</td>
		</tr>
		<cfif isDefined("variables.errortext2")>
		<tr>
			<td colspan="2">
			<p style="color:##ff3300;"><strong>#variables.errortext2#</strong></p>
			</td>
		</tr>
		</cfif>
		<tr>
			<td colspan="2">
			<br><p <cfif highlightPassword>style="color:##ff3300;"</cfif>>To reload your application a password is required. <br>Please enter the password you want to use.</p>
			</td>
		</tr>
		<tr>
			<td>Fusebox Password: </td>
			<td>
				* <input type="text" name="scaffolding.password" tabindex="2" id="password" size="40" tabindex="1" <cfif isDefined("form.scaffolding.password")>value="#form.scaffolding.password#"</cfif> >
			</td>
		</tr>
        <tr>
			<td>&nbsp;</td>
			<td align="right">
				<button onClick="this.form.submit()" tabindex="16" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:small">next &gt;&gt;</button>
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
<cfif isDefined("form.scaffolding.applicationName")>TabbedPanels1.showPanel(3);</cfif>
//-->
</script>
<cfsetting showdebugoutput="No">
</body>
</html>
</cfoutput>


