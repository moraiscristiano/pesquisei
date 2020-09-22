import 'dart:convert';

import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/models/pergunta.dart';
import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class PerguntaRepository {
  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    RetornoSincronizacao retorno = new RetornoSincronizacao();
    retorno.erros = 0;
    retorno.mensagem = "";
    retorno.registrosSincronizados = 0;

    Future<Database> _db = DbHelper().db;

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

      // Get Pergunta da API
      List<Pergunta> listaApi =
          await getFromWebApi(tokenReturn.token.accessToken);

      // Get Pergunta Db
      List<Pergunta> listaDb = await getFromDb(_db);

    //  print('listaApi' + listaApi.length.toString());
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

    //    print('itemExist?' + itemExist.toString());
     //   print('itemParaAtualizar?' + itemParaAtualizar.toString());
        if (itemExist) {
          if (itemParaAtualizar) {
            // Atualizar
            retorno.registrosSincronizados = retorno.registrosSincronizados + 1;
            int q = await atualizar(_db, itemApi);
            print(q.toString() + ' registro atualizado');
          }
        } else {
          // add
          retorno.registrosSincronizados = retorno.registrosSincronizados + 1;
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

  Future<List<Pergunta>> getFromDb(Future<Database> db) async {
    var dbPergunta = await db;
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

  Future<List<Pergunta>> getFromWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Pergunta> perguntas = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_PERGUNTAS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    //await Future.delayed(new Duration(milliseconds: 1500));

  //  print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(utf8convert(r.body));

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          perguntas.add(Pergunta.fromMap(lista[i]));
        }
      }
    }
    return perguntas;
  }

  void salvar(Future<Database> db, Pergunta pergunta) async {
    var dbPergunta = await db;
    pergunta.id = await dbPergunta.insert('Pergunta', pergunta.toMap());
    print("save().pergunta.id: " + pergunta.id.toString());
  }

  Future<int> atualizar(Future<Database> db, Pergunta pergunta) async {
    var dbPergunta = await db;
    return await dbPergunta.update('Pergunta', pergunta.toMap(),
        where: 'id = ?', whereArgs: [pergunta.id]);
  }

  Future<int> deletar(Future<Database> db, int id) async {
    var dbPergunta = await db;
    return await dbPergunta
        .delete('Pergunta', where: 'id = ?', whereArgs: [id]);
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
