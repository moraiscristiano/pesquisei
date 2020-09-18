import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/repositories/cidade.repository.dart';

class CidadeController {
  CidadeRepository repository;

  CidadeController() {
    repository = new CidadeRepository();
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza');
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
