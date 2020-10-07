
import 'package:Pesquisei/models/resposta.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:sqflite/sqflite.dart';

class RespostaProvider {
  Future<Database> _db;

  RespostaProvider() {
    _db = DbHelper().db;
  }

  Future<Resposta> saveResposta(Resposta resposta) async {
    var dbResposta = await _db;
    resposta.id = await dbResposta.insert('Resposta', resposta.toMap());
    print("saveResposta().resposta.id: " + resposta.id.toString());
    return resposta;
  }

  Future<List<Resposta>> getRespostas() async {
    var dbResposta = await _db;
    List<Map> maps = await dbResposta.query('Resposta',
        columns: ['id', 'perguntaId', 'descricao', 'ordem', 'alteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Resposta> respostas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        respostas.add(Resposta.fromMap(maps[i]));
      }
    }
    return respostas;
  }

  Future<int> deleteResposta(int id) async {
    var dbResposta = await _db;
    return await dbResposta
        .delete('Resposta', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateResposta(Resposta resposta) async {
    var dbResposta = await _db;
    return await dbResposta.update('Resposta', resposta.toMap(),
        where: 'id = ?', whereArgs: [resposta.id]);
  }
}
