/**
*
* @author  felipeam1985 [at] gmail
* @description
*
*/

component output="false" displayname=""  {

	public function init(){
		return this;
	}

	public org.jdsnet.arangodb.Connection function getConnection(){
		var connection = new org.jdsnet.arangodb.Connection();

		connection.setHost(getProfileString(application.configurationFile, "database", "host"));
		connection.setPort(getProfileString(application.configurationFile, "database", "port"));
		connection.setProtocol(getProfileString(application.configurationFile, "database", "protocol"));
	
		return connection;
	}

	public model.Database function getDatabase(org.jdsnet.arangodb.Connection conn){

		var databaseName = getProfileString(application.configurationFile, "database", "name");
		var database = conn.getDatabase(databaseName);

		return database;
	}	
	
}