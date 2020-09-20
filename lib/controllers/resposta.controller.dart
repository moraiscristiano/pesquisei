import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/repositories/resposta.repository.dart';
import 'package:flutter_crud/view-models/sincronize.viewmodel.dart';

class RespostaController {
  RespostaRepository repository;

  RespostaController() {
    repository = new RespostaRepository();
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass, SincronizeViewModel vm) async {
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Resposta...');
    while (processado == false && tentativas <= 3) {
      retorno = await repository.sincronizar(pUser, pPass);

      if (retorno.statuscode == 200) {
        processado = true;
      } else {
        tentativas = tentativas + 1;
      }
    }

    vm.busy = false;


    return retorno;
  }
}
