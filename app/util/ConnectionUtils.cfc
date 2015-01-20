/**
*
* @author  felipeam1985 [at] gmail
* @description Classe responsável pela conexão com o banco e recuperação do database
*
*/

component output="false" {

	VARIABLES.configurationFile = "../resources/config.ini";

	public function init(){
		return this;
	}

	public string function getConfigurationFile(){
		return VARIABLES.configurationFile;
	}

	public org.jdsnet.arangodb.Connection function getConnection(){
		var connection = new org.jdsnet.arangodb.Connection();

		connection.setHost(getProfileString(THIS.getConfigurationFile(), "database", "host"));
		connection.setPort(getProfileString(THIS.getConfigurationFile(), "database", "port"));
		connection.setProtocol(getProfileString(THIS.getConfigurationFile(), "database", "protocol"));
	
		return connection;
	}

	public model.Database function getDatabase(org.jdsnet.arangodb.Connection conn){

		var databaseName = getProfileString(THIS.getConfigurationFile(), "database", "name");
		var database = conn.getDatabase(databaseName);

		return database;
	}	
	
}