class Cidade {
  int id;
  String nome;
  String estadosigla;

  Cidade(this.id, this.nome, this.estadosigla);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'estadosigla': estadosigla,
    };

    return map;
  }

  Cidade.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    estadosigla = map['estadosigla'];
  }
}
