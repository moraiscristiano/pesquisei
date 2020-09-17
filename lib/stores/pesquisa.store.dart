import 'package:flutter_crud/controllers/pesquisa.list.controller.dart';
import 'package:flutter_crud/models/pesquisa.quiz.dart';
import 'package:flutter_crud/models/resposta.dart';
import 'package:mobx/mobx.dart';
part 'pesquisa.store.g.dart';

class PesquisaStore = _PesquisaStore with _$PesquisaStore;

abstract class _PesquisaStore with Store {
  @observable
  int id;

  @observable
  String nome = "";

  @observable
  String descricao = "";

  @observable
  int idbairro;

  @observable
  int idcidade;

  @observable
  List<PerguntaQuiz> perguntas;

  @action
  Future<void> setPerguntas(
    int pId,
  ) async {
    PesquisaListController _controller = new PesquisaListController();

    print('veio aqui');
    perguntas = await _controller.getPerguntasPorPesquisa(pId);
    
  }

  @action
  void setPesquisa(
    int pId,
    String pNome,
    String pDescricao,
    int pIdBairro,
    int pIdCidade,
  ) {
    id = pId;
    nome = pNome;
    descricao = pDescricao;
    idbairro = pIdBairro;
    idcidade = pIdCidade;

        setPerguntas(pId);

  }
}
