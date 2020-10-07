import 'dart:io';

import 'package:Pesquisei/models/retorno.sincronizacao.dart';
import 'package:Pesquisei/models/token.return.dart';
import 'package:Pesquisei/repositories/cidade.repository.dart';
import 'package:Pesquisei/view-models/sincronize.viewmodel.dart';

class CidadeController {
  CidadeRepository repository;

  CidadeController() {
    repository = new CidadeRepository();
  }

  Future<RetornoSincronizacao> sincronizar(String pUser, String pPass) async {
    RetornoSincronizacao retornoSync = new RetornoSincronizacao();

    bool processado = false;
    int tentativas = 0;
    print('sincroniza Cidade...');

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
