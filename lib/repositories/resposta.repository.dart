import 'dart:convert';

import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/models/resposta.dart';
import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class RespostaRepository {
  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DbHelper().db;

    AuthController _authController = new AuthController();
    RetornoSincronizacao retorno = new RetornoSincronizacao();
    retorno.erros = 0;
    retorno.mensagem = "";
    retorno.registrosSincronizados = 0;

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

      // Get Resposta da API
      List<Resposta> listaApi =
          await getFromWebApi(tokenReturn.token.accessToken);

      // Get Resposta Db
      List<Resposta> listaDb = await getFromDb(_db);

   //   print('listaApi' + listaApi.length.toString());
    //  print('listaDb' + listaDb.length.toString());

      for (var itemApi in listaApi) {
        bool itemParaAtualizar = false;
        bool itemExist = false;
        for (var itemDb in listaDb) {
          if (itemApi.id == itemDb.id) {
            itemExist = true;

            if (itemApi.alteracao?.isEmpty ||
                itemDb.alteracao?.isEmpty ||
                DateTime.parse(itemApi.alteracao)
                    .isAfter(DateTime.parse(itemDb.alteracao))) {
              itemParaAtualizar = true;
            }
          }
        }

     //   print('itemExist?' + itemExist.toString());
     //   print('itemParaAtualizar?' + itemParaAtualizar.toString());
        if (itemExist) {
          if (itemParaAtualizar) {
            retorno.registrosSincronizados = retorno.registrosSincronizados + 1;

            // Atualizar
            int q = await atualizar(_db, itemApi);
            print(q.toString() + ' registro atualizado');
          }
        } else {
          retorno.registrosSincronizados = retorno.registrosSincronizados + 1;

          // add
          salvar(_db, itemApi);
          print('registro de id:' + itemApi.id.toString() + '  adicionado');
        }

    //    print('statusCode: ' + tokenReturn.statuscode.toString());
   //     print('accessToken: ' + tokenReturn.token.accessToken);
      }
    } catch (error) {
      retorno.erros = 1;
      retorno.mensagem = error.toString();
    }

    return retorno;
  }

  Future<List<Resposta>> getFromDb(Future<Database> db) async {
    var dbResposta = await db;
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

  Future<List<Resposta>> getFromWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Resposta> respostas = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_RESPOSTAS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
   // await Future.delayed(new Duration(milliseconds: 1500));

   // print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(utf8convert(r.body));

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          respostas.add(Resposta.fromMap(lista[i]));
        }
      }
    }
    return respostas;
  }

  void salvar(Future<Database> db, Resposta resposta) async {
    var dbResposta = await db;
    resposta.id = await dbResposta.insert('Resposta', resposta.toMap());
    print("save().resposta.id: " + resposta.id.toString());
  }

  Future<int> atualizar(Future<Database> db, Resposta resposta) async {
    var dbResposta = await db;
    return await dbResposta.update('Resposta', resposta.toMap(),
        where: 'id = ?', whereArgs: [resposta.id]);
  }

  Future<int> deletar(Future<Database> db, int id) async {
    var dbResposta = await db;
    return await dbResposta
        .delete('Resposta', where: 'id = ?', whereArgs: [id]);
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
