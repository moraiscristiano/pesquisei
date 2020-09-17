import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/pesquisa.quiz.dart';
import 'package:flutter_crud/repositories/pesquisa.list.repository.dart';

class PesquisaListController {
  PesquisaListRepository repository;

  PesquisaListController() {
    repository = new PesquisaListRepository();
  }

  Future<List<Pesquisa>> getPesquisasPorCidadeBairro(int idbairro) async {
    Future<List<Pesquisa>> pesquisas =
        repository.getPesquisasPorCidadeBairro(idbairro);

    return pesquisas;
  }

  Future<List<PerguntaQuiz>> getPerguntasPorPesquisa(int idpesquisa) async {
    List<PerguntaQuiz> perguntas =
        await repository.getPerguntasPorPesquisa(idpesquisa);

    return perguntas;
  }

  
}
