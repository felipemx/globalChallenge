/**
*
* @author  felipeam1985 [at] gmail
* @description
*
*/

component output="false" {

	public function init(){
		return this;
	}

	private void function validateRead(struct document) {};
	private void function validateCreate(struct document) {};
	private void function validateUpdate(struct document) {};
}