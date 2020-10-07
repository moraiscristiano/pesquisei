import 'package:Pesquisei/models/pesquisa.dart';
import 'package:Pesquisei/models/pesquisa.quiz.dart';
import 'package:Pesquisei/models/resumo.pesquisa.dart';
import 'package:Pesquisei/models/retorno.sincronizacao.dart';
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

  Future<ResumoPesquisa> getResumoPorPesquisaBairro(
      int pId, String pNome, int pIdBairro, int pIdCidade) async {
    ResumoPesquisa resumo = await repository.getResumoPorPesquisaBairro(
        pId, pNome, pIdBairro, pIdCidade);

    return resumo;
  }

  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    RetornoSincronizacao retornoSync = new RetornoSincronizacao();

    try {
      bool processado = false;
      int tentativas = 0;
      print('sincroniza Pesquisa...');
      while (processado == false && tentativas <= 3) {
        retornoSync = await repository.sincronizar(pUser, pPass);

        if (retornoSync.erros > 0) {
          tentativas = tentativas + 1;
        } else {
          processado = true;
        }
      }
    } catch (error) {
      retornoSync.mensagem = error.toString();
      retornoSync.erros = 1;
      retornoSync.registrosSincronizados = 0;
      print(error);
    }
    return retornoSync;
  }
}
