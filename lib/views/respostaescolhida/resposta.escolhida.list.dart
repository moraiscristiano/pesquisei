import 'package:flutter/material.dart';
import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/models/resposta_escolhida.dart';
import 'package:flutter_crud/provider/bairro_provider.dart';
import 'package:flutter_crud/provider/resposta_escolhida.dart';
import 'package:intl/intl.dart';

class RespostaEscolhidaList extends StatefulWidget {
  final String title;

  RespostaEscolhidaList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RespostaEscolhidaListState();
  }
}

class _RespostaEscolhidaListState extends State<RespostaEscolhidaList> {
  Future<List<RespostaEscolhida>> respostas;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  refreshList() {
    setState(() {
      respostas = RespostaEscolhidaProvider().getRespostasEscolhidas();
    });
  }

  SingleChildScrollView dataTable(List<RespostaEscolhida> respostas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('ID PERGUNTA'),
          ),
          DataColumn(
            label: Text('IS RESPOSTA'),
          ),
          
        ],
        rows: respostas
            .map(
              (resp) => DataRow(cells: [
                DataCell(
                  Text(resp.idpergunta.toString()),
                ),
                DataCell(
                  Text(resp.idresposta.toString()),
                ),
                
              ]),
            )
            .toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: respostas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }
}