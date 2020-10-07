import 'package:Pesquisei/models/pergunta.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:sqflite/sqflite.dart';

class PerguntaProvider {
  Future<Database> _db;

  PerguntaProvider() {
    _db = DbHelper().db;
  }

  Future<Pergunta> savePergunta(Pergunta pergunta) async {
    var dbPergunta = await _db;
    pergunta.id = await dbPergunta.insert('Pergunta', pergunta.toMap());
    print("savePergunta().pergunta.id: " + pergunta.id.toString());
    return pergunta;
  }

  Future<List<Pergunta>> getPerguntas() async {
    var dbPergunta = await _db;
    List<Map> maps = await dbPergunta.query('Pergunta',
        columns: ['id', 'pesquisaId', 'descricao', 'ordem', 'alteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pergunta> perguntas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        perguntas.add(Pergunta.fromMap(maps[i]));
      }
    }
    return perguntas;
  }

  Future<int> deletePergunta(int id) async {
    var dbPergunta = await _db;
    return await dbPergunta
        .delete('Pergunta', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePergunta(Pergunta pergunta) async {
    var dbPergunta = await _db;
    return await dbPergunta.update('Pergunta', pergunta.toMap(),
        where: 'id = ?', whereArgs: [pergunta.id]);
  }
}
