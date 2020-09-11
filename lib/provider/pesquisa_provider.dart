import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/utils/Strings.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class PesquisaProvider {
  Future<Database> _db;
  Dio _dio;

  PesquisaProvider() {
    BaseOptions options = new BaseOptions(
      baseUrl: Strings.BASE_URL_SERVER,
      connectTimeout: 5000,
    );
    _dio = new Dio(options);

    _db = DBHelper().db;
  }

  Future<Pesquisa> savePesquisa(Pesquisa pesquisa) async {
    var dbPesquisa = await _db;
    pesquisa.id = await dbPesquisa.insert('Pesquisa', pesquisa.toMap());
    print("savePesquisa().pesquisa.id: " + pesquisa.id.toString());
    return pesquisa;
  }

  Future<List<Pesquisa>> getPesquisas() async {
    var dbPesquisa = await _db;
    List<Map> maps = await dbPesquisa.query('Pesquisa',
        columns: ['id', 'nome', 'descricao', 'idbairro', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pesquisa> pesquisas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        pesquisas.add(Pesquisa.fromMap(maps[i]));
      }
    }
    return pesquisas;
  }

  Future<int> deletePesquisa(int id) async {
    var dbPesquisa = await _db;
    return await dbPesquisa
        .delete('Pesquisa', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePesquisa(Pesquisa pesquisa) async {
    var dbPesquisa = await _db;
    return await dbPesquisa.update('Pesquisa', pesquisa.toMap(),
        where: 'id = ?', whereArgs: [pesquisa.id]);
  }

  Future<List<Pesquisa>> getPesquisasFromServer() async {
    List<Pesquisa> lista;

    Response<String> response =
        await _dio.get(Strings.GET_ALL_PESQUISAS_FROM_SERVER);
    if (response != null && response.statusCode == 200) {
      List responseJson = json.decode(response.data);
      lista = responseJson.map((m) => new Pesquisa.fromJson(m)).toList();
    }
    return lista;
  }
}
