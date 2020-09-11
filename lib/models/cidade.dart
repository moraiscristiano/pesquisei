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
      'estadosigla': estadosigla,
      'dataalteracao': dataalteracao
    };

    return map;
  }

  Cidade.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    estadosigla = map['estadosigla'];
    dataalteracao = map['dataalteracao'];
  }

  factory Cidade.fromJson(Map<String, dynamic> json) {
    return new Cidade(
        id: json['id'],
        nome: json['nome'].toString(),
        estadosigla: json['estadosigla'].toString(),
        dataalteracao: json['dataalteracao'].toString());
  }
}
