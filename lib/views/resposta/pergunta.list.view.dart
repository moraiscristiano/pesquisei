import 'package:flutter/material.dart';
import 'package:Pesquisei/models/pergunta.dart';
import 'package:Pesquisei/models/resposta.dart';
import 'package:Pesquisei/provider/pergunta_provider.dart';
import 'package:Pesquisei/provider/resposta_provider.dart';
import 'package:intl/intl.dart';

class RespostaList extends StatefulWidget {
  final String title;

  RespostaList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RespostaListState();
  }
}

class _RespostaListState extends State<RespostaList> {
  Future<List<Resposta>> respostas;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  refreshList() {
    setState(() {
      respostas = RespostaProvider().getRespostas();
    });
  }

  SingleChildScrollView dataTable(List<Resposta> respostas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('DESCRIÇÃO'),
          ),
          DataColumn(
            label: Text('EXCLUIR'),
          )
        ],
        rows: respostas
            .map(
              (resposta) => DataRow(cells: [
                DataCell(
                  Text(resposta.descricao),
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    PerguntaProvider().deletePergunta(resposta.id);
                    refreshList();
                  },
                )),
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
