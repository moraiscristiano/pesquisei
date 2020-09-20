class Pergunta {
  int id;
  int pesquisaId;
  String descricao;
  int ordem;
  String alteracao;

  Pergunta(
      {this.id,
      this.pesquisaId,
      this.descricao,
      this.ordem,
      this.alteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'pesquisaId': pesquisaId,
      'descricao': descricao,
      'ordem': ordem,
      'alteracao': alteracao,
    };

    return map;
  }

  Pergunta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    pesquisaId = map['pesquisaId'];
    descricao = map['descricao'];
    ordem = map['ordem'];
    alteracao = map['alteracao'];
  }

  factory Pergunta.fromJson(Map<String, dynamic> json) {
    return Pergunta(
        id: json['id'],
        pesquisaId: json['pesquisaId'],
        descricao: json['descricao'].toString(),
        ordem: json['ordem'],
        alteracao: json['alteracao'].toString());
  }
}
