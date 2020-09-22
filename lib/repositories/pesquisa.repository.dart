import 'dart:convert';

import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/models/bairro.pesquisa.dart';
import 'package:Pesquisei/models/pesquisa.dart';
import 'package:Pesquisei/models/pesquisa.quiz.dart';
import 'package:Pesquisei/models/resposta.dart';
import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:html_unescape/html_unescape.dart';
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
        pesquisas.add(Pesquisa.fromJson(maps[i]));
      }
    }
    return pesquisas;
  }

  Future<List<PerguntaQuiz>> getPerguntasPorPesquisa(int idpesquisa) async {
    var db = await _db;

    List<Map> maps = await db
        .rawQuery("SELECT * FROM Pergunta where pesquisaId = $idpesquisa");

    List<PerguntaQuiz> perguntas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        perguntas.add(PerguntaQuiz.fromMap(maps[i]));
      }
    }

    for (int i = 0; i < perguntas.length; i++) {
      int idpergunta = perguntas[i].id;

      List<Map> maps = await db
          .rawQuery("SELECT * FROM Resposta where perguntaId = $idpergunta");

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

  //    print('chegou api');

      List<Pesquisa> lApi = [];

      // Get Pesquisas da API
      List<Pesquisa> listaApi =
          await getListaWebApi(tokenReturn.token.accessToken);

      for (var iapi in listaApi) {
        List<BairroPesquisas> listaBP =
            await getListaBairroPesquisaWebApi(tokenReturn.token.accessToken);
        for (var itemBP in listaBP) {
          Pesquisa p = Pesquisa(
              id: iapi.id,
              nome: iapi.nome,
              descricao: iapi.descricao,
              dataCricao: iapi.dataCricao,
              numeroEntrevistados: iapi.numeroEntrevistados,
              alteracao: iapi.alteracao,
              idbairro: itemBP.idbairro);

          lApi.add(p);
        }
      }

      List<Pesquisa> listaDb = await getListaDb(_db);

      for (var o in lApi) {
        bool itemParaAtualizar = false;
        bool itemExist = false;

    //    if (listaDb.length > 0) {
    //      print('MAIOR QUE ZERO');
     //   } else {
     //     print('MENOR QUE ZERO');
    //    }
        for (var itemDb in listaDb) {
          if (o.id == itemDb.id && o.idbairro == itemDb.idbairro) {
            itemExist = true;

            if (o.alteracao?.isEmpty ||
                itemDb.alteracao?.isEmpty ||
                DateTime.parse(o.alteracao)
                    .isAfter(DateTime.parse(itemDb.alteracao))) {
              itemParaAtualizar = true;
            }
          }

     //     print(itemDb);
        }

   //     print('OOOOOOOOOO' + o.idbairro.toString());
   //     print('itemExist' + itemExist.toString());

        if (itemExist) {
          if (itemParaAtualizar) {
            retorno.registrosSincronizados = retorno.registrosSincronizados + 1;

            int q = await atualizar(_db, o);
            print(q.toString() + ' registro atualizado');
          }
        } else {
          retorno.registrosSincronizados = retorno.registrosSincronizados + 1;

          salvar(_db, o);
          print('registro de id:' +
              o.id.toString() +
              '  adicionado' +
              o.idbairro.toString());
        }
      }
    } catch (error) {
      retorno.erros = 1;
      retorno.mensagem = error.toString();
    }

    return retorno;
  }

  Future<List<Pesquisa>> getListaDb(Future<Database> db) async {
    var database = await db;
    List<Map> maps = await database.query('Pesquisa', columns: [
      'id',
      'nome',
      'descricao',
      'numeroEntrevistados',
      'alteracao',
      'idbairro'
    ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pesquisa> lista = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        lista.add(Pesquisa.fromJsonDb(maps[i]));
      }
    }
    return lista;
  }

  Future<List<Pesquisa>> getListaWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Pesquisa> pesquisas = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_PESQUISAS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    // await Future.delayed(new Duration(milliseconds: 1500));

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(utf8convert(r.body));

//      print('decode=');
  //    print(lista);
      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          pesquisas.add(Pesquisa.fromJson(lista[i]));
        }
      }
    }
    return pesquisas;
  }

  Future<List<BairroPesquisas>> getListaBairroPesquisaWebApi(
      String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<BairroPesquisas> bairroPesquisas = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_PESQUISAS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    //await Future.delayed(new Duration(milliseconds: 1500));

 //   print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(r.body);

  //    print('decode=');
  //    print(lista);
      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          Map<String, dynamic> j = lista[i];

    //      print('id? ' + j['id'].toString());

          var bairrospesquisas = j['bairroPesquisas'];
          if (null != bairrospesquisas && bairrospesquisas.length > 0) {
            for (int k = 0; k < bairrospesquisas.length; k++) {
              bairroPesquisas
                  .add(BairroPesquisas.fromJson(bairrospesquisas[k]));
            }
          }
        }
      }
    }
    return bairroPesquisas;
  }

  void salvar(Future<Database> db, Pesquisa param) async {
    var database = await db;
    param.id = await database.insert('Pesquisa', param.toJson());
    print("salvar().pesquisa.id: " + param.id.toString());
  }

  Future<int> atualizar(Future<Database> db, Pesquisa param) async {
    var database = await db;
    return await database.update('Pesquisa', param.toJson(),
        where: 'id = ? and idbairro = ?',
        whereArgs: [param.id, param.idbairro]);
  }

  Future<int> deletar(Future<Database> db, int id) async {
    var database = await db;
    return await database.delete('Pesquisa', where: 'id = ?', whereArgs: [id]);
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
