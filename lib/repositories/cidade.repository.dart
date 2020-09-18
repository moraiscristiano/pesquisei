import 'dart:convert';

import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class CidadeRepository {
  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    Future<Database> _db = DBHelper().db;

    AuthController _authController = new AuthController();

    // Get Token (Authenticate)
    TokenReturn tokenReturn = await _authController.authenticate(pUser, pPass);

    if (tokenReturn.statuscode != 200) {
      return tokenReturn;
    }

    // Get Cidades da API
    List<Cidade> cidadesApi =
        await getCidadesWebApi(tokenReturn.token.accessToken);

    // Get Cidades Db
    List<Cidade> cidadesDb = await getCidadesDb(_db);

    for (var itemApi in cidadesApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in cidadesDb) {
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
          int q = await atualizarCidade(_db, itemApi);
          print(q.toString() + ' registro atualizado');
        }
      } else {
        // add
        salvarCidade(_db, itemApi);
        print('registro de id:' + itemApi.id.toString() + '  adicionado');
      }

      print('statusCode: ' + tokenReturn.statuscode.toString());
      print('accessToken: ' + tokenReturn.token.accessToken);
    }

    return tokenReturn;
  }

  Future<List<Cidade>> getCidadesDb(Future<Database> db) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('Cidade',
        columns: ['id', 'nome', 'estadosigla', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Cidade> cidades = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cidades.add(Cidade.fromMap(maps[i]));
      }
    }
    return cidades;
  }

  Future<List<Cidade>> getCidadesWebApi(String accessToken) async {
    String bearerAuth = 'Bearer ' + accessToken;
    List<Cidade> cidades = [];

    var r = await get(
        Strings.BASE_URL_WEB_API + Strings.GET_ALL_CIDADES_FROM_WEB_API,
        headers: <String, String>{'authorization': bearerAuth});
    await Future.delayed(new Duration(milliseconds: 1500));

    print(r.body);

    if (r.statusCode == 200) {
      List<dynamic> lista = jsonDecode(r.body);

      if (null != lista && lista.length > 0) {
        for (int i = 0; i < lista.length; i++) {
          cidades.add(Cidade.fromMap(lista[i]));
        }
      }
    }
    return cidades;
  }

  void salvarCidade(Future<Database> db, Cidade cidade) async {
    var dbClient = await db;
    cidade.id = await dbClient.insert('Cidade', cidade.toMap());
    print("saveCidade().cidade.id: " + cidade.id.toString());
  }

  Future<int> atualizarCidade(Future<Database> db, Cidade cidade) async {
    var dbClient = await db;
    return await dbClient.update('Cidade', cidade.toMap(),
        where: 'id = ?', whereArgs: [cidade.id]);
  }
}
