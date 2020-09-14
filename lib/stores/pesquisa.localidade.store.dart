import 'package:mobx/mobx.dart';
part 'pesquisa.localidade.store.g.dart';

class PesquisaLocalidadeStore = _PesquisaLocaliadeStore
    with _$PesquisaLocalidadeStore;

abstract class _PesquisaLocaliadeStore with Store {
  @observable
  int idcidade;

  @observable
  int idbairro;

  @action
  void setPesquisaLocalidade(
    int pIdCidade,
    int pIdBairro,
  ) {
    idcidade = pIdCidade;
    idbairro = pIdBairro;
  }
}
