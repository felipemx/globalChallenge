/**
*
* @author felipeam1985 [at] gmail
* @description Classe que comporta os métodos para interação com a camada de controle referente à coleção "Servers" da base de dados
*
*/

component implements="interface.iGlobalChallengeWS" rest="true" restPath="/server"  {

	remote string function listAll() httpmethod="GET" produces="application/JSON"{
		var controller = createObject("component", "globalChallenge.app.controller.serverController");
		var response = controller.list();

		return response;
	}

	remote string function read(numeric id restArgSource="path") httpmethod="GET" produces="application/JSON" restPath="{id}"{
		var controller = createObject("component", "globalChallenge.app.controller.serverController");
		var response = controller.read("_key", ARGUMENTS.id);

		return response;
	}

	remote string function create() httpmethod="POST" produces="application/JSON"{
		var controller = createObject("component", "globalChallenge.app.controller.serverController");
		var document = {
			"_name" = name
		};
		var response = controller.create(document);

		return response;
	}

	remote boolean function update() httpmethod="PUT" produces="application/JSON" {
		var controller = createObject("component", "globalChallenge.app.controller.serverController");
		var document = {
			"_key" = id,
			"_name" = name
		};
		var response = controller.update(document);

		return response;
	}
	
	remote boolean function delete() httpmethod="DELETE" produces="application/JSON" {
		var controller = createObject("component", "globalChallenge.app.controller.serverController");
		var response = controller.delete(id);

		return response;
	}
	
}