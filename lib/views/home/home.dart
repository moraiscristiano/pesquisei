import 'package:flutter/material.dart';
import 'package:flutter_crud/views/bairro/bairro_list.dart';
import 'package:flutter_crud/views/fragment/fragment.dart';
import 'package:flutter_crud/views/pergunta/pergunta_list.dart';
import 'package:flutter_crud/views/pesquisa/pesquisa_list.dart';
import 'package:flutter_crud/views/resposta/pergunta_list.dart';
import 'package:flutter_crud/views/sincronize/sincronize.dart';

import '../cidade/cidade_list.dart';

class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String curTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(curTitle),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
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
              title: Text('PesquisaApp'),
              selected: 2 == _selectedIndex,
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: Text('Sincronizar'),
              selected: 3 == _selectedIndex,
              onTap: () {
                _onSelectItem(3);
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
        return Fragment("Bem Vindo ao Pesquisei: O seu App de Pesquisas");
      case 1: // Cidades
        return CidadeList();
      case 2: // Pesquisa
        return Fragment("");
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
    }
  }

  _onSelectItem(int index) {
    switch (index) {
      case 0: // Home
        curTitle = 'Home';
        break;
      case 1: // Cidades
        curTitle = 'Cidades';
        break;
      case 2: // PesquisaApp
        curTitle = 'PesquisaApp';
        break;
      case 3: // Sincronizar
        curTitle = 'Sincronizar';
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
      case 6: // Respostas
        curTitle = 'Respostas';
        break;
    }

    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}
