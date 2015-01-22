/*
	Por não manter uma estrutura fixa, o ArangoDB e, conseqüentemente, o CFArango não devolvem as colunas na mesma ordem
	Então é necessário varrer o array de colunas para redefinir, a cada passagem, a posição das chaves ("colunas") necessárias
*/
function mapStructure(vetor){
	var estrutura = new Object();
	var posicaoId = -1;
	var posicaoNome = -1;
	var posicaoServidor = -1;;

	for(var i = 0; i < vetor.length; i++){
		if(vetor[i].toLowerCase() == "_key"){
			posicaoId = i;		
		}

		if(vetor[i].toLowerCase() == "name"){
			posicaoNome = i;
		}

		if(vetor[i].toLowerCase() == "serverId"){
			posicaoServidor = i;
		}
	}

	estrutura.id = posicaoId;
	estrutura.nome = posicaoNome;
	estrutura.servidor = posicaoServidor;

	return estrutura;
}

function getURLParameter(parametro){
	return parametro.replace('?','');
}

function carregaAplicacoes(servidor){
	var aplicacao = new ApplicationComponent();
	var servidor = new ServerComponent();
	var idServidor = getURLParameter(location.search);

	servidor.setId(idServidor);
	servidor.read(function(retorno){
		escreveServidor(retorno);
	});

	aplicacao.setServer('servers/' + idServidor);
	aplicacao.list(function(conteudo){

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

function escreveServidor(servidor){
	var estruturaServidor = mapStructure(servidor.COLUMNS);
	var dadosServidor = servidor.DATA[0];
	var nomeServidor = dadosServidor[estruturaServidor.nome];

	var subtitulo = document.querySelector('h2');
	subtitulo.innerHTML = 'Servidor: ' + nomeServidor;
}

function listarServidores(){
	var servidor = new ServerComponent();
	servidor.list(function(conteudo){

		var estrutura	= mapStructure(conteudo.COLUMNS);
		var lista 		= document.querySelector('select');

		for(var i = 0; i < conteudo.DATA.length; i++){
			var itemServidor= conteudo.DATA[i];
			var itemLista	= document.createElement('option');
			itemLista.text 	= itemServidor[estrutura.nome];
			itemLista.value = itemServidor[estrutura.id];


			if(itemServidor[estrutura.id] == getURLParameter(location.search)){
				itemLista.selected = true;
			}

			lista.appendChild(itemLista);
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

function criarConteudoTabela(itemAplicacao, estrutura){

	var linhaTabela = document.createElement("tr");
	var celulaDescricao = document.createElement("td");
	var descricao = document.createElement("a");
	var celulaBotao = document.createElement("td");
	var botaoEditar  = document.createElement("a");
	var botaoRemover  = document.createElement("a");

	celulaDescricao.textContent = itemAplicacao[estrutura.nome];

	botaoEditar.setAttribute('href', '#');
	botaoEditar.textContent = '* Editar';
	botaoEditar.classList.add('botao');
	botaoEditar.classList.add('editar');
	botaoEditar.addEventListener("click", function(event){
			event.preventDefault();
			editaAplicacao(itemAplicacao, estrutura);
		});

	botaoRemover.setAttribute('href', '#');
	botaoRemover.textContent = '- Excluir';
	botaoRemover.classList.add('botao');
	botaoRemover.classList.add('excluir');
	botaoRemover.addEventListener("click", function(event){
		event.preventDefault();
		removeAplicacao(itemAplicacao[estrutura.id]);
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
	listarServidores();
	formulario.classList.remove('oculto');
}

function desabilitaFormulario(){
	var formulario = document.querySelector('form');
	formulario.reset();
	formulario.classList.add('oculto');
}

function enviaFormulario(){

	var campoNome 		= document.querySelector('#nome');
	var campoId 		= document.querySelector('#id');
	var campoServidor	= document.querySelector('#servidor');
	var aplicacao 		= new ApplicationComponent();

	aplicacao.setServer(campoServidor.options[campoServidor.selectedIndex].value);
	aplicacao.setId(campoId.value);
	aplicacao.setName(campoNome.value);

	if(aplicacao.getId() == ''){
		cadastrarAplicacao(aplicacao);
	}
	else{
		atualizarAplicacao(aplicacao);
	}
}

function editaAplicacao(elemento, estrutura){
	habilitaFormulario();
	var campoNome 		= document.querySelector('#nome');
	var campoId   		= document.querySelector('#id');
	var campoServidor	= document.querySelector('#servidor');
	
	campoNome.value = elemento[estrutura.nome];
	campoId.value   = elemento[estrutura.id];

	for(item in campoServidor){
		if(item.value == elemento[estrutura.servidor]){
			item.selected = true;
			break;
		}
	}
}

function cadastrarAplicacao(aplicacao){
	aplicacao.create(function(retorno){
		desabilitaFormulario();
		carregaAplicacoes(location.search);
	});
}

function atualizarAplicacao(aplicacao){
	aplicacao.update(function(retorno){

		if(retorno){
			desabilitaFormulario();
			carregaAplicacoes(location.search);
		}
	});
}

function removeAplicacao(id){
	if(window.confirm('ATENÇÃO:\n\nTem certeza que deseja remover esta aplicação?')){

		var aplicacao = new ApplicationComponent();
		aplicacao.setId(id);

		aplicacao.delete(function(retorno) {
			if(retorno){
				carregaAplicacoes(location.search);
			}
		});
	}
}