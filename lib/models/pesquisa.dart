import 'package:flutter_crud/models/bairroPesquisa.dart';
import 'package:flutter_crud/models/pergunta.dart';

class Pesquisa {
  final int id;
  final String nome;
  final String descricao;
  final DateTime dataCriacao;
  final int numeroEntrevistados;
  final List<Pergunta> perguntas;
  final Set<BairroPesquisa> bairroPesquisas;

  const Pesquisa(
      {this.id,
      this.nome,
      this.descricao,
      this.dataCriacao,
      this.numeroEntrevistados,
      this.perguntas,
      this.bairroPesquisas});
}
