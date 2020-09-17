import 'dart:math';

import 'package:flutter_crud/models/pesquisa.quiz.dart';
import 'package:flutter_crud/models/resposta.dart';
import 'package:flutter_crud/repositories/pesquisa.list.repository.dart';

class QuizController {
  PesquisaListRepository repository;  
  int idpesquisa ;


   QuizController(int pesquisa) {
    repository = new PesquisaListRepository();
      idpesquisa = pesquisa;
  }


  List<PerguntaQuiz> _questionBank;

  Random _random = new Random();
  int questionIndex = 0;
  bool _shiftAnswer;
  int hitNumber = 0;

  int get questionsNumber => _questionBank.length ?? 0;
  PerguntaQuiz get question => _questionBank[questionIndex];

  Future<void> initialize() async {
    questionIndex = 0;
    hitNumber = 0;
    _questionBank = await repository.getPerguntasPorPesquisa(idpesquisa);
    print('Number of questions: ${_questionBank.length}');
    _questionBank.shuffle();
    _shiftAnswer = _random.nextBool();
  }

  void nextQuestion() {
    questionIndex = ++questionIndex % _questionBank.length;
    _shiftAnswer = _random.nextBool();
  }

  String getQuestion() {
    return _questionBank[questionIndex].descricao;
  }

   List<Resposta> getAnswers() {
    return _questionBank[questionIndex].opcoes;
  }


  String getAnswer1() {
    return _shiftAnswer
        ? _questionBank[questionIndex].opcoes[0].descricao
        : _questionBank[questionIndex].opcoes[1].descricao;
  }

  String getAnswer2() {
    return _shiftAnswer
        ? _questionBank[questionIndex].opcoes[1].descricao
        : _questionBank[questionIndex].opcoes[0].descricao;
  }

  bool correctAnswer(String answer) {
    var correct = _questionBank[questionIndex].descricao == answer;
    hitNumber = hitNumber + (correct ? 1 : 0);
    return correct;
  }

   Future<List<PerguntaQuiz>> getPerguntasPorPesquisa(int idpesquisa)  async {

    print("idpesquisa que entrou =  $idpesquisa");

    List<PerguntaQuiz> perguntas =  await repository.getPerguntasPorPesquisa(idpesquisa);

    return perguntas;
  }

}