import 'cidade.dart';

class Bairro {
  int id;
  Cidade idcidade;
  String nome;

  Bairro({this.id, this.idcidade, this.nome});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idcidade': idcidade,
      'nome': nome,
    };

    return map;
  }

  Bairro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idcidade = map['idcidade'];
    nome = map['nome'];
  }

   factory Bairro.fromJson(Map<String, dynamic> json) {
      return new Bairro(
         id: json['id'],
         idcidade: json['idcidade'],
         nome: json['nome'].toString()
      );
   }

}
