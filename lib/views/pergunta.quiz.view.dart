import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/quiz.controller.dart';
import 'package:flutter_crud/stores/pesquisa.store.dart';
import 'package:flutter_crud/utils/centered.circular.progress.dart';
import 'package:flutter_crud/utils/centered.message.dart';
import 'package:flutter_crud/utils/finish.dialog.dart';
import 'package:flutter_crud/utils/result.dialog.dart';
import 'package:provider/provider.dart';

class PerguntaQuizView extends StatefulWidget {
  int pesquisaid;

  PerguntaQuizView(int pesquisa) {
    pesquisaid = pesquisa;
  }

  @override
  _PerguntaQuizViewState createState() => _PerguntaQuizViewState(pesquisaid);
}

class _PerguntaQuizViewState extends State<PerguntaQuizView> {
  int pid;
  bool _loading = true;
  QuizController _controller;

  List<Widget> _scoreKeeper = [];

  _PerguntaQuizViewState(pesquisa) {
    _controller = QuizController(pesquisa);
    _initialize(pesquisa);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initialize(int c) async {
    this._controller = new QuizController(c);
    await _controller.initialize();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pesquisaStore = Provider.of<PesquisaStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
            '( ${null == _scoreKeeper.length ? 0 : _scoreKeeper.length}/${null == pesquisaStore.perguntas ? 0 : pesquisaStore.perguntas.length} )'),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CenteredCircularProgress();

    if (_controller.questionsNumber == 0)
      return CenteredMessage(
        'Sem questões',
        icon: Icons.warning,
      );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildQuestion(_controller.getQuestion()),
        for (var i in _controller.getAnswers()) _buildAnswerButton(i.descricao),
        _buildScoreKeeper(),
      ],
    );
  }

  _buildQuestion(String question) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(String answer) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          child: Container(
            padding: EdgeInsets.all(4.0),
            color: Colors.blue,
            child: Center(
              child: AutoSizeText(
                answer,
                maxLines: 2,
                minFontSize: 10.0,
                maxFontSize: 32.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          onTap: () {
            bool correct = _controller.correctAnswer(answer);

            ResultDialog.show(
              context,
              question: _controller.question,
              correct: correct,
              onNext: () {
                setState(() {
                  _scoreKeeper.add(
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  );

                  if (_scoreKeeper.length < _controller.questionsNumber) {
                    _controller.nextQuestion();
                  } else {
                    FinishDialog.show(context,
                        hitNumber: _controller.hitNumber,
                        questionNumber: _controller.questionsNumber);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }

  _buildScoreKeeper() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _scoreKeeper,
      ),
    );
  }
}
