import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/repositories/resposta.escolhia.repository.dart';
import 'package:Pesquisei/view-models/sincronize.viewmodel.dart';

class RespostaEscolhidaController {
  RespostaEscolhidaRepository repository;

  RespostaEscolhidaController() {
    repository = new RespostaEscolhidaRepository();
  }

  Future<RetornoSincronizacao> deleteWherePerguntaOrBairroNotExistInDb(
      SincronizeViewModel vm) async {

    RetornoSincronizacao retornoSync = new RetornoSincronizacao();
    try {
      print('sincroniza deleteWherePesquisaOrBairroNotExistInDb...');
      retornoSync = await repository.deleteWherePerguntaOrBairroNotExistInDb();
    } catch (error) {
      retornoSync.mensagem = error.toString();
      retornoSync.erros = 1;
      retornoSync.registrosSincronizados = 0;
      print(error);
    } finally {
      vm.busy = false;
    }

    return retornoSync;
  }

  Future<RetornoSincronizacao> sincronizar(
      String pUser, String pPass, SincronizeViewModel vm) async {

    RetornoSincronizacao retornoSync = new RetornoSincronizacao();

    bool processado = false;
    int tentativas = 0;

    try {
      print('sincroniza Respostas Escolhidas...');
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
