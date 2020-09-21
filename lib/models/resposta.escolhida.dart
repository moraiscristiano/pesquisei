import 'package:intl/intl.dart';

class RespostaEscolhida {
  int id;
  int idPergunta;
  int idResposta;
  int idBairro;
  String alteracao;
  String dataprocessamento;

  RespostaEscolhida(
      {this.id,
      this.idPergunta,
      this.idResposta,
      this.idBairro,
      this.alteracao,
      this.dataprocessamento});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'idPergunta': idPergunta,
      'idResposta': idResposta,
      'idBairro': idBairro,
      'alteracao': alteracao,
      'dataprocessamento': dataprocessamento,
    };

    return map;
  }

  Map<String, dynamic> toMapList() {
    DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");

    var map = <String, dynamic>{
      //   'id': id,
      '"idPergunta"': idPergunta,
      '"idResposta"': idResposta,
      '"idBairro"': idBairro,
      '"momento"': '"' + dateFormat.format(DateTime.parse(alteracao)) + '"'
      //   'dataprocessamento': dataprocessamento,
    };

    return map;
  }

  RespostaEscolhida.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    idPergunta = map['idPergunta'];
    idResposta = map['idResposta'];
    idBairro = map['idBairro'];
    alteracao = map['alteracao'];
    dataprocessamento = map['dataprocessamento'];
  }

  factory RespostaEscolhida.fromJson(Map<String, dynamic> json) {
    return RespostaEscolhida(
        id: json['id'],
        idPergunta: json['idPergunta'],
        idResposta: json['idResposta'],
        idBairro: json['idBairro'],
        alteracao: json['alteracao'].toString(),
        dataprocessamento: json['dataprocessamento'].toString());
  }
}
