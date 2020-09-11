import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/provider/bairro_provider.dart';
import 'package:flutter_crud/provider/cidade_provider.dart';
import 'package:intl/intl.dart';

class Sincronize {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  CidadeProvider cidadeProvider;
  BairroProvider bairroProvider;

  Sincronize() {
    cidadeProvider = new CidadeProvider();
    bairroProvider = new BairroProvider();
  }

  Future<bool> Sincronizar() async {
    bool synccidades = await this.SincronizarCidades();
    bool syncBairros = await this.SincronizarBairros();

    if (synccidades && syncBairros) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> SincronizarCidades() async {
    List<Bairro> bairrosApi = new List<Bairro>();
    List<Bairro> bairrosDb = new List<Bairro>();

    bairrosApi = await bairroProvider.getBairrosFromServer();

    if (bairrosApi == null || bairrosApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    bairrosDb = await bairroProvider.getBairros();

    for (var itemApi in bairrosApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in bairrosDb) {
        if (itemApi.id == itemDb.id) {
          itemExist = true;

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
          bairroProvider.updateBairro(itemApi);
        }
      } else {
        // add
        bairroProvider.saveBairro(itemApi);
      }
    }

    return true;
  }

  Future<bool> SincronizarBairros() async {
    List<Cidade> cidadesApi = new List<Cidade>();
    List<Cidade> cidadesDb = new List<Cidade>();

    cidadesApi = await cidadeProvider.getCidadesFromServer();

    if (cidadesApi == null || cidadesApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    cidadesDb = await cidadeProvider.getCidades();

    for (var itemApi in cidadesApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in cidadesDb) {
        if (itemApi.id == itemDb.id) {
          itemExist = true;

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
          cidadeProvider.updateCidade(itemApi);
        }
      } else {
        // add
        cidadeProvider.saveCidade(itemApi);
      }
    }

    return true;
  }
}
