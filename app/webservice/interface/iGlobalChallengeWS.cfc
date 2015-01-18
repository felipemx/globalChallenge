/**
*
* @author  felipeam1985@gmail.com
* @description Interface que define o comportamento das classes que serão expostas através de webservice REST
*
*/

interface{

	remote string function listAll() httpmethod="GET" produces="application/JSON"{};
	remote string function read(numeric id restArgSource="path") httpmethod="GET" produces="application/JSON" restPath="{id}"{};
	remote string function create() httpmethod="POST" produces="application/JSON"{};
	remote string function update() httpmethod="PUT" produces="application/JSON"{};
	remote string function delete() httpmethod="DELETE" produces="application/JSON"{};
}