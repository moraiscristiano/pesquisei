import 'package:flutter_crud/models/resposta.escolhida.dart';

class RespostaEscolhidaList {
  List<RespostaEscolhida> respostas;

  RespostaEscolhidaList(this.respostas);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resultado': respostas,
      };
}
