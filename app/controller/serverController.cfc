/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que controla a troca de mensagens entre o requisitor e a camada de modelo, aplicando as validações necessárias
*
*/

component output="false" extends="baseController" implements="interface.iGlobalChallengeController" {

	VARIABLES.model = createObject("component", "globalChallenge.app.model.serverModel");
	model.init();

	public function init(){
		return this;
	}

	/* CRUD */
	public string function list(){

		try{
			var result = model.list();
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
			var resultJSON = "";

			if(result.RecordCount GT 0){
				resultJSON = serializeJSON(result);
			}
			
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
			var update = ARGUMENTS.document;
			structDelete(update, "_key");

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
			var appModel = createObject("component", "globalChallenge.app.controller.appController");
			var appRemove = appModel.deleteByExample("serverId", "servers/#ARGUMENTS.id#");
			
			var execution = model.delete(ARGUMENTS.id);
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
			var stringParameter = toString(ARGUMENTS.value);

			if(CompareNoCase(TRIM(ARGUMENTS.key), "") EQ 0){
				throw(type="InvalidData", message="Invalid key parameter");
			}
		}
		catch(any e){
			throw(type="InvalidData", message="Invalid value parameter");	
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
	}}