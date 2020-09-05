import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/resposta.dart';

class Pergunta {  


  final int id;
  final Pesquisa pesquisa;
  final String descricao;
  final int ordem;
  final List<Resposta> respostas; 

  const Pergunta({
    this.id,
    this.pesquisa,
    this.descricao,
    this.ordem,
   this.respostas
  });
}