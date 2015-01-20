/**
*
* @author  felipeam1985 [at] gmail
* @description Classe de teste do appController.cfc
*
*/

component extends="mxunit.framework.TestCase" {
	
	function setUp(){ 
		VARIABLES.controllerTest = createObject("component", "globalChallenge.app.controller.appController");
	}

	function tearDown(){
		structDelete(VARIABLES, "controllerTest");
	}
	
	function testList(){
		VARIABLES.result = VARIABLES.controllerTest.list();
		assertTrue(isJSON(VARIABLES.result), 'Falha na listagem de aplicações no Controller');
	}

	function testRead() {
		VARIABLES.result = VARIABLES.controllerTest.read("_key","1");
		assertTrue(isJSON(VARIABLES.result), 'Falha na leitura de aplicação no Controller');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.controllerTest.read(1,"1");
		assertFalse(isJSON(VARIABLES.result), 'Leitura de aplicação indevida: argumento KEY inválido no Controller');
		fail("Expected behavior");
	}

	function testCreate(){
		var document = {"name" = "Testing", "serverId" = "1"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isJSON(VARIABLES.result), 'Falha na criação de aplicação no Controller');
	}

	function testUpdate(){
		var document = {"id" = "1", "name" = "Testing", "serverId" = "1"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isBoolean(VARIABLES.result), 'Falha na atualização de aplicação no Controller');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 1, "name" = "Testing", "serverId" = "1"};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Leitura de aplicação indevida: argumento KEY inválido no Controller');
		fail("Expected behavior");
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "1", "name" = 2, "serverId" = "1"};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Leitura de aplicação indevida: argumento NAME inválido no Controller');
		fail("Expected behavior");
	}

	function testUpdateInvalidServerID() {
		var document = {"id" = "1", "name" = 2, "serverId" = 1};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Leitura de aplicação indevida: argumento SERVERID inválido no Controller');
		fail("Expected behavior");
	}	
	
	function testUpdateInvalidParams() {
		var document = {"id" = 1, "name" = 2, "serverId" = 3};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Leitura de aplicação indevida: parâmetros inválidos');
		fail("Expected behavior");
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.controllerTest.delete(1);
		assertTrue(isBoolean(VARIABLES.result), 'Falha ao apagar aplicação no Controller');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.controllerTest.delete("a");
		assertFalse(isBoolean(VARIABLES.result), 'Remoção de aplicação invevida: argumento inválido no Controller');
		fail("Expected behavior");
	}
}