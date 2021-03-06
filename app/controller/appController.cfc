/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que controla a troca de mensagens entre o requisitor e a camada de modelo, aplicando as validações necessárias
*
*/

component output="false" extends="baseController" implements="interface.iGlobalChallengeController" {

	VARIABLES.model = createObject("component", "globalChallenge.app.model.appModel");
	model.init();

	public function init(){
		return this;
	}

	/* CRUD */
	public string function list(string serverId){

		THIS.validateRead("serverId", ARGUMENTS.serverId);
		try{
			var result = model.listByServer(toString(THIS.decodeServerID(ARGUMENTS.serverId)));
			var resultJSON = serializeJSON(result);

			return resultJSON;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public string function read(string key, any value){

		THIS.validateRead(ARGUMENTS.key, ARGUMENTS.value);

		try{
			var parameter = toString(value);
			var result = model.read(ARGUMENTS.key, parameter);
			var resultJSON = serializeJSON(result);
			
			return resultJSON;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public string function create(struct document){

		THIS.validateCreate(ARGUMENTS.document);

		try{
			var result = model.create(ARGUMENTS.document);
			var generatedDocument = result.getCurrentDocument();
			var resultJSON = serializeJSON(generatedDocument);

			return resultJSON;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public boolean function update(struct document){

		THIS.validateUpdate(ARGUMENTS.document);

		try{
			var find = {"_key" = "#toString(ARGUMENTS.document._key)#"}
			var update = {
				"name" = "#toString(ARGUMENTS.document.name)#",
				"serverId" = "#THIS.encodeServerID(toString(ARGUMENTS.document.serverId))#"
			}

			var execution = model.update(find, update);
			var result = (execution.updated EQ 1);

			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public boolean function delete(numeric id){

		try{
			var execution = model.delete(ARGUMENTS.id);
			var result = (execution.deleted EQ 1);
			
			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};

	public boolean function deleteByExample(string key, string value){

		THIS.validateDeleteByExample(ARGUMENTS.key, ARGUMENTS.value)
		try{
			var execution = model.deleteByExample(ARGUMENTS.key, ARGUMENTS.value);
			var result = (execution.deleted EQ 1);
			
			return result;
		}
		catch(any e){
			throw(type="DatabaseError", message="There was a problem with the database connection");
		}
	};


	/* VALIDATION - subir para o controller*/
	private void function validateRead(string key, any value) {
		
		try{
			if(CompareNoCase(TRIM(ARGUMENTS.value), "") EQ 0){
				throw(type="InvalidData", message="Invalid value parameter");
			}

			if(CompareNoCase(TRIM(ARGUMENTS.key), "") EQ 0){
				throw(type="InvalidData", message="Invalid key parameter");
			}
		}
		catch(any e){
			throw(type="InvalidData", message="Invalid parameters");	
		}
	}

	private void function validateCreate(struct document) {
		
		if(isStruct(ARGUMENTS.document)){

			//Validating name
			if(structKeyExists(ARGUMENTS.document, "name")){
				if(CompareNoCase(TRIM(ARGUMENTS.document.name), "") EQ 0){
					throw(type="InvalidData", message="Empty name attribute");
				}
			}
			else{
				throw(type="InvalidData", message="Invalid document format");
			}

			//Validating serverId
			if(structKeyExists(ARGUMENTS.document, "serverId")){
				if(CompareNoCase(TRIM(ARGUMENTS.document.serverId), "") EQ 0){
					throw(type="InvalidData", message="Empty serverId attribute");
				}
				else{
					THIS.validateServer(ARGUMENTS.document.serverId);
				}
			}
			else{
				throw(type="InvalidData", message="Invalid document format");
			}
		}
		else{
			throw(type="InvalidData", message="Invalid document format");
		}
	}	

	private void function validateUpdate(struct document) {
		
		THIS.validateCreate(ARGUMENTS.document);

		if(structKeyExists(ARGUMENTS.document, "_key")){
			if(NOT isNumeric(ARGUMENTS.document._key)){
				throw(type="InvalidData", message="Non-Numeric _key attribute");
			}
		}
		else{
			throw(type="InvalidData", message="Invalid document format");
		}
	}

	private void function validateDeleteByExample(string key, string value) {

		if(compareNoCase(ARGUMENTS.key, "") EQ 0){
			throw(type="InvalidData", message="Invalid key");
		}

		if(compareNoCase(ARGUMENTS.value, "") EQ 0){
			throw(type="InvalidData", message="Invalid value");
		}
	}

	private void function validateServer(string serverId) {
		
		VARIABLES.serverController = createObject("component", "globalChallenge.app.controller.serverController");
		VARIABLES.serverController.init();
		VARIABLES.validServer = VARIABLES.serverController.read("_key", "#ARGUMENTS.serverId#");

		if(compareNoCase(VARIABLES.validServer, "") EQ 0){
			throw(type="InvalidData", message="Invalid Server: #ARGUMENTS.serverId#");
		}
	}

	private string function encodeServerID(string serverId){
		return 'servers/' & ARGUMENTS.serverId;
	}

	private string function decodeServerID(string serverId){
		return replace(ARGUMENTS.serverId, 'servers/', '');
	}
}