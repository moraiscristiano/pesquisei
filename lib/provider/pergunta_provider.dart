import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_crud/models/pergunta.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class PerguntaProvider {
  Future<Database> _db;
  Dio _dio;

  PerguntaProvider() {
    BaseOptions options = new BaseOptions(
      baseUrl: Strings.BASE_URL_SERVER,
      connectTimeout: 5000,
    );
    _dio = new Dio(options);

    _db = DBHelper().db;
  }

  Future<Pergunta> savePergunta(Pergunta pergunta) async {
    var dbPergunta = await _db;
    pergunta.id = await dbPergunta.insert('Pergunta', pergunta.toMap());
    print("savePergunta().pergunta.id: " + pergunta.id.toString());
    return pergunta;
  }

  Future<List<Pergunta>> getPerguntas() async {
    var dbPergunta = await _db;
    List<Map> maps = await dbPergunta.query('Pergunta',
        columns: ['id', 'idpesquisa', 'descricao', 'ordem', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Pergunta> perguntas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        perguntas.add(Pergunta.fromMap(maps[i]));
      }
    }
    return perguntas;
  }

  Future<int> deletePergunta(int id) async {
    var dbPergunta = await _db;
    return await dbPergunta
        .delete('Pergunta', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePergunta(Pergunta pergunta) async {
    var dbPergunta = await _db;
    return await dbPergunta.update('Pergunta', pergunta.toMap(),
        where: 'id = ?', whereArgs: [pergunta.id]);
  }

  Future<List<Pergunta>> getPerguntasFromServer() async {
    List<Pergunta> lista;

    Response<String> response =
        await _dio.get(Strings.GET_ALL_PERGUNTAS_FROM_SERVER);
    if (response != null && response.statusCode == 200) {
      List responseJson = json.decode(response.data);
      lista = responseJson.map((m) => new Pergunta.fromJson(m)).toList();
    }
    return lista;
  }
}
