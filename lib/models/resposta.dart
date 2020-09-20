class Resposta {
  int id;
  int perguntaId;
  String descricao;
  int ordem;
  String alteracao;

  Resposta(
      {this.id,
      this.perguntaId,
      this.descricao,
      this.ordem,
      this.alteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'perguntaId': perguntaId,
      'descricao': descricao,
      'ordem': ordem,
      'alteracao': alteracao,
    };

    return map;
  }

  Resposta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    perguntaId = map['perguntaId'];
    descricao = map['descricao'];
    ordem = map['ordem'];
    alteracao = map['alteracao'];
  }

  factory Resposta.fromJson(Map<String, dynamic> json) {
    return Resposta(
        id: json['id'],
        perguntaId: json['perguntaId'],
        descricao: json['descricao'].toString(),
        ordem: json['ordem'],
        alteracao: json['alteracao'].toString());
  }
}
