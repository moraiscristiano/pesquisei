import 'package:flutter/material.dart';
import 'package:Pesquisei/models/bairro.dart';
import 'package:Pesquisei/models/cidade.dart';
import 'package:Pesquisei/provider/bairro_provider.dart';
import 'package:Pesquisei/provider/cidade_provider.dart';
import 'package:Pesquisei/stores/pesquisa.localidade.store.dart';
import 'package:Pesquisei/views/pesquisa.list.view.dart';
import 'package:provider/provider.dart';

class PesquisaLocalidadeView extends StatefulWidget {
  @override
  _PesquisaLocalidadeViewState createState() => _PesquisaLocalidadeViewState();
}

class _PesquisaLocalidadeViewState extends State<PesquisaLocalidadeView> {
  @override
  void initState() {
    _getCidadesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cidadeFormKey = GlobalKey<FormState>();
    final _bairroFormKey = GlobalKey<FormState>();

    var pesquisaLocalidadeStore = Provider.of<PesquisaLocalidadeStore>(context);

    return Scaffold(
      /* appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ), */
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 75, top: 75),
            child: Text(
              'Informe sua localização',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== Cidade

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _minhaCidade,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Selecione a Cidade'),
                        key: _cidadeFormKey,
                        onChanged: (String newValue) {
                          setState(() {
                            _minhaCidade = null;
                            _meuBairro = null;
                            _minhaCidade = newValue;
                            _getBairrosList();
                            print(_minhaCidade);
                          });
                        },
                        items: cidades?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.nome),
                                value: item.id.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _meuBairro,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Selecione o Bairro'),
                        key: _bairroFormKey,
                        onChanged: (String newValue) {
                          setState(() {
                            _meuBairro = newValue;
                            print(_meuBairro);
                          });
                        },
                        items: bairros?.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.nome),
                                value: item.id.toString(),
                              );
                            })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Próximo"),
              onPressed: () {
                Future<void> _showMyDialog() async {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Falha'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Ocorreu um erro.'),
                              Text(
                                  'Você deve selecionar uma Cidade e um Bairro.'),
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

                if (_minhaCidade == null ||
                    _meuBairro == null ||
                    _minhaCidade?.trim().isEmpty ||
                    _meuBairro?.trim().isEmpty) {
                  _showMyDialog();
                } else {
                  setState(() {});

                  pesquisaLocalidadeStore.setPesquisaLocalidade(
                    int.parse(_minhaCidade),
                    int.parse(_meuBairro),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesquisaListView(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API

  List<Cidade> cidades;
  String _minhaCidade;
  List<Bairro> bairros;
  String _meuBairro;

  Future<String> _getCidadesList() async {
    CidadeProvider cidadeProvider = new CidadeProvider();

    List<Cidade> retornoCidades = await cidadeProvider.getCidades();

    setState(() {
      cidades = retornoCidades;
    });
  }

  Future<String> _getBairrosList() async {
    BairroProvider bairroProvider = new BairroProvider();

    List<Bairro> retornoBairros =
        await bairroProvider.getBairrosPorCidadeId(_minhaCidade);

    setState(() {
      bairros = retornoBairros;
    });
  }
}
