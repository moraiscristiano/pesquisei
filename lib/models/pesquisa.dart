import 'bairro.pesquisa.dart';

class Pesquisa {
  int id;
  String nome;
  String descricao;
  String dataCricao;
  int numeroEntrevistados;
  String alteracao;
  int idbairro;

  Pesquisa({
    this.id,
    this.nome,
    this.descricao,
    this.dataCricao,
    this.numeroEntrevistados,
    this.alteracao,
    this.idbairro,
  });


  Pesquisa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    dataCricao = json['dataCricao'];
    numeroEntrevistados = json['numeroEntrevistados'];
    alteracao = json['alteracao'];
    idbairro = 0;
  }

  Pesquisa.fromJsonDb(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    dataCricao = json['dataCricao'];
    numeroEntrevistados = json['numeroEntrevistados'];
    alteracao = json['alteracao'];
    idbairro = json['idbairro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['dataCricao'] = this.dataCricao;
    data['numeroEntrevistados'] = this.numeroEntrevistados;
    data['alteracao'] = this.alteracao;
    data['idbairro'] = this.idbairro;

    return data;
  }
}
