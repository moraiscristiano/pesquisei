import 'dart:convert';

class Cidade {
  int id;
  String nome;
  String estadoSigla;
  String alteracao;

  Cidade({this.id, this.nome, this.estadoSigla, this.alteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'estadoSigla': estadoSigla,
      'alteracao': alteracao
    };

    return map;
  }

  Future<List<String>> _mapTodoData(List<dynamic> todos) async {
    try {
      var res = todos.map((v) => json.encode(v)).toList();
      return res;
    } catch (err) {
      // Just in case
      return [];
    }
  }

  Cidade.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    estadoSigla = map['estadoSigla'];
    alteracao = map['alteracao'];
  }

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return new Cidade(
        id: json['id'],
        nome: json['nome'].toString(),
        estadoSigla: json['estadoSigla'].toString(),
        alteracao: json['alteracao'].toString());
  }
}
