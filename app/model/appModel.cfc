/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que realiza a interação com o banco de dados no que se refere à coleção "apps"
*
*/

component output="false" extends="baseModel" implements="interface.iGlobalChallengeModel" persistent="true"  {

	public function init(){
		VARIABLES.collectionName = getProfileString(VARIABLES.connectionUtil.getConfigurationFile(), "collections", "application");
		return this;
	}

	/* CRUD */
	public query function listByServer(string serverId){
		try{
			var aqlQuery = "FOR a IN apps FOR s IN servers FILTER a.serverId == s._id && s._key == @key SORT a.name ASC RETURN {'_id': a._id, '_rev': a._rev, '_key': a._key, 'name': a.name, 'serverId': a.serverId, 'server' : {'_id': s._id, '_key': s._key, '_rev': s._rev, 'name': s.name }}";
			var statement 	= THIS.getDatabase().prepareStatement(aqlQuery);
			var cursor 		= statement.execute({"key" : "#ARGUMENTS.serverId#"});
			var result 		= cursor.toQuery();

			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public query function read(string key, string value){
		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var result = collection.queryByExample({"#key#":"#value#"}).toQuery();
			
			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public document function create(struct document){
		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var document = collection.newDocument({"name" : "#ARGUMENTS.document.name#", "serverId" : "servers/#ARGUMENTS.document.serverId#"});
			var execution = document.save();

			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public struct function update(struct find, struct update){
		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var execution = collection.updateByExample(ARGUMENTS.find, ARGUMENTS.update);

			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}

	};

	public struct function delete(numeric id){
		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var parameter = {"_key" = "#toString(ARGUMENTS.id)#"};
			var execution = collection.deleteByExample(parameter);
			
			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public struct function deleteByExample(string key, string value){
		try{
			var collection = THIS.getCollection(VARIABLES.collectionName);
			var parameter = {"#ARGUMENTS.key#" = "#toString(ARGUMENTS.value)#"};
			var execution = collection.deleteByExample(parameter);
			
			return execution;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

}