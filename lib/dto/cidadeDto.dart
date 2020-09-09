import 'package:flutter_crud/models/cidade.dart';

class CidadeDTO {
  int id;
  String nome;
  String estadosigla;

  CidadeDTO({this.id, this.nome, this.estadosigla});

  factory CidadeDTO.fromJson(Map<String, dynamic> json) {
    return new CidadeDTO(
        id: json['id'],
        nome: json['nome'].toString(),
        estadosigla: json['estadosigla'].toString());
  }

  Cidade DtoToModel(CidadeDTO dto) {
    return new Cidade(dto.id, dto.nome, dto.estadosigla);
  }
}
