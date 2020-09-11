import 'package:flutter/material.dart';
import 'package:flutter_crud/data/sincronize.dart';


class SincronizePage extends StatefulWidget {
  SincronizePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SincronizePageState createState() => _SincronizePageState();
}

class _SincronizePageState extends State<SincronizePage> {

  @override
  Widget build(BuildContext context) {
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
              onPressed: (){
                new Sincronize().SincronizarCidades();
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text ('Clique aqui'),
            )
          ],
        ),
      ),
    );
  }
}