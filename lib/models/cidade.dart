class Cidade {
  int id;
  String nome;
  String estadoSigla;

  Cidade(this.id, this.nome, this.estadoSigla);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'estadoSigla': estadoSigla,
    };

    return map;
  }

  Cidade.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    estadoSigla = map['estadoSigla'];
  }
}

