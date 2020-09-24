import 'bairro.dart';

class BairroPesquisas {
  int idpesquisa;
  int idbairro;
  int percentual;

  BairroPesquisas({this.idpesquisa, this.idbairro, this.percentual});

  BairroPesquisas.fromJson(Map<String, dynamic> json) {
    idpesquisa = 0;
    idbairro = Bairro.fromJson(json['bairro']).id;
    percentual = json['percentual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idpesquisa'] = this.idpesquisa;
    data['idbairro'] = this.idbairro;
    data['percentual'] = this.percentual;
    return data;
  }
}
