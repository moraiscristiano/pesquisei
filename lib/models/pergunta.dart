import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/resposta.dart';

class Pergunta {
  int id;
  int idpesquisa;
  String descricao;
  int ordem;
  String dataalteracao;

  Pergunta(
      {this.id,
      this.idpesquisa,
      this.descricao,
      this.ordem,
      this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idpesquisa': idpesquisa,
      'descricao': descricao,
      'ordem': ordem,
      'dataalteracao': dataalteracao,
    };

    return map;
  }

  Pergunta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idpesquisa = map['idpesquisa'];
    descricao = map['descricao'];
    ordem = map['ordem'];
    dataalteracao = map['dataalteracao'];
  }

  factory Pergunta.fromJson(Map<String, dynamic> json) {
    return Pergunta(
        id: json['id'],
        idpesquisa: json['idpesquisa'],
        descricao: json['descricao'].toString(),
        ordem: json['ordem'],
        dataalteracao: json['dataalteracao'].toString());
  }
}
