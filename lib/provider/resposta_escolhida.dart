import 'package:dio/dio.dart';
import 'package:flutter_crud/models/resposta.escolhida.dart';
import 'package:flutter_crud/utils/strings.dart';
import 'package:flutter_crud/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class RespostaEscolhidaProvider {
  Future<Database> _db;
  Dio _dio;

  RespostaEscolhidaProvider() {
    BaseOptions options = new BaseOptions(
      baseUrl: Strings.BASE_URL_SERVER,
      connectTimeout: 5000,
    );
    _dio = new Dio(options);

    _db = DBHelper().db;
  }

  Future<RespostaEscolhida> saveRespostaEscolhida(
      RespostaEscolhida resposta) async {
    resposta.dataalteracao =
        DateTime.parse(new DateTime.now().toString()).toString();
    var dbRespostaEscolhida = await _db;
    resposta.id =
        await dbRespostaEscolhida.insert('RespostaEscolhida', resposta.toMap());
    print("saveRespostaEscolhida().id: " + resposta.id.toString());
    return resposta;
  }

  Future<List<RespostaEscolhida>> getRespostasEscolhidas() async {
    var dbRespostaEscolhida = await _db;
    List<Map> maps = await dbRespostaEscolhida.query('RespostaEscolhida',
        columns: [
          'id',
          'idpergunta',
          'idresposta',
          'idbairro',
          'dataalteracao'
        ]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<RespostaEscolhida> resp = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        resp.add(RespostaEscolhida.fromMap(maps[i]));
      }
    }
    return resp;
  }
}
