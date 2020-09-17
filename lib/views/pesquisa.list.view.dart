import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/pesquisa.list.controller.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/stores/pesquisa.localidade.store.dart';
import 'package:flutter_crud/stores/pesquisa.store.dart';
import 'package:flutter_crud/views/pergunta.quiz.view.dart';
import 'package:flutter_crud/views/pesquisa.localidade.view.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';

class PesquisaListView extends StatefulWidget {
  @override
  _PesquisaListViewState createState() => _PesquisaListViewState();
}

class _PesquisaListViewState extends State<PesquisaListView> {
  final _controller = new PesquisaListController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Pesquisa>> getPesquisasPorCidadeBairro(int idbairro) {
    return _controller.getPesquisasPorCidadeBairro(idbairro);
  }

  @override
  Widget build(BuildContext context) {
    var pesquisaLocalidadeStore = Provider.of<PesquisaLocalidadeStore>(context);
    var pesquisaStore = Provider.of<PesquisaStore>(context);

    SingleChildScrollView dataTable(List<Pesquisa> pesquisas) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Selecione uma pesquisa',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
          ],
          dataRowHeight: 80,
          rows: pesquisas
              .map(
                (pesquisa) => DataRow(cells: [
                  DataCell(
                    Text(pesquisa.descricao, style: TextStyle(fontSize: 14)),
                    onTap: () {
                      setState(() {});

                      pesquisaStore.setPesquisa(
                          pesquisa.id,
                          pesquisa.nome,
                          pesquisa.descricao,
                          pesquisa.idbairro,
                          pesquisaLocalidadeStore.idcidade);

                      setState(() {});

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          
                          builder: (context) => PerguntaQuizView(pesquisa.id),
                        ),
                      );
                    },
                  ),
                ]),
              )
              .toList(),
        ),
      );
    }

    list(int idbairro) {
      return Expanded(
        child: FutureBuilder(
          future: getPesquisasPorCidadeBairro(idbairro),
          builder: (context, snapshot) {
            if (null == snapshot.data || snapshot.data.length == 0) {
              return Center(
                  child: Text(
                      "Não há pesquisas cadastradas para o Bairro escolhido."));
            }

            if (snapshot.hasData) {
              return dataTable(snapshot.data);
            }

            return CircularProgressIndicator();
          },
        ),
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text('Pesquisas'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.home,color: Colors.white),
            onPressed: () async {
              await Future.delayed(Duration(seconds: 3));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          ),
        ],
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(pesquisaLocalidadeStore.idbairro),
          ],
        ),
      ),
    );
  }
}
