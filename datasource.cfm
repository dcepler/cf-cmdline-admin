<!---
	datasource.cfm - run ColdFusion 2016 AdminAPI datassource from CLI
	Copyright (C) 2016 - David C. Epler - dcepler@dcepler.net

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
--->
<cfscript>

	public void function generateHelp() {
		
		cli.writeln("");
		cli.writeln("datasource.cfm - run ColdFusion 2016 AdminAPI datassource from CLI");
		cli.writeln("Copyright (C) 2016 - David C. Epler - dcepler@dcepler.net");
		cli.writeln("");
		cli.writeln("Arguments:");
		cli.writeln("  [username] - username to connect with, default: admin");
		cli.writeln("  password - password to connect with, required");
		cli.writeln("  [serverURL] - server URL for service, default: http://127.0.0.1:8500");
//		cli.writeln("  [outputDirectory] - output directory, default: current directory");
//		cli.writeln("  [outputFilename] - output filename, default: securityanalyzer-yyyymmddhhmmss");
//		cli.writeln("  [outputFormat] - json or html, default: html");

		cli.writeln("");
		cli.writeln("Example:");
//		cli.writeln("scanDirectory=c:\inetpub\wwwroot password=myPassword");

	}


	// constants
	variables.crlf = chr(13) & chr(10);
	variables.now = now();
	
	// determine current working directory
	variables.currentWorkingDirectory = replace(getCurrentTemplatePath(), "\", "/", "all");
	variables.currentWorkingDirectory = replace(variables.currentWorkingDirectory, listLast(variables.currentWorkingDirectory, "/"), "");

	// populate from arguments
	variables.username = cli.getNamedArg("username")?: "admin";
	variables.password = cli.getNamedArg("password");
	variables.serverURL = cli.getNamedArg("serverURL")?: "http://127.0.0.1:8500";
//	variables.outputDirectory = cli.getNamedArg("outputDirectory")?: variables.currentWorkingDirectory;
//	variables.outputFilename = cli.getNamedArg("outputFilename")?: "datasource-" & variables.now.dateTimeFormat("yyyymmddHHnnss");
//	variables.outputFormat = cli.getNamedArg("outputFormat")?: "html";

	// show help information if no args or first arg is "help"
//	if (arrayIsEmpty(cli.getArgs()) || findNoCase("help", cli.getArg(1))) {
//		generateHelp();
//		cli.exit(0);
//	}

	// validate arguments
//	if (!structKeyExists(variables, "password")) {
//		cli.writeError("ERROR: password is required");
//		generateHelp();
//		cli.exit(-1);
//	}


	cfhttp(method="POST", charset="utf-8", url=variables.serverURL & "/CFIDE/adminapi/RemoteAdminAPI.cfc", result="variables.result") {
		cfhttpparam(type="formfield", name="method", value="getDatasources");
		cfhttpparam(type="formfield", name="adminUsername", value=variables.username);
		cfhttpparam(type="formfield", name="adminPassword", value=variables.password);
	}

writeDump(var=deserializeJSON(variables.result.fileContent), format="text");
	
//	cli.exit(0);

</cfscript>