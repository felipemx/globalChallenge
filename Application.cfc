/**
*
* @author  felipeam1985 [at] gmail
* @description
*
*/

component output="false" displayname="Application"  {

	THIS.name = "globalChallenge";
	THIS.applicationTimeout = createTimeSpan(0, 1, 0, 0);
	THIS.sessionManagement = true;
	THIS.sessionTimeout = createTimeSpan(0, 0, 30, 0);

	THIS.mappings['/root'] = getDirectoryFromPath(ExpandPath("*"));

	/**
	@hint Executado em todo o início de uma requisição
	*/
	public boolean function onRequestStart() {

		APPLICATION.configurationFile = "/root/resources/config.ini";

		return true;
	}

}