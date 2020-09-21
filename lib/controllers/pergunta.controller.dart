import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/cidade.repository.dart';
import 'package:Pesquisei/repositories/pergunta.repository.dart';

class PerguntaController {
  PerguntaRepository repository;

  PerguntaController() {
    repository = new PerguntaRepository();
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Pergunta...');
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
