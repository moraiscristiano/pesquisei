import 'package:Pesquisei/models/resposta.escolhida.dart';

class RespostaEscolhidaList {
  List<RespostaEscolhida> respostas;

  RespostaEscolhidaList(this.respostas);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resultado': respostas,
      };
}
