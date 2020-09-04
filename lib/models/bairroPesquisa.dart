import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/pergunta.dart';
import 'package:flutter_crud/models/pesquisa.dart';

class BairroPesquisa {
  final Bairro bairro;
  final Pesquisa pesquisa;
  final num percentual;

  const BairroPesquisa({
    this.bairro,
    this.pesquisa,
    this.percentual
  });
}
