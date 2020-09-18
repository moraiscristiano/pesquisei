import 'dart:convert';

import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class BairroRepository {
  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DBHelper().db;

    AuthController _authController = new AuthController();

    // Get Token (Authenticate)
    TokenReturn tokenReturn = await _authController.authenticate(pUser, pPass);

    if (tokenReturn.statuscode != 200) {
      return tokenReturn;
    }

    // Get Bairros da API
    List<Bairro> listaApi = await getListaWebApi(tokenReturn.token.accessToken);

    // Get Bairros Db
    List<Bairro> listaDb = await getListaDb(_db);

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

  Future<List<Bairro>> getListaDb(Future<Database> db) async {
    var database = await db;
    List<Map> maps = await database
        .query('Bairro', columns: ['id', 'idcidade', 'nome', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Bairro> lista = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        lista.add(Bairro.fromMap(maps[i]));
      }
    }
    return lista;
  }

  Future<List<Bairro>> getListaWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Bairro> lista = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_BAIRROS_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    await Future.delayed(new Duration(milliseconds: 1500));

    print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(r.body);

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          lista.add(Bairro.fromMap(lista[i]));
        }
      }
    }
    return lista;
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
}
