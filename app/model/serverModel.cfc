/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que realiza a interação com o banco de dados no que se refere à coleção "servers"
*
*/

component output="false" extends="baseModel" implements="interface.iGlobalChallengeModel" persistent="true"  {

	public function init(){
		VARIABLES.collectionName = getProfileString(VARIABLES.connectionUtil.getConfigurationFile(), "collections", "server");
		return this;
	}

	/* CRUD */
	public query function list(){

		try{
			var aqlQuery = "FOR s IN servers SORT s.name ASC RETURN s";
			var result = THIS.queryByAQL(aqlQuery);

			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection. #e.message#");
		}
	};

	public query function read(string key, string value){

		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var result = collection.queryByExample({"#key#":"#value#"}).toQuery();
			
			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection. #e.message#");
		}
	};

	public document function create(struct document){

		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var document = collection.newDocument({"name" : "#ARGUMENTS.document.name#"});
			var execution = document.save();

			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection. #e.message#");
		}
	};

	public struct function update(struct find, struct update){

		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var execution = collection.updateByExample(ARGUMENTS.find, ARGUMENTS.update);

			return execution;		
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection. #e.message#");
		}
	};

	public struct function delete(numeric id){

		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var parameter = {"_key" = "#toString(id)#"};
			var execution = collection.deleteByExample(parameter);
			
			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection. #e.message#");
		}
	};

}