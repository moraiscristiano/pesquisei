class RespostaEscolhida {
  int id;
  int idpergunta;
  int idresposta;
  int idbairro;
  String dataalteracao;

  RespostaEscolhida(
      {this.id, this.idpergunta, this.idresposta, this.idbairro, this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idpergunta': idpergunta,
      'idresposta': idresposta,
      'idbairro': idbairro,
      'dataalteracao': dataalteracao,
    };

    return map;
  }

  RespostaEscolhida.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idpergunta = map['idpergunta'];
    idresposta = map['idresposta'];
    idbairro = map['idbairro'];
    dataalteracao = map['dataalteracao'];
  }

  factory RespostaEscolhida.fromJson(Map<String, dynamic> json) {
    return RespostaEscolhida(
        id: json['id'],
        idpergunta: json['idpergunta'],
        idresposta: json['idresposta'],
        idbairro: json['idbairro'],
        dataalteracao: json['dataalteracao'].toString());
  }
}
