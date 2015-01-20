/**
*
* @author  felipeam1985 [at] gmail
* @description Classe de teste do serverController.cfc
*
*/

component extends="mxunit.framework.TestCase" {
	
	function setUp(){ 
		VARIABLES.controllerTest = createObject("component", "globalChallenge.app.controller.serverController");
	}

	function tearDown(){
		structDelete(VARIABLES, "controllerTest");
	}
	
	function testList(){
		VARIABLES.result = VARIABLES.controllerTest.list();
		assertTrue(isJSON(VARIABLES.result), 'Falha na listagem de servidores no Controller');
	}

	function testRead() {
		VARIABLES.result = VARIABLES.controllerTest.read("_key","1");
		assertTrue(isJSON(VARIABLES.result), 'Falha na leitura de servidor no Controller');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.controllerTest.read(1,"1");
		assertFalse(isJSON(VARIABLES.result), 'Leitura de servidor indevida: argumento KEY inválido no Controller');
	}

	function testCreate(){
		var document = {"name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isJSON(VARIABLES.result), 'Falha na criação de servidor no Controller');
	}

	function testUpdate(){
		var document = {"id" = "1", "name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isBoolean(VARIABLES.result), 'Falha na atualização de servidor no Controller');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 1, "name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Atualização de servidor indevida: argumento KEY inválido no Controller');
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "1", "name" = 2};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Atualização de servidor indevida: argumento NAME inválido no Controller');
	}

	function testUpdateInvalidParams() {
		var document = {"id" = 1, "name" = 2};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Atualização de servidor indevida: parâmetros inválidos');
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.controllerTest.delete(1);
		assertTrue(isBoolean(VARIABLES.result), 'Falha ao apagar servidor no Controller');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.controllerTest.delete("a");
		assertFalse(isBoolean(VARIABLES.result), 'Remoção de servidor invevida: argumento inválido no Controller');
	}
}