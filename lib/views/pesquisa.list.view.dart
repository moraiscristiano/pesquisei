import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/pesquisa.list.controller.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/stores/pesquisa.localidade.store.dart';
import 'package:provider/provider.dart';

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




  
  SingleChildScrollView dataTable(List<Pesquisa> pesquisas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('Selecione a pesquisa:',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
          ),
        ],
        dataRowHeight: 80,
        rows:  pesquisas
            .map(
              (pesquisa) => DataRow(cells: [
                DataCell(

                  Text(pesquisa.descricao,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),

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
            
            return Center(child:Text("Não há pesquisas cadastradas para o Bairro escolhido.") );
          }

            if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }


          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pesquisaLocalidadeStore = Provider.of<PesquisaLocalidadeStore>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text('Pesquisas'),
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
