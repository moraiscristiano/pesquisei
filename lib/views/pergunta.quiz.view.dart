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
          child: _buildQuiz(
              pesquisaLocalidadeStore.idbairro,
              pesquisaStore.resumo.numeroEntrevistadosAtual,
              pesquisaStore.resumo.numeroEntrevistadosParaBairro,
              pesquisaStore.resumo.bairro),
        ),
      ),
    );
  }

  _buildQuiz(int bairro, int qtd, int total, String nomeBairro) {
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
        Text(nomeBairro + ': ' + qtd.toString() + '/' + total.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, color: Colors.black)),
        _buildQuestion(_controller.getQuestion()),
        Container(
          height: 350,
          //   width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (var i in _controller.getAnswers())
                  _buildAnswerButton(i.id, bairro, i.descricao, i.perguntaId),
              ],
            ),
          ),
        ),
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
              fontSize: 28,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  _buildAnswerButton(int idResposta, int bairro, String answer, int pergunta) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(6.0),
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
            resp.idPergunta = pergunta;
            resp.idResposta = idResposta;
            print(bairro);
            print(pergunta);
            print(idResposta);

            if (_controller.questionIndex == 0 &&
                answer.toUpperCase().trim() == "BRANCO") {
              new RespostaEscolhidaProvider().saveRespostaEscolhida(resp);

              for (int k = 1; k < _controller.questionsNumber; k++) {
                _controller.nextQuestion();
                var opcoes = _controller.getAnswers();

                for (var item in opcoes) {
                  if (item.descricao.toUpperCase().trim() == "BRANCO") {
                    RespostaEscolhida resp1 = new RespostaEscolhida();
                    resp1.idBairro = bairro;
                    resp1.idPergunta = item.perguntaId;
                    resp1.idResposta = item.id;
                    print("BRANCO" + k.toString());
                    print(bairro);
                    print(item.perguntaId);
                    print(item.id);

                    new RespostaEscolhidaProvider().saveRespostaEscolhida(resp1);

                    setState(() {
                      _scoreKeeper.add(
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      );
                    });
                  }
                }
              }

              FinishDialog.show(context,
                  //  hitNumber: _controller.hitNumber,
                  questionNumber: _controller.questionsNumber);
            } else {
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
                          //  hitNumber: _controller.hitNumber,
                          questionNumber: _controller.questionsNumber);
                    }
                  });
                },
              );
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
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
