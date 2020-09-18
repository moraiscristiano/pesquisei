import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/repositories/bairro.repository.dart';

class BairroController {
  BairroRepository repository;

  BairroController() {
    repository = new BairroRepository();
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass) async {
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Bairro...');
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
