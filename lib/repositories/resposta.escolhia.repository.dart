import 'dart:convert';

import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/models/resposta.escolhida.dart';
import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class RespostaEscolhidaRepository {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DbHelper().db;
    RetornoSincronizacao retorno = new RetornoSincronizacao();
    retorno.erros = 0;
    retorno.mensagem = "";
    retorno.registrosSincronizados = 0;

    AuthController _authController = new AuthController();

    try {
      // Get Token (Authenticate)
      TokenReturn tokenReturn =
          await _authController.authenticate(pUser, pPass);

      if (tokenReturn.statuscode != 200) {
        retorno.erros = 1;
        retorno.mensagem = tokenReturn.error_description;
        retorno.registrosSincronizados = 0;
        return retorno;
      }

      // Get Resposta Db
      List<RespostaEscolhida> listaDb = await getFromDb(_db);
      //await Future.delayed(new Duration(milliseconds: 1500));
    //  print('listaDb' + listaDb.length.toString());

      if (!listVazia(listaDb)) {
        //RespostaEscolhidaList list = RespostaEscolhidaList(listaDb);

        String jsonRespostas =
            List<dynamic>.from(listaDb.map((x) => x.toMapList())).toString();
        Response resposta = await postRespostasRescolhidas(
            tokenReturn.token.accessToken, jsonRespostas);

    //    print('Post Status Code: ' + resposta.statusCode.toString());

        if (resposta.statusCode == 201) {
          for (var item in listaDb) {
            retorno.registrosSincronizados = retorno.registrosSincronizados + 1;
            item.dataprocessamento = dateFormat.format(DateTime.now());
            int i = await atualizar(_db, item);
          }
        }
      }
    } catch (error) {
      retorno.erros = 1;
      retorno.mensagem = error.toString();
    }

    return retorno;
  }

  bool listVazia(var myList) {
    //length of empty list is zero
    return myList.length == 0;
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
    //await Future.delayed(new Duration(milliseconds: 1500));

  //  print(r.body);

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
