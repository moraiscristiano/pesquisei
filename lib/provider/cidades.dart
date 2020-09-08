import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/utils/db_helper.dart';

class CidadeProvider {
  Future<Cidade> saveCidade(Cidade cidade) async {
    var dbClient = await DBHelper().db;
    cidade.id = await dbClient.insert('Cidade', cidade.toMap());
    return cidade;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Cidade>> getCidades() async {
    var dbClient = await DBHelper().db;
    List<Map> maps =
        await dbClient.query('Cidade', columns: ['id', 'nome', 'estado_sigla']);
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
    var dbClient = await DBHelper().db;
    return await dbClient.delete('Cidade', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCidade(Cidade cidade) async {
    var dbClient = await DBHelper().db;
    return await dbClient.update('Cidade', cidade.toMap(),
        where: 'id = ?', whereArgs: [cidade.id]);
  }
}
