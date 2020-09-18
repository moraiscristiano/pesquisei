import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_crud/models/resposta.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class RespostaProvider {
  Future<Database> _db;
  Dio _dio;

  RespostaProvider() {
    BaseOptions options = new BaseOptions(
      baseUrl: Strings.BASE_URL_SERVER,
      connectTimeout: 5000,
    );
    _dio = new Dio(options);

    _db = DBHelper().db;
  }

  Future<Resposta> saveResposta(Resposta resposta) async {
    var dbResposta = await _db;
    resposta.id = await dbResposta.insert('Resposta', resposta.toMap());
    print("saveResposta().resposta.id: " + resposta.id.toString());
    return resposta;
  }

  Future<List<Resposta>> getRespostas() async {
    var dbResposta = await _db;
    List<Map> maps = await dbResposta.query('Resposta',
        columns: ['id', 'idpergunta', 'descricao', 'ordem', 'dataalteracao']);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Resposta> respostas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        respostas.add(Resposta.fromMap(maps[i]));
      }
    }
    return respostas;
  }

  Future<int> deleteResposta(int id) async {
    var dbResposta = await _db;
    return await dbResposta
        .delete('Resposta', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateResposta(Resposta resposta) async {
    var dbResposta = await _db;
    return await dbResposta.update('Resposta', resposta.toMap(),
        where: 'id = ?', whereArgs: [resposta.id]);
  }

  Future<List<Resposta>> getRespostasFromServer() async {
    List<Resposta> lista;

    Response<String> response =
        await _dio.get(Strings.GET_ALL_RESPOSTAS_FROM_SERVER);
    if (response != null && response.statusCode == 200) {
      List responseJson = json.decode(response.data);
      lista = responseJson.map((m) => new Resposta.fromJson(m)).toList();
    }
    return lista;
  }
}
