import 'package:dio/dio.dart';
import 'package:flutter_crud/models/resposta.dart';

class PerguntaQuiz {
  int id;
  String nome;
  String descricao;
  int idbairro;
  List<Resposta> opcoes;

  PerguntaQuiz({
    this.id,
    this.nome,
    this.descricao,
    this.idbairro,
    this.opcoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'idbairro': idbairro,
      'opcoes': opcoes,
    };
  }

  static PerguntaQuiz fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PerguntaQuiz(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      idbairro: map['idbairro'],
      opcoes: map['opcoes'],
    );
  }
}
