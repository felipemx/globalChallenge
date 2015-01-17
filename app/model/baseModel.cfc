/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que centraliza os métodos de conexão com o banco e execução de Query simples via AQL (Arango Query Language) e é estendida por todas as classes da camada de controle. Estes métodos vieram para esta classe pois no Railo os métodos de interface não podem ser privados
*
*/

component output="false" {

	property type="string" name="collectionName" default="";

	VARIABLES.connectionUtil = createObject("component", "globalChallenge.app.util.ConnectionUtils");
	VARIABLES.connection = VARIABLES.connectionUtil.getConnection();

	public function init(){
		return this;
	}

	package model.Database function getDatabase() {
	 	var database = VARIABLES.connectionUtil.getDatabase(VARIABLES.connection);
	 	return database;
	 }

	package collection function getCollection(string collectionName) {
	 	var collection = THIS.getDatabase().getCollection(collectionName);
	 	return collection;
	 }

	package query function queryByAQL(string aql) {
		
		var statement 	= THIS.getDatabase().prepareStatement(aql);
		var result 		= statement.execute().toQuery();

		return result;
	}

}