import 'package:flutter_crud/models/pergunta.dart';

class Resposta {
  final int id;
  final Pergunta pergunta; 
  final String descricao;
  final int ordem;

  const Resposta({
    this.id,
    this.pergunta,
    this.descricao,
    this.ordem
  });
}