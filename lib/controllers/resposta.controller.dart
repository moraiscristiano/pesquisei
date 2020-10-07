import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/repositories/resposta.repository.dart';

class RespostaController {
  RespostaRepository repository;

  RespostaController() {
    repository = new RespostaRepository();
  }

  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Resposta...');
    RetornoSincronizacao retornoSync = new RetornoSincronizacao();

    try {
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
