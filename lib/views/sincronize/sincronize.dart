import 'dart:io';

import 'package:Pesquisei/controllers/connectivity.controller.dart';
import 'package:flutter/material.dart';
import 'package:Pesquisei/controllers/bairro.controller%20.dart';
import 'package:Pesquisei/controllers/cidade.controller.dart';
import 'package:Pesquisei/controllers/pergunta.controller.dart';
import 'package:Pesquisei/controllers/pesquisa.controller.dart';
import 'package:Pesquisei/controllers/resposta.controller.dart';
import 'package:Pesquisei/controllers/resposta.escolhida.controller.dart';
import 'package:Pesquisei/stores/app.store.dart';
import 'package:Pesquisei/view-models/sincronize.viewmodel.dart';
import 'package:provider/provider.dart';

class SincronizePage extends StatefulWidget {
  SincronizePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SincronizePageState createState() => _SincronizePageState();
}

class _SincronizePageState extends State<SincronizePage> {
  final _cidadeController = new CidadeController();
  final _bairroController = new BairroController();
  final _pesquisaController = new PesquisaController();
  final _perguntaController = new PerguntaController();
  final _respostaController = new RespostaController();
  final _respostaEscolhidaController = new RespostaEscolhidaController();
  final _connectivityController = new ConnectivityController();

  var model = new SincronizeViewModel();

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<AppStore>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sincronizar\n',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            model.busy
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                : FlatButton(
                    onPressed: () {
                      // new SincronizeController().Sincronizar();
                      print('name: ' + store.name);
                      print('pass: ' + store.pass);

                      Future<void> _showMyDialog(String str) async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pesquisei'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(str),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }

                      setState(() {});

                      _connectivityController.isConnected(model).then((data) {
                        if (data) {
                          int erros = 0;
                          int resultadosEnviados = 0;

                          _cidadeController
                              .sincronizar(store.name, store.pass)
                              .then((data) {
                            print('cidades sincronizadas!');
                            setState(() {});

                            if (data.erros > 0) {
                              erros = 1;
                            }

                            _bairroController
                                .sincronizar(store.name, store.pass)
                                .then((data) {
                              print('bairros sincronizados!');
                              setState(() {});

                              if (data.erros > 0) {
                                erros = 1;
                              }

                              _pesquisaController
                                  .sincronizar(store.name, store.pass)
                                  .then((data) {
                                print('pesquisas sincronizadas!');
                                setState(() {});

                                if (data.erros > 0) {
                                  erros = 1;
                                }

                                _perguntaController
                                    .sincronizar(store.name, store.pass)
                                    .then((data) {
                                  print('pesquisas sincronizadas!');
                                  setState(() {});

                                  if (data.erros > 0) {
                                    erros = 1;
                                  }

                                  _respostaController
                                      .sincronizar(store.name, store.pass)
                                      .then((data) {
                                    print('Respostas sincronizadas!');
                                    setState(() {});

                                    if (data.erros > 0) {
                                      erros = 1;
                                    }

                                    _respostaEscolhidaController
                                        .sincronizar(
                                            store.name, store.pass, model)
                                        .then((data) {
                                      print(
                                          'Respostas Escolhias sincronizadas!');
                                      setState(() {});

                                      if (data.erros > 0) {
                                        erros = 1;
                                      } else {
                                        resultadosEnviados =
                                            data.registrosSincronizados;
                                      }

                                      if (erros > 0) {
                                        _showMyDialog(
                                            'Sincronização finalizada com erros!\nFavor tente novamente.');
                                      } else {
                                        if (resultadosEnviados > 0) {
                                          _showMyDialog(
                                              'Sincronização finalizada com sucesso!\n' +
                                                  resultadosEnviados
                                                      .toString() +
                                                  ' registros enviados ao painel online.');
                                        } else {
                                          _showMyDialog(
                                              'Sincronização finalizada com sucesso!');
                                        }
                                      }
                                    });
                                  });
                                });
                              });
                            });
                          });
                        } else {
                          _showMyDialog(
                              'A sincronização falhou!\nVocê não está conectado à internet.');
                        }

                        print(data);
                      });
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('Clique aqui'),
                  )
          ],
        ),
      ),
    );
  }
}
