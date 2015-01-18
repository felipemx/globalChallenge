/*
 *ATTENTION: Requires jQuery v1.11.2
*/
function GCConfig(){
	var defaultUrl = "http://127.0.0.1:8888/rest/globalChallenge/";

	//Bean methods
	this.getDefaultUrl = function(){
		return defaultUrl;
	}
};

function ServerComponent(){
	var id;
	var name;
	var defaultUrl;

	//Bean methods
	this.getId = function(){
		return this.id;
	}

	this.setId = function(paramId){
		this.id = paramId;
	}

	this.getName = function(){
		return this.name;
	}

	this.setName = function(paramName){
		this.name = paramName;
	}

	this.getDefaultUrl = function(){
		return new GCConfig().getDefaultUrl();
	}

	//Business methods
	this.list = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'GET'
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.read = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/' + this.getId(),
		    type: 'GET'
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.create = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'POST',
		    data: {"name" : this.getName() }
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.update = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'PUT',
		    data: {"id" : this.getId(), "name" : this.getName() }
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.delete = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'DELETE',
		    data: {"id" : this.getId()}
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}
}

function ApplicationComponent(){
	var id;
	var name;
	var server;
	var defaultUrl;

	//Bean methods
	this.getId = function(){
		return this.id;
	}

	this.setId = function(paramId){
		this.id = paramId;
	}

	this.getName = function(){
		return this.name;
	}

	this.setName = function(paramName){
		this.name = paramName;
	}

	this.getServer = function(){
		return this.name;
	}

	this.setServer = function(paramServer){
		this.name = paramServer;
	}

	this.getDefaultUrl = function(){
		return new GCConfig().getDefaultUrl();
	}

	//Business methods
	this.list = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'GET'
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.read = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/' + this.getId(),
		    type: 'GET'
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.create = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'POST',
		    data: {"name" : this.getName(), "serverId" : this.getServer().getId() }
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.update = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'PUT',
		    data: {"id" : this.getId(), "name" : this.getName(), "serverId" : this.getServer().getId() }
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}

	this.delete = function(){
		$.ajax({
		    url: this.getDefaultUrl() + 'server/',
		    type: 'DELETE',
		    data: {"id" : this.getId()}
		}).done(function(result) {
				console.log("success\nResultString: " + result);
			})
			.fail(function(errorMessage) {
				console.log(errorMessage);
			});
	}
}