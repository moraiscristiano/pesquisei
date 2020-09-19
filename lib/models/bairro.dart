import 'cidade.dart';

class Bairro {
  int id;
  int idcidade;
  String nome;
  String alteracao;

  Bairro({this.id, this.idcidade, this.nome, this.alteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idcidade': idcidade,
      'nome': nome,
      'alteracao': alteracao,
    };

    return map;
  }

  Bairro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idcidade = Cidade.fromJson(map['cidade']).id;
    nome = map['nome'];
    alteracao = map['alteracao'];
  }

   Bairro.fromMapDb(Map<String, dynamic> map) {
    id = map['id'];
    idcidade = map['idcidade'];
    nome = map['nome'];
    alteracao = map['alteracao'];
  }


  factory Bairro.fromJson(Map<String, dynamic> json) {
    return Bairro(
        id: json['id'],
        idcidade: Cidade.fromJson(json['cidade']).id,
        nome: json['nome'].toString(),
        alteracao: json['alteracao']);
  }
}
