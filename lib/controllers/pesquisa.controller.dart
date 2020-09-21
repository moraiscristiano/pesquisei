import 'package:Pesquisei/models/pesquisa.dart';
import 'package:Pesquisei/models/pesquisa.quiz.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/pesquisa.repository.dart';

class PesquisaController {
  PesquisaRepository repository;

  PesquisaController() {
    repository = new PesquisaRepository();
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

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Pesquisa...');
    while (processado == false && tentativas <= 3) {
      retorno = await repository.sincronizar(pUser, pPass);

      if (retorno.statuscode == 200) {
        processado = true;
      } else {
        tentativas = tentativas + 1;
      }
    }

    return retorno;
  }
}
