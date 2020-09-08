class Cidade {
  int id;
  String nome;
  String estado_sigla;

  Cidade(this.id, this.nome, this.estado_sigla);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'estado_sigla': estado_sigla,
    };

    return map;
  }

  Cidade.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    estado_sigla = map['estado_sigla'];
  }
}

