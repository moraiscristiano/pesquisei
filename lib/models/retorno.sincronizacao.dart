class RetornoSincronizacao {
  int erros;
  int registrosSincronizados;
  String mensagem;

  RetornoSincronizacao({
    this.erros,
    this.registrosSincronizados,
    this.mensagem,
  });

  RetornoSincronizacao.fromJson(Map<String, dynamic> json) {
    erros = json['erros'];
    registrosSincronizados = json['registrosSincronizados'];
    mensagem = json['mensagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['erros'] = this.erros;
    data['registrosSincronizados'] = this.registrosSincronizados;
    data['mensagem'] = this.mensagem;

    return data;
  }
}
