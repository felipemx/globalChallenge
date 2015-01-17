/**
* 
* @author felipeam1985 [at] gmail 
* @description Interface para definir os métodos comuns entre os controladores
*
*/

interface  {
	public string function read(string key, any value){};
	public string function create(struct document){};
	public boolean function update(struct document){};
	public boolean function delete(numeric id){};
}