import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/cidade.repository.dart';
import 'package:Pesquisei/view-models/sincronize.viewmodel.dart';

class CidadeController {
  CidadeRepository repository;

  CidadeController() {
    repository = new CidadeRepository();
  }

  Future<TokenReturn> sincronizar(String pUser, String pPass, SincronizeViewModel vm) async {
    vm.busy = true;
    TokenReturn retorno = new TokenReturn();
    bool processado = false;
    int tentativas = 0;
    print('sincroniza Cidade...');
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
