import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/cidade.repository.dart';
import 'package:Pesquisei/repositories/pergunta.repository.dart';

class PerguntaController {
  PerguntaRepository repository;

  PerguntaController() {
    repository = new PerguntaRepository();
  }

  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    RetornoSincronizacao retornoSync = new RetornoSincronizacao();

    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Pergunta...');

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
