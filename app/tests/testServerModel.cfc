/**
*
* @author  felipeam1985 [at] gmail
* @description Classe de teste do serverModel.cfc
*
*/

component extends="mxunit.framework.TestCase" {
	
	function setUp(){ 
		VARIABLES.modelTest = createObject("component", "globalChallenge.app.model.serverModel");
		VARIABLES.modelTest.init();
	}

	function tearDown(){
		structDelete(VARIABLES, "modelTest");
	}
	
	function testList(){
		VARIABLES.result = VARIABLES.modelTest.list();
		assertIsQuery(VARIABLES.result, 'Falha na listagem de servidores no Model');
	}

	function testRead() {
		VARIABLES.result = VARIABLES.modelTest.read("_key","1");
		assertIsQuery(VARIABLES.result, 'Falha na leitura de servidor no Model');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.modelTest.read(1,"1");
		assertFalse(isQuery(VARIABLES.result), 'Leitura de servidor indevida: argumento KEY inválido no Model');
	}
	
	function testReadInvalidValue() {
		VARIABLES.result = VARIABLES.modelTest.read("_key", 1);
		assertFalse(isQuery(VARIABLES.result), 'Leitura de servidor indevida: argumento VALUE inválido no Model');	
	}

	function testReadInvalidParams() {
		VARIABLES.result = VARIABLES.modelTest.read(1, 1);
		assertFalse(isQuery(VARIABLES.result), 'Leitura de servidor indevida: parâmetros inválidos no Model');
	}

	function testCreate(){
		var document = {"name" = "TDD Create"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertTrue(isInstanceOf(VARIABLES.result, "document"), 'Falha na criação de servidor no Model');		
	}

	function testUpdate(){
		var document = {"id" = "48", "name" = "TDD Update"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertIsStruct(VARIABLES.result, 'Falha na atualização de servidor no Model');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 48, "name" = "TDD Update Invalid Key"};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de servidor indevida: argumento KEY inválido no Model');
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "48", "name" = 2};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de servidor invedida: argumento NAME inválido no Model');
	}

	function testUpdateInvalidParams() {
		var document = {"id" = 48, "name" = 2};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de servidor invevida: argumentos inválidos no Model');
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.modelTest.delete(49);
		assertIsStruct(VARIABLES.result, 'Falha ao apagar servidor no Model');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.modelTest.delete("a");
		assertFalse(isStruct(VARIABLES.result), 'Remoção de servidor invevida: argumento inválido no Model');
	}
}