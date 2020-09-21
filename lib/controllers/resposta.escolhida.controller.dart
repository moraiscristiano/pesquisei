import 'package:flutter_crud/models/token.return.dart';
import 'package:flutter_crud/repositories/cidade.repository.dart';
import 'package:flutter_crud/repositories/resposta.escolhia.repository.dart';
import 'package:flutter_crud/view-models/sincronize.viewmodel.dart';

class RespostaEscolhidaController {
  RespostaEscolhidaRepository repository;

  RespostaEscolhidaController() {
    repository = new RespostaEscolhidaRepository();
  }

  Future<TokenReturn> sincronizar(
      String pUser, String pPass, SincronizeViewModel vm) async {
    vm.busy = true;

    TokenReturn retorno = new TokenReturn();
    try {
      bool processado = false;
      int tentativas = 0;
      print('sincroniza Respostas Escolhidas...');
      while (processado == false && tentativas <= 3) {
        retorno = await repository.sincronizar(pUser, pPass);

        if (retorno.statuscode == 200) {
          processado = true;
        } else {
          tentativas = tentativas + 1;
        }
      }
    } catch (error) {
      print(error);
    } finally {
      vm.busy = false;
    }

    return retorno;
  }
}
