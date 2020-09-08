class RespostaEscolhida {
  final int id;
  final int perguntaId;
  final int respostaId;
  final int bairroId;
  final DateTime data;

  const RespostaEscolhida({
    this.id,
    this.perguntaId,
    this.respostaId,    
    this.bairroId,
    this.data
  });
}