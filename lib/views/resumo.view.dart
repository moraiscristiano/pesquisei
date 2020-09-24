import 'package:Pesquisei/controllers/pesquisa.controller.dart';
import 'package:Pesquisei/models/resumo.pesquisa.dart';
import 'package:Pesquisei/stores/pesquisa.store.dart';
import 'package:Pesquisei/utils/centered.circular.progress.dart';
import 'package:Pesquisei/utils/centered.message.dart';
import 'package:Pesquisei/views/pergunta.quiz.view.dart';
import 'package:flutter/material.dart';
import 'package:Pesquisei/stores/app.store.dart';
import 'package:provider/provider.dart';

class ResumoView extends StatefulWidget {
  int pesquisaid;
  String nome;
  int cidade;
  int bairro;

  ResumoView(int pesquisaId, String nome, int bairro, int cidade) {
    this.pesquisaid = pesquisaId;
    this.nome = nome;
    this.bairro = bairro;
    this.cidade = cidade;
  }

  @override
  _ResumoViewState createState() =>
      _ResumoViewState(pesquisaid, nome, bairro, cidade);
}

class _ResumoViewState extends State<ResumoView> {
  int pid;
  ResumoPesquisa resumo;
  bool _loading = true;
  PesquisaController _controller;

  List<Widget> _scoreKeeper = [];

  _ResumoViewState(int pesquisaid, String nome, int bairro, int cidade) {
    _controller = new PesquisaController();
    _initialize(pesquisaid, nome, bairro, cidade);
  }

  @override
  void initState() {
    super.initState();
  }

  _initialize(int pesquisaId, String nome, int bairro, int cidade) async {
    Future.delayed(Duration(seconds: 3));
    resumo = await _controller.getResumoPorPesquisaBairro(
        pesquisaId, nome, bairro, cidade);

    pid = pesquisaId;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //var pesquisaStore = Provider.of<PesquisaStore>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Pesquisei'),
        // centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: _buildQuiz(),
        ),
      ),
    );
  }

  _buildQuestion(String question) {
    return Expanded(
      //   flex: 5,
      child: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Text(
              question,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              resumo.descricaoPesquisa,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            Text('Cidade: ' + resumo.cidade),
            Text('Bairro: ' + resumo.bairro),
            Text('Numero de Entrevistados para a Pesquisa: ' +
                resumo.numeroEntrevistadosConfigurado.toString()),
            Text('Total de entrevistados para o bairro: ' +
                resumo.numeroEntrevistadosParaBairro.toString()),
            Text('Quantidade de entrevistados atual: ' +
                resumo.numeroEntrevistadosAtual.toString()),
            SizedBox(
              height: 30,
            ),
            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Próximo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerguntaQuizView(pid),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  _buildResume() {
    return Expanded(
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  _buildQuiz() {
    if (_loading) return CenteredCircularProgress();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildQuestion("Resumo"),
        _buildResume(),
      ],
    );
  }
}
