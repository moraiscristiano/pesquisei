import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/provider/cidade_provider.dart';
import 'package:intl/intl.dart';

class Sincronize {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  CidadeProvider cidadeProvider;

  Sincronize() {
    cidadeProvider = new CidadeProvider();
  }

  Future<bool> SincronizarCidades() async {
    print("SincronizarCidades()");

    List<Cidade> cidadesApi = new List<Cidade>();
    List<Cidade> cidadesDb = new List<Cidade>();

    cidadesApi = await cidadeProvider.getCidadesFromServer();

    print("SincronizarCidades().cidadesapi.lenght");

    if (cidadesApi == null || cidadesApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    cidadesDb = await cidadeProvider.getCidades();

    print("SincronizarCidades().cidadesdb.lenght");

    for (var itemApi in cidadesApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in cidadesDb) {
        if (itemApi.id == itemDb.id) {
          itemExist = true;

          print("itemApi" + itemApi.dataalteracao);
          print("itemDb" + itemDb.dataalteracao);
        

          if (itemApi.dataalteracao?.isEmpty ||
               itemDb.dataalteracao?.isEmpty ||
              DateTime.parse(itemApi.dataalteracao)
                  .isAfter(DateTime.parse(itemDb.dataalteracao))) {
            itemParaAtualizar = true;
          }
        }
      }

      if (itemExist) {
        if (itemParaAtualizar) {
          // Atualizar
          print("SincronizarCidades().update");
          cidadeProvider.updateCidade(itemApi);
        }
      } else {
        // add
        print("SincronizarCidades().add");
        cidadeProvider.saveCidade(itemApi);
      }
    }

    return true;
  }
}
