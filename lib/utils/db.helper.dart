import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';

class DbHelper {
  static Database _db;

  static const String DB_NAME = 'perguntei.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);

    print(path);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    // Cidade
    await db.execute(
        "CREATE TABLE Cidade (id INTEGER PRIMARY KEY  UNIQUE NOT NULL ,nome VARCHAR (255) NOT NULL,estadoSigla VARCHAR (2) NOT NULL,alteracao VARCHAR NOT NULL)");
    // Bairro
    await db.execute(
        "CREATE TABLE Bairro (id INTEGER PRIMARY KEY  UNIQUE NOT NULL,nome VARCHAR (255) NOT NULL, idcidade INTEGER NOT NULL,alteracao VARCHAR NOT NULL)");
    // Pesquisa
    await db.execute(
        "CREATE TABLE Pesquisa (id INTEGER    NOT NULL,nome VARCHAR (255) NOT NULL,descricao VARCHAR (255) NOT NULL, dataCricao VARCHAR NOT NULL, numeroEntrevistados INTEGER NOT NULL,alteracao VARCHAR NOT NULL,  idbairro INTEGER NOT NULL)");
   // Bairro Pesquisa
      await db.execute(
        "CREATE TABLE BairroPesquisas (idbairro INTEGER NOT NULL, idpesquisa INTEGER NOT NULL, percentual INTEGER NOT NULL)");
   
    // Pergunta
    await db.execute(
        "CREATE TABLE Pergunta (id INTEGER PRIMARY KEY  UNIQUE NOT NULL,idpesquisa INTEGER NOT NULL, descricao VARCHAR (255) NOT NULL,ordem INTEGER NOT NULL,dataalteracao VARCHAR NOT NULL)");
    // Resposta
    await db.execute(
        "CREATE TABLE Resposta (id INTEGER PRIMARY KEY  UNIQUE NOT NULL,idpergunta INTEGER NOT NULL, descricao VARCHAR (255) NOT NULL,ordem INTEGER NOT NULL,dataalteracao VARCHAR NOT NULL)");

    await db.execute(
        "CREATE TABLE RespostaEscolhida (id INTEGER PRIMARY KEY  UNIQUE NOT NULL,idpergunta INTEGER NOT NULL, idresposta INTEGER NOT NULL, idbairro INTEGER NOT NULL,dataalteracao VARCHAR NOT NULL)");
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
