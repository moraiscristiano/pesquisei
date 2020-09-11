class Resposta {
  int id;
  int idpergunta;
  String descricao;
  int ordem;
  String dataalteracao;

  Resposta(
      {this.id,
      this.idpergunta,
      this.descricao,
      this.ordem,
      this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idpergunta': idpergunta,
      'descricao': descricao,
      'ordem': ordem,
      'dataalteracao': dataalteracao,
    };

    return map;
  }

  Resposta.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idpergunta = map['idpergunta'];
    descricao = map['descricao'];
    ordem = map['ordem'];
    dataalteracao = map['dataalteracao'];
  }

  factory Resposta.fromJson(Map<String, dynamic> json) {
    return Resposta(
        id: json['id'],
        idpergunta: json['idpergunta'],
        descricao: json['descricao'].toString(),
        ordem: json['ordem'],
        dataalteracao: json['dataalteracao'].toString());
  }
}
