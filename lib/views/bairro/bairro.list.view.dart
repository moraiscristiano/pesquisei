import 'package:flutter/material.dart';
import 'package:flutter_crud/models/bairro.dart';
import 'package:flutter_crud/provider/bairro_provider.dart';
import 'package:intl/intl.dart';

class BairroList extends StatefulWidget {
  final String title;

  BairroList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BairroListState();
  }
}

class _BairroListState extends State<BairroList> {
  Future<List<Bairro>> bairros;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    refreshList();
  }

  refreshList() {
    setState(() {
      bairros = BairroProvider().getBairros();
    });
  }

  SingleChildScrollView dataTable(List<Bairro> bairros) {
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
        rows: bairros
            .map(
              (bairro) => DataRow(cells: [
                DataCell(
                  Text(bairro.nome),
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    BairroProvider().deleteBairro(bairro.id);
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
        future: bairros,
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
