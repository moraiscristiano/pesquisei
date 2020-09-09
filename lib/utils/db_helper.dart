import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';
 
class DBHelper {
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
    await db
        .execute("CREATE TABLE Cidade (id INTEGER PRIMARY KEY, nome TEXT, estadosigla TEXT)");
    // Bairro
    await db
        .execute("CREATE TABLE Bairro (id INTEGER PRIMARY KEY, nome TEXT, idcidade INTEGER)");
  }
 
 
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}