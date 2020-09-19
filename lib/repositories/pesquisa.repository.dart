import 'dart:convert';

import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/pesquisa.quiz.dart';
import 'package:flutter_crud/models/resposta.dart';
import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/utils/db.helper.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class PesquisaRepository {
  Future<Database> _db;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  PesquisaRepository() {
    _db = DbHelper().db;
  }

  Future<List<Pesquisa>> getPesquisasPorCidadeBairro(int idbairro) async {
    var dbPesquisa = await _db;

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
      perguntas[i].opcoes = respostas;
    }

    return perguntas;
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DbHelper().db;

    AuthController _authController = new AuthController();

    // Get Token (Authenticate)
    TokenReturn tokenReturn = await _authController.authenticate(pUser, pPass);

    if (tokenReturn.statuscode != 200) {
      return tokenReturn;
    }

    // Get Pesquisas da API
    List<Pesquisa> listaApi =
        await getListaWebApi(tokenReturn.token.accessToken);

    // Get Pesquisas Db
    List<Pesquisa> listaDb = await getListaDb(_db);

    for (var itemApi in listaApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in listaDb) {
        if (itemApi.id == itemDb.id) {
          itemExist = true;

          if (itemApi.dataalteracao?.isEmpty ||
              itemDb.dataalteracao?.isEmpty ||
              DateTime.parse(itemApi.dataalteracao)
                  .isAfter(DateTime.parse(itemDb.dataalteracao))) {
            itemParaAtualizar = true;
          }
        }
      }

      if (itemExist) {
        if (itemParaAtualizar) {
          // Atualizar
          int q = await atualizar(_db, itemApi);
          print(q.toString() + ' registro atualizado');
        }
      } else {
        // add
        salvar(_db, itemApi);
        print('registro de id:' + itemApi.id.toString() + '  adicionado');
      }

      print('statusCode: ' + tokenReturn.statuscode.toString());
      print('accessToken: ' + tokenReturn.token.accessToken);
    }

    return tokenReturn;
  }

  Future<List<Pesquisa>> getListaDb(Future<Database> db) async {
    var database = await db;
    List<Map> maps = await database.query('Pesquisa',
        columns: ['id', 'nome', 'descricao', 'idbairro', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pesquisa> lista = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        lista.add(Pesquisa.fromMap(maps[i]));
      }
    }
    return lista;
  }

  Future<List<Pesquisa>> getListaWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Pesquisa> lista = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_PESQUISAS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    await Future.delayed(new Duration(milliseconds: 1500));

    print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(r.body);

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          lista.add(Pesquisa.fromMap(lista[i]));
        }
      }
    }
    return lista;
  }

  void salvar(Future<Database> db, Pesquisa param) async {
    var database = await db;
    param.id = await database.insert('Pesquisa', param.toMap());
    print("salvar().pesquisa.id: " + param.id.toString());
  }

  Future<int> atualizar(Future<Database> db, Pesquisa param) async {
    var database = await db;
    return await database.update('Pesquisa', param.toMap(),
        where: 'id = ?', whereArgs: [param.id]);
  }

  Future<int> deletar(Future<Database> db, int id) async {
    var database = await db;
    return await database.delete('Pesquisa', where: 'id = ?', whereArgs: [id]);
  }
}
