component  displayname="RemoteAdminAPI" hint="Web Service wrapper for Admin API" output="false" 
{
	remote string function getDatasources(required string adminPassword, string adminUsername = "admin") returnformat="JSON" {
		var adminAPI = createObject("CFIDE.adminapi.administrator").login(arguments.adminPassword, arguments.adminUsername);
		var datasources = createObject("CFIDE.adminapi.datasource").getDatasources();
		
		return serializeJSON(datasources);
	}

}