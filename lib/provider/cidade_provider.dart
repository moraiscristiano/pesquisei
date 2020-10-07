
import 'package:Pesquisei/models/cidade.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:sqflite/sqflite.dart';

class CidadeProvider {
  Future<Database> _db;

  CidadeProvider() {
    _db = DbHelper().db;
  }

  Future<Cidade> saveCidade(Cidade cidade) async {
    var dbClient = await _db;
    cidade.id = await dbClient.insert('Cidade', cidade.toMap());
    print("saveCidade().cidade.id: " + cidade.id.toString());
    return cidade;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Cidade>> getCidades() async {
    var dbClient = await _db;
    List<Map> maps = await dbClient.query('Cidade',
        columns: ['id', 'nome', 'estadoSigla', 'alteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Cidade> cidades = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cidades.add(Cidade.fromMap(maps[i]));
      }
    }
    print(cidades.length);
    return cidades;
  }

  Future<int> deleteCidade(int id) async {
    var dbClient = await _db;
    return await dbClient.delete('Cidade', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCidade(Cidade cidade) async {
    var dbClient = await _db;
    return await dbClient.update('Cidade', cidade.toMap(),
        where: 'id = ?', whereArgs: [cidade.id]);
  }

}
