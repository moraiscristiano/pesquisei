import 'package:flutter/material.dart';
import 'package:flutter_crud/models/pesquisa.dart';
import 'package:flutter_crud/provider/pesquisa_provider.dart';
import 'package:intl/intl.dart';

class PesquisaList extends StatefulWidget {
  final String title;

  PesquisaList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PesquisaListState();
  }
}

class _PesquisaListState extends State<PesquisaList> {
  Future<List<Pesquisa>> pesquisas;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  refreshList() {
    setState(() {
      pesquisas = PesquisaProvider().getPesquisas();
    });
  }

  SingleChildScrollView dataTable(List<Pesquisa> pesquisas) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('NOME'),
          ),
          DataColumn(
            label: Text('EXCLUIR'),
          )
        ],
        rows: pesquisas
            .map(
              (pesquisa) => DataRow(cells: [
                DataCell(
                  Text(pesquisa.nome),
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    PesquisaProvider().deletePesquisa(pesquisa.id);
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
        future: pesquisas,
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
