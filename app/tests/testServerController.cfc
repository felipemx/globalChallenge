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

	function tearDown(){ }
	
	function testList(){
		VARIABLES.result = VARIABLES.controllerTest.list();
		assertTrue(isJSON(VARIABLES.result), 'Test failed');
	}

	function testRead() {
		VARIABLES.result = VARIABLES.controllerTest.read("_key","1");
		assertTrue(isJSON(VARIABLES.result), 'Test failed');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.controllerTest.read(1,"1");
		assertFalse(isJSON(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}

	function testCreate(){
		var document = {"name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isJSON(VARIABLES.result), 'Test failed');
	}

	function testUpdate(){
		var document = {"id" = "1", "name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.create(document);
		assertTrue(isBoolean(VARIABLES.result), 'Test failed');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 1, "name" = "Testing"};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "1", "name" = 2};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}

	function testUpdateInvalidParams() {
		var document = {"id" = 1, "name" = 2};
		VARIABLES.result = VARIABLES.controllerTest.update(document);
		assertFalse(isBoolean(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.controllerTest.delete(1);
		assertTrue(isBoolean(VARIABLES.result), 'Test failed');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.controllerTest.delete("a");
		assertFalse(isBoolean(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}
}