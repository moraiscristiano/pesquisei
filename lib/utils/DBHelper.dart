import 'package:flutter_crud/models/cidade.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';
 
class DBHelper {
  static Database _db;

  //Cidade
  static const String TABLE_CIDADE = 'Cidade';
  static const String ID_CIDADE = 'id';
  static const String NOME_CIDADE = 'nome';
  static const String ESTADOSIGLA_CIDADE = 'estadoSigla';
  
  
  
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
    await db
        .execute("CREATE TABLE $TABLE_CIDADE ($ID_CIDADE INTEGER PRIMARY KEY, $NOME_CIDADE TEXT, $ESTADOSIGLA_CIDADE TEXT)");
  }
 
  Future<Cidade> saveCidade(Cidade cidade) async {
    var dbClient = await db;
    cidade.id = await dbClient.insert(TABLE_CIDADE, cidade.toMap());
    return cidade;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }
 
  Future<List<Cidade>> getCidades() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE_CIDADE, columns: [ID_CIDADE, NOME_CIDADE, ESTADOSIGLA_CIDADE]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Cidade> cidades = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cidades.add(Cidade.fromMap(maps[i]));
      }
    }
    return cidades;
  }
 
  Future<int> deleteCidade(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE_CIDADE, where: '$ID_CIDADE = ?', whereArgs: [id]);
  }
 
  Future<int> updateCidade(Cidade employee) async {
    var dbClient = await db;
    return await dbClient.update(TABLE_CIDADE, employee.toMap(),
        where: '$ID_CIDADE = ?', whereArgs: [employee.id]);
  }
 
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}