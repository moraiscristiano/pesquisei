import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/pergunta.dart';

class Pesquisa { 
  final int id;
  final String nome;
  final String descricao;
  final List<Pergunta> perguntas;
  final Bairro bairro;// Adicionado para o app
  
  const Pesquisa(
      {this.id,
      this.nome,
      this.descricao,
      this.perguntas,
      this.bairro});
}
