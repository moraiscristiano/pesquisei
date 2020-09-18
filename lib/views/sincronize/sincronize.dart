import 'package:flutter/material.dart';
import 'package:flutter_crud/controllers/auth.controller.dart';
import 'package:flutter_crud/controllers/cidade.controller.dart';
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

                _cidadeController
                    .sincronizar(store.name, store.pass)
                    .then((data) {
                  print('ok');
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
