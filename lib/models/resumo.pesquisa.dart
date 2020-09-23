class ResumoPesquisa {
  String descricaoPesquisa;
  String cidade;
  String bairro;
  int numeroEntrevistadosConfigurado;
  double numeroEntrevistadosParaBairro;
  int numeroEntrevistadosAtual;
  int percentual;

  ResumoPesquisa(
      {this.descricaoPesquisa,
      this.cidade,
      this.bairro,
      this.numeroEntrevistadosConfigurado,
      this.numeroEntrevistadosParaBairro,
      this.numeroEntrevistadosAtual,
      this.percentual});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'descricaoPesquisa': descricaoPesquisa,
      'cidade': cidade,
      'bairro': bairro,
      'numeroEntrevistadosConfigurado': numeroEntrevistadosConfigurado,
      'numeroEntrevistadosParaBairro': numeroEntrevistadosParaBairro,
      'numeroEntrevistadosAtual': numeroEntrevistadosAtual,
      'percentual': percentual
    };

    return map;
  }

  ResumoPesquisa.fromMap(Map<String, dynamic> map) {
    descricaoPesquisa = map['descricaoPesquisa'].toString();
    cidade = map['cidade'].toString();
    bairro = map['bairro'].toString();
    numeroEntrevistadosConfigurado = map['numeroEntrevistadosConfigurado'];
    numeroEntrevistadosParaBairro = map['numeroEntrevistadosParaBairro'];
    numeroEntrevistadosAtual = map['numeroEntrevistadosAtual'];
    percentual = map['percentual'];
  }

  factory ResumoPesquisa.fromJson(Map<String, dynamic> json) {
    return new ResumoPesquisa(
        descricaoPesquisa: json['descricaoPesquisa'].toString(),
        cidade: json['cidade'].toString(),
        bairro: json['bairro'].toString(),
        numeroEntrevistadosConfigurado: json['numeroEntrevistadosConfigurado'],
        numeroEntrevistadosParaBairro: json['numeroEntrevistadosParaBairro'],
        numeroEntrevistadosAtual: json['numeroEntrevistadosAtual'],
        percentual: json['percentual']);
  }
}
