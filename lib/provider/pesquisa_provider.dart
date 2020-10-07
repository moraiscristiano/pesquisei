import 'package:Pesquisei/models/pesquisa.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:sqflite/sqflite.dart';

class PesquisaProvider {
  Future<Database> _db;

  PesquisaProvider() {
    _db = DbHelper().db;
  }

  Future<Pesquisa> savePesquisa(Pesquisa pesquisa) async {
    var dbPesquisa = await _db;
    pesquisa.id = await dbPesquisa.insert('Pesquisa', pesquisa.toJson());
    print("savePesquisa().pesquisa.id: " + pesquisa.id.toString());
    return pesquisa;
  }

  Future<List<Pesquisa>> getPesquisas() async {
    var dbPesquisa = await _db;
    List<Map> maps = await dbPesquisa.query('Pesquisa', columns: [
      'id',
      'nome',
      'descricao',
      'dataCricao',
      'numeroEntrevistados',
      'alteracao',
      'idbairro'
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pesquisa> pesquisas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        pesquisas.add(Pesquisa.fromJsonDb(maps[i]));
      }
    }
    return pesquisas;
  }

  Future<int> deletePesquisa(int id) async {
    var dbPesquisa = await _db;
    return await dbPesquisa
        .delete('Pesquisa', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePesquisa(Pesquisa pesquisa) async {
    var dbPesquisa = await _db;
    return await dbPesquisa.update('Pesquisa', pesquisa.toJson(),
        where: 'id = ?', whereArgs: [pesquisa.id]);
  }
}
