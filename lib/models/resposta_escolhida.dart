class RespostaEscolhida {
  int id;
  int idpergunta;
  int idresposta;
  int idbairro;
  String data;

  RespostaEscolhida(
      {this.id, this.idpergunta, this.idresposta, this.idbairro, this.data});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'perguntaId': idpergunta,
      'idresposta': idresposta,
      'idbairro': idbairro,
      'data': data,
    };

    return map;
  }

  RespostaEscolhida.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idpergunta = map['idpergunta'];
    idresposta = map['idresposta'];
    idbairro = map['idbairro'];
    data = map['data'];
  }

  factory RespostaEscolhida.fromJson(Map<String, dynamic> json) {
    return RespostaEscolhida(
        id: json['id'],
        idpergunta: json['idpergunta'],
        idresposta: json['idresposta'],
        idbairro: json['idbairro'],
        data: json['data'].toString());
  }
}
