import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/controllers/bairro.controller%20.dart';
import 'package:flutter_crud/controllers/cidade.controller.dart';
import 'package:flutter_crud/controllers/pesquisa.controller.dart';
import 'package:flutter_crud/controllers/sincronize.controller..dart';
import 'package:flutter_crud/stores/app.store.dart';
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
            RaisedButton(
              onPressed: () {
                // new SincronizeController().Sincronizar();
                print('name: ' + store.name);
                print('pass: ' + store.pass);

                setState(() {});
/*
                _cidadeController
                    .sincronizar(store.name, store.pass)
                    .then((data) {
                  print('cidades sincronizadas!');
                });
             

                _bairroController
                    .sincronizar(store.name, store.pass)
                    .then((data) {
                  print('bairros sincronizados!');
                });   
                */

                _pesquisaController
                    .sincronizar(store.name, store.pass)
                    .then((data) {
                  print('pesquisas sincronizadas!');
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
