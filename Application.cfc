/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que define comportamentos globais para a aplicação
*
*/

component output="false" displayname="Application"  {

	THIS.name = "globalChallenge";
	THIS.applicationTimeout = createTimeSpan(0, 1, 0, 0);
	THIS.sessionManagement = true;
	THIS.sessionTimeout = createTimeSpan(0, 0, 30, 0);
}