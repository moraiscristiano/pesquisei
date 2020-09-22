import 'package:flutter/material.dart';
import 'package:Pesquisei/stores/app.store.dart';
import 'package:Pesquisei/views/bairro/bairro.list.view.dart';
import 'package:Pesquisei/views/fragment/fragment.dart';
import 'package:Pesquisei/views/pergunta/pergunta.list.view.dart';
import 'package:Pesquisei/views/pesquisa/pesquisa.list.view.dart';
import 'package:Pesquisei/views/resposta/pergunta.list.view.dart';
import 'package:Pesquisei/views/respostaescolhida/resposta.escolhida.list.dart';
import 'package:Pesquisei/views/signup.view.dart';
import 'package:Pesquisei/views/sincronize/sincronize.dart';
import 'package:provider/provider.dart';

import '../cidade/cidade.list.view.dart';
import '../pesquisa.localidade.view.dart';

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String curTitle = 'Pesquisei';

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<AppStore>(context);

    void _showDialogLogout() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Finalizar sessão?"),
            content: new Text("Deseja sair da sessão?"),
            actions: <Widget>[
              FlatButton(
                child: new Text("NÂO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text("SIM"),
                onPressed: () async {
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupView()),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text(curTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80.0,
              child: DrawerHeader(
                  child: Text(
                    store.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 16),
                  ),
                  decoration: BoxDecoration(color: Colors.blue),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(10.0)),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
        
        /*
            ListTile(
              title: Text('Cidades'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(1);
              },
            ),
           
               
            ListTile(
              title: Text('Bairros'),
              selected: 4 == _selectedIndex,
              onTap: () {
                _onSelectItem(4);
              },
            ),
     
            ListTile(
              title: Text('Pesquisas'),
               leading: Icon(Icons.search),
              selected: 5 == _selectedIndex,
              onTap: () {
                _onSelectItem(5);
              },
            ),
  
        
            ListTile(
              title: Text('Perguntas'),
              selected: 6 == _selectedIndex,
              onTap: () {
                _onSelectItem(6);
              },
            ),

             

            ListTile(
              title: Text('Respostas'),
              selected: 7 == _selectedIndex,
              onTap: () {
                _onSelectItem(7);
              },
            ),
          
            ListTile(
              title: Text('Respostas Escolhidas'),
              leading: Icon(Icons.search),
              selected: 8 == _selectedIndex,
              onTap: () {
                _onSelectItem(8);
              },
            ),
              */

            ListTile(
              title: Text('Pesquisa'),
              leading: Icon(Icons.search),
              selected: 2 == _selectedIndex,
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: Text('Sincronizar'),
              leading: Icon(Icons.sync),
              selected: 3 == _selectedIndex,
              onTap: () {
                _onSelectItem(3);
              },
            ),
            ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                _showDialogLogout();
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_selectedIndex),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0: // Home
        return Fragment("Bem Vindo ao Pesquisei!");
      case 1: // Cidades
        return CidadeList();
      case 2: // Pesquisa
        return PesquisaLocalidadeView();
      case 3: // Sincronizar
        return SincronizePage();
      case 4: // Sincronizar
        return BairroList();
      case 5: // Sincronizar
        return PesquisaList();
      case 6: // Sincronizar
        return PerguntaList();
      case 7: // Sincronizar
        return RespostaList();
      case 8: // Sincronizar
        return RespostaEscolhidaList();
    }
  }

  _onSelectItem(int index) {
    switch (index) {
      case 0: // Home
        curTitle = 'Pesquisei';
        break;
      case 1: // Cidades
        curTitle = 'Cidades';
        break;
      case 2: // PesquisaApp
        curTitle = 'Pesquisei';
        break;
      case 3: // Sincronizar
        curTitle = 'Pesquisei';
        break;
      case 4: // Bairros
        curTitle = 'Bairros';
        break;
      case 5: // Pesquisas
        curTitle = 'Pesquisas';
        break;
      case 6: // Perguntas
        curTitle = 'Perguntas';
        break;
      case 7: // Respostas
        curTitle = 'Respostas';
        break;
      case 8: // Respostas Escolhidas
        curTitle = 'Respostas Escolhidas';
        break;
    }

    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
