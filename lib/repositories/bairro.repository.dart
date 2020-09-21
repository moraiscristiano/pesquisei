import 'dart:convert';

import 'package:Pesquisei/controllers/auth.controller.dart';
import 'package:Pesquisei/models/bairro.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/utils/db.helper.dart';
import 'package:Pesquisei/utils/strings.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class BairroRepository {
  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DbHelper().db;

    AuthController _authController = new AuthController();

    // Get Token (Authenticate)
    TokenReturn tokenReturn = await _authController.authenticate(pUser, pPass);

    if (tokenReturn.statuscode != 200) {
      return tokenReturn;
    }

    // Get Bairros da API
    List<Bairro> listaApi = await getListaWebApi(tokenReturn.token.accessToken);
    print('listaApi' + listaApi.length.toString());

    // Get Bairros Db
    List<Bairro> listaDb = await getListaDb(_db);

    print('listaDb' + listaDb.length.toString());

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

      print('itemExist?' + itemExist.toString());
      print('itemParaAtualizar?' + itemParaAtualizar.toString());
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

  Future<List<Bairro>> getListaDb(Future<Database> db) async {
    var database = await db;
    List<Map> maps = await database
        .query('Bairro', columns: ['id', 'idcidade', 'nome', 'alteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Bairro> lista = [];
    print('map1');
    print(maps);

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print('map2');
        print(Bairro.fromMapDb(maps[i]));

        lista.add(Bairro.fromMapDb(maps[i]));
      }
    }
    return lista;
  }

  Future<List<Bairro>> getListaWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Bairro> bairros = [];

    print('Bearer');

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_BAIRROS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    await Future.delayed(new Duration(milliseconds: 1500));

    print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(utf8convert(r.body));

      print('lista: ' + lista.toString());

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          print(Bairro.fromMap(lista[i]).id);
          print(Bairro.fromMap(lista[i]).alteracao);
          print(Bairro.fromMap(lista[i]).idcidade);
          print(Bairro.fromMap(lista[i]).nome);

          bairros.add(Bairro.fromMap(lista[i]));

          print('ok??????????');
        }
      }
    }
    return bairros;
  }

  void salvar(Future<Database> db, Bairro param) async {
    var database = await db;
    param.id = await database.insert('Bairro', param.toMap());
    print("salvar().bairro.id: " + param.id.toString());
  }

  Future<int> atualizar(Future<Database> db, Bairro param) async {
    var database = await db;
    return await database.update('Bairro', param.toMap(),
        where: 'id = ?', whereArgs: [param.id]);
  }

  Future<int> deletar(Future<Database> db, int id) async {
    var database = await db;
    return await database.delete('Bairro', where: 'id = ?', whereArgs: [id]);
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}
