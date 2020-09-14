import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class PesquisaListRepository {
  Future<Database> _db;

  PesquisaListRepository() {
    _db = DBHelper().db;
  }

  Future<List<Pesquisa>> getPesquisasPorCidadeBairro(int idbairro) async {
    var dbPesquisa = await _db;

    print("idbairro que entrou 2=  $idbairro");

    List<Map> maps = await dbPesquisa
        .rawQuery("SELECT * FROM Pesquisa where idbairro = $idbairro");

    List<Pesquisa> pesquisas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        pesquisas.add(Pesquisa.fromMap(maps[i]));
      }
    }
    return pesquisas;
  }
}
