import 'bairro.dart';

class BairroPesquisas {
  int idpesquisa;
  int idbairro;
  int quantidade;

  BairroPesquisas({this.idpesquisa, this.idbairro, this.quantidade});

  BairroPesquisas.fromJson(Map<String, dynamic> json) {
    idpesquisa = 0;
    idbairro = Bairro.fromJson(json['bairro']).id;
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpesquisa'] = this.idpesquisa;
    data['idbairro'] = this.idbairro;
    data['quantidade'] = this.quantidade;
    return data;
  }
}
