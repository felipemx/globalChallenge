function mapStructure(vetor){
	var estrutura = new Object();
	var posicaoId = -1;
	var posicaoNome = -1;

	for(var i = 0; i < vetor.length; i++){
		if(vetor[i].toLowerCase() == "_key"){
			posicaoId = i;		
		}

		if(vetor[i].toLowerCase() == "name"){
			posicaoNome = i;
		}
	}

	estrutura.id = posicaoId;
	estrutura.nome = posicaoNome;

	return estrutura;
}

function carregaServidores(){
	var servidor = new ServerComponent();
	servidor.list(function(conteudo){

		var corpoTabela = document.querySelector('tbody');
		var linhaInicial= this.criarLinhaInicialTabela();
		var estrutura	= mapStructure(conteudo.COLUMNS);

		corpoTabela.innerHTML = "";
		corpoTabela.appendChild(linhaInicial);
		
		for(var i = 0; i < conteudo.DATA.length; i++){
			var novaLinha = this.criarConteudoTabela(conteudo.DATA[i], estrutura);
			corpoTabela.appendChild(novaLinha);
		}

	});
}

function criarLinhaInicialTabela(){
		
	var linhaAdicionar  = document.createElement("tr");
	var celulaAdicionar = document.createElement("td");
	var botaoAdicionar  = document.createElement("a");

	botaoAdicionar.setAttribute('href', '#');
	botaoAdicionar.classList.add('botao');
	botaoAdicionar.classList.add('adicionar');
	botaoAdicionar.textContent = "+ Adicionar";
	botaoAdicionar.addEventListener("click", function(event){
		event.preventDefault();
		habilitaFormulario();
	});
	celulaAdicionar.setAttribute('colspan', '2');

	celulaAdicionar.appendChild(botaoAdicionar);
	linhaAdicionar.appendChild(celulaAdicionar);

	return linhaAdicionar;
}

function criarConteudoTabela(itemServidor, estrutura){

	var linhaTabela = document.createElement("tr");
	var celulaDescricao = document.createElement("td");
	var descricao = document.createElement("a");
	var celulaBotao = document.createElement("td");
	var botaoEditar  = document.createElement("a");
	var botaoRemover  = document.createElement("a");

	descricao.setAttribute('href', '#');
	descricao.textContent = itemServidor[estrutura.nome];

	botaoEditar.setAttribute('href', '#');
	botaoEditar.textContent = '* Editar';
	botaoEditar.classList.add('botao');
	botaoEditar.classList.add('editar');
	botaoEditar.addEventListener("click", function(event){
			event.preventDefault();
			editaServidor(itemServidor, estrutura);
		});

	botaoRemover.setAttribute('href', '#');
	botaoRemover.textContent = '- Excluir';
	botaoRemover.classList.add('botao');
	botaoRemover.classList.add('excluir');
	botaoRemover.addEventListener("click", function(event){
		event.preventDefault();
		removeServidor(itemServidor[estrutura.id]);
	});

	celulaDescricao.appendChild(descricao);
	celulaBotao.appendChild(botaoEditar);
	celulaBotao.appendChild(botaoRemover);

	linhaTabela.appendChild(celulaDescricao);
	linhaTabela.appendChild(celulaBotao);

	return linhaTabela;
}

function habilitaFormulario(){
	var formulario = document.querySelector('form');
	var campoId = document.querySelector('#id');
	campoId.value = '';
	formulario.reset();
	formulario.classList.remove('oculto');
}

function desabilitaFormulario(){
	var formulario = document.querySelector('form');
	formulario.reset();
	formulario.classList.add('oculto');
}

function enviaFormulario(){

	var campoNome 	= document.querySelector('#nome');
	var campoId 	= document.querySelector('#id');
	var servidor 	= new ServerComponent();

	servidor.setId(campoId.value);
	servidor.setName(campoNome.value);

	if(servidor.getId() == ''){
		cadastrarServidor(servidor);
	}
	else{
		atualizarServidor(servidor);
	}
}

function editaServidor(elemento, estrutura){
	habilitaFormulario();
	var campoNome = document.querySelector('#nome');
	var campoId   = document.querySelector('#id');
	
	campoNome.value = elemento[estrutura.nome];
	campoId.value   = elemento[estrutura.id];
}

function cadastrarServidor(servidor){
	servidor.create(function(retorno){
		desabilitaFormulario();
		carregaServidores();
	});
}

function atualizarServidor(servidor){
	servidor.update(function(retorno){

		if(retorno){
			desabilitaFormulario();
			carregaServidores();
		}
	});
}

function removeServidor(id){
	if(window.confirm('ATENÇÃO:\n\nTem certeza que deseja remover este servidor?\nIsto irá remover o servidor e suas respectivas aplicações!!!')){

		var servidor = new ServerComponent();
		servidor.setId(id);

		servidor.delete(function(retorno) {
			if(retorno){
				carregaServidores();
			}
		});
	}
}