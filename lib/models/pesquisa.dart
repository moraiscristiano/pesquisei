class Pesquisa {
  int id;
  String nome;
  String descricao;
  int idbairro;
  String dataalteracao;

  Pesquisa(
      {this.id, this.nome, this.descricao, this.idbairro, this.dataalteracao});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'idbairro': idbairro,
      'dataalteracao': dataalteracao,
    };

    return map;
  }

  Pesquisa.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    descricao = map['descricao'];
    idbairro = map['idbairro'];
    dataalteracao = map['dataalteracao'];
  }

  factory Pesquisa.fromJson(Map<String, dynamic> json) {
    return Pesquisa(
        id: json['id'],
        nome: json['nome'].toString(),
        descricao: json['descricao'].toString(),
        idbairro: json['idbairro'],
        dataalteracao: json['dataalteracao'].toString());
  }
}
