
import 'package:Pesquisei/controllers/pesquisa.controller.dart';
import 'package:Pesquisei/models/bairro.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:sqflite/sqflite.dart';

class BairroProvider {
  Future<Database> _db; 

  BairroProvider() {
    _db = DbHelper().db;
  }

  Future<Bairro> saveBairro(Bairro bairro) async {
    var dbBairro = await _db;
    bairro.id = await dbBairro.insert('Bairro', bairro.toMap());
    print("saveBairro().bairro.id: " + bairro.id.toString());
    return bairro;
  }

  Future<List<Bairro>> getBairros() async {
    var dbBairro = await _db;
    List<Map> maps = await dbBairro
        .query('Bairro', columns: ['id', 'idcidade', 'nome', 'alteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Bairro> bairros = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        bairros.add(Bairro.fromMapDb(maps[i]));
      }
    }
    return bairros;
  }

  Future<int> deleteBairro(int id) async {
    var dbBairro = await _db;
    return await dbBairro.delete('Bairro', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateBairro(Bairro bairro) async {
    var dbBairro = await _db;
    return await dbBairro.update('Bairro', bairro.toMap(),
        where: 'id = ?', whereArgs: [bairro.id]);
  }

  Future<bool> verificaPesquisaFinalizada(int idbairro, int idcidade) async {
    bool retorno = true;

    var _controllerPesquisa = new PesquisaController();

    var listPesquisas =
        await _controllerPesquisa.getPesquisasPorCidadeBairro(idbairro);

    if (listPesquisas.length > 0) {
      for (var pesquisa in listPesquisas) {
        var resumo = await _controllerPesquisa.getResumoPorPesquisaBairro(
            pesquisa.id, pesquisa.nome, pesquisa.idbairro, idcidade);
        if (resumo.numeroEntrevistadosAtual <
            resumo.numeroEntrevistadosParaBairro) {
          retorno = false;
        }
      }
    }

    return retorno;
  }

  Future<List<Bairro>> getBairrosPorCidadeId(String minhaCidade) async {
    var dbBairro = await _db;
    //List<Map> maps = await dbBairro.query('Bairro', columns: ['id', 'idcidade', 'nome', 'dataalteracao']);
    List<Map> maps = await dbBairro.rawQuery(
        "SELECT id,idcidade,nome,alteracao FROM Bairro where idcidade= $minhaCidade");
    List<Bairro> bairros = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        bairros.add(Bairro.fromMapDb(maps[i]));
      }
    }
    return bairros;
  }
}
