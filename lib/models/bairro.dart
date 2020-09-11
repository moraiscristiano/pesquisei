class Bairro {
  int id;
  int idcidade;
  String nome;
  String dataalteracao;

  Bairro({this.id, this.idcidade, this.nome, this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idcidade': idcidade,
      'nome': nome,
      'dataalteracao': dataalteracao,
    };

    return map;
  }

  Bairro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idcidade = map['idcidade'];
    nome = map['nome'];
    dataalteracao = map['dataalteracao'];
  }

  factory Bairro.fromJson(Map<String, dynamic> json) {
    return Bairro(
        id: json['id'],
        idcidade: json['idcidade'],
        nome: json['nome'].toString(),
        dataalteracao: json['dataalteracao']);
  }
}
