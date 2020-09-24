import 'dart:math';

import 'package:Pesquisei/models/pesquisa.quiz.dart';
import 'package:Pesquisei/models/resposta.dart';
import 'package:Pesquisei/repositories/pesquisa.repository.dart';

class QuizController {
  PesquisaRepository repository;
  int idpesquisa;

  QuizController(int pesquisa) {
    repository = new PesquisaRepository();
    idpesquisa = pesquisa;
  }

  List<PerguntaQuiz> _questionBank;

 // Random _random = new Random();
  int questionIndex = 0;
 // bool _shiftAnswer;
 // int hitNumber = 0;

  int get questionsNumber => _questionBank.length ?? 0;
  PerguntaQuiz get question => _questionBank[questionIndex];

  Future<void> initialize() async {
    questionIndex = 0;
   // hitNumber = 0;
    _questionBank = await repository.getPerguntasPorPesquisa(idpesquisa);
    print('Number of questions: ${_questionBank.length}');
  //  _questionBank.shuffle();
  //  _shiftAnswer = _random.nextBool();
  }

  void nextQuestion() {
    //questionIndex = questionIndex++;
    questionIndex = ++questionIndex;// % _questionBank.length;
   // _shiftAnswer = _random.nextBool();
  }

  String getQuestion() {
    return _questionBank[questionIndex].descricao;
  }

  List<Resposta> getAnswers() {
    return _questionBank[questionIndex].opcoes;
  }

  Future<List<PerguntaQuiz>> getPerguntasPorPesquisa(int idpesquisa) async {
    print("idpesquisa que entrou =  $idpesquisa");

    List<PerguntaQuiz> perguntas =
        await repository.getPerguntasPorPesquisa(idpesquisa);

    return perguntas;
  }
}
