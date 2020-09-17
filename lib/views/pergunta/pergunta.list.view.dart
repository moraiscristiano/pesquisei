import 'package:flutter/material.dart';
import 'package:flutter_crud/models/pergunta.dart';
import 'package:flutter_crud/provider/pergunta_provider.dart';
import 'package:intl/intl.dart';

class PerguntaList extends StatefulWidget {
  final String title;

  PerguntaList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PerguntaListState();
  }
}

class _PerguntaListState extends State<PerguntaList> {
  Future<List<Pergunta>> perguntas;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  refreshList() {
    setState(() {
      perguntas = PerguntaProvider().getPerguntas();
    });
  }

  SingleChildScrollView dataTable(List<Pergunta> perguntas) {
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
        rows: perguntas
            .map(
              (pergunta) => DataRow(cells: [
                DataCell(
                  Text(pergunta.descricao),
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    PerguntaProvider().deletePergunta(pergunta.id);
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
        future: perguntas,
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
