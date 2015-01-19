/**
*
* @author  felipeam1985 [at] gmail
* @description Classe de teste do serverModel.cfc
*
*/

component extends="mxunit.framework.TestCase" {
	
	function setUp(){ 
		VARIABLES.modelTest = createObject("component", "globalChallenge.app.model.serverModel");
	}

	function tearDown(){ }
	
	function testList(){
		VARIABLES.result = VARIABLES.modelTest.list();
		assertIsQuery(VARIABLES.result, 'Test failed');
	}

	
	function testRead() {
		VARIABLES.result = VARIABLES.modelTest.read("_key","1");
		assertIsQuery(VARIABLES.result, 'Test failed');
	}
	
	function testReadInvalidKey() {
		VARIABLES.result = VARIABLES.modelTest.read(1,"1");
		assertFalse(isQuery(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}
	
	function testReadInvalidValue() {
		VARIABLES.result = VARIABLES.modelTest.read("_key",1);
		assertFalse(isQuery(VARIABLES.result), 'Test failed');	
	}

	function testReadInvalidParams() {
		VARIABLES.result = VARIABLES.modelTest.read(1,1);
		assertFalse(isQuery(VARIABLES.result), 'Test failed');
	}

	function testCreate(){
		var document = {"name" = "Testing"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertTrue(isInstanceOf(VARIABLES.result, "document"), 'Test failed');		
	}

	function testUpdate(){
		var document = {"id" = "1", "name" = "Testing"};
		VARIABLES.result = VARIABLES.modelTest.create(document);
		assertIsStruct(VARIABLES.result, 'Test failed');
	}

	function testUpdateInvalidKey() {
		var document = {"id" = 1, "name" = "Testing"};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}
	
	function testUpdateInvalidValue() {
		var document = {"id" = "1", "name" = 2};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}

	function testReadInvalidParams() {
		var document = {"id" = 1, "name" = 2};
		VARIABLES.result = VARIABLES.modelTest.update(document);
		assertFalse(isQuery(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}

	function testDelete() {
		VARIABLES.result = VARIABLES.modelTest.delete(1);
		assertIsStruct(VARIABLES.result, 'Test failed');
	}
	
	function testDeleteInvalidId() {
		VARIABLES.result = VARIABLES.modelTest.delete("a");
		assertFalse(isStruct(VARIABLES.result), 'Test failed');
		fail("Expected behavior");
	}
}