import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/utils/Strings.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class CidadeProvider {
  Future<Database> _db;
  Dio _dio;

  CidadeProvider() {
    BaseOptions options = new BaseOptions(
      baseUrl: Strings.BASE_URL_SERVER,
      connectTimeout: 5000,
    );
    _dio = new Dio(options);

    _db = DBHelper().db;
  }

  Future<Cidade> saveCidade(Cidade cidade) async {
    var dbClient = await _db;
    cidade.id = await dbClient.insert('Cidade', cidade.toMap());
    print("saveCidade().cidade.id: " + cidade.id.toString());
    return cidade;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Cidade>> getCidades() async {
    var dbClient = await _db;
    List<Map> maps =
        await dbClient.query('Cidade', columns: ['id', 'nome', 'estadosigla','dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Cidade> cidades = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cidades.add(Cidade.fromMap(maps[i]));
      }
    }
    return cidades;
  }

  Future<int> deleteCidade(int id) async {
    var dbClient = await _db;
    return await dbClient.delete('Cidade', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCidade(Cidade cidade) async {
    var dbClient = await _db;
    return await dbClient.update('Cidade', cidade.toMap(),
        where: 'id = ?', whereArgs: [cidade.id]);
  }

  Future<List<Cidade>> getCidadesFromServer() async {
    List<Cidade> lista;

    Response<String> response =
        await _dio.get(Strings.GET_ALL_CIDADES_FROM_SERVER);
    if (response != null && response.statusCode == 200) {
      List responseJson = json.decode(response.data);
      lista = responseJson.map((m) => new Cidade.fromJson(m)).toList();
    }
    print(lista[0]);
    return lista;
  }
}
