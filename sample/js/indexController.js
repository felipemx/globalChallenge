function carregaServidores(){
	var servidor = new ServerComponent();
	servidor.list(function(conteudo){

		var corpoTabela = document.querySelector('tbody');
		var linhaInicial = this.criarLinhaInicialTabela();

		corpoTabela.innerHTML = "";
		corpoTabela.appendChild(linhaInicial);

		for(var i = 0; i < conteudo.DATA.length; i++){
			var novaLinha = this.criarConteudoTabela(conteudo.DATA[i]);
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
	celulaAdicionar.setAttribute('colspan', '2');

	celulaAdicionar.appendChild(botaoAdicionar);
	linhaAdicionar.appendChild(celulaAdicionar);

	return linhaAdicionar;
}

function criarConteudoTabela(itemServidor){

	var linhaTabela = document.createElement("tr");
	var celulaDescricao = document.createElement("td");
	var descricao = document.createElement("a");
	var celulaBotao = document.createElement("td");
	var botaoEditar  = document.createElement("a");
	var botaoRemover  = document.createElement("a");

	descricao.setAttribute('href', '#?id=' + itemServidor[2]);
	descricao.textContent = itemServidor[3];

	botaoEditar.setAttribute('href', '#?id=' + itemServidor[2]);
	botaoEditar.textContent = '* Editar';
	botaoEditar.classList.add('botao');
	botaoEditar.classList.add('editar');

	botaoRemover.setAttribute('href', '#?id=' + itemServidor[2]);
	botaoRemover.textContent = '- Excluir';
	botaoRemover.classList.add('botao');
	botaoRemover.classList.add('excluir');

	celulaDescricao.appendChild(descricao);
	celulaBotao.appendChild(botaoEditar);
	celulaBotao.appendChild(botaoRemover);

	linhaTabela.appendChild(celulaDescricao);
	linhaTabela.appendChild(celulaBotao);

	return linhaTabela;
}