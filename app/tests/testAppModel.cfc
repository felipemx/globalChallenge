/**
*
* @author  felipeam1985 [at] gmail
* @description Classe de teste do appModel.cfc
*
*/

component extends="mxunit.framework.TestCase" {
	
	function setUp(){ 
		VARIABLES.modelTest = createObject("component", "globalChallenge.app.model.appModel");
		VARIABLES.modelTest.init();
	}

	function tearDown(){
		structDelete(VARIABLES, "modelTest");
	}
	
	function testList(){
		VARIABLES.result = VARIABLES.modelTest.list();
		assertIsQuery(VARIABLES.result, 'Falha na listagem de aplicações no Model');
	}
	
	function testRead() {
		VARIABLES.result = VARIABLES.modelTest.read("_key","1");
		assertIsQuery(VARIABLES.result, 'Falha na leitura de aplicação no Model');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.modelTest.read(1,"1");
		assertFalse(isQuery(VARIABLES.result), 'Leitura de aplicação indevida: argumento KEY inválido no Model');
		fail("Expected behavior");
	}
	
	function testReadInvalidValue() {
		VARIABLES.result = VARIABLES.modelTest.read("_key",1);
		assertFalse(isQuery(VARIABLES.result), 'Leitura de aplicação indevida: argumento VALUE inválido no Model');	
	}

	function testReadInvalidParams() {
		VARIABLES.result = VARIABLES.modelTest.read(1,1);
		assertFalse(isQuery(VARIABLES.result), 'Leitura de aplicação indevida: parâmetros inválidos no Model');
	}

	function testCreate(){
		var document = {"name" = "TDD Create", "serverId" = "1"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertTrue(isInstanceOf(VARIABLES.result, "document"), 'Falha na criação de aplicação no Model');		
	}

	function testUpdate(){
		var document = {"id" = "30", "name" = "TDD Update", "serverId" = "1"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertIsStruct(VARIABLES.result, 'Falha na atualização de aplicação no Model');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 30, "name" = "TDD Update Invalid Key", "serverId" = "1"};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de aplicação indevida: argumento KEY inválido no Model');
		fail("Expected behavior");
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "30", "name" = 2, "serverId" = "1"};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de aplicação indevida: argumento NAME inválido no Model');
		fail("Expected behavior");
	}

	function testUpdateInvalidServerID() {
		var document = {"id" = "30", "name" = "TDD Update Invalid Server Id", "serverId" = 1};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de aplicação indevida: argumento SERVERID inválido no Model');
		fail("Expected behavior");
	}
	
	function testUpdateInvalidParams() {
		var document = {"id" = 30, "name" = 2, "serverId" = 1};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Atualização de aplicação indevida: parâmetros inválidos');
		fail("Expected behavior");
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.modelTest.delete(30);
		assertIsStruct(VARIABLES.result, 'Falha ao apagar aplicação no Model');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.modelTest.delete("a");
		assertFalse(isStruct(VARIABLES.result), 'Remoção de aplicação invevida: argumento inválido no Model');
	}
}