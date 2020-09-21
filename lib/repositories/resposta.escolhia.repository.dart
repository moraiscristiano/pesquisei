import 'dart:convert';

import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/models/resposta.escolhida.dart';
import 'package:flutter_crud/models/resposta.escolhida.list.dart';
import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/utils/db.helper.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class RespostaEscolhidaRepository {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DbHelper().db;

    AuthController _authController = new AuthController();

    // Get Token (Authenticate)
    TokenReturn tokenReturn = await _authController.authenticate(pUser, pPass);

    if (tokenReturn.statuscode != 200) {
      return tokenReturn;
    }

    // Get Resposta Db
    List<RespostaEscolhida> listaDb = await getFromDb(_db);
    print('listaDb' + listaDb.length.toString());

    if (null != listaDb && listaDb.length > 0) {
      //RespostaEscolhidaList list = RespostaEscolhidaList(listaDb);

      String jsonRespostas =
          List<dynamic>.from(listaDb.map((x) => x.toMapList())).toString();
      Response resposta = await postRespostasRescolhidas(
          tokenReturn.token.accessToken, jsonRespostas);

      print('Post Status Code: ' + resposta.statusCode.toString());

      if (resposta.statusCode == 201) {
        for (var item in listaDb) {
          item.dataprocessamento = dateFormat.format(DateTime.now());
          int i = await atualizar(_db, item);
        }
      }
    }

    return tokenReturn;
  }

  Future<Response> postRespostasRescolhidas(
      String accessToken, String jsonRespostas) async {
    String bearerAuth = 'Bearer ' + accessToken;

    var r = await post(
        Strings.BASE_URL_WEB_API +
            Strings.GET_ALL_RESPOSTAS_ESCOLHIDAS_FROM_WEB_API,
        headers: <String, String>{
          'authorization': bearerAuth,
          'Content-type': 'application/json'
        },
        body: jsonRespostas);
    await Future.delayed(new Duration(milliseconds: 1500));

    print(r.body);

    return r;
  }

  Future<List<RespostaEscolhida>> getFromDb(Future<Database> db) async {
    var dbResposta = await db;
    List<Map> maps = await dbResposta.query('RespostaEscolhida',
        columns: [
          'id',
          'idPergunta',
          'idResposta',
          'idBairro',
          'alteracao',
          'dataprocessamento'
        ],
        where: 'dataprocessamento IS NULL');
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<RespostaEscolhida> respostas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        respostas.add(RespostaEscolhida.fromMap(maps[i]));
      }
    }
    return respostas;
  }

  Future<int> atualizar(
      Future<Database> db, RespostaEscolhida respostaEscolhida) async {
    var dbRespostaEscolhida = await db;
    return await dbRespostaEscolhida.update(
        'RespostaEscolhida', respostaEscolhida.toMap(),
        where: 'id = ?', whereArgs: [respostaEscolhida.id]);
  }
}
