import 'cidade.dart';

class Bairro {
  int id;
  Cidade cidade;
  String nome;

  Bairro({this.id, this.cidade, this.nome});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'cidade': cidade,
      'nome': nome,
    };

    return map;
  }

  Bairro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cidade = map['cidade'];
    nome = map['nome'];
  }
}
