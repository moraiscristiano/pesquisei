import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:Pesquisei/controllers/quiz.controller.dart';
import 'package:Pesquisei/models/resposta.escolhida.dart';
import 'package:Pesquisei/provider/resposta_escolhida.dart';
import 'package:Pesquisei/stores/pesquisa.localidade.store.dart';
import 'package:Pesquisei/stores/pesquisa.store.dart';
import 'package:Pesquisei/utils/centered.circular.progress.dart';
import 'package:Pesquisei/utils/centered.message.dart';
import 'package:Pesquisei/utils/finish.dialog.dart';
import 'package:Pesquisei/utils/result.dialog.dart';
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
   var pesquisaLocalidadeStore = Provider.of<PesquisaLocalidadeStore>(context);
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            '( ${null == _scoreKeeper.length ? 0 : _scoreKeeper.length}/${null == pesquisaStore.perguntas ? 0 : pesquisaStore.perguntas.length} )'),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildQuiz(pesquisaLocalidadeStore.idbairro),
        ),
      ),
    );
  }

  _buildQuiz(int bairro) {
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
        for (var i in _controller.getAnswers())
          _buildAnswerButton(i.id, bairro, i.descricao),
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
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(int idResposta, int bairro, String answer) {
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
            RespostaEscolhida resp = new RespostaEscolhida();
            resp.idBairro = bairro;
            resp.idPergunta = _controller.question.id;
            resp.idResposta = idResposta;
            print(bairro);
            print(_controller.question.id);
            print(idResposta);

            new RespostaEscolhidaProvider().saveRespostaEscolhida(resp);

            ResultDialog.show(
              context,
              resp: answer,
              question: _controller.question,
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
