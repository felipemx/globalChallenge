/**
*
* @author  felipeam1985 [at] gmail
* @description Interface para definir os métodos comuns entre as classes da camada de modelo
*
*/

interface  {

	public query function read(string key, string value){};
	public document function create(struct document){};
	public struct function update(struct find, struct update){};
	public struct function delete(numeric id){};
}