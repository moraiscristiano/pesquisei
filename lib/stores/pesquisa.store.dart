import 'package:Pesquisei/controllers/pesquisa.controller.dart';
import 'package:Pesquisei/models/pesquisa.quiz.dart';
import 'package:Pesquisei/models/resumo.pesquisa.dart';
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

  @observable
  ResumoPesquisa resumo;

  @action
  Future<void> setPerguntas(
    int pId,
  ) async {
    PesquisaController _controller = new PesquisaController();

    perguntas = await _controller.getPerguntasPorPesquisa(pId);
  }

  @action
  Future<void> setResumo(
      int pId, String pNome, int pIdBairro, int pIdCidade) async {
    PesquisaController _controller = new PesquisaController();

    resumo = await _controller.getResumoPorPesquisaBairro(
        pId, pNome, pIdBairro, pIdCidade);
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

    setResumo(pId, pNome, pIdBairro, pIdCidade);
  }
}
