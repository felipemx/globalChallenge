/**
*
* @author felipeam1985 [at] gmail
* @description Classe que comporta os métodos para interação com a camada de controle referente à coleção "Apps" da base de dados
*
*/

component implements="interface.iGlobalChallengeWS" rest="true" restPath="/app"  {

	remote string function listAll() httpmethod="GET" produces="application/JSON"{
		var controller = createObject("component", "globalChallenge.app.controller.appController");
		var response = controller.list();

		return response;
		//var message = "list";
		//return message;
	}

	remote string function read(numeric id restArgSource="path") httpmethod="GET" produces="application/JSON" restPath="{id}"{
		var controller = createObject("component", "globalChallenge.app.controller.appController");
		var response = controller.read("_key", ARGUMENTS.id);

		return response;
		//var message = "read " & arguments.id;
		//return message;
	}

	remote string function create() httpmethod="POST" produces="application/JSON"{
		var controller = createObject("component", "globalChallenge.app.controller.appController");
		var document = {
			"name" = FORM.name,
			"serverId" = FORM.serverId
		};
		var response = controller.create(document);

		return response;
		//var message = "create";
		//return message;
	}

	remote string function update() httpmethod="PUT" produces="application/JSON" {
		var controller = createObject("component", "globalChallenge.app.controller.appController");
		var document = {
			"name" = name,
			"serverId" = serverId
		};
		var response = controller.update(document);

		return response;
		//var message = "create";
		//return message;
	}
	
	remote string function delete() httpmethod="DELETE" produces="application/JSON" {
		var controller = createObject("component", "globalChallenge.app.controller.appController");
		var response = controller.delete(id);

		return response;
		//var message = "delete";
		//return message;
	}

}