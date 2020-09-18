import 'dart:convert';

class Cidade {
  int id;
  String nome;
  String estadosigla;
  String dataalteracao;

  Cidade({this.id, this.nome, this.estadosigla, this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'estadoSigla': estadosigla,
      'dataalteracao': dataalteracao
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
    estadosigla = map['estadoSigla'];
    dataalteracao = map['dataalteracao'];
  }

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return new Cidade(
        id: json['id'],
        nome: json['nome'].toString(),
        estadosigla: json['estadoSigla'].toString(),
        dataalteracao: json['dataalteracao'].toString());
  }
}
