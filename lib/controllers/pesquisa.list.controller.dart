import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/repositories/pesquisa.list.repository.dart';

class PesquisaListController {
  PesquisaListRepository repository;

  PesquisaListController() {
    repository = new PesquisaListRepository();
  }

  Future<List<Pesquisa>> getPesquisasPorCidadeBairro(
      int idbairro) async {


        print("idbairro que entrou =  $idbairro");
    Future<List<Pesquisa>> pesquisas =
         repository.getPesquisasPorCidadeBairro( idbairro);


    return pesquisas;
  }
}
