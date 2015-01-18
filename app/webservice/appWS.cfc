/**
*
* @author felipeam1985 [at] gmail
* @description Classe que comporta os métodos para interação com a camada de controle referente à coleção "Apps" da base de dados
*
*/

component implements="interface.iGlobalChallengeWS" rest="true" restPath="/app"  {

	remote string function listAll() httpmethod="GET" produces="application/JSON"{
		var message = "listAll";
		return message;
	}

	remote string function read(numeric id restArgSource="path") httpmethod="GET" produces="application/JSON" restPath="{id}"{
		var message = "read " & arguments.id;
		return message;
	}

	remote string function create() httpmethod="POST" produces="application/JSON"{
		var message = "create";
		return message;
	}

	remote string function update() httpmethod="PUT" produces="application/JSON" {
		var message = "update";
		return message;
	}
	
	remote string function delete() httpmethod="DELETE" produces="application/JSON" {
		var message = "delete";
		return message;
	}

}