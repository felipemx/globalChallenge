# globalChallenge
Aplicação de desafio, focando a criação de uma API em Javascript.

Banco de Dados utilizado:

ArangoDB 2.3.4 (https://www.arangodb.com/)

Download: https://www.arangodb.com/download

Estrutura de back-end utilizada:

CFML rodando em cima do Railo Express v4.2.1.008 com Jetty, na porta 8888.

Download: http://www.getrailo.org/index.cfm/download/

Instalação: https://github.com/getrailo/railo/wiki/Installation-ExpressJetty

Maiores informações:

Alterações no Railo Web Server:

URL: http://127.0.0.1:8888/railo-context/admin/web.cfm

* Settings -> Language/Compiler -> Template charset: UTF-8

* Settings -> Charset -> Resource charset: UTF-8

* Archives & Resources -> Rest -> 

   Virtual: globalChallenge
   
   Physical: {caminho-pasta-raiz-do-projeto}
   
Driver: CFArango

URL: https://github.com/dajester2013/CFArango

Clonar para: {railo-express-home}\webapps\ROOT\
 
 
 
ArangoDB v2.3.4

Arango Web Interface: http://localhost:8529/

Criar, via arangosh:

db._createDatabase("globalChallenge");

db._useDatabase("globalChallenge");

db._create("servers", {keyOptions: {type:"autoincrement"}});

db._create("apps", {keyOptions: {type:"autoincrement"}});

db.servers.save({"name":"Giant"});

db.servers.save({"name":"Cowboy"});

db.servers.save({"name":"Eagle"});

db.servers.save({"name":"Redskin"});

db.apps.save({"name":"Giant"});

var s = db.servers.firstExample({"name":"Giant"});

db.apps.save({"name":"MetLifeApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Redskin"});

db.apps.save({"name":"LambeauApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Giant"});

db.apps.save({"name":"ArrowHeadApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Cowboy"});

db.apps.save({"name":"SunLifeApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Eagle"});

db.apps.save({"name":"FirstEnergyApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Eagle"});

db.apps.save({"name":"QualcommApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Eagle"});

db.apps.save({"name":"ReliantApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Giant"});

db.apps.save({"name":"LincolnFinancialApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Redskin"});

db.apps.save({"name":"LPApp", "serverId":s._id});

s = db.servers.firstExample({"name":"Cowboy"});

db.apps.save({"name":"CandlestickApp", "serverId":s._id});
