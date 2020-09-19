import 'package:flutter/material.dart';
import 'package:flutter_crud/models/cidade.dart';
import 'package:flutter_crud/provider/cidade_provider.dart';
import 'package:intl/intl.dart';

class CidadeList extends StatefulWidget {
  final String title;

  CidadeList({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CidadeListState();
  }
}

class _CidadeListState extends State<CidadeList> {
  Future<List<Cidade>> cidades;
  TextEditingController controllerTxtNome = TextEditingController();
  TextEditingController controllerTxtEstadoSigla = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  String nome;
  String estadoSigla;
  int curCidadeId;
  String dataalteracao;

  final formKey = new GlobalKey<FormState>();
  bool isUpdating;

  @override
  void initState() {
    super.initState();

    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      cidades = CidadeProvider().getCidades();
    });
  }

  clearName() {
    controllerTxtNome.text = '';
    controllerTxtEstadoSigla.text = '';

    dataalteracao = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Cidade c = Cidade(
            id: curCidadeId,
            nome: nome,
            estadoSigla: estadoSigla,
            alteracao: dateFormat.format(DateTime.now()));

        CidadeProvider().updateCidade(c);
        setState(() {
          isUpdating = false;
        });
      } else {
        Cidade e = Cidade(
            id: null,
            nome: nome,
            estadoSigla: estadoSigla,
            alteracao: dateFormat.format(DateTime.now()));

        CidadeProvider().saveCidade(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controllerTxtNome,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (val) => val.length == 0 ? 'Digite o nome' : null,
              onSaved: (val) => nome = val,
            ),
            TextFormField(
              controller: controllerTxtEstadoSigla,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Estado'),
              validator: (val) =>
                  val.length == 0 ? 'Digite a sigla do Estado' : null,
              onSaved: (val) => estadoSigla = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<Cidade> cidades) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('NOME'),
          ),
          DataColumn(
            label: Text('SIGLA ESTADO'),
          ),
          DataColumn(
            label: Text('EXCLUIR'),
          )
        ],
        rows: cidades
            .map(
              (cidade) => DataRow(cells: [
                DataCell(
                  Text(cidade.nome ?? ''),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curCidadeId = cidade.id;
                    });
                    controllerTxtNome.text = cidade.nome;
                    controllerTxtEstadoSigla.text = cidade.estadoSigla;
                  },
                ),
                DataCell(
                  Text(cidade.estadoSigla ?? ''),
                  onTap: () {
                    setState(() {
                      isUpdating = true;
                      curCidadeId = cidade.id;
                    });
                    controllerTxtNome.text = cidade.nome;
                    controllerTxtEstadoSigla.text = cidade.estadoSigla;
                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    CidadeProvider().deleteCidade(cidade.id);
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
        future: cidades,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
print(snapshot.data );
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
            form(),
            list(),
          ],
        ),
      ),
    );
  }
}
