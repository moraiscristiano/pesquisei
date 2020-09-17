import 'package:flutter_crud/models/pergunta.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/pesquisa.quiz.dart';
import 'package:flutter_crud/models/resposta.dart';
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

  Future<List<PerguntaQuiz>> getPerguntasPorPesquisa(int idpesquisa) async {
    var db = await _db;

    print("idbairro que entrou 2=  $idpesquisa");

    List<Map> maps = await db
        .rawQuery("SELECT * FROM Pergunta where idpesquisa = $idpesquisa");

    List<PerguntaQuiz> perguntas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        perguntas.add(PerguntaQuiz.fromMap(maps[i]));
      }
    }

    for (int i = 0; i < perguntas.length; i++) {

              
      int idpergunta = perguntas[i].id;

      List<Map> maps = await db
          .rawQuery("SELECT * FROM Resposta where idpergunta = $idpergunta");

      List<Resposta> respostas = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          respostas.add(Resposta.fromMap(maps[i]));
        }
      }


print('depois de tudo');

      perguntas[i].opcoes = respostas;
    }

    return perguntas;
  }
}
