import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/models/pergunta.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/models/resposta.dart';
import 'package:flutter_crud/provider/bairro_provider.dart';
import 'package:flutter_crud/provider/cidade_provider.dart';
import 'package:flutter_crud/provider/pergunta_provider.dart';
import 'package:flutter_crud/provider/pesquisa_provider.dart';
import 'package:flutter_crud/provider/resposta_provider.dart';
import 'package:intl/intl.dart';

class Sincronize {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  CidadeProvider cidadeProvider;
  BairroProvider bairroProvider;
  PesquisaProvider pesquisaProvider;
  PerguntaProvider perguntaProvider;
  RespostaProvider respostaProvider;

  Sincronize() {
    cidadeProvider = new CidadeProvider();
    bairroProvider = new BairroProvider();
    pesquisaProvider = new PesquisaProvider();
    perguntaProvider = new PerguntaProvider();
    respostaProvider = new RespostaProvider();
  }

  Future<bool> Sincronizar() async {
    bool synccidades = await this.SincronizarCidades();
    bool syncBairros = await this.SincronizarBairros();
    bool syncPesquisas = await this.SincronizarPesquisas();
    bool syncPerguntas = await this.SincronizarPerguntas();
    bool syncRespostas = await this.SincronizarRespostas();

    if (synccidades &&
        syncBairros &&
        syncPesquisas &&
        syncPerguntas &&
        syncRespostas) {
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

  Future<bool> SincronizarPesquisas() async {
    List<Pesquisa> pesquisasApi = new List<Pesquisa>();
    List<Pesquisa> pesquisasDb = new List<Pesquisa>();

    pesquisasApi = await pesquisaProvider.getPesquisasFromServer();

    if (pesquisasApi == null || pesquisasApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    pesquisasDb = await pesquisaProvider.getPesquisas();

    for (var itemApi in pesquisasApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in pesquisasDb) {
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
          pesquisaProvider.updatePesquisa(itemApi);
        }
      } else {
        // add
        pesquisaProvider.savePesquisa(itemApi);
      }
    }

    return true;
  }

  Future<bool> SincronizarPerguntas() async {
    List<Pergunta> perguntasApi = new List<Pergunta>();
    List<Pergunta> perguntasDb = new List<Pergunta>();

    perguntasApi = await perguntaProvider.getPerguntasFromServer();

    if (perguntasApi == null || perguntasApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    perguntasDb = await perguntaProvider.getPerguntas();

    for (var itemApi in perguntasApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in perguntasDb) {
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
          perguntaProvider.updatePergunta(itemApi);
        }
      } else {
        // add
        perguntaProvider.savePergunta(itemApi);
      }
    }

    return true;
  }

  Future<bool> SincronizarRespostas() async {
    List<Resposta> respostasApi = new List<Resposta>();
    List<Resposta> respostasDb = new List<Resposta>();

    respostasApi = await respostaProvider.getRespostasFromServer();

    if (respostasApi == null || respostasApi.length == 0) {
      return true; // Não há registros para sincronizar.
    }

    respostasDb = await respostaProvider.getRespostas();

    for (var itemApi in respostasApi) {
      bool itemParaAtualizar = false;
      bool itemExist = false;
      for (var itemDb in respostasDb) {
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
          respostaProvider.updateResposta(itemApi);
        }
      } else {
        // add
        respostaProvider.saveResposta(itemApi);
      }
    }

    return true;
  }
}
