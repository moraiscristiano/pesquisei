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
  }
}
