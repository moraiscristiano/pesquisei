import 'package:flutter_crud/dto/cidadeDto.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/provider/cidade_provider.dart';

class Sincronize {
  CidadeProvider cidadeProvider;

  Sincronize() {
    cidadeProvider = new CidadeProvider();
  }

  bool SincronizarCidades() {
    List<CidadeDTO> cidadesServerDTO = new List<CidadeDTO>();
    List<Cidade> cidadesServer  = new List<Cidade>();       
    List<Cidade> cidades = new List<Cidade>();

    print("Entrou no sicronize");

    Future<List<CidadeDTO>> retornoFromServer =
        cidadeProvider.getCidadesFromServer();

    retornoFromServer.then((value) {
      if (value != null) value.forEach((item) => cidadesServerDTO.add(item));
    });

    print("retornoFromServer: " + retornoFromServer.toString());
    print("cidadesServerDTO: " + cidadesServerDTO.toString());

    
    
    cidadesServerDTO.forEach((element) {
      cidadesServer.add(CidadeDTO().DtoToModel(element));
    });

    /*
    cidadesFromServer.then((value) {
      if (value != null) value.forEach((item) => cidadesServer.add(item));
    });
    */
    print("cidadesServer" + cidadesServer.toString());

    if (cidadesServer == null || cidadesServer.length == 0) {
      return true;
    }

    print("cidadesServer {0}" + cidadesServer.length.toString());

    Future<List<Cidade>>  cidadesSqlite = cidadeProvider.getCidades();
cidadesSqlite.then((value) {
      if (value != null) value.forEach((item) => cidades.add(item));
    });


    cidadesServer.removeWhere((item) => cidades.contains(item));

    cidadesServer.forEach((element) {
      print("ADD CIDADE" + element.nome);
      CidadeProvider().saveCidade(element);
    });

    return true;
  }
}
