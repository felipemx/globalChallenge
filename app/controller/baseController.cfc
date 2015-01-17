/**
*
* @author  felipeam1985 [at] gmail
* @description Classe que centraliza os métodos de validação e é estendida por todas as classes da camada de controle. Estes métodos vieram para esta classe pois no Railo os métodos de interface não podem ser privados
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