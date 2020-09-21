import 'package:flutter/material.dart';
import 'package:Pesquisei/stores/app.store.dart';
import 'package:Pesquisei/stores/pesquisa.localidade.store.dart';
import 'package:Pesquisei/stores/pesquisa.store.dart';
import 'package:Pesquisei/views/home/home.view.dart';
import 'package:Pesquisei/views/signup.view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppStore>.value(
          value: AppStore(),
        ),
        Provider<PesquisaStore>.value(
          value: PesquisaStore(),
        ),
        Provider<PesquisaLocalidadeStore>.value(
          value: PesquisaLocalidadeStore(),
        ),
      ],
      child: MaterialApp(
        title: 'Pesquisei',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignupView(),
      ),
    );
  }
}

/* MyAppOld
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perguntei',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
|*/
